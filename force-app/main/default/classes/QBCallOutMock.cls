/*
This class is used for the test purpose. It implements HttpCalloutMock.
All the callout request comes here. All the requests returns httpresponse
based on request endpoint
*/
public with sharing class QBCallOutMock implements HttpCalloutMock {
    
  public QBCallOutMock() {

  }

  public HTTPResponse respond(HTTPRequest req) {
      String jsonResponse;
      HTTPResponse res = new HTTPResponse();
      res.setStatusCode(200);
      res.setStatus('ok');
      
      system.debug('I am in the mock - request endpoint -- ' + req.getEndpoint());

      if (req.getEndpoint().containsIgnoreCase('Select+*+from+Customer')) { //getCustomer
          jsonResponse = '{ '+
              '   \"QueryResponse\": { '+
              '   \"Customer\": [ '+
              '    { '+
              '      \"domain\": \"QBO\", '+
              '      \"FamilyName\": \"Lauterbach\", '+
              '     \"DisplayName\": \"Amy\'s Bird Sanctuary\", '+
              '      \"DefaultTaxCodeRef\": { '+
              '        \"value\": \"2\" '+
              '      }, '+
              '      \"PrimaryEmailAddr\": {'+
              '        \"Address\": \"Birds@Intuit.com\" '+
              '      }, '+
              '      \"PreferredDeliveryMethod\": \"Print\", '+
              '      \"GivenName\": \"Amy\", '+
              '      \"FullyQualifiedName\": \"Amy\'s Bird Sanctuary\", '+
              '      \"BillWithParent\": false, '+
              '      \"Job\": false, '+
              '      \"BalanceWithJobs\": 274.0, '+
              '      \"PrimaryPhone\": { '+
              '        \"FreeFormNumber\": \"(650) 555-3311\" '+
              '      }, '+
              '      \"Active\": true, '+
              '      \"MetaData\": { '+
              '        \"CreateTime\": \"2014-09-11T16:48:43-07:00\", '+
              '        \"LastUpdatedTime\": \"2015-07-01T10:14:15-07:00\" '+
              '      }, '+
              '      \"BillAddr\": { '+
                  '        \"City\": \"Bayshore\", '+
                  '    \"Line1\": \"4581 Finch St.\", '+ 
                  '    \"PostalCode\": \"94326\", '+ 
                  '    \"Lat\": \"INVALID\", '+
                  '    \"Long\": \"INVALID\", '+
                  '    \"CountrySubDivisionCode\": \"CA\", '+
                  '    \"Id\": \"2\" '+
                  '  }, '+
                  '  \"MiddleName\": \"Michelle\", '+
                  '  \"Notes\": \"Note added via Update operation.\", '+
                  '  \"Taxable\": true, '+
                  '  \"Balance\": 274.0, '+
                  '  \"SyncToken\": \"5\", '+
                  '  \"CompanyName\": \"Amy\'s Bird Sanctuary\", '+
                  '  \"ShipAddr\": { '+
                      ' \"City\": \"Bayshore\", '+
                      ' \"Line1\": \"4581 Finch St.\", '+
                      ' \"PostalCode\": \"94326\", '+
                      ' \"Lat\": \"INVALID\", '+
                      ' \"Long\": \"INVALID\", '+
                      ' \"CountrySubDivisionCode\": \"CA\", '+
                      ' \"Id\": \"109\" '+
                     '}, '+
                  '  \"PrintOnCheckName\": \"Amy\'s Bird Sanctuary\", '+
                  '  \"sparse\": false, '+
                  '  \"Id\": \"1\" '+
                  ' } '+
              ' ], '+
              '  \"startPosition\": 1, '+ 
              '  \"maxResults\": 6 '+
              ' }, '+
              ' \"time\": \"2015-07-23T11:02:25.149-07:00\" '+
          '} ';
      }
      else if (req.getEndpoint().containsIgnoreCase('/customer?')) { //createCustomerCall
          jsonResponse = '{ '+
              ' \"Customer\": { '+
              ' \"domain\": \"QBO\", '+
              ' \"PrimaryEmailAddr\": { '+
                  ' \"Address\": \"jdrew@myemail.com\" '+
                  ' }, '+
                  ' \"DisplayName\": \"King\'s Groceries\", '+
                  ' \"CurrencyRef\": { '+
                  ' \"name\": \"United States Dollar\", '+
                  ' \"value\": \"USD\" '+
              ' }, '+
              ' \"DefaultTaxCodeRef\": { '+
                  ' \"value\": \"2\" '+
              ' }, '+
              ' \"PreferredDeliveryMethod\": \"Print\", '+
              ' \"GivenName\": \"James\", '+
              ' \"FullyQualifiedName\": \"King\'s Groceries\", '+
              ' \"BillWithParent\": false, '+
              ' \"Title\": \"Mr\", '+
              ' \"Job\": false, '+
              ' \"BalanceWithJobs\": 0, '+
              ' \"PrimaryPhone\": { '+
                  ' \"FreeFormNumber\": \"(555) 555-5555\" '+
              ' }, '+
              ' \"Taxable\": true, '+
              ' \"MetaData\": { '+
                  ' \"CreateTime\": \"2015-07-23T10:58:12-07:00\", '+
                  ' \"LastUpdatedTime\": \"2015-07-23T10:58:12-07:00\" '+
                ' }, '+
                ' \"BillAddr\": { '+
                  ' \"City\": \"Mountain View\", '+
                  ' \"Country\": \"USA\", '+
                  ' \"Line1\": \"123 Main Street\", '+
                  ' \"PostalCode\": \"94042\", '+
                  ' \"CountrySubDivisionCode\": \"CA\", '+
                  ' \"Id\": \"112\" '+
                  ' }, '+
              ' \"MiddleName\": \"B\", '+
              ' \"Notes\": \"Here are other details.\", '+
              ' \"Active\": true, '+
              ' \"Balance\": 0, '+
              ' \"SyncToken\": \"0\", '+
              ' \"Suffix\": \"Jr\", '+
              ' \"CompanyName\": \"King Groceries\", '+
              ' \"FamilyName\": \"King\", '+
              ' \"PrintOnCheckName\": \"King Groceries\", '+
              ' \"sparse\": false, '+
              ' \"Id\": \"67\" '+
              ' }, '+
              ' \"time\": \"2015-07-23T10:58:12.099-07:00\" '+
          ' }';  
      }
      else if (req.getEndpoint().containsIgnoreCase('Select+*+from+invoice')) { //getInvoice
          jsonResponse = ' { '+
          ' \"QueryResponse\": { '+
            ' \"startPosition\": 1, '+
            ' \"totalCount\": 1, '+
            ' \"maxResults\": 1, '+
            ' \"Invoice\": ['+'  '+
              ' { '+
                ' \"DocNumber\": \"1070\", '+
                ' \"SyncToken\": \"0\", '+
                ' \"domain\": \"QBO\", '+
                ' \"Balance\": 150.0, '+
                '\"AllowIPNPayment\": false, '+
                '\"AllowOnlinePayment\": false, '+
                '\"AllowOnlineACHPayment\": false, '+
                '\"AllowOnlineCreditCardPayment\": false, '+
                ' \"BillAddr\": {'+'  '+
                  ' \"City\": \"Bayshore\", '+
                  ' \"Line1\": \"4581 Finch St.\", '+
                  ' \"PostalCode\": \"94326\", '+
                  ' \"Lat\": \"INVALID\", '+'  '+
                  ' \"Long\": \"INVALID\", '+
                  ' \"CountrySubDivisionCode\": \"CA\", '+
                  ' \"Id\": \"2\" '+
                ' }, '+
                ' \"TxnDate\": \"2015-07-24\", '+
                ' \"TotalAmt\": 150.0, '+
                ' \"CustomerRef\": { '+
                  ' \"name\": \"Amy\'s Bird Sanctuary\", '+
                  ' \"value\": \"1\" '+
                ' }, '+
                ' \"CurrencyRef\": { '+
                  ' \"name\": \"USA\", '+
                  ' \"value\": \"1\" '+
                ' }, '+
                ' \"SalesTermRef\": { '+
                   ' \"value\": \"NON\" '+
                  ' }, '+
                ' \"CustomerMemo\": { '+
                  ' \"value\": \"NON\" '+
                 ' }, '+
                ' \"ShipAddr\": { '+
                  ' \"City\": \"Bayshore\", '+
                  ' \"Line1\": \"4581 Finch St.\", '+
                  ' \"PostalCode\": \"94326\", '+
                  ' \"Lat\": \"INVALID\", '+
                  ' \"Long\": \"INVALID\", '+
                  ' \"CountrySubDivisionCode\": \"CA\", '+
                  ' \"Id\": \"109\" '+
                ' }, '+
                ' \"LinkedTxn\": [], '+
                ' \"DueDate\": \"2015-08-23\", '+
                ' \"PrintStatus\": \"NeedToPrint\", '+
                ' \"Deposit\": 0, '+
                ' \"sparse\": false, '+
                ' \"EmailStatus\": \"NotSet\", '+
                ' \"Line\": [ '+
                  ' { '+
                    ' \"LineNum\": 1, '+
                    ' \"Amount\": 150.0, '+
                    ' \"SalesItemLineDetail\": { '+
                      ' \"TaxCodeRef\": { '+
                        ' \"value\": \"NON\" '+
                      ' }, '+
                      ' \"ItemRef\": { '+
                        ' \"name\": \"Services\", '+
                        ' \"value\": \"1\"'+'  '+
                      ' }, '+
                      ' \"ItemAccountRef\": { '+
                        ' \"name\": \"Services\", '+
                        ' \"value\": \"1\"'+'  '+
                      ' } '+
                    ' }, '+
                    ' \"Id\": \"1\", '+
                    ' \"DetailType\": \"SalesItemLineDetail\" '+
                  ' }, '+
                  ' { '+
                    ' \"DetailType\": \"SubTotalLineDetail\", '+
                    ' \"Amount\": 150.0, '+
                    ' \"SubTotalLineDetail\": {} '+
                  ' } '+
                ' ], '+
                ' \"ApplyTaxAfterDiscount\": false, '+
                ' \"CustomField\": [ '+
                  ' { '+
                    ' \"DefinitionId\": \"1\", '+
                    ' \"Type\": \"StringType\", '+
                    ' \"Name\": \"Crew #\" '+
                  ' } '+
                ' ], '+
                ' \"Id\": \"239\", '+
                ' \"TxnTaxDetail\": { '+
                  ' \"TotalTax\": 0 '+
                ' }, '+
                ' \"MetaData\": { '+
                  ' \"CreateTime\": \"2015-07-24T10:35:08-07:00\", '+
                  ' \"LastUpdatedTime\": \"2015-07-24T10:35:08-07:00\" '+
                ' } '+
              ' } '+
            ' ] '+
          ' }, '+
          ' \"time\": \"2015-07-24T10:38:50.01-07:00\" '+
         ' } ';
      }
      else if (req.getEndpoint().containsIgnoreCase('/batch')) { //createQbBatchCall
          jsonResponse = '{'+
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
              '       \"value\": \"25\",'+
              '       \"name\": \"Dock Parts\"'+
              '     },'+
              '    \"Level\": 1,'+
              '    \"FullyQualifiedName\": \"Dock Parts:BG 109-105 x9\",'+
              '    \"Taxable\": true,'+
              '    \"UnitPrice\": 51,'+
              '    \"Type\": \"NonInventory\",'+
              '    \"IncomeAccountRef\": {'+
              '       \"value\": \"35\",'+
              '       \"name\": \"Checking\"'+
              '    },'+
              '    \"PurchaseCost\": 0,'+
              '    \"TrackQtyOnHand\": false,'+
              '    \"domain\": \"QBO\",'+
              '    \"sparse\": false,'+
              '    \"Id\": \"33\",'+
              '    \"SyncToken\": \"0\",'+
              '    \"MetaData\": {'+
              '       \"CreateTime\": \"2022-04-28T14:39:17-07:00\",'+
              '       \"LastUpdatedTime\": \"2022-04-28T14:39:17-07:00\"'+
              '    }'+
              '   },'+
              '   \"bId\": \"01t8c00000K4zXDAAr\"'+
              '  }'+
              ' ],'+
              ' \"time\": \"2022-04-28T14:39:17.786-07:00\"'+
          '}';
      }
      else if (req.getEndpoint().containsIgnoreCase('/invoice')) { //createInvoiceFromWorkOrderCall
          jsonResponse = '{'+
              '\"Invoice\": {'+
              '\"TxnDate\": \"2015-07-24\",'+
              '\"domain\": \"QBO\", '+
              '\"PrintStatus\": \"NeedToPrint\", '+
              '\"SalesTermRef\": {'+
              '      \"value\": \"3\"'+
              '    }, '+
              '\"TotalAmt\": 150.0, '+
              '\"Line\": ['+
              '{'+
                  '\"LineNum\": 1, '+
                  '\"Description\": \"Rock Fountain\", '+
                  '\"Amount\": 150.0, '+
                  '\"SalesItemLineDetail\": {'+
                  '\"TaxCodeRef\": {'+
                      '\"value\": \"NON\"'+
                  '}, '+
                  '\"ItemRef\": {'+
                      '\"name\": \"Services\", '+
                      '\"value\": \"1\"'+
                  '},'+
                  '\"ItemAccountRef\": {'+
                      '\"name\": \"Services\", '+
                      '\"value\": \"1\"'+
                  '}'+
                  '}, '+
                  '\"Id\": \"1\", '+
                  '\"DetailType\": \"SalesItemLineDetail\"'+
              '}, '+
              '{'+
                  '\"DetailType\": \"SubTotalLineDetail\", '+
                  '\"Amount\": 150.0, '+
                  '\"SubTotalLineDetail\": {}'+
              '}'+
              '], '+
              '\"DueDate\": \"2015-08-23\", '+
              '\"ApplyTaxAfterDiscount\": false, '+
              '\"DocNumber\": \"1070\", '+
              '\"sparse\": false, '+
              '\"CustomerMemo\": {'+
                 '\"value\": \"Added customer memo.\"'+
              '}, '+
              '\"Deposit\": 0, '+
              '\"Balance\": 150.0, '+
              '\"AllowIPNPayment\": false, '+
              '\"AllowOnlinePayment\": false, '+
              '\"AllowOnlineACHPayment\": false, '+
              '\"AllowOnlineCreditCardPayment\": false, '+
              '\"CustomerRef\": {'+
                  '\"name\": \"Amy\'s Bird Sanctuary\", '+
                  '\"value\": \"1\"'+
              '}, '+
              '\"TxnTaxDetail\": {'+
              '   \"TxnTaxCodeRef\": {'+
              '        \"value\": \"2\"'+
              '   }, '+
              '   \"TotalTax\": 26.82, '+
              '   \"TaxLine\": ['+
              '   {'+
              '       \"DetailType\": \"TaxLineDetail\", '+
              '       \"Amount\": 26.82, '+
              '       \"TaxLineDetail\": {'+
              '           \"NetAmountTaxable\": 335.25, '+
              '           \"TaxPercent\": 8, '+
              '           \"TaxRateRef\": {'+
              '               \"value\": \"3\"'+
              '           }, '+
              '           \"PercentBased\": true'+
              '       }'+
              '   }'+
              '   ]'+
              '}, '+
              '\"CurrencyRef\": {'+
                  '\"name\": \"USA\", '+
                  '\"value\": \"dollar\"'+
              '}, '+
              '\"SalesTermRef\": {'+
                  '\"value\": \"NON\"'+
              '}, '+
              '\"SyncToken\": \"1\", '+
              '\"LinkedTxn\": [], '+
              '\"ShipAddr\": {'+
                  '\"CountrySubDivisionCode\": \"CA\", '+
                  '\"City\": \"Bayshore\", '+
                  '\"PostalCode\": \"94326\", '+
                  '\"Id\": \"118\", '+
                  '\"Line1\": \"4581 Finch St.\"'+
              '}, '+
              '\"EmailStatus\": \"NotSet\", '+
              '\"BillAddr\": {'+
                  '\"CountrySubDivisionCode\": \"CA\", '+
                  '\"City\": \"Bayshore\", '+
                  '\"PostalCode\": \"94326\", '+
                  '\"Id\": \"117\", '+
                  '\"Line1\": \"4581 Finch St.\"'+
              '}, '+
              '\"ShipFromAddr\": {'+
                  '\"Id\": \"119\", '+
                  '\"Line1\": \"4581 Finch St.\", '+
                  '\"Line2\": \"Test Line2\"'+
              '}, '+
              '\"MetaData\": {'+
              '\"CreateTime\": \"2015-07-24T10:35:08-07:00\", '+
              '\"LastUpdatedTime\": \"2015-07-24T10:53:39-07:00\"'+
              '}, '+
              '\"CustomField\": ['+
              '{'+
                  '\"DefinitionId\": \"1\", '+
                  '\"Type\": \"StringType\", '+
                  '\"Name\": \"Crew #\"'+
              '}'+
              '], '+
              '\"Id\": \"239\"'+
          '}, '+
          '\"time\": \"2015-07-24T10:53:39.287-07:00\"'+
          '}';

      }
      else if (req.getEndpoint().containsIgnoreCase('Select+*+from+Item')) { //getItem
          jsonResponse = '{'+
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
          '      } '+
          // '      ,{'+
          // '        \"FullyQualifiedName\": \"Design\", '+
          // '        \"domain\": \"QBO\", '+
          // '        \"Name\": \"Design\", '+
          // '        \"TrackQtyOnHand\": false, '+
          // '        \"Type\": \"Service\", '+
          // '        \"PurchaseCost\": 0, '+
          // '        \"IncomeAccountRef\": {'+
          // '          \"name\": \"Design income\", '+
          // '          \"value\": \"82\"'+
          // '        }, '+
          // '        \"Taxable\": false, '+
          // '        \"MetaData\": {'+
          // '          \"CreateTime\": \"2014-09-16T10:41:38-07:00\", '+
          // '          \"LastUpdatedTime\": \"2015-04-17T14:31:10-07:00\"'+
          // '        }, '+
          // '        \"sparse\": false, '+
          // '        \"Active\": true, '+
          // '        \"SyncToken\": \"1\", '+
          // '        \"UnitPrice\": 75, '+
          // '        \"Id\": \"4\", '+
          // '        \"Description\": \"Custom Design\"'+
          // '      }'+
          '    ], '+
          '    \"maxResults\": 1'+
          '  }, '+
          '  \"time\": \"2015-04-22T11:04:34.194-07:00\"'+
          '}';
      }
      else if (req.getEndpoint().containsIgnoreCase('/item?')) { //createItemCall
          jsonResponse = '{'+
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
      }
      else if (req.getEndpoint().containsIgnoreCase('Select+*+from+Vendor')) {
        jsonResponse = '{'+
        '  \"PrimaryEmailAddr\": {'+
        '    \"Address\": \"dbradley@myemail.com\"'+
        '  }, '+
        '  \"WebAddr\": {'+
        '    \"URI\": \"http://DiannesAutoShop.com\"'+
        '  }, '+
        '  \"PrimaryPhone\": {'+
        '    \"FreeFormNumber\": \"(650) 555-2342\"'+
        '  }, '+
        '  \"DisplayName\": \"Dianne\'s Auto Shop\", '+
        '  \"Suffix\": \"Sr.\", '+
        '  \"Title\": \"Ms.\", '+
        '  \"Mobile\": {'+
        '    \"FreeFormNumber\": \"(650) 555-2000\"'+
        '  }, '+
        '  \"FamilyName\": \"Bradley\", '+
        '  \"TaxIdentifier\": \"99-5688293\", '+
        '  \"AcctNum\": \"35372649\", '+
        '  \"CompanyName\": \"Dianne\'s Auto Shop\", '+
        '  \"BillAddr\": {'+
        '    \"City\": \"Millbrae\", '+
        '    \"Country\": \"U.S.A\", '+
        '    \"Line3\": \"29834 Mustang Ave.\", '+
        '    \"Line2\": \"Dianne Bradley\", '+
        '    \"Line1\": \"Dianne\'s Auto Shop\", '+
        '    \"PostalCode\": \"94030\", '+
        '    \"CountrySubDivisionCode\": \"CA\"'+
        '  }, '+
        '  \"GivenName\": \"Dianne\", '+
        '  \"PrintOnCheckName\": \"Dianne\'s Auto Shop\"'+
        '}';
      }
      else if (req.getEndpoint().containsIgnoreCase('/vendor?')) {
        jsonResponse = '{'+
        '  \"Vendor\": {'+
        '    \"domain\": \"QBO\", '+
        '    \"PrimaryEmailAddr\": {'+
        '      \"Address\": \"dbradley@myemail.com\"'+
        '    }, '+
        '    \"DisplayName\": \"Dianne\'s Auto Shop\", '+
        '    \"CurrencyRef\": {'+
        '      \"name\": \"United States Dollar\", '+
        '      \"value\": \"USD\"'+
        '    }, '+
        '    \"GivenName\": \"Dianne\", '+
        '    \"Title\": \"Ms.\", '+
        '    \"PrimaryPhone\": {'+
        '      \"FreeFormNumber\": \"(650) 555-2342\"'+
        '    }, '+
        '    \"Active\": true, '+
        '    \"MetaData\": {'+
        '      \"CreateTime\": \"2015-07-28T12:51:21-07:00\", '+
        '      \"LastUpdatedTime\": \"2015-07-28T12:51:21-07:00\"'+
        '    }, '+
        '    \"Vendor1099\": false, '+
        '    \"BillAddr\": {'+
        '      \"City\": \"Millbrae\", '+
        '      \"Country\": \"U.S.A\", '+
        '      \"Line3\": \"29834 Mustang Ave.\", '+
        '      \"Line2\": \"Dianne Bradley\", '+
        '      \"Line1\": \"Dianne\'s Auto Shop\", '+
        '      \"PostalCode\": \"94030\", '+
        '      \"CountrySubDivisionCode\": \"CA\", '+
        '      \"Id\": \"423\"'+
        '    }, '+
        '    \"Mobile\": {'+
        '      \"FreeFormNumber\": \"(650) 555-2000\"'+
        '    }, '+
        '    \"WebAddr\": {'+
        '      \"URI\": \"http://DiannesAutoShop.com\"'+
        '    }, '+
        '    \"Balance\": 0, '+
        '    \"SyncToken\": \"0\", '+
        '    \"Suffix\": \"Sr.\", '+
        '    \"CompanyName\": \"Dianne\'s Auto Shop\", '+
        '    \"FamilyName\": \"Bradley\", '+
        '    \"TaxIdentifier\": \"99-5688293\", '+
        '    \"AcctNum\": \"35372649\", '+
        '    \"PrintOnCheckName\": \"Dianne\'s Auto Shop\", '+
        '    \"sparse\": false, '+
        '    \"Id\": \"137\"'+
        '  }, '+
        '  \"time\": \"2015-07-28T12:51:21.326-07:00\"'+
        '}';
      }
      else if (req.getEndpoint().containsIgnoreCase('Select+*+from+PurchaseOrder')) { //getPurchaseOrder
        jsonResponse = '{'+
        '  \"QueryResponse\": {'+
        '    \"startPosition\": 1, '+
        '    \"totalCount\": 1, '+
        '    \"PurchaseOrder\": ['+
        '      {'+
        '        \"DocNumber\": \"1007\", '+
        '        \"SyncToken\": \"0\", '+
        '        \"domain\": \"QBO\", '+
        '        \"VendorRef\": {'+
        '          \"name\": \"Hicks Hardware\", '+
        '          \"value\": \"41\"'+
        '        }, '+
        '        \"TxnDate\": \"2015-07-28\", '+
        '        \"TotalAmt\": 25.0, '+
        '        \"APAccountRef\": {'+
        '          \"name\": \"Accounts Payable (A/P)\", '+
        '          \"value\": \"33\"'+
        '        }, '+
        '        \"sparse\": false, '+
        '        \"Line\": ['+
        '          {'+
        '            \"DetailType\": \"ItemBasedExpenseLineDetail\", '+
        '            \"Amount\": 25.0, '+
        '            \"Id\": \"1\", '+
        '            \"ItemBasedExpenseLineDetail\": {'+
        '              \"ItemRef\": {'+
        '                \"name\": \"Garden Supplies\", '+
        '                \"value\": \"38\"'+
        '              }, '+
        '              \"CustomerRef\": {'+
        '                \"name\": \"Cool Cars\", '+
        '                \"value\": \"3\"'+
        '              }, '+
        '              \"Qty\": 1, '+
        '              \"TaxCodeRef\": {'+
        '                \"value\": \"NON\"'+
        '              }, '+
        '              \"BillableStatus\": \"NotBillable\", '+
        '              \"UnitPrice\": 25'+
        '            }'+
        '          }'+
        '        ], '+
        '        \"CustomField\": ['+
        '          {'+
        '            \"DefinitionId\": \"1\", '+
        '            \"Type\": \"StringType\", '+
        '            \"Name\": \"Crew #\"'+
        '          }, '+
        '          {'+
        '            \"DefinitionId\": \"2\", '+
        '            \"Type\": \"StringType\", '+
        '            \"Name\": \"Sales Rep\"'+
        '          }'+
        '        ], '+
        '        \"Id\": \"259\", '+
        '        \"MetaData\": {'+
        '          \"CreateTime\": \"2015-07-28T16:06:03-07:00\", '+
        '          \"LastUpdatedTime\": \"2015-07-28T16:06:03-07:00\"'+
        '        }'+
        '      }'+
        '    ], '+
        '    \"maxResults\": 1'+
        '  }, '+
        '  \"time\": \"2015-07-28T16:09:26.277-07:00\"'+
        '}';
      }
      else if (req.getEndpoint().containsIgnoreCase('/purchaseorder?')) { // createPurchaseOrderCall
        jsonResponse = '{'+
        '  \"PurchaseOrder\": {'+
        '    \"DocNumber\": \"1007\", '+
        '    \"SyncToken\": \"0\", '+
        '    \"domain\": \"QBO\", '+
        '    \"VendorRef\": {'+
        '      \"name\": \"Hicks Hardware\", '+
        '      \"value\": \"41\"'+
        '    }, '+
        '    \"TxnDate\": \"2015-07-28\", '+
        '    \"TotalAmt\": 25.0, '+
        '    \"APAccountRef\": {'+
        '      \"name\": \"Accounts Payable (A/P)\", '+
        '      \"value\": \"33\"'+
        '    }, '+
        '    \"EmailStatus\": \"NotSet\", '+
        '    \"sparse\": false, '+
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
        '    \"Id\": \"259\", '+
        '    \"MetaData\": {'+
        '      \"CreateTime\": \"2015-07-28T16:06:03-07:00\", '+
        '      \"LastUpdatedTime\": \"2015-07-28T16:06:03-07:00\"'+
        '    }'+
        '  }, '+
        '  \"time\": \"2015-07-28T16:06:04.864-07:00\"'+
        '}';
      }

      system.debug('I AM IN THE MOCK -  ' + jsonResponse);
      res.setBody(jsonResponse);
      return res;
  }
}