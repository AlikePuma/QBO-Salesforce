1.	**Create An App (Intuit)** 
    1. Create a developer account (https://developer.intuit.com)
    2.  Click the ‘Dashboard’ tab.
    3.	Click the ‘+ Create an app’ button.
    4.	Click ‘QuickBooks Online and Payments’ box.
        1.	Name – Salesforce Integration
        2.	com.intuit.quickbooks.accounting – Checked
    5.	Under ‘Development Settings’, click the ‘Keys & credentials’ tab
    6.	Copy and save your Client Id and Client secret, you will need it later


2. **Create Auth. Provider (Salesforce)**
   1.  In setup, type ‘Auth. Provider’ in the quick find box. 
   2.  Click the ‘New’ button.
       1.  Provider Type – Open ID Connect
       2.  Name – QuickBooks
       3.  URL Suffix – QuickBooks
       4.  Customer Key – Use client id from Step 1.e
       5.  Customer Secret = Use client secret from Step 1.f
       6.  Authorize Endpoint URL - https://appcenter.intuit.com/connect/oauth2
       7.  Token Endpoint URL -https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer
       8.  Default Scopes - com.intuit.quickbooks.accounting
       9.  Send access token in header – Checked
       10. Include Consumer Secret in API Responses – Checked
 
3. **Add Callback URL To App (Intuit)**
   1. Go back to intuit developer account.
   2. Click the ‘Dashboard’ tab.
   3. Click on the name of your app (Salesforce Integration).
   4. Under ‘Development Settings’, click the ‘Keys & credentials’ tab.
   5. Click the ‘Add URI’ button.
   6. Paste the callback URL from Step 2.d
   7. Click the save button.

4. **Create a sandbox company (Intuit)**
   1. Log into your intuit developer account.
   2. Hover over the ‘API Docs & Tools’..
   3. Select ‘Sandbox’.
   4. Click the ‘+ Add a sandbox company’.
      1.  QuickBooks Online Plus – Selected
      2.  Country – United States
   5. Click the ‘Add’ button. 
   6. Take note of your sandbox name, you will need it later.
   7. Under your sandbox name, copy the Company Id, you will need it later.

5. **Create Named Credential (Salesforce)**
   1. In setup, type ‘named credential’ in the quick find box. 
   2. Click the ‘New Named Credential’ button.
      1. Label - QBO
      2. Name - QBO
      3. URL - https://sandbox-quickbooks.api.intuit.com (Sandbox API)
      4. Identify Type – Named Principle
      5. Authentication Protocol - OAuth 2.0
      6. Authentication Provider – QuickBooks
      7. Scope - com.intuit.quickbooks.accounting
      8. Generate Authorization Header – Checked
      9. Start Authentication Flow on Save - Checked
      10. Allow Merge Fields in HTTP Header – Checked
      11. Allow Merge Fields in HTTP Body – Unchecked
   3. Click the ‘Save’ button.
   4. After clicking the save button, you will be redirected to QuickBooks login.
   5. Enter your login credentials. 
   6. You may be asked to select a sandbox if you have more than one. Select the sandbox from Step 4.f
 
6. **Add Sandbox Company Information (Salesforce)**
   1. In setup, type ‘Custom Metadata’ in the quick find box.
   2. Look for ‘QBO Metadata’ in the list of custom metadata, then click ‘Manage Records’ to the left of the metadata name.
   3. Click the ‘Edit’ button next to the label ‘Default’.
      1. Company Id – Enter the company Id from step 4.g
      2. Minor Version – Follow the steps below.
         1. Go to your intuit developer account
         2. Hover over ‘API Docs & Tools’.
         3. Select ‘API Explorer’.
         4. Select the drop down to the right of your demo org.
         5. Use the highest minor version in the dropdown above.
