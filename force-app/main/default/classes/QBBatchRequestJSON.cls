public class QBBatchRequestJSON {
    public List<BatchItemRequest> BatchItemRequest;
    
    public QBBatchRequestJSON() {
        BatchItemRequest = new List<BatchItemRequest>();
    }

    public class BatchItemRequest {
        public QBItemJSON Item;
        // add additional QB objects here
        // each batchItemRequest in list can be a different QB object
        
        public String bId;
        public String operation; // create, update, delete
    }

    public static QBBatchRequestJSON parse(String json) {
        return (QBBatchRequestJSON) System.JSON.deserialize(json, QBBatchRequestJSON.class);
    }
}

/* Sample - notice different QB object types in BatchItemRequest list
{
  "BatchItemRequest": [
    {
      "bId": "bid1", 
      "Vendor": {
        "DisplayName": "Smith Family Store"
      }, 
      "operation": "create"
    }, 
    {
      "bId": "bid2", 
      "operation": "delete", 
      "Invoice": {
        "SyncToken": "0", 
        "Id": "129"
      }
    }, 
    {
      "SalesReceipt": {
        "PrivateNote": "A private note.", 
        "SyncToken": "0", 
        "domain": "QBO", 
        "Id": "11", 
        "sparse": true
      }, 
      "bId": "bid3", 
      "operation": "update"
    }, 
    {
      "Query": "select * from SalesReceipt where TotalAmt > '300.00'", 
      "bId": "bid4"
    }
  ]
}
*/