public with sharing class QBPOSync_Controller {
    @InvocableMethod(label='Sync Purchase Order' description='Creates and syncs PO with QB PO' category= 'Purchase Order')
    public static void callFromFlow(List<Id> poId){
        Purchase_Order__c po = [SELECT Id,
                                Name,
                                (Select Id,Product__c,Product__r.QBO_Id__c From Purchase_Order_Items__r), 
                                QBO_Id__c, 
                                QBO_SyncToken__c,
                                Vendor_Account__c,
                                Vendor_Account__r.QBO_Id__c,
                                Vendor_Account__r.contact__r.email,
                                Vendor_Account__r.Name,
                                Vendor_Account__r.Contact__r.Name,
                                Vendor_Account__r.ShippingCity,
                                Vendor_Account__r.ShippingStreet,
                                Vendor_Account__r.ShippingState,
                                Vendor_Account__r.ShippingCountry,
                                Vendor_Account__r.ShippingPostalCode,
                                Vendor_Account__r.Phone,
                                Vendor_Account__r.BillingCity,
                                Vendor_Account__r.BillingStreet,
                                Vendor_Account__r.BillingCountry,
                                Vendor_Account__r.BillingPostalCode,
                                Vendor_Account__r.BillingState,
                                Vendor_Account__r.BillingLatitude,
                                Vendor_Account__r.BillingLongitude
                            FROM Purchase_Order__c 
                            WHERE Id =: poId[0]];
        
        QBCallout callout = new QBCallout();
        QBPOQueryJSON queryJson = callout.getPurchaseOrder(po);
        //Check if an invoice was found
        if(queryJson != null){
            if(queryJson.QueryResponse.PurchaseOrder.size() == 1){
                po.QBO_Id__c = queryJson.QueryResponse.PurchaseOrder[0].Id;
                po.QBO_SyncToken__c = queryJson.QueryResponse.PurchaseOrder[0].SyncToken;
            }else{
                //Multiple Customer Error Handling
               throw new ListException(); 
            }
        }

        QBPOResponseJSON res = callout.createPurchaseOrderCall(po,po.Purchase_Order_Items__r);        
        po.QBO_Id__c = res.PurchaseOrder.Id;
        po.QBO_SyncToken__c = res.PurchaseOrder.SyncToken;
        
        //DML After Callouts
        update po;
    }    
}
