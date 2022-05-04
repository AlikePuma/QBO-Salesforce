public with sharing class QBPOSync_Controller {
    
    public Id poId{get;set;}
    public Purchase_Order__c po {get;set;}

    public QBPOSync_Controller(ApexPages.StandardController stdController) {
        poId = ApexPages.currentPage().getParameters().get('id');
        po = [SELECT Id,
                     (Select Id, 
                     Product__c,
                     Product__r.Name,
                     Product__r.QBO_Id__c,
                     Quantity__c,
                     Unit_Cost__c,
                     Amount__c
                     From Purchase_Order_Items__r),
                      Name, 
                      QBO_Id__c, 
                      QBO_SyncToken__c,
                      Vendor_Account__r.contact__r.email,
                      Vendor_Account__r.Name,
                      Vendor_Account__r.Contact__r.Name,
                      Vendor_Account__r.ShippingStreet,
                      Vendor_Account__r.ShippingCity,
                      Vendor_Account__r.ShippingState,
                      Vendor_Account__r.ShippingPostalCode,
                      Vendor_Account__r.QBO_Id__c,
                      Vendor_Account__r.QBO_SyncToken__c
              FROM Purchase_Order__c 
              WHERE Id =: poId];
    }

    public Pagereference syncQB(){
        QBCallout callout = new QBCallout();
        QBPOQueryJSON queryJson = callout.getPurchaseOrder(po);
        system.debug(queryJson);
        //Check if a Purchase Order was found
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
        return new PageReference('/'+poId);
    }
}