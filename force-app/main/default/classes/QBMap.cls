public class QBMap {
  
    /**
     * Map the SF Account data to the QB customer JSON
     * @param acc The account data that is mapped
     * @return the QB json that can be used to CRUD a customer in QBO
     */
    public static String mapAccountData(Account acc){
        System.debug('********** In QBMap.mapAccountData');

        QBCustomerJSON.Customer customer = new QBCustomerJSON.Customer();

        //Map given account fields
        customer.CompanyName = acc.Name;
        customer.Taxable = True;       
        customer.SyncToken = acc.QBO_SyncToken__c;
        customer.sparse = True;

        //Create Shipping address
        QBCustomerJSON.BillAddr shipAddy = new QBCustomerJSON.BillAddr();
        shipAddy.City = acc.ShippingCity;
        shipAddy.Line1 = acc.ShippingStreet;
        shipAddy.CountrySubDivisionCode = acc.ShippingState;
        shipAddy.PostalCode = acc.ShippingPostalCode;
        shipAddy.Country = acc.ShippingCountry;
        customer.ShipAddr = shipAddy;

        customer.PrintOnCheckName = acc.Name; 
        //Create Primary Phone
        QBCustomerJSON.PrimaryPhone phone = new QBCustomerJSON.PrimaryPhone ();
        phone.FreeFormNumber = acc.Phone;
        customer.PrimaryPhone = phone;
        //customer.PrimaryEmailAddr = acc.Email; //does not have correct mapping
        customer.Job = False;
        customer.IsProject = False;
        customer.Id = acc.QBO_ID__c;
        customer.DisplayName = acc.Name;

        //Create Billing Address
        QBCustomerJSON.BillAddr billAddy = new QBCustomerJSON.BillAddr();
        billAddy.City = acc.BillingCity;
        billAddy.Line1 = acc.BillingStreet;
        billAddy.CountrySubDivisionCode = acc.BillingState;
        billAddy.PostalCode = acc.BillingPostalCode;
        billAddy.Lat = String.valueOf(acc.BillingLatitude);
        billAddy.Long_x = String.valueOf(acc.BillingLongitude);
        billAddy.Country = acc.BillingCountry;
        customer.BillAddr = billAddy;

        customer.Active = True;

        return JSON.serialize(customer, True).replace('"Long_x":', '"Long":');
    }

    /**
     * Map the SF Account data to the QB customer JSON
     * @param wo The work order 
     * @return the QB json that can be used to CRUD a customer in QBO
     */
    public static String mapWorkOrderToSubCustomer(WorkOrder wo){
        System.debug('********** In QBMap.mapWorkOrderToSubCustomer');

        /*
        {
            "FullyQualifiedName": "TestJob",
            "DisplayName": "TestJob",
            "Active": true,
            "BillWithParent": true,
            "ParentRef": {
                "value": 68 // account QBO
            },
        } 
        */

        QBCustomerJSON.Customer customer = new QBCustomerJSON.Customer();
        customer.FullyQualifiedName = wo.Job_number__c;
        customer.DisplayName = wo.Job_number__c;
        customer.Job = true;
        customer.Active = true;
        customer.BillWithParent = true;
        
        QBCustomerJSON.ParentRef parentRef = new QBCustomerJSON.ParentRef();
        parentRef.value = wo.Customer_Account__r.QBO_Id__c;

        customer.ParentRef = parentRef;
        //customer.IsProject = False;

        return JSON.serialize(customer, True).replace('"Long_x":', '"Long":');
    }


    public static String mapProductsToBatchItems(List<QBProductAndWoliWrapper> wrappers){
        QBBatchRequestJSON batch;

        // Ensure list not empty
        if(wrappers.size() > 0){
            batch = new QBBatchRequestJSON();
            
            QBItemJSON item;

            for(QBProductAndWoliWrapper w : wrappers){
                // instantiate and update QBBatchRequestJSON.BatchItemRequest class
                QBBatchRequestJSON.BatchItemRequest bir = new QBBatchRequestJSON.BatchItemRequest();
                bir.bid         = String.valueOf(w.product.Id);
                bir.operation   = 'create';

                // instantiate item class
                item = new QBItemJSON();
                item.TrackQtyOnHand     = false;
                item.Name               = w.product.Name + ' x13';
                item.UnitPrice          = w.woli.UnitPrice;
                item.Taxable            = true;
                item.Type               = 'NonInventory';
                item.IncomeAccountRef = new QBItemJSON.IncomeAccountRef();
                item.IncomeAccountRef.name      = 'Checking'; // change these to match prod
                item.IncomeAccountRef.value     = '35';
                
                bir.Item = item;
                
                batch.BatchItemRequest.add(bir);
            }
        }
        String payload = JSON.serialize(batch, true);
        System.debug(payload);
        return payload;
    }


    /**
     * Map an invoice from Salesforce to QBO JSON
     * @param inv The invoice that is used for the mapping
     * @return The json String that is used for the body of the request callout 
     */
    public static String mapInvoice(Invoice__c inv, WorkOrder wo, List<WorkOrderLineItem> woliList){
        System.debug('********** In QBMap.mapInvoice');

        //////////////////////////
        // INVOICE TOP LEVEL ITEMS
        //////////////////////////

        //Initialize invoice object
        QBInvoiceJSON invoiceObj = new QBInvoiceJSON();   
        
        invoiceObj.Id = inv.QBO_Id__c;
        invoiceObj.SyncToken = inv.QBO_SyncToken__c;
        
        invoiceObj.AllowOnlineACHPayment = True;
        invoiceObj.AllowOnlineCreditCardPayment = True;
        invoiceObj.DocNumber  = inv.name.replace('INV-', '');
        invoiceObj.EmailStatus = 'NotSet';
        QBInvoiceJSON.EmailAddress email = new QBInvoiceJSON.EmailAddress();
        email.Address = inv.Work_Order__r.Customer_Account__r.contact__r.email;
        invoiceObj.BillEmail = email;

        //*****  CUSTOMER / JOB REFERENCE  *****//
        QBInvoiceJSON.CustomerRef customerRef = new QBInvoiceJSON.CustomerRef();
        String customerOrJob;
        if(inv.Sync_in_QBO_to__c == 'Job'){ //job is synced, sync to job
            customerOrJob = wo.QBO_Id__c;
        } else {  // sync to customer account
            customerOrJob = inv.Work_Order__r.Customer_Account__r.QBO_Id__c;
        }
        customerRef.value = customerOrJob;
        invoiceObj.CustomerRef = customerRef;
                
        //*****  MEMO  *****//
        QBInvoiceJSON.MemoRef memo = new QBInvoiceJSON.MemoRef();
        memo.value = inv.Description__c;
        invoiceObj.CustomerMemo = memo;

        //*****  TERMS & DUE DATE  *****//
        QBInvoiceJSON.SalesTermRef sales = new QBInvoiceJSON.SalesTermRef();
        //these values are different for each QB org
        sales.value = inv.Terms__c;
        invoiceObj.SalesTermRef = sales;
        // The following may be used to set a due date without terms
        //invoiceObj.DueDate = Date.today().addDays(daysToAddToDueDate);
        
        
        //*****  BILLING ADDRESS  *****//
        QBInvoiceJSON.BillAddr billAddy = new QBInvoiceJSON.BillAddr();
        billAddy.City = inv.Work_Order__r.Customer_Account__r.BillingCity;
        billAddy.Line1 = inv.Work_Order__r.Customer_Account__r.Name;
        billAddy.Line2 = inv.Work_Order__r.Customer_Account__r.BillingStreet;
        billAddy.CountrySubDivisionCode = inv.Work_Order__r.Customer_Account__r.BillingState;
        billAddy.PostalCode = inv.Work_Order__r.Customer_Account__r.BillingPostalCode;
        billAddy.Country = inv.Work_Order__r.Customer_Account__r.BillingCountry;
        invoiceObj.BillAddr = billAddy;

        //*****  SHIPPING ADDRESS  *****//
        QBInvoiceJSON.BillAddr shipAddy = new QBInvoiceJSON.BillAddr();
        if(inv.Work_Order__r.Customer_Account__r != null){
            String phone = '';
            String cName = '';

            if(inv.Work_Order__r.Customer_Account__r.Contact__c != null){
                cName = inv.Work_Order__r.Account.Contact__r.Name;
            } else {
                cName = 'ATTN: Billing';
            }
            String contactLine = cName + phone;

            shipAddy.Line1 = inv.Work_Order__r.Customer_Account__r.Name;
            shipAddy.Line2 = contactLine;
            shipAddy.Line3 = inv.Work_Order__r.Customer_Account__r.ShippingStreet;
            shipAddy.Line4 = inv.Work_Order__r.Customer_Account__r.ShippingCity + ', '+ 
                               inv.Work_Order__r.Customer_Account__r.ShippingState + '  ' +
                               inv.Work_Order__r.Customer_Account__r.ShippingPostalCode;
            shipAddy.Line5 = inv.Work_Order__r.Customer_Account__r.ShippingCountry;

            shipAddy.Lat = String.valueOf(inv.Work_Order__r.Customer_Account__r.ShippingLatitude);
            shipAddy.Long_x = String.valueOf(inv.Work_Order__r.Customer_Account__r.ShippingLongitude);
            invoiceObj.ShipAddr = shipAddy;
        }

        
        //////////////////////////
        // INVOICE LINE ITEMS
        //////////////////////////

        //Initialize line items for invoice mapping
        QBInvoiceJSON.SalesItemLineDetail salesItemLineDetail;
        List<QBInvoiceJSON.Line> lineItems = new List<QBInvoiceJSON.Line>(); // refers to the list in parent class
        QBInvoiceJSON.Line line; // refers to the sub class

        for(WorkOrderLineItem woli : woliList){
            System.debug(woli);

            line = new QBInvoiceJSON.Line(); 

            salesItemLineDetail = new QBInvoiceJSON.SalesItemLineDetail();
            QBInvoiceJSON.ItemRef itemRef = new QBInvoiceJSON.ItemRef();
            // Pull this from QB instance, 
            // this is the product/service (or Item) required for an invoice line item
            
            itemRef.name = woli.PricebookEntry.Product2.Name;
            itemRef.value = woli.PricebookEntry.Product2.QBO_Id__c; 
            salesItemLineDetail.ItemRef = itemRef;

            // set line item details
            salesItemLineDetail.TaxCodeRef          = new QBInvoiceJSON.ItemRef();
            salesItemLineDetail.TaxCodeRef.value    = 'TAX';
            salesItemLineDetail.Qty                 = woli.Quantity.setScale(2);
            salesItemLineDetail.UnitPrice           = woli.UnitPrice.setScale(2);
            line.SalesItemLineDetail = salesItemLineDetail;

            System.debug('Quantity: ' + salesItemLineDetail.Qty);
            System.debug('UnitPrice: ' + salesItemLineDetail.UnitPrice);

            // Set line parent vars
            line.Amount = (salesItemLineDetail.Qty  * salesItemLineDetail.UnitPrice).setScale(2);
            System.debug('Amount: ' + Line.Amount);
            line.Description    = woli.PricebookEntry.Product2.Family;
            line.DetailType = 'SalesItemLineDetail';

            lineItems.add(line);
            System.debug('Line : ' + line);
        }

        invoiceObj.line = lineItems;

        //*****  OVERRIDE TAX  *****//
        /*
        QBInvoiceJSON.TxnTaxDetail txnTaxDetail = new QBInvoiceJSON.TxnTaxDetail();
        QBInvoiceJSON.TaxLine taxLine = new QBInvoiceJSON.TaxLine();
        QBInvoiceJSON.TaxLineDetail taxLineDetail = new QBInvoiceJSON.TaxLineDetail();

        QBInvoiceJSON.ItemRef taxRateIdRef = new QBInvoiceJSON.ItemRef();
        taxRateIdRef.name = 'Florida';
        taxRateIdRef.value = '3'; // Change per QBO
        taxLineDetail.TaxRateRef = taxRateIdRef;
        taxLineDetail.PercentBased = true;
        taxLineDetail.TaxPercent = 7.5;

        taxLine.DetailType = 'TaxLineDetail';
        taxLine.TaxLineDetail = taxLineDetail;

        txnTaxDetail.TaxLine = new List<QBInvoiceJSON.TaxLine>{taxLine};

        //invoiceObj.TxnTaxDetail = txnTaxDetail;
        System.debug('txnTaxDetailDebug: ' + InvoiceObj.TxnTaxDetail);
        */


        System.debug('boogabooga' + JSON.serialize(invoiceObj, True).replace('"Long_x":', '"Long":'));
        return JSON.serialize(invoiceObj, True).replace('"Long_x":', '"Long":');
    }


     /**
     * Map an purchase order from Salesforce to QBO JSON
     * @param po The purchase order that is used for the mapping
     * @param poliList Purchase Order Items related to the PO
     * @return The json String that is used for the body of the request callout 
     */
    public static String mapPurchaseOrder(Purchase_Order__c po, List<Purchase_Order_Item__c> poliList){
        System.debug('********** In QBMap.mapPurchaseOrder');
       
        /////////////////////////////////
        // PURCHASE ORDER TOP LEVEL ITEMS
        /////////////////////////////////

        //Initialize purchase order object
        QBPOJSON purchaseOrderObj = new QBPOJSON();
 
        purchaseOrderObj.Id = po.QBO_Id__c;
        purchaseOrderObj.SyncToken = po.QBO_SyncToken__c;
        String poNumber = po.name.replace('PO-', '');
        purchaseOrderObj.DocNumber  = poNumber;
        
        //*****  EMAIL  *****//
        purchaseOrderObj.EmailStatus = 'NotSet'; //TODO: SHOULD THIS BE NOTSET?
        QBPOJSON.POEmail email = new QBPOJSON.POEmail();
        email.Address = po.Vendor_Account__r.contact__r.email;
        purchaseOrderObj.POEmail = email;

        //*****  VENDOR REFERENCE  *****//
        QBPOJSON.VendorRef vendorRef = new QBPOJSON.VendorRef();
        vendorRef.value = po.Vendor_Account__r.QBO_Id__c;
        vendorRef.Name = po.Vendor_Account__r.Name;
        purchaseOrderObj.VendorRef = vendorRef;

        //*****  AP ACCOUNT REFERENCE  *****//
        QBPOJSON.APAccountRef APAccountRef = new QBPOJSON.APAccountRef(); 
        // TODO:
        APAccountRef.value = '136';  //NOTE: change this per org but it's suggested to hardcode this as most QB customers only have 1 AP and changeing regularly causes some customer relationship issues
        APAccountRef.Name = 'Accounts Payable (A/P)';
        purchaseOrderObj.APAccountRef = APAccountRef;

        //*****  SHIPPING ADDRESS  *****//
        QBPOJSON.ShipAddr shipAddy = new QBPOJSON.ShipAddr();
        if(po.Vendor_Account__r != null){
            String phone = '';
            String cName = '';

            if(po.Vendor_Account__r != null){
               cName = po.Vendor_Account__r.Name;

            }
            if(po.Vendor_Account__r.Contact__c != null){
                cName = po.Vendor_Account__r.Contact__r.Name;
            }
            String contactLine = cName + phone;

            shipAddy.Line1 = po.Vendor_Account__r.Name;
            shipAddy.Line2 = contactLine ;
            shipAddy.Line3 = po.Vendor_Account__r.ShippingStreet;
            shipAddy.Line4 = po.Vendor_Account__r.ShippingCity + ', '+ 
                               po.Vendor_Account__r.ShippingState + '  ' +
                               po.Vendor_Account__r.ShippingPostalCode + '\n';           
                               purchaseOrderObj.ShipAddr = shipAddy;
        }


        ////////////////////////////
        // PURCHASE ORDER LINE ITEMS
        ////////////////////////////
       
        //Initialize line items for invoice mapping
        QBPOJSON.ItemBasedExpenseLineDetail ItemBasedExpenseLineDetail;
        List<QBPOJSON.Line> lineItems = new List<QBPOJSON.Line>(); // refers to the list in parent class
        QBPOJSON.Line line; // refers to the sub class

        for(Purchase_Order_Item__c poli : poliList){

            // Top level line object
            line = new QBPOJSON.Line();
            line.Amount = poli.Amount__c;
            line.DetailType = 'ItemBasedExpenseLineDetail';    
            line.Id = poli.Name.split('-')[1];
            
            
            // Start ItemBasedExpenseLineDetail NOTE: OTHER IS ACCOUNT BASED
            ItemBasedExpenseLineDetail = new QBPOJSON.ItemBasedExpenseLineDetail();
            ItemBasedExpenseLineDetail.BillableStatus = String.valueOf(poli.Billable_Status__c).deleteWhitespace(); // turns 'Not Billable' into 'NotBillable'
            ItemBasedExpenseLineDetail.UnitPrice = poli.Unit_Cost__c;
            ItemBasedExpenseLineDetail.Qty = poli.Quantity__c;
            ItemBasedExpenseLineDetail.BillableStatus = 'NotBillable';  //NOTE: make programmatic
            
            // ItemRef: product Name and QBO Id
            QBPOJSON.ItemRef itemRef = new QBPOJSON.ItemRef(); 
            itemRef.value = poli.Product__r.QBO_Id__c;
            ItemBasedExpenseLineDetail.ItemRef = itemref;

            // Customer Reference
            QBPOJSON.ItemRef customerRef = new QBPOJSON.ItemRef();
            //customerRef.value = poli.Purchase_Order__r.Vendor_Account__r.QBO_Id__c;
            customerRef.value = po.Work_Order__r.QBO_Id__c;
            ItemBasedExpenseLineDetail.CustomerRef = customerRef;  //NOTE: currently not being added to object

            // Tax Code Reference
            QBPOJSON.TaxCodeRef taxCodeRef = new QBPOJSON.TaxCodeRef();
            taxCodeRef.value = 'NON';  // NOTE: we need to add a piece to query Tax Code References

            // End ItemBasedExpenseLineDetail
            line.ItemBasedExpenseLineDetail = ItemBasedExpenseLineDetail; 
            
            lineItems.add(line);
        }
        purchaseOrderObj.Line = lineItems;

        system.debug(purchaseOrderObj);

        return JSON.serialize(purchaseOrderObj, True).replace('"Long_x":', '"Long":');
    }

        
    /**
     * Map an product from Salesforce to QBO JSON
     * @param p The product that is used for the mapping
     * @return The json String that is used for the body of the request callout 
     */
    public static String mapItem(Product2 p){
        System.debug('********** In QBMap.mapItem');
        
        //Initialize item object
        QBItemJSON itemObj = new QBItemJSON();
        itemObj.IncomeAccountRef = new QBItemJSON.IncomeAccountRef();
        itemObj.TrackQtyOnHand = false;
        itemObj.Name = p.Name;
        itemObj.Type = 'NonInventory';
        
        // Set QBO ID and Sync Token to update instead of create 
        if(!String.isBlank(p.QBO_Id__c)){
            itemObj.Id = p.QBO_Id__c;
            System.debug('SF Product QBO Id: ' + p.QBO_Id__c);
        }

        if(!String.isBlank(p.QBO_SyncToken__c)){
            itemObj.SyncToken = p.QBO_SyncToken__c;
        }

        // Set Income and Expense Account
        if(p.Sell_Product_Service__c){
            QBItemJSON.IncomeAccountRef IncomeAccountRef = new QBItemJSON.IncomeAccountRef();
            IncomeAccountRef.value = p.Income_Account__c;
            itemObj.IncomeAccountRef = IncomeAccountRef;
            System.debug('SF Income Account Id: ' + p.Income_Account__c);
        }
        
        if(p.Purchase_Product_Service__c){
            QBItemJSON.ExpenseAccountRef ExpenseAccountRef = new QBItemJSON.ExpenseAccountRef();
            ExpenseAccountRef.value = p.Expense_Account__c;
            itemObj.ExpenseAccountRef = ExpenseAccountRef;
            System.debug('SF Expense Account Id: ' + p.Expense_Account__c);
        }

        return JSON.serialize(itemObj, True).replace('"Long_x":', '"Long":');
    }

    
    /**
     * Map the SF Account data to the QB vendor JSON
     * @param acc The account data that is mapped
     * @return the QB json that can be used to CRUD a customer in QBO
     */
    public static String mapAccountDataVendor(Account acc){
        QBVendorJSON.Vendor vendor = new QBVendorJSON.Vendor();

        vendor.Id = acc.QBO_Id__c;
        vendor.SyncToken = acc.QBO_SyncToken__c;

        //Create Primary Phone
        QBVendorJSON.PrimaryPhone phone = new QBVendorJSON.PrimaryPhone ();
        phone.FreeFormNumber = acc.Phone;
        vendor.PrimaryPhone = phone;
        
        QBVendorJSON.PrimaryEmailAddr email = new QBVendorJSON.PrimaryEmailAddr ();
        email.Address = acc.contact__r.email; //does not have correct mapping
        vendor.PrimaryEmailAddr = email;
        //QBVendorJSON.WebAddr webAddress = new QBVendorJSON.WebAddr ();
        //webAddress.URI = 'www.test.com';
        //vendor.WebAddr = webAddress;
        

        //Create Billing Address
        QBVendorJSON.BillAddr billAddy = new QBVendorJSON.BillAddr();
        billAddy.City = acc.BillingCity;
        billAddy.Line1 = acc.BillingStreet;
        billAddy.CountrySubDivisionCode = acc.BillingState;
        billAddy.PostalCode = acc.BillingPostalCode;
        billAddy.Lat = String.valueOf(acc.BillingLatitude);
        billAddy.Long_x = String.valueOf(acc.BillingLongitude);
        billAddy.Country = acc.BillingCountry;
        vendor.BillAddr = billAddy;

        vendor.DisplayName = acc.Name;
        vendor.GivenName = acc.Name;

        return JSON.serialize(vendor, True).replace('"Long_x":', '"Long":');
    }

}