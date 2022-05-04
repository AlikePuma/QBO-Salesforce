public with sharing class QBProductSync_Controller {

    public Id pId{get;set;}
    public Product2 p {get;set;}

    public QBProductSync_Controller(ApexPages.StandardController stdController) {
        pId = ApexPages.currentPage().getParameters().get('id');
        p = [SELECT Id,
                      Name, 
                      QBO_Id__c, 
                      QBO_SyncToken__c                     
              FROM Product2 
              WHERE Id =: pId];
    }

    public Pagereference syncQB(){
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
        return new PageReference('/'+pId);
    }
}
