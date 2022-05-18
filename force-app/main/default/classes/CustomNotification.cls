public without sharing class CustomNotification {
    
    // WITHOUT TARGET ID TO RECORD
    public static void notifyUsersWithoutTarget(Set<String> recipientsIds, String notificationTitle, String notificationBody) {
        String dummyTargetId = '000000000000000AAA';
    	notifyUsersWithTargetRecord(recipientsIds, dummyTargetId, notificationTitle, notificationBody);
    }
	
    
    // WITH TARGET ID TO SPECIFIC RECORD
    public static void notifyUsersWithTargetRecord(Set<String> recipientsIds, String targetId, String notificationTitle, String notificationBody) {
        // Get the Id for our custom notification type
        CustomNotificationType notificationType = 
            [SELECT Id, DeveloperName 
             FROM CustomNotificationType 
             WHERE DeveloperName='ApexClass_CustomNotification'];
        
        // Create a new custom notification
        Messaging.CustomNotification notification = new Messaging.CustomNotification();

        // Set the contents for the notification
        notification.setTitle(notificationTitle);
        notification.setBody(notificationBody);

        // Set the notification type and target
        notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetId(targetId);
        
        // Actually send the notification
        try {
            notification.send(recipientsIds);
        }
        catch (Exception e) {
            System.debug('Problem sending notification: ' + e.getMessage());
        }
    }
    
    
    // WITH TARGET ID TO SPECIFIC RECORD
    public static void notifyUsersWithTargetPage(Set<String> recipientsIds, String targetPage, String notificationTitle, String notificationBody) {
        // Get the Id for our custom notification type
        CustomNotificationType notificationType = 
            [SELECT Id, DeveloperName 
             FROM CustomNotificationType 
             WHERE DeveloperName='ApexClass_CustomNotification'];
        
        // Create a new custom notification
        Messaging.CustomNotification notification = new Messaging.CustomNotification();

        // Set the contents for the notification
        notification.setTitle(notificationTitle);
        notification.setBody(notificationBody);

        // Set the notification type and target page
        notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetPageRef(targetPage);
        
        // Actually send the notification
        try {
            notification.send(recipientsIds);
        }
        catch (Exception e) {
            System.debug('Problem sending notification: ' + e.getMessage());
        }
    }
    
    /* INVOCATION EXAMPLE
    Set<String> recipientsIds = new Set<String>{UserInfo.getUserId()};
    String notificationTitle = 'Project Profitability Calculations Complete';
    String notificationBody = 'The CBDs for this project have finished calculating profitability. Click to go to project.';
    
    CustomNotification.notifyUsersWithTarget(recipientsIds, projectId, notificationTitle, notificationBody);
	*/
}