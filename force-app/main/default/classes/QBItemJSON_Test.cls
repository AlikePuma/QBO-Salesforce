@IsTest
public class QBItemJSON_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'  \"TrackQtyOnHand\": false, '+
		'  \"Name\": \"Product Name 113\", '+
		'  \"UnitPrice\": 25.00,'+
		'  \"Taxable\": true,'+
		'  \"IncomeAccountRef\": {'+
		'    \"name\": \"Checking\", '+
		'    \"value\": \"79\"'+
		'  }, '+
		'  \"Type\": \"NonInventory\"'+
		'}';
		QBItemJSON obj = QBItemJSON.parse(json);
		System.assert(obj != null);
	}
}