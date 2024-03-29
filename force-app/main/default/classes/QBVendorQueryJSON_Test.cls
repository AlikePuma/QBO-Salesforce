@IsTest
public class QBVendorQueryJSON_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		' \"QueryResponse\": { '+
        ' \"startPosition\": 1, '+
        ' \"maxResults\": 1, '+
		' \"Vendor\": [' +
		'   { '+ 
		'    \"PrimaryEmailAddr\": {'+
		'      \"Address\": \"Books@Intuit.com\"'+
		'    }, '+
		'    \"Vendor1099\": false, '+
		'    \"domain\": \"QBO\", '+
		'    \"GivenName\": \"Bessie\", '+
		'    \"DisplayName\": \"Books by Bessie\", '+
		'    \"BillAddr\": {'+
		'      \"City\": \"Palo Alto\", '+
		'      \"Line1\": \"15 Main St.\", '+
		'      \"PostalCode\": \"94303\", '+
		'      \"Lat\": \"37.445013\", '+
		'      \"Long\": \"-122.1391443\", '+
		'      \"CountrySubDivisionCode\": \"CA\", '+
		'      \"Id\": \"31\"'+
		'    }, '+
		'    \"SyncToken\": \"0\", '+
		'    \"PrintOnCheckName\": \"Books by Bessie\", '+
		'    \"FamilyName\": \"Williams\", '+
		'    \"PrimaryPhone\": {'+
		'      \"FreeFormNumber\": \"(650) 555-7745\"'+
		'    }, '+
		'    \"Mobile\": {'+
		'      \"FreeFormNumber\": \"(650) 555-7745\"'+
		'    }, '+
		' 	\"TermRef\": { '+
              ' \"value\": \"NON\" '+
            ' }, '+
		'    \"TaxIdentifier\": \"99-5688293\", '+
		'    \"AcctNum\": \"1345\", '+
		'    \"CompanyName\": \"Books by Bessie\", '+
		'    \"WebAddr\": {'+
		'      \"URI\": \"http://www.booksbybessie.co\"'+
		'    }, '+
		'    \"sparse\": false, '+
		'    \"Active\": true, '+
		'    \"Balance\": 0, '+
		'    \"Id\": \"30\", '+
		'    \"MetaData\": {'+
		'      \"CreateTime\": \"2014-09-12T10:07:56-07:00\", '+
		'      \"LastUpdatedTime\": \"2014-09-17T11:13:46-07:00\"'+
		'    }'+
		' } '+
    	' ] '+
        ' }, '+
        ' \"time\": \"2015-07-24T10:38:50.01-07:00\" '+
        ' } ';
		QBVendorQueryJSON r = QBVendorQueryJSON.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBVendorQueryJSON.BillAddr objBillAddr = new QBVendorQueryJSON.BillAddr(System.JSON.createParser(json));
		System.assert(objBillAddr != null);
		System.assert(objBillAddr.City == null);
		System.assert(objBillAddr.Line1 == null);
		System.assert(objBillAddr.PostalCode == null);
		System.assert(objBillAddr.Lat == null);
		System.assert(objBillAddr.Long_Z == null);
		System.assert(objBillAddr.CountrySubDivisionCode == null);
		System.assert(objBillAddr.Id == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBVendorQueryJSON.PrimaryPhone objPrimaryPhone = new QBVendorQueryJSON.PrimaryPhone(System.JSON.createParser(json));
		System.assert(objPrimaryPhone != null);
		System.assert(objPrimaryPhone.FreeFormNumber == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBVendorQueryJSON.MetaData objMetaData = new QBVendorQueryJSON.MetaData(System.JSON.createParser(json));
		System.assert(objMetaData != null);
		System.assert(objMetaData.CreateTime == null);
		System.assert(objMetaData.LastUpdatedTime == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBVendorQueryJSON.Vendor objVendor = new QBVendorQueryJSON.Vendor(System.JSON.createParser(json));
		System.assert(objVendor != null);
		System.assert(objVendor.PrimaryEmailAddr == null);
		System.assert(objVendor.Vendor1099 == null);
		System.assert(objVendor.domain == null);
		System.assert(objVendor.GivenName == null);
		System.assert(objVendor.DisplayName == null);
		System.assert(objVendor.BillAddr == null);
		System.assert(objVendor.SyncToken == null);
		System.assert(objVendor.PrintOnCheckName == null);
		System.assert(objVendor.FamilyName == null);
		System.assert(objVendor.PrimaryPhone == null);
		System.assert(objVendor.AcctNum == null);
		System.assert(objVendor.CompanyName == null);
		System.assert(objVendor.WebAddr == null);
		System.assert(objVendor.sparse == null);
		System.assert(objVendor.Active == null);
		System.assert(objVendor.Balance == null);
		System.assert(objVendor.Id == null);
		System.assert(objVendor.MetaData == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBVendorQueryJSON.PrimaryEmailAddr objPrimaryEmailAddr = new QBVendorQueryJSON.PrimaryEmailAddr(System.JSON.createParser(json));
		System.assert(objPrimaryEmailAddr != null);
		System.assert(objPrimaryEmailAddr.Address == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBVendorQueryJSON objQBVendorQueryJSON = new QBVendorQueryJSON(System.JSON.createParser(json));
		System.assert(objQBVendorQueryJSON != null);
		//System.assert(objQBVendorQueryJSON.Vendor == null);
		System.assert(objQBVendorQueryJSON.time_Z == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		QBVendorQueryJSON.WebAddr objWebAddr = new QBVendorQueryJSON.WebAddr(System.JSON.createParser(json));
		System.assert(objWebAddr != null);
		System.assert(objWebAddr.URI == null);
	}
}