public class QBWorkOrder_Controller {
    public Map<Id, WorkOrderLineItem> woliMap {get;set;}
    public Map<Id, Product2> productsNotInQBMap {get;set;}
    public List<QBProductAndWoliWrapper> wrappers {get;set;}
    public List<Product2> productsToUpdate {get;set;}
    public Invoice__c inv {get;set;}

    public void wrapWOliAndProduct(Invoice__c inv){ // inv needs to have Work_Order__c
        List<Id> productIds;
        Set<Id> productIdsNotInQB;

        woliMap = new Map<ID, WorkOrderLineItem>([SELECT Id, Subtotal, Description, Quantity, PricebookEntry.Product2.Name, 
                    UnitPrice, PricebookEntry.Product2.Id, PricebookEntry.Product2.QBO_Id__c, PricebookEntry.Product2.Family
                    FROM WorkOrderLineItem 
                    WHERE WorkOrderId =: inv.Work_Order__c]);
        
        // Ensure all products have a QBO_ID (meaning they're in QB), if not add to QB
        productIds = new List<Id>();
        
        for(WorkOrderLineItem woli : woliMap.values()){
            productIds.add(woli.PricebookEntry.Product2.Id);
           
        }
        productsNotInQBMap = new Map<Id, Product2>([SELECT Id, QBO_Id__c, Name 
                        FROM Product2 
                        WHERE Id IN :productIds 
                        AND (Product2.QBO_Id__c = null 
                        OR Product2.QBO_Id__c = '')]);

        productIdsNotInQB = productsNotInQBMap.keySet();

        // create wrapper objects 
        wrappers = new List<QBProductAndWoliWrapper>();
        for(Id prodId : productIdsNotInQB){
            QBProductAndWoliWrapper pToI = new QBProductAndWoliWrapper();
            pToI.product = productsNotInQBMap.get(prodId);
            for(WorkOrderLineItem woli : woliMap.values()){
                if(woli.PricebookEntry.Product2.Id == prodId){
                    pToI.woli = woli;
                }
            }
            wrappers.add(pToI);
        }
    }

    public List<Product2> createItemsQbBatch(Invoice__c inv){
        productsToUpdate = new List<Product2>();
        QBCallout callout = new QBCallout();
        this.inv = inv;
        
        wrapWOliAndProduct(inv);

        if(wrappers.size() > 0){ 
            // Pas s along to have items created in QB
            QBBatchResponseJSON res = callout.createQbBatchCall(wrappers);

            if(res.BatchItemResponse.size() > 0){
                for(QBBatchResponseJSON.BatchItemResponse bir : res.BatchItemResponse){
                    if(bir.Fault == null){
                        String prodId = bir.bId;
                        Product2 prod = productsNotInQBMap.get(prodId);
                        if (prod != null) {
                            prod.QBO_Id__c = bir.Item.Id;
                            productsToUpdate.add(prod);
                        }
                        
                        inv.QBO_Callout_Status__c = 'Success';
                        inv.Error_Detail__c = '';
                    } else {
                        inv.Error_Detail__c = bir.Fault.Error[0].Detail + 
                        '\nCode: ' + bir.Fault.Error[0].Code +
                        '\nProduct ID: ' + bir.bId;

                        inv.QBO_Callout_Status__c = 'Error';
                    }
                }
            }
        }
        return productsToUpdate;
    }
}