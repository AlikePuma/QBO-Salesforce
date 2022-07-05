public with sharing class QBInvoiceSync_Controller {
	@InvocableMethod(label='Sync Invoice' description='Creates and syncs invoice with QB invoice' category= 'Account')
    public static void callFromFlow(List<Id> invId){
        invoice__c inv = [SELECT Id,
                           Due_Date__c,
                           Name, 
                           QBO_Id__c, 
                           QBO_SyncToken__c,
                           Terms__c,
                           Description__c,
                           Balance_Due__c,
                           Sync_in_QBO_to__c,
                           Work_Order__c,
                           Work_Order__r.QBO_Id__c,
                           Work_Order__r.Customer_Account__r.contact__r.email,
                           Work_Order__r.Customer_Account__r.QBO_Id__c,
                           Work_Order__r.Customer_Account__r.BillingCity,  
                           Work_Order__r.Customer_Account__r.BillingStreet,  
                           Work_Order__r.Customer_Account__r.BillingState,  
                           Work_Order__r.Customer_Account__r.BillingPostalCode,  
                           Work_Order__r.Customer_Account__r.BillingLatitude,  
                           Work_Order__r.Customer_Account__r.BillingLongitude,  
                           Work_Order__r.Customer_Account__r.BillingCountry,
                           Work_Order__r.Customer_Account__r.name,
                           Work_Order__r.Customer_Account__r.contact__r.Name,
                           Work_Order__r.Customer_Account__r.contact__r.Phone,
                           Work_Order__r.Customer_Account__r.ShippingCity, 
                           Work_Order__r.Customer_Account__r.ShippingStreet, 
                           Work_Order__r.Customer_Account__r.ShippingState, 
                           Work_Order__r.Customer_Account__r.ShippingPostalCode, 
                           Work_Order__r.Customer_Account__r.ShippingLatitude, 
                           Work_Order__r.Customer_Account__r.ShippingLongitude, 
                           Work_Order__r.Customer_Account__r.ShippingCountry
                    FROM Invoice__c 
                    WHERE Id =: invId[0]];

        // due to an issue above with Work_Order__r.QBO_Id__c giving us a soql field missing 
        // error when accessing that field, we're adding this otherwise unneccessary query
        // and passing it through QBCallout to QBMap
        WorkOrder wo = [SELECT QBO_Id__c FROM WorkOrder WHERE Id = :inv.Work_Order__c];

        
        QBCallout callout = new QBCallout();
        QBInvoiceQueryJSON queryJson = callout.getInvoice(inv);
        //Check if an invoice was found
        if(queryJson != null){
            if(queryJson.QueryResponse.Invoice.size() == 1){
                inv.QBO_Id__c = queryJson.QueryResponse.Invoice[0].Id;
                inv.QBO_SyncToken__c = queryJson.QueryResponse.Invoice[0].SyncToken;
            }else{
                //Multiple Customer Error Handling
               throw new ListException(); 
            }
        }
        QBWorkOrder_Controller woController = new QBWorkOrder_Controller();
        woController.wrapWOliAndProduct(inv);
        QBInvoiceResponseJSON res = callout.createInvoiceFromWorkOrderCall(inv, wo, woController.woliMap.values());        
        inv.Due_Date__c = Date.valueOf(res.Invoice.DueDate);
        inv.QBO_Id__c = res.Invoice.Id;
        inv.QBO_SyncToken__c = res.Invoice.SyncToken;
        inv.tax__c = res.Invoice.TxnTaxDetail.TotalTax;
        inv.total__c = res.Invoice.TotalAmt;
        //inv.Subtotal__c = res.Invoice.Line.;
        inv.Balance_Due__c = res.Invoice.Balance;
        //DML After Callouts
        update inv;
    }    
}