@IsTest
public class QBPOJSON_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"PurchaseOrder\": {'+
		'    \"DocNumber\": \"1005\", '+
		'    \"SyncToken\": \"0\", '+
		'    \"POEmail\": {'+
		'      \"Address\": \"send_email@intuit.com\"'+
		'    }, '+
		'    \"APAccountRef\": {'+
		'      \"name\": \"Accounts Payable (A/P)\", '+
		'      \"value\": \"33\"'+
		'    }, '+
		'    \"CurrencyRef\": {'+
		'      \"name\": \"United States Dollar\", '+
		'      \"value\": \"USD\"'+
		'    }, '+
		'    \"TxnDate\": \"2015-07-28\", '+
		'    \"TotalAmt\": 25.0, '+
		'    \"ShipAddr\": {'+
		'      \"Line4\": \"Half Moon Bay, CA  94213\", '+
		'      \"Line3\": \"65 Ocean Dr.\", '+
		'      \"Id\": \"121\", '+
		'      \"Line1\": \"Grace Pariente\", '+
		'      \"Line2\": \"Cool Cars\"'+
		'    }, '+
		'    \"domain\": \"QBO\", '+
		'    \"Id\": \"257\", '+
		'    \"POStatus\": \"Open\", '+
		'    \"sparse\": false, '+
		'    \"EmailStatus\": \"NotSet\", '+
		'    \"VendorRef\": {'+
		'      \"name\": \"Hicks Hardware\", '+
		'      \"value\": \"41\"'+
		'    }, '+
		'    \"Line\": ['+
		'      {'+
		'        \"DetailType\": \"ItemBasedExpenseLineDetail\", '+
		'        \"Amount\": 25.0, '+
		'        \"Id\": \"1\", '+
		'        \"ItemBasedExpenseLineDetail\": {'+
		'          \"ItemRef\": {'+
		'            \"name\": \"Garden Supplies\", '+
		'            \"value\": \"38\"'+
		'          }, '+
		'          \"CustomerRef\": {'+
		'            \"name\": \"Cool Cars\", '+
		'            \"value\": \"3\"'+
		'          }, '+
		'          \"Qty\": 1, '+
		'          \"TaxCodeRef\": {'+
		'            \"value\": \"NON\"'+
		'          }, '+
		'          \"BillableStatus\": \"NotBillable\", '+
		'          \"UnitPrice\": 25'+
		'        }'+
		'      }'+
		'    ], '+
		'    \"CustomField\": ['+
		'      {'+
		'        \"DefinitionId\": \"1\", '+
		'        \"Type\": \"StringType\", '+
		'        \"Name\": \"Crew #\"'+
		'      }, '+
		'      {'+
		'        \"DefinitionId\": \"2\", '+
		'        \"Type\": \"StringType\", '+
		'        \"Name\": \"Sales Rep\"'+
		'      }'+
		'    ], '+
		'    \"VendorAddr\": {'+
		'      \"Line4\": \"Middlefield, CA  94303\", '+
		'      \"Line3\": \"42 Main St.\", '+
		'      \"Id\": \"120\", '+
		'      \"Line1\": \"Geoff Hicks\", '+
		'      \"Line2\": \"Hicks Hardware\"'+
		'    }, '+
		'    \"MetaData\": {'+
		'      \"CreateTime\": \"2015-07-28T16:01:47-07:00\", '+
		'      \"LastUpdatedTime\": \"2015-07-28T16:01:47-07:00\"'+
		'    }'+
		'  }, '+
		'  \"time\": \"2015-07-28T16:04:49.874-07:00\"'+
		'}';
		QBPOJSON r = QBPOJSON.parse(json);
		System.assert(r != null);
	}
}
