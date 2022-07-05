@IsTest
public with sharing class QBCustomerResponseJSON_Test {
    
    static testMethod void testParse() {
        String json = '{ '+
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
        
        QBCustomerResponseJSON obj = QBCustomerResponseJSON.parse(json);
        System.assert(obj != null);
    }
}