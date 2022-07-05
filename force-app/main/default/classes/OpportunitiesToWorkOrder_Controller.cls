public class OpportunitiesToWorkOrder_Controller {
	private List<Opportunity> selectedOpps;
    private List<Id> oppIds = new List<Id>();
    private List<WorkOrder> workOrdersToInsert = new List<WorkOrder>();
    
    private String woListViewId 	= '00B8c00000BrguBEAR';
    private String oppsListViewId 	= '00B8c00000Brgr2EAB';
    
    
    public OpportunitiesToWorkOrder_Controller(ApexPages.StandardSetController listController){  
        for(Opportunity o : (Opportunity[]) listController.getSelected()){
            oppIds.add(o.Id);
        }
        
        // Get all fields for Opportunity
        String oppAllFields = GeneralUtility.getAllFieldsForObject('Opportunity');
        String query = 'SELECT ' + oppAllFields + '  FROM Opportunity WHERE Id IN :oppIds';
        selectedOpps = Database.query(query);
    }
    
    public PageReference createWorkOrders(){
        
        try {            
            List<WorkOrderLineItem> woliToInsert = new List<WorkOrderLineItem>();
            
            Map<Id, List<OpportunityLineItem>> oppLineItemsMap	= new Map<Id, List<OpportunityLineItem>>();  // key opportunity id 
            
            String oppLineItemsAllFields = GeneralUtility.getAllFieldsForObject('OpportunityLineItem');
            
            // Get and Map OLIs
            String query = 'SELECT ' + oppLineItemsAllFields + '  FROM OpportunityLineItem WHERE OpportunityId IN :oppIds';
            List<OpportunityLineItem> oppLineItems = Database.query(query);
            
            for(OpportunityLineItem oli : oppLineItems){
                List<OpportunityLineItem> oliTempList;
                if(oppLineItemsMap.containsKey(oli.OpportunityId)){
                    oliTempList = oppLineItemsMap.get(oli.OpportunityId);
                } else {
                    oliTempList = new List<OpportunityLineItem>();
                }
                oliTempList.add(oli);
                oppLineItemsMap.put(oli.OpportunityId, oliTempList);
            }


            // Create WOs for each opp
            for(Opportunity o : selectedOpps){
                // Set Pricebook to Standard if one's not set on Opportunity
                String defaultPricebook; 
                if(String.isBlank(o.Pricebook2Id)){
                    defaultPricebook = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book' AND IsStandard = true AND isActive = true LIMIT 1].Id;
                } else {
                    defaultPricebook = o.Pricebook2Id;
                }

                // Set Territory to default 
                String territory = [SELECT Id FROM ServiceTerritory WHERE Name = 'Default Territory' AND isActive = true LIMIT 1].Id;

                Address addr = [SELECT ShippingAddress FROM Account WHERE Id = :o.AccountId].ShippingAddress;

                WorkOrder wo = new WorkOrder(
                    AccountId 		= o.AccountId,
                    Description 	= o.Description,
                    Opportunity__c 	= o.Id,
                    Pricebook2Id 	= defaultPricebook,
                    Subject 		= o.Name,

                    Street          = addr.Street,
                    City            = addr.City,
                    State           = addr.State,
                    PostalCode      = addr.PostalCode,
                    Country         = addr.Country,

                    ServiceTerritoryId = territory
                );
                
                o.Work_Orders_Created__c = true;
                workOrdersToInsert.add(wo);
            }
            update selectedOpps;
            insert workOrdersToInsert;  //insert to get ID's 
            
            
            for(WorkOrder wo : workOrdersToInsert){
                if(oppLineItemsMap.containsKey(wo.Opportunity__c)){
                    for(OpportunityLineItem oli : oppLineItemsMap.get(wo.Opportunity__c)) {
                        WorkOrderLineItem woli = new WorkOrderLineItem(
                            WorkOrderId			= wo.Id,
                            PricebookEntryId 	= oli.PricebookEntryId,
                            Unit_Cost__c  		= oli.Cost_per_unit__c,
                            UnitPrice 			= oli.UnitPrice, 
                            Quantity 			= oli.Quantity
                        );
                        woliToInsert.add(woli);
                    }
                } 
            }
            
            //List<String> throwException;
            //throwException.add('This should throw exception');
            
            insert woliToInsert;
            return redirectUser(true);
        } catch (Exception e) {
            notifyUser('We\'ve encountered an error, please reach out to IT.');
            return redirectUser(false);
        }
    }
    
    
    public PageReference redirectUser(Boolean success){   
        PageReference pageRef;

        if(success){
            if(workOrdersToInsert.size() > 1){  // All Work Orders
                pageRef = new PageReference('/lightning/o/WorkOrder/list?filterName='+ woListViewId);
            
            } else {  // Single Work Order
                pageRef = new PageReference('/'+ workOrdersToInsert[0].id);

            }
        } else {
            if(selectedOpps.size() > 1){  // return to All Opportunities
                pageRef = new PageReference('/lightning/o/Opportunity/list?filterName='+ oppsListViewId);
            
            } else {  // Single opportunity
                pageRef = new PageReference('/'+ selectedOpps[0].id);
            }            
        }
                                         
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    
    public void notifyUser(String notificationBody){
        Set<String> recipientsIds = new Set<String>{UserInfo.getUserId()};
        String notificationTitle = 'Work Order and Line Item Creation';
        
        String target = '{"type": "standard__webPage","attributes": {"url": "/lightning/o/Opportunity/list?filterName='+ oppsListViewId+'"}}';
        CustomNotification.notifyUsersWithTargetPage(recipientsIds, target, notificationTitle, notificationBody);
    }
}