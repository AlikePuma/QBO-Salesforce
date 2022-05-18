public with sharing class QBProductSync_Controller {

 
    @InvocableMethod(label='Sync Item' description='Creates and syncs product with QB item' category= 'Product2')
    public static void callFromFlow(List<Id> p2Id){
        System.debug('********** In QBProductSync_Controller');

		Product2 p = [SELECT Id,
                      Name, 
                      QBO_Id__c, 
                      QBO_SyncToken__c,
                      Income_Account__c,
                      Expense_Account__c,
                      Sell_Product_Service__c,
                      Purchase_Product_Service__c                
                    FROM Product2 
                    WHERE Id =: p2Id[0]]; 
        
        QBCallout callout = new QBCallout();
        QBItemQueryJSON queryJson = callout.getItem(p);
        system.debug(queryJson);
        
        //*****  ONE WAY SYNC - SF TO QB *****/
        if(queryJson != null && queryJson.QueryResponse.Item != null){ // Item found in QB
            if(queryJson.QueryResponse.Item.size() == 1){
                //p.QBO_Id__c = queryJson.QueryResponse.Item[0].Id;
                //p.QBO_SyncToken__c = queryJson.QueryResponse.Item[0].SyncToken;
                
                // Sync new SF Product data w/ QB Item
                QBItemResponseJSON res = callout.createItemCall(p);
                p.QBO_Id__c = res.Item.Id;
                p.QBO_SyncToken__c = res.Item.SyncToken;

            }else{  // Multiple Items returned from QB Error Handling
               throw new ListException(); 
            }
        } else {  // Item not found in QB, create
            QBItemResponseJSON res = callout.createItemCall(p);
            p.QBO_Id__c = res.Item.Id;
            p.QBO_SyncToken__c = res.Item.SyncToken;
        }

        
        update p;  // DML After Callouts
        
    }
}