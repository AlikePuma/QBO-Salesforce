@isTest
public class CustomNotification_Test {
	@isTest 
    static void testCustomNotficationWithoutTarget(){
    	Set<String> recipientsIds = new Set<String>{UserInfo.getUserId()};
        String notificationTitle = 'I Am Title';
        String notificationBody = 'And I am body';
		
        CustomNotification.notifyUsersWithoutTarget(recipientsIds, notificationTitle, notificationBody);
        
        String targetPage = '{"type": "standard__webPage","attributes": {"url": "https://salesforce.com"}}';
        CustomNotification.notifyUsersWithTargetPage(recipientsIds, targetPage, notificationTitle, notificationBody);
    }
}