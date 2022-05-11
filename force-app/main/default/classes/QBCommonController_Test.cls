@isTest
public with sharing class QBCommonController_Test {
    public QBCommonController_Test() {

    }

    @testSetup Static void setup() {

        //create common test accounts
        Account testAccount = createAccount();

        //create contact for this accout
        Contact testContact = createContact(testAccount.Id);

        //create products
        List<Product2> testProducts = createProducts(testAccount.Id, 3);

        //create pricebook
        createPriceBook();

        //add products to pricebook
        addProductToPriceBook(testProducts);
        
        //create opportunity with line items
        Opportunity testOpportunity = createOpportunityWithProducts(testAccount.Id, testProducts);

        //cretae work order with line itmes
        WorkOrder testWO = createWorkOrderWithLineItems (testOpportunity);

        //create invoice
        createInvoices(testWO.Id); 

    }
    
    @isTest
    Static void testQBCustomerSync(){
        
        Test.setMock(HttpCalloutMock.class, new QBCallOutMock());
        Test.startTest();
        // Get the first test account by using a SOQL query
        Account acct = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];
        List<Id> accIds = new List<Id>();
        accIds.add(acct.Id);
        QBCustomerSync_Controller.callFromFlow(accIds);
        
        Test.stopTest();

        System.assert(true);
    }

    @isTest
    Static void testQBInvoiceSync(){
        
        Test.setMock(HttpCalloutMock.class, new QBCallOutMock());
        Test.startTest();

        // Get the test account by using a SOQL query
        Account acct = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];

        // Get workOrder for the account by using a SOQL query
        WorkOrder wOrder = [SELECT Id FROM WorkOrder WHERE AccountId=:acct.Id LIMIT 1];

        // Get invoice for the workorder
        Invoice__c inv0 = [SELECT Id FROM Invoice__c WHERE Work_Order__c=:wOrder.Id and QBO_Id__c != null LIMIT 1];
        System.debug('Invoice Id to add in the list is ------' + inv0.Id);
        List<Id> invIds = new List<Id>();
        invIds.add(inv0.Id);
        QBInvoice_Controller.callFromFlow(invIds);
        
        Test.stopTest();

        System.assert(true);
    }

    @isTest
    Static void testQBProductSync(){
        
        Test.setMock(HttpCalloutMock.class, new QBCallOutMock());
        Test.startTest();
        // Get the first test account by using a SOQL query
        Product2 p = [SELECT Id FROM Product2 LIMIT 1];
        List<Id> prodIds = new List<Id>();
        prodIds.add(p.Id);
        QBProductSync_Controller.callFromFlow(prodIds);
        
        Test.stopTest();

        System.assert(true);
    }

    @isTest
    static void testCreateItemsQbBatch() {  

        Test.setMock(HttpCalloutMock.class, new QBCallOutMock());
        QBWorkOrder_Controller woController = new QBWorkOrder_Controller();

        Test.startTest();

        // Get the test account by using a SOQL query
        Account acct = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];

        // Get workOrder for the account by using a SOQL query
        WorkOrder wOrder = [SELECT Id FROM WorkOrder WHERE AccountId=:acct.Id LIMIT 1];

        // Get invoice for the workorder
        Invoice__c inv0 = [SELECT Id,Work_Order__c FROM Invoice__c WHERE Work_Order__c=:wOrder.Id and QBO_Id__c != null LIMIT 1];
        
        woController.createItemsQbBatch(inv0);

        Test.stopTest();

        System.assert(true);
    }

    private Static Account createAccount() {
        Account testAccount = new Account();
		testAccount.Name='Test Account' ;
        testAccount.Phone = '999-999-9999';
        testAccount.BillingCity = 'Saint Luis';
        testAccount.BillingStreet = '123 Elm Street';
        testAccount.BillingCountry = 'USA';
        testAccount.BillingPostalCode = '63130';
        testAccount.BillingState = 'MO';
        testAccount.BillingLatitude = 38.665788;
        testAccount.BillingLongitude = -90.32224;
        testAccount.ShippingCity = 'West Palm Beach';
        testAccount.ShippingStreet = '1234 Elm Street';
        testAccount.ShippingState = 'FL';
        testAccount.ShippingCountry = 'USA';
        testAccount.ShippingPostalCode = '33417';
        
		insert testAccount;
        return testAccount;
    }

    private Static Contact createContact(Id accId) {

        Contact testContact = new Contact();
        testContact.FirstName = 'John';    
        testContact.LastName = 'Doe';
        testContact.Phone = '555-555-5555';
        testContact.Email = 'jdoe@contact.com';
        testContact.AccountId = accId;
        
        insert testContact;

        return testContact;
    }

    private Static List<Product2> createProducts(Id acctId, Integer numProducts) {

        List<Product2> listOfProds = new List<Product2>();

        if (numProducts <= 0) {
            numProducts = 1;
        }

        Product2 p = new Product2();
        for(integer i = 1; i <= numProducts; i++) {
            p = new Product2();
            p.Name = 'Test Prod ' + i;
            p.IsActive = true;
            p.Description = 'Test Description ' + i;
            listOfProds.add(p);
        }

        insert listOfProds;
        return listOfProds;
    }

    //create opportunity
    private Static Opportunity createOpportunity(Id acctId) {

        PriceBook2 standardPriceBook=[SELECT id FROM PriceBook2 where isStandard=true Limit 1];

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.AccountId = acctId;
        opp.StageName = 'Qualification';
        opp.CloseDate = Date.today().addDays(15);
        opp.Pricebook2Id = standardPriceBook.Id;

        insert opp;
        return opp;
    }

    //create opportunity with products
    private Static Opportunity createOpportunityWithProducts(Id acctId, List<Product2> prods) {
        
        List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>();
        //create opp first
        Opportunity opp = createOpportunity(acctId);
        if (opp != null) {
            OpportunityLineItem oppLineItem = new OpportunityLineItem();
            for (Product2 prod : prods) {
                oppLineItem = new OpportunityLineItem();
                oppLineItem.OpportunityId = opp.Id;
                oppLineItem.Product2Id = prod.Id;
                oppLineItem.Product_Cost__c = (oppItems.size() + 1) * 10;
                oppLineItem.UnitPrice = (oppItems.size() + 1) * 20;
                oppLineItem.Quantity = (oppItems.size() + 1);
                oppLineItem.Description = prod.Description;
                oppItems.add(oppLineItem);          
            }
            insert oppItems;
        }
        return opp;
    }

    private Static void createPriceBook() {

        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        Update standardPricebook;
    }


    private Static void addProductToPriceBook(List<Product2> prods) {

        PriceBook2 standardPriceBook=[SELECT id FROM PriceBook2 where isStandard=true Limit 1];
        
        List<PriceBookEntry> pbEntries =new List<PriceBookEntry>();
        Integer j=1;
        for(Product2 pb1:prods)
        {
            PriceBookEntry priceBook1=new PriceBookEntry();
            priceBook1.Product2Id=pb1.Id;
            priceBook1.PriceBook2Id=standardPriceBook.Id;
            priceBook1.UnitPrice=100+j;
            priceBook1.UseStandardPrice=false;
            priceBook1.IsActive=true;  
            pbEntries.add(priceBook1);
            j++;
        }
       
        if(!pbEntries.isEmpty())
        {
            insert pbEntries;
        }
    }


    private Static WorkOrder createWorkOrder (Opportunity opp) {

        PriceBook2 standardPriceBook=[SELECT id FROM PriceBook2 where isStandard=true Limit 1];

        WorkOrder wo = new WorkOrder();
        wo.AccountId = opp.AccountId;
        wo.Opportunity__c = opp.Id;
        wo.Status = 'New';
        wo.Subject = 'Creaetd for Test';
        wo.Description = 'Test Work Order';
        wo.PriceBook2Id = standardPriceBook.Id;

        insert wo;

        return wo;
    }

    private Static WorkOrder createWorkOrderWithLineItems (Opportunity opp) {

        //create workorder
        WorkOrder wo = createWorkOrder(opp);

        List<PricebookEntry> pbEntries = [Select Id, Product2Id, UnitPrice from PricebookEntry WHERE Pricebook2Id = :wo.PriceBook2Id];

        System.debug('Pricebook Entries - ' + pbEntries.size());

        Map<Id, PriceBookEntry> pbEntriesMap = new Map<Id, PricebookEntry>();
        for (PricebookEntry pbEntry : pbEntries) {
            if (pbEntriesMap.get(pbEntry.Product2Id) == null) {
                pbEntriesMap.put(pbEntry.Product2Id, pbEntry);
            }
        }
        
        //add workorderline item now
        List<WorkOrderLineItem> woLineItems = new List<WorkOrderLineItem>();
        WorkOrderLineItem woli = new WorkOrderLineItem();


        //get opportunity lineitems
        List<OpportunityLineItem> oppLineItems = [SELECT Id, OpportunityId, Product2Id, Product_Cost__c, UnitPrice, Quantity, Description
        FROM OpportunityLineItem 
        WHERE OpportunityId =: opp.Id];
        for (OpportunityLineItem oppLineItem : oppLineItems) {
            PriceBookEntry pbe = pbEntriesMap.get(oppLineItem.Product2Id);
            woli = new WorkOrderLineItem();
            woli.PricebookEntryId = pbe.Id;
            woli.UnitPrice = oppLineItem.UnitPrice;
            woli.WorkOrderId = wo.Id;
            woli.Description = oppLineItem.Description;
            woli.Quantity = oppLineItem.Quantity;
            woLineItems.add(woli);
        }
        
        if(!woLineItems.isEmpty())
        {
            insert woLineItems;
        }

        return wo;

    }

    private Static void createInvoices(Id workOrderId) {

        List<Invoice__c> invoices = new List<Invoice__c>();

        Invoice__c inv = new Invoice__c();
        inv.Work_Order__c = workOrderId;
        inv.Description__c = 'Thank you for bussiness';
        inv.Terms__c = 'Net 15';
        invoices.add(inv);

        inv = new Invoice__c();
        inv.Work_Order__c = workOrderId;
        inv.Description__c = 'Thank you for bussiness';
        inv.Terms__c = 'Net 15';
        inv.QBO_Id__c = '2';
        inv.QBO_SyncToken__c = '35';
        invoices.add(inv);

        insert invoices;
        
    }

}
