@isTest
public class OpportunitiesToWorkOrder_Test {
    @testSetup 
    static void setup() {
        Account acct = new Account(
            Name                    = 'Test Account',
            ShippingStreet          = '2100 Woodward Ave',
            ShippingCity            = 'Detroit',
            ShippingState           = 'MI',
            ShippingPostalCode      = '48201',
            ShippingCountry         = 'US'
        );
        insert acct;
        
        
        // Create opportunities
        Decimal oppAmount = 9000.00;
        
        Opportunity o = new Opportunity(
        	AccountId 		= acct.Id,
            Amount 			= oppAmount,
            Description 	= 'test description',
            Name 			= 'test name',
            StageName 		= 'New', 
            CloseDate 		= Date.today(),
            Pricebook2Id 	= Test.getStandardPricebookId()
        );
        insert o;
        
        // Create product and pricebook entry
        Product2 prod = new Product2(Name = 'SLA Bronze', IsActive = true);
    	insert prod;
        
        PricebookEntry pbe = new PricebookEntry(UnitPrice = 50.00, Product2Id = prod.Id, Pricebook2Id = Test.getStandardPricebookId(), IsActive = true); 
     	insert pbe;      
        
        // Create opp products
        OpportunityLineItem oli = new OpportunityLineItem (
            OpportunityId 		= o.Id,
            PriceBookEntryId 	= pbe.Id,
        	Product_Cost__c 	= 25.00,
            UnitPrice 			= 50.00,
            Quantity 			= 1
        );
        insert oli;

        // Create operating hours
        OperatingHours oh = new OperatingHours(
            Name = 'Base Calendar'
        );
        insert oh;

        // Create ServiceTerritory
        ServiceTerritory st = new ServiceTerritory(
            Name = 'Default Territory',
            isActive = true,
            OperatingHoursId = oh.id
        );
        insert st;
    }
    
    @isTest 
    static void testController(){
        // Get all fields of all opps created in test setup
        List<String> allFields = new List<String>();
        
        for(SObjectField field: Opportunity.sobjectType.getDescribe().fields.getMap().values()) {
            allFields.add(String.valueOf(field));
        }
        
        String query = 'SELECT ' + String.join(allFields, ',') + '  FROM Opportunity';
        List<Opportunity> opps = Database.query(query);
        
        // Set standardSetController and page, as well as SetSelected Opps to all
        Test.setCurrentPage(Page.OpportunitiesToWorkOrders_VFPage);
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(opps);
  		stdSetController.setSelected(opps);
        
        OpportunitiesToWorkOrder_Controller controller = new OpportunitiesToWorkOrder_Controller(stdSetController);
        controller.createWorkOrders();
    }
}