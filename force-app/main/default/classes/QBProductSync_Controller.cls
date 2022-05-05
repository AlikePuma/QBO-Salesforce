public with sharing class QBProductSync_Controller {

 
    @InvocableMethod(label='Sync Item' description='Creates and syncs product with QB item' category= 'Product2')
    public static void callFromFlow(List<Id> p2Id){
		Product2 p = [SELECT Id,
                      Name, 
                      QBO_Id__c, 
                      QBO_SyncToken__c                     
              FROM Product2 
              WHERE Id =: p2Id[0]]; 
        
        QBCallout callout = new QBCallout();
        QBItemQueryJSON queryJson = callout.getItem(p);
        system.debug(queryJson);
        //Check if a item was found
        if(queryJson != null&&queryJson.QueryResponse.Item!=null){
            if(queryJson.QueryResponse.Item.size() == 1){
                p.QBO_Id__c = queryJson.QueryResponse.Item[0].Id;
                p.QBO_SyncToken__c = queryJson.QueryResponse.Item[0].SyncToken;
            }else{
                //Multiple Customer Error Handling
               throw new ListException(); 
            }
        }else{
            QBItemResponseJSON res = callout.createItemCall(p);
            p.QBO_Id__c = res.Item.Id;
            p.QBO_SyncToken__c = res.Item.SyncToken;
        }
        //DML After Callouts
        update p;
        
    }
}