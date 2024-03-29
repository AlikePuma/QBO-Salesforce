//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

@IsTest
public class QBItemQueryJSON_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"QueryResponse\": {'+
		'    \"startPosition\": 1, '+
		'    \"Item\": ['+
		'      {'+
		'        \"FullyQualifiedName\": \"Concrete\", '+
		'        \"domain\": \"QBO\", '+
		'        \"Name\": \"Concrete\", '+
		'        \"TrackQtyOnHand\": false, '+
		'        \"Type\": \"Service\", '+
		'        \"PurchaseCost\": 0, '+
		'        \"IncomeAccountRef\": {'+
		'          \"name\": \"Landscaping Services:Job Materials:Fountains and Garden Lighting\", '+
		'          \"value\": \"48\"'+
		'        }, '+
		'        \"Taxable\": true, '+
		'        \"MetaData\": {'+
		'          \"CreateTime\": \"2014-09-16T10:36:03-07:00\", '+
		'          \"LastUpdatedTime\": \"2014-09-19T12:47:47-07:00\"'+
		'        }, '+
		'        \"sparse\": false, '+
		'        \"Active\": true, '+
		'        \"SyncToken\": \"1\", '+
		'        \"UnitPrice\": 0, '+
		'        \"Id\": \"3\", '+
		'        \"Description\": \"Concrete for fountain installation\"'+
		'      }, '+
		'      {'+
		'        \"FullyQualifiedName\": \"Design\", '+
		'        \"domain\": \"QBO\", '+
		'        \"Name\": \"Design\", '+
		'        \"TrackQtyOnHand\": false, '+
		'        \"Type\": \"Service\", '+
		'        \"PurchaseCost\": 0, '+
		'        \"IncomeAccountRef\": {'+
		'          \"name\": \"Design income\", '+
		'          \"value\": \"82\"'+
		'        }, '+
		'        \"Taxable\": false, '+
		'        \"MetaData\": {'+
		'          \"CreateTime\": \"2014-09-16T10:41:38-07:00\", '+
		'          \"LastUpdatedTime\": \"2015-04-17T14:31:10-07:00\"'+
		'        }, '+
		'        \"sparse\": false, '+
		'        \"Active\": true, '+
		'        \"SyncToken\": \"1\", '+
		'        \"UnitPrice\": 75, '+
		'        \"Id\": \"4\", '+
		'        \"Description\": \"Custom Design\"'+
		'      }'+
		'    ], '+
		'    \"maxResults\": 2'+
		'  }, '+
		'  \"time\": \"2015-04-22T11:04:34.194-07:00\"'+
		'}';
		QBItemQueryJSON r = QBItemQueryJSON.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryJSON.Item objItem = new QBItemQueryJSON.Item(System.JSON.createParser(json));
		System.assert(objItem != null);
		System.assert(objItem.FullyQualifiedName == null);
		System.assert(objItem.domain == null);
		System.assert(objItem.Name == null);
		System.assert(objItem.TrackQtyOnHand == null);
		System.assert(objItem.Type == null);
		System.assert(objItem.PurchaseCost == null);
		System.assert(objItem.IncomeAccountRef == null);
		System.assert(objItem.Taxable == null);
		System.assert(objItem.MetaData == null);
		System.assert(objItem.sparse == null);
		System.assert(objItem.Active == null);
		System.assert(objItem.SyncToken == null);
		System.assert(objItem.UnitPrice == null);
		System.assert(objItem.Id == null);
		System.assert(objItem.Description == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryJSON.MetaData objMetaData = new QBItemQueryJSON.MetaData(System.JSON.createParser(json));
		System.assert(objMetaData != null);
		System.assert(objMetaData.CreateTime == null);
		System.assert(objMetaData.LastUpdatedTime == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryJSON.QueryResponse objQueryResponse = new QBItemQueryJSON.QueryResponse(System.JSON.createParser(json));
		System.assert(objQueryResponse != null);
		System.assert(objQueryResponse.startPosition == null);
		System.assert(objQueryResponse.Item == null);
		System.assert(objQueryResponse.maxResults == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryJSON objQBItemQueryJSON = new QBItemQueryJSON(System.JSON.createParser(json));
		System.assert(objQBItemQueryJSON != null);
		System.assert(objQBItemQueryJSON.QueryResponse == null);
		System.assert(objQBItemQueryJSON.time_Z == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryJSON.IncomeAccountRef objIncomeAccountRef = new QBItemQueryJSON.IncomeAccountRef(System.JSON.createParser(json));
		System.assert(objIncomeAccountRef != null);
		System.assert(objIncomeAccountRef.name == null);
		System.assert(objIncomeAccountRef.value == null);
	}
}