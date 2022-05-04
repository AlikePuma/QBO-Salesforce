@IsTest
public class QBBatchResponseJSON_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		' \"BatchItemResponse\": ['+
		'  {'+
		'   \"Fault\": {'+
		'    \"Error\": ['+
		'     {'+
		'      \"Message\": \"Duplicate Name Exists Error\",'+
		'      \"Detail\": \"The name supplied already exists. : Another product or service is already using this name. Please use a different name.\",'+
		'      \"code\": \"6240\",'+
		'      \"element\": \"\"'+
		'     }'+
		'    ],'+
		'    \"type\": \"ValidationFault\"'+
		'   },'+
		'   \"bId\": \"01t8c00000K4zXDAAZ\"'+
		'  },'+
		'  {'+
		'   \"Item\": {'+
		'    \"Name\": \"BG 109-105 x9\",'+
		'    \"Active\": true,'+
		'    \"SubItem\": true,'+
		'    \"ParentRef\": {'+
		'     \"value\": \"25\",'+
		'     \"name\": \"Dock Parts\"'+
		'    },'+
		'    \"Level\": 1,'+
		'    \"FullyQualifiedName\": \"Dock Parts:BG 109-105 x9\",'+
		'    \"Taxable\": true,'+
		'    \"UnitPrice\": 51,'+
		'    \"Type\": \"NonInventory\",'+
		'    \"IncomeAccountRef\": {'+
		'     \"value\": \"35\",'+
		'     \"name\": \"Checking\"'+
		'    },'+
		'    \"PurchaseCost\": 0,'+
		'    \"TrackQtyOnHand\": false,'+
		'    \"domain\": \"QBO\",'+
		'    \"sparse\": false,'+
		'    \"Id\": \"33\",'+
		'    \"SyncToken\": \"0\",'+
		'    \"MetaData\": {'+
		'     \"CreateTime\": \"2022-04-28T14:39:17-07:00\",'+
		'     \"LastUpdatedTime\": \"2022-04-28T14:39:17-07:00\"'+
		'    }'+
		'   },'+
		'   \"bId\": \"01t8c00000K4zXDAAr\"'+
		'  }'+
		' ],'+
		' \"time\": \"2022-04-28T14:39:17.786-07:00\"'+
		'}';
		QBBatchResponseJSON r = QBBatchResponseJSON.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBBatchResponseJSON.ParentRef objParentRef = new QBBatchResponseJSON.ParentRef(System.JSON.createParser(json));
		System.assert(objParentRef != null);
		System.assert(objParentRef.value == null);
		System.assert(objParentRef.name == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBBatchResponseJSON.Item objItem = new QBBatchResponseJSON.Item(System.JSON.createParser(json));
		System.assert(objItem != null);
		System.assert(objItem.Name == null);
		System.assert(objItem.Active == null);
		System.assert(objItem.SubItem == null);
		System.assert(objItem.ParentRef == null);
		System.assert(objItem.Level == null);
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
		QBBatchResponseJSON objQBBatchResponseJSON = new QBBatchResponseJSON(System.JSON.createParser(json));
		System.assert(objQBBatchResponseJSON != null);
		System.assert(objQBBatchResponseJSON.BatchItemResponse == null);
		System.assert(objQBBatchResponseJSON.time_Z == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBBatchResponseJSON.MetaData objMetaData = new QBBatchResponseJSON.MetaData(System.JSON.createParser(json));
		System.assert(objMetaData != null);
		System.assert(objMetaData.CreateTime == null);
		System.assert(objMetaData.LastUpdatedTime == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBBatchResponseJSON.Error objError = new QBBatchResponseJSON.Error(System.JSON.createParser(json));
		System.assert(objError != null);
		System.assert(objError.Message == null);
		System.assert(objError.Detail == null);
		System.assert(objError.code == null);
		System.assert(objError.element == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBBatchResponseJSON.Fault objFault = new QBBatchResponseJSON.Fault(System.JSON.createParser(json));
		System.assert(objFault != null);
		System.assert(objFault.Error == null);
		System.assert(objFault.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBBatchResponseJSON.BatchItemResponse objBatchItemResponse = new QBBatchResponseJSON.BatchItemResponse(System.JSON.createParser(json));
		System.assert(objBatchItemResponse != null);
		System.assert(objBatchItemResponse.Fault == null);
		System.assert(objBatchItemResponse.bId == null);
		System.assert(objBatchItemResponse.Item == null);
	}
}