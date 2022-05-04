@IsTest
public class QBItemResponseJSON_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		' \"Item\": {'+
		'  \"Name\": \"Product Name 113\",'+
		'  \"Active\": true,'+
		'  \"FullyQualifiedName\": \"Product Name 113\",'+
		'  \"Taxable\": false,'+
		'  \"UnitPrice\": 25,'+
		'  \"Type\": \"NonInventory\",'+
		'  \"IncomeAccountRef\": {'+
		'   \"value\": \"79\",'+
		'   \"name\": \"Sales of Product Income\"'+
		'  },'+
		'  \"PurchaseCost\": 0,'+
		'  \"TrackQtyOnHand\": false,'+
		'  \"domain\": \"QBO\",'+
		'  \"sparse\": false,'+
		'  \"Id\": \"23\",'+
		'  \"SyncToken\": \"0\",'+
		'  \"MetaData\": {'+
		'   \"CreateTime\": \"2022-04-27T14:39:15-07:00\",'+
		'   \"LastUpdatedTime\": \"2022-04-27T14:39:15-07:00\"'+
		'  }'+
		' },'+
		' \"time\": \"2022-04-27T14:39:15.051-07:00\"'+
		'}';
		QBItemResponseJSON r = QBItemResponseJSON.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemResponseJSON.Item objItem = new QBItemResponseJSON.Item(System.JSON.createParser(json));
		System.assert(objItem != null);
		System.assert(objItem.Name == null);
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
		QBItemResponseJSON.MetaData objMetaData = new QBItemResponseJSON.MetaData(System.JSON.createParser(json));
		System.assert(objMetaData != null);
		System.assert(objMetaData.CreateTime == null);
		System.assert(objMetaData.LastUpdatedTime == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemResponseJSON objQBItemResponseJSON = new QBItemResponseJSON(System.JSON.createParser(json));
		System.assert(objQBItemResponseJSON != null);
		System.assert(objQBItemResponseJSON.Item == null);
		System.assert(objQBItemResponseJSON.time_Z == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBItemResponseJSON.IncomeAccountRef objIncomeAccountRef = new QBItemResponseJSON.IncomeAccountRef(System.JSON.createParser(json));
		System.assert(objIncomeAccountRef != null);
		System.assert(objIncomeAccountRef.value == null);
		System.assert(objIncomeAccountRef.name == null);
	}
}