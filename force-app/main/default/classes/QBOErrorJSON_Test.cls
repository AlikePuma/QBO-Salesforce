@IsTest
public class QBOErrorJSON_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{\"Fault\":{\"Error\":[{\"Message\":\"A business validation error has occurred while processing your request\",\"Detail\":\"Business Validation Error: Were sorry, QuickBooks encountered an error while calculating tax. Try reselecting the tax rate or reentering the product/service item and saving the form again.\",\"code\":\"6000\",\"element\":\"\"}],\"type\":\"ValidationFault\"},\"time\":\"2019-11-06T21:40:41.673-08:00\"}';
		QBOErrorJSON r = QBOErrorJSON.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBOErrorJSON objQBOErrorJSON = new QBOErrorJSON(System.JSON.createParser(json));
		System.assert(objQBOErrorJSON != null);
		System.assert(objQBOErrorJSON.Fault == null);
		System.assert(objQBOErrorJSON.time_x == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBOErrorJSON.Error objError = new QBOErrorJSON.Error(System.JSON.createParser(json));
		System.assert(objError != null);
		System.assert(objError.Message == null);
		System.assert(objError.Detail == null);
		System.assert(objError.code == null);
		System.assert(objError.element == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBOErrorJSON.Fault objFault = new QBOErrorJSON.Fault(System.JSON.createParser(json));
		System.assert(objFault != null);
		System.assert(objFault.Error == null);
		System.assert(objFault.type_Z == null);
	}
}