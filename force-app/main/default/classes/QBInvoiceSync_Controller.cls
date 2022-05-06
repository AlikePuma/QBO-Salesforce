public with sharing class QBInvoice_Controller {
	@InvocableMethod(label='Sync Invoice' description='Creates and syncs invoice with QB invoice' category= 'Account')
    public static void callFromFlow(List<Id> invId){
        invoice__c inv = [SELECT Id,
                           Due_Date__c,
                          //Subtotal__c,
                           Name, 
                           QBO_Id__c, 
                           QBO_SyncToken__c,
                           Terms__c,
                           Description__c,
                           Balance_Due__c,
                           Work_Order__c,
                           Work_Order__r.Account.contact__r.email,
                           Work_Order__r.Account.QBO_Id__c,
                           Work_Order__r.Account.BillingCity,  
                           Work_Order__r.Account.BillingStreet,  
                           Work_Order__r.Account.BillingState,  
                           Work_Order__r.Account.BillingPostalCode,  
                           Work_Order__r.Account.BillingLatitude,  
                           Work_Order__r.Account.BillingLongitude,  
                           Work_Order__r.Account.BillingCountry,
                           Work_Order__r.Account.name,
                           Work_Order__r.Account.contact__r.Name,
                           Work_Order__r.Account.contact__r.Phone,
                           Work_Order__r.Account.ShippingCity, 
                           Work_Order__r.Account.ShippingStreet, 
                           Work_Order__r.Account.ShippingState, 
                           Work_Order__r.Account.ShippingPostalCode, 
                           Work_Order__r.Account.ShippingLatitude, 
                           Work_Order__r.Account.ShippingLongitude, 
                           Work_Order__r.Account.ShippingCountry 
                    FROM Invoice__c 
                    WHERE Id =: invId[0]];
        
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
        QBInvoiceResponseJSON res = callout.createInvoiceFromWorkOrderCall(inv, woController.woliMap.values());        
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