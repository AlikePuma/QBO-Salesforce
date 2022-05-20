@isTest
public class GeneralUtility_Test {

    @isTest
    static void test_getAllRequiredFieldsOfObjectMethod(){
        GeneralUtility.getAllRequiredFieldsOfObject('Account');
    }
    
    @isTest
    static void test_getAllFieldsForObjectMethod(){
        GeneralUtility.getAllFieldsForObject('Account');
    }
}