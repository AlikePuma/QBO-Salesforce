public with sharing class QBPOSync_Controller {
    @InvocableMethod(label='Sync Purchase Order' description='Creates and syncs PO with QB PO' category= 'Purchase Order')
    public static void callFromFlow(List<Id> poId){
        Purchase_Order__c po = [SELECT Id,
                                Name, 
                                QBO_Id__c, 
                                QBO_SyncToken__c
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
        //QBWorkOrder_Controller woController = new QBWorkOrder_Controller();
        //woController.wrapWOliAndProduct(inv);
        QBPOResponseJSON res = callout.createPurchaseOrderCall(po,new List<Purchase_Order_Item__c>());        
        po.QBO_Id__c = res.PurchaseOrder.Id;
        po.QBO_SyncToken__c = res.PurchaseOrder.SyncToken;
        //DML After Callouts
        update po;
    }    
}
