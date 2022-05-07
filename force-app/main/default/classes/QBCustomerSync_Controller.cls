public with sharing class QBCustomerSync_Controller {
	@InvocableMethod(label='Sync Customer / Vendor' description='Creates and syncs account with QB customer or vendor' category= 'Account')
    public static void callFromFlow(List<Id> accId){
        Account acc = [SELECT Id,
                      Name, 
                      QBO_Id__c, 
                      QBO_SyncToken__c,
                      Type,
                      ShippingCity,
                      ShippingStreet,
                      ShippingState,
                      ShippingCountry,
                      ShippingPostalCode,
                      Phone,
                      BillingCity,
                      BillingStreet,
                      BillingCountry,
                      BillingPostalCode,
                      BillingState,
                      BillingLatitude,
                      BillingLongitude
              FROM Account 
                       WHERE Id =: accId[0]];
        
       if(acc.Type=='Customer'){
        customer(acc);
       }
       if(acc.Type=='Vendor'){
        vendor(acc);
       }
    }
    public static void customer(Account acc){
        QBCallout callout = new QBCallout();
        QBCustomerJSON accountData = callout.getCustomer(acc);
        //Check if a customer was found
        if(accountData.QueryResponse.Customer != null){
            
            //Check if only 1 customer was found
            if(accountData.QueryResponse.Customer.size() == 1){
                for(QBCustomerJSON.Customer c : accountData.QueryResponse.Customer){
                    acc.QBO_Id__c = c.id;
                    System.debug('QB Id: ' + acc.QBO_Id__c);
                    acc.QBO_SyncToken__c = c.SyncToken;
                    System.debug('QB Synctoken: ' + acc.QBO_SyncToken__c );
                }
            }else{
                //Multiple Customer Error Handling
               throw new ListException(); 
            }
        }
        QBCustomerResponseJSON accountPushData = callout.createCustomerCall(acc);
        System.debug(accountPushData);
        if(accountPushData.Customer.Id != null){
            acc.QBO_ID__c = accountPushData.Customer.Id;
        }
        if(accountPushData.Customer.SyncToken != null){
            acc.QBO_SyncToken__c = accountPushData.Customer.SyncToken;
        }
        
        //DML After Callouts
        update acc;
    }

    public static void vendor(Account acc){
        QBCallout callout = new QBCallout();
        QBVendorJSON accountData = callout.getVendor(acc);
        //Check if a vendor was found
        if(accountData.QueryResponse.Vendor != null){
            
            //Check if only 1 vendor was found
            if(accountData.QueryResponse.Vendor.size() == 1){
                for(QBvendorJSON.Vendor c : accountData.QueryResponse.Vendor){
                    acc.QBO_Id__c = c.id;
                    System.debug('QB Id: ' + acc.QBO_Id__c);
                    acc.QBO_SyncToken__c = c.SyncToken;
                    System.debug('QB Synctoken: ' + acc.QBO_SyncToken__c );
                }
            }else{
                //Multiple Vendor Error Handling
               throw new ListException(); 
            }
        }
        QBVendorResponseJSON accountPushData = callout.createVendorCall(acc);
        System.debug(accountPushData);
        if(accountPushData.Vendor.Id != null){
            acc.QBO_ID__c = accountPushData.Vendor.Id;
        }
        if(accountPushData.Vendor.SyncToken != null){
            acc.QBO_SyncToken__c = accountPushData.Vendor.SyncToken;
        }
        
        //DML After Callouts
        update acc;
    }

}