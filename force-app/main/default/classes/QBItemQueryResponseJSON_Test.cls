@IsTest
public class QBItemQueryResponseJSON_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		' \"QueryResponse\": {'+
		'  \"Item\": ['+
		'   {'+
		'    \"Name\": \"Concrete\",'+
		'    \"Description\": \"Concrete for fountain installation\",'+
		'    \"Active\": true,'+
		'    \"FullyQualifiedName\": \"Concrete\",'+
		'    \"Taxable\": true,'+
		'    \"UnitPrice\": 0,'+
		'    \"Type\": \"Service\",'+
		'    \"IncomeAccountRef\": {'+
		'     \"value\": \"48\",'+
		'     \"name\": \"Fountains and Garden Lighting\"'+
		'    },'+
		'    \"PurchaseCost\": 0,'+
		'    \"TrackQtyOnHand\": false,'+
		'    \"domain\": \"QBO\",'+
		'    \"sparse\": false,'+
		'    \"Id\": \"3\",'+
		'    \"SyncToken\": \"1\",'+
		'    \"MetaData\": {'+
		'     \"CreateTime\": \"2022-03-27T10:36:03-07:00\",'+
		'     \"LastUpdatedTime\": \"2022-03-30T12:47:47-07:00\"'+
		'    }'+
		'   }'+
		'  ],'+
		'  \"startPosition\": 1,'+
		'  \"maxResults\": 1'+
		' },'+
		' \"time\": \"2022-04-28T17:09:13.858-07:00\"'+
		'}';
		QBItemQueryResponseJSON r = QBItemQueryResponseJSON.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryResponseJSON.Item objItem = new QBItemQueryResponseJSON.Item(System.JSON.createParser(json));
		System.assert(objItem != null);
		System.assert(objItem.Name == null);
		System.assert(objItem.Description == null);
		System.assert(objItem.Active == null);
		System.assert(objItem.FullyQualifiedName == null);
		System.assert(objItem.Taxable == null);
		System.assert(objItem.UnitPrice == null);
		System.assert(objItem.Type == null);
		System.assert(objItem.IncomeAccountRef == null);
		System.assert(objItem.PurchaseCost == null);
		System.assert(objItem.TrackQtyOnHand == null);
		System.assert(objItem.domain == null);
		System.assert(objItem.sparse == null);
		System.assert(objItem.Id == null);
		System.assert(objItem.SyncToken == null);
		System.assert(objItem.MetaData == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryResponseJSON.MetaData objMetaData = new QBItemQueryResponseJSON.MetaData(System.JSON.createParser(json));
		System.assert(objMetaData != null);
		System.assert(objMetaData.CreateTime == null);
		System.assert(objMetaData.LastUpdatedTime == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryResponseJSON.QueryResponse objQueryResponse = new QBItemQueryResponseJSON.QueryResponse(System.JSON.createParser(json));
		System.assert(objQueryResponse != null);
		System.assert(objQueryResponse.Item == null);
		System.assert(objQueryResponse.startPosition == null);
		System.assert(objQueryResponse.maxResults == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryResponseJSON.IncomeAccountRef objIncomeAccountRef = new QBItemQueryResponseJSON.IncomeAccountRef(System.JSON.createParser(json));
		System.assert(objIncomeAccountRef != null);
		System.assert(objIncomeAccountRef.value == null);
		System.assert(objIncomeAccountRef.name == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemQueryResponseJSON objQBItemQueryResponseJSON = new QBItemQueryResponseJSON(System.JSON.createParser(json));
		System.assert(objQBItemQueryResponseJSON != null);
		System.assert(objQBItemQueryResponseJSON.QueryResponse == null);
		System.assert(objQBItemQueryResponseJSON.time_Z == null);
	}
}