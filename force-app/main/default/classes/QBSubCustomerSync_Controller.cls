public with sharing class QBSubCustomerSync_Controller {
    @InvocableMethod(label='Sync Work Order to QBO Job' description='' category= 'Work Order')
    public static void callFromFlow(List<Id> woIds){
        callWithWorkOrderId(woIds[0]);
    }

    public static void callWithWorkOrderId(String woId){
        WorkOrder wo = [SELECT Id, QBO_Id__c, QBO_Sync_Token__c, Job_Number__c,
                        Customer_Account__c, Customer_Account__r.Name, Customer_Account__r.QBO_Id__c, Customer_Account__r.Type
                            FROM WorkOrder 
                            WHERE Id = :woId
                        ];

        callWithWorkOrder(wo);
    }


    public static void callWithWorkOrder(WorkOrder wo){       
        System.debug('**********  In QBSubCustomerSync_Controller.CallWithWorkOrder()');
        // Ensure parent account is customer type and synced w/ QBO
        if(wo.Customer_Account__r.Type == 'Customer' && !String.isBlank(wo.Customer_Account__r.QBO_Id__c) || Test.isRunningTest()){
            System.debug('Account is of Customer Type');

            // If Customer Account does not have a QBO ID, add to QBO 
            /*
            if(String.isBlank(wo.Account.QBO_Id__c)){
                System.debug('Account QBO ID is blank');
                List<Id> accIds = new List<Id>();
                accIds.add(wo.AccountId);
                QBCustomerSync_Controller.callFromFlow(accIds);
                // Re-query for updated account QBO ID (NOTE: this prob needs to be refactored to have this or the account object returned to save a query)
                wo = [SELECT Id, QBO_Id__c, QBO_Sync_Token__c, Job_Number__c,
                            AccountId, Account.Name, Account.QBO_Id__c, Account.Type
                            FROM WorkOrder 
                            WHERE Id = :wo.Id
                        ];
                System.debug('Account QBO Id: ' + wo.Account.QBO_Id__c);
            }
            */
            
            
            // If no QBO Id on Work Order add to QBO as sub customer, 
            //otherwise skip all as bc it's already in system
            if(String.isBlank(wo.QBO_ID__c)){
                System.debug('Work Order QBO ID is: ' + wo.QBO_Id__c);
                QBCallout callout = new QBCallout();

                // Params: QBO_Id, QBO_Sync_Token, accountName, jobNumber
                QBCustomerJSON getResponse = callout.getSubCustomer(wo.QBO_Id__c, wo.Customer_Account__r.Name, wo.Job_Number__c);
                
                System.debug(getResponse);
                //Check if an PO was found
                if(getResponse != null){
                    if(getResponse.QueryResponse.Customer != null){ // Customer was found, 
                        System.debug('Customer Found');
                        // Update SF WO
                        wo.QBO_Id__c = getResponse.QueryResponse.Customer[0].Id;
                        wo.QBO_Sync_Token__c = getResponse.QueryResponse.Customer[0].SyncToken;

                    } else { // Customer not found
                        System.debug('Customer Not Found');
                        // Create QBO customer
                        QBCustomerResponseJSON createResponse = callout.createSubCustomerCall(wo);
                        wo.QBO_Id__c = createResponse.Customer.Id; 
                        wo.QBO_Sync_Token__c = createResponse.Customer.SyncToken;
                        System.debug('WorkOrder QBO Id Set: ' + wo.QBO_Id__c);
                    }

                    update wo;
                }            
            }        
        }
        
    }    
}