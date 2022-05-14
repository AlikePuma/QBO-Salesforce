public class GeneralUtility {
    
    // Pass in the API name of the object you want the required fields for
    public static String getAllRequiredFieldsOfObject(String sObjApiName) {
        String requiredFields = '';
        SObjectType sObjType = ((SObject) Type.forName(sObjApiName).newInstance()).getSObjectType();
        
        Schema.DescribeSObjectResult r = sObjType.getDescribe();
        Map<String,Schema.SObjectField> M = r.fields.getMap();
        for(String fieldName : M.keySet()){ 
            Schema.SObjectField field = M.get(fieldName);
            Schema.DescribeFieldResult F = field.getDescribe();
            //A nillable field can have empty content. A isNillable Boolean non-nillable field must have a value for the object to be                       //created or saved. 
            // if F.isNillable() is false then field is mandatory
            Boolean isFieldreq  = F.isNillable();
            if(!isFieldReq){
                System.debug(fieldName);
                requiredFields += fieldName;
            }
            
        }
        return requiredFields;
        
        // Use Example
		// GeneralUtility.getAllRequiredFieldsOfObject('Account');
		// Check debug log or return value
    }
    
    
    // For use in queries to return all fields
    public static String getAllFieldsForObject(String sObjApiName){
        // Get all fields of all opps created in test setup
        List<String> allFields = new List<String>();
        SObjectType sObjType = ((SObject) Type.forName(sObjApiName).newInstance()).getSObjectType();
        
        for(SObjectField field: sObjType.getDescribe().fields.getMap().values()) {
            allFields.add(String.valueOf(field));
        }
        
        return String.join(allFields, ',');
        
        // Use Example
        // String allFields = GeneralUtility.getAllFieldsForObject('Account');
        // String query = 'SELECT ' + allFields + '  FROM Account';
        // List<Accounts> accts = Database.query(query);
    }
    
    //Add in following
    /*
    private static Pricebook2 stdPriceBook;  // Singleton, remember when first referenced
    
    //  ------------------------------------------------------
    //  getStdPricebookId : as of V31, testmethods can locate std pricebook wo seeAlldata=true
    //  ------------------------------------------------------
    public static ID getStdPricebookId() {
        if (Test.isRunningTest())   return Test.getStandardPricebookId();
        return getStdPricebook().id;    
    } 
    
    //  -------------------------------------------------------
    //  getStdPriceBook: Singleton
    //  -------------------------------------------------------
    public static Pricebook2    getStdPriceBook () {
        if (stdPriceBook == null) 
            stdPriceBook    = [select id, name from Pricebook2 where isStandard = true limit 1];
        return stdPriceBook;    
    }
	*/
}