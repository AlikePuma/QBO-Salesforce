@IsTest
public with sharing class QBBatchRequestJSON_Test {
        
    static testMethod void testParse() {
        String json = '{ ' +
            '\"BatchItemRequest\": [ '+
            '{ '+
                '\"bId": \"bid1\", '+
                '\"operation\": \"create\", '+
                '\"Item\": {' +
                    '  \"TrackQtyOnHand\": false, '+
                    '  \"Name\": \"Product Name 113\", '+
                    '  \"UnitPrice\": 25.00,'+
                    '  \"Taxable\": true,'+
                    '  \"IncomeAccountRef\": {'+
                    '    \"name\": \"Checking\", '+
                    '    \"value\": \"79\"'+
                    '  }, '+
                    '  \"Type\": \"NonInventory\"'+
                '}' +
            '}' +
            ']'+
        '}';
        QBBatchRequestJSON obj = QBBatchRequestJSON.parse(json);
        System.assert(obj != null);
    }
}