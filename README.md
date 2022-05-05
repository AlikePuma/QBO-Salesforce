# You will need a quickbooks developer account and postman for initial setup. You need postman to get your first refresh token in salesforce.

## 1. Go to developer.intuit.com and create an accounting app.
![image](https://user-images.githubusercontent.com/20245187/147251086-c5dc70cb-235b-4f9f-ac03-3126034c3362.png)

## 2. Add https://www.getpostman.com/oauth2/callback to the Redirect URIs section on your app detail page.
![image](https://user-images.githubusercontent.com/20245187/147251540-c048dafb-112f-44d7-9d3a-1285fdb8b031.png)

## 3. Open Postman, create a new workspace, open the authorization tab, set type to Auth 2.0.
(a quicker and easier way might be to just go here to [Intuit Developer Playground](https://developer.intuit.com/app/developer/playground))

![image](https://user-images.githubusercontent.com/20245187/147252004-041e2fc0-5c4f-4c5f-8d32-3d695c2febcc.png)
 
  - Callback URL - https://www.getpostman.com/oauth2/callback
  - Auth URL - https://appcenter.intuit.com/connect/oauth2
  - Access Token URL - https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer
  - Client Id - Get from app detail page
  - Client Secret - Get from app detail page
  - Scope - com.intuit.quickbooks.accounting
  - State - Salesforce

We will use this connection later

## 4. Go to custom metadata types in salesforce, click 'manage records' next to QBO Metadata and create a new metadata record.

  - Label - Default
  - QBO Metadata Label - Default
  - Base URL -  https://sandbox-quickbooks.api.intuit.com
  - MinorVersion - API version of app ([Intuit Postman Docs Step 7](https://developer.intuit.com/app/developer/qbo/docs/develop/sandboxes/postman)) Postman > Environments tab (left) > QBO ENV Variables > minorversion
  - Company Id - Sandbox Id ([Find here, at sandboxes list](https://developer.intuit.com/app/developer/sandbox))

## 5. Go to custom settings, click 'Manage' on QBData, click the new button.

  - Client Id - developer.intuit.com app detail page
  - Client Secret - developer.intuit.com app detail page
  - Auth URL - https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer
  - Refresh Token - Use step 3 to get the refresh token
