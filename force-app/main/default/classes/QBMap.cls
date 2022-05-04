public class QBMap {
  
    /**
     * Map the SF Account data to the QB customer JSON
     * @param acc The account data that is mapped
     * @return the QB json that can be used to CRUD a customer in QBO
     */
    public static String mapAccountData(Account acc){
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
     * Map an invoice from Salesforce to QBO JSON
     * @param inv The invoice that is used for the mapping
     * @return The json String that is used for the body of the request callout 
     */
    public static String mapInvoice(Invoice__c inv){
        //Initialize invoice object
        QBInvoiceJSON invoiceObj = new QBInvoiceJSON();

        //Initialize line items for invoice mapping
        QBInvoiceJSON.Line line = new QBInvoiceJSON.Line();
        QBInvoiceJSON.SalesItemLineDetail detail = new QBInvoiceJSON.SalesItemLineDetail();
        invoiceObj.Line = new List<QBInvoiceJSON.Line>();
        
        //map line item fields
        line.Amount = inv.Total__c;
        //@todo unhardcode this
        line.DetailType = 'SalesItemLineDetail';
        invoiceObj.Id = inv.QBO_Id__c;
        invoiceObj.SyncToken = inv.QBO_SyncToken__c;
        invoiceObj.DueDate = inv.Due_Date__c;
        invoiceObj.AllowOnlineACHPayment = True;
        invoiceObj.AllowOnlineCreditCardPayment = True;
        String invNumber = inv.name.replace('INV-', '');
        invoiceObj.DocNumber  = invNumber;
        invoiceObj.EmailStatus = 'NotSet';
        QBInvoiceJSON.EmailAddress email = new QBInvoiceJSON.EmailAddress();
        email.Address = inv.Opportunity__r.Account.contact__r.email;
        invoiceObj.BillEmail = email;

        QBInvoiceJSON.CustomerRef customerRef = new QBInvoiceJSON.CustomerRef();
        customerRef.value = inv.Opportunity__r.Account.QBO_Id__c;
        invoiceObj.CustomerRef = customerRef;
        
        //Map description
        QBInvoiceJSON.MemoRef memoRef = new QBInvoiceJSON.MemoRef();
        memoRef.value = inv.Description__c;
        invoiceObj.CustomerMemo = memoRef;
        QBInvoiceJSON.SalesTermRef sales = new QBInvoiceJSON.SalesTermRef();
        //these values are different for each QB org
        if(inv.Terms__c == 'Due on receipt'){
            sales.value = '6';
        }else if(inv.Terms__c == 'Net 15'){
            sales.value = '7';
        }else if(inv.Terms__c == 'Net 30'){
            sales.value = '8';
        }else{
            sales.value = '9';
        }
        invoiceObj.SalesTermRef = sales;
        
        //Create Billing Address
        QBInvoiceJSON.BillAddr billAddy = new QBInvoiceJSON.BillAddr();
        billAddy.City = inv.Opportunity__r.Account.BillingCity;
        billAddy.Line1 = inv.Opportunity__r.Account.BillingStreet;
        billAddy.CountrySubDivisionCode = inv.Opportunity__r.Account.BillingState;
        billAddy.PostalCode = inv.Opportunity__r.Account.BillingPostalCode;
        billAddy.Country = inv.Opportunity__r.Account.BillingCountry;
        invoiceObj.BillAddr = billAddy;

        //Create Shipping Address
        QBInvoiceJSON.BillAddr shipAddy = new QBInvoiceJSON.BillAddr();
        if(inv.Opportunity__r.Account != null){
            String phone = '';
            String cName = '';

            if(inv.Opportunity__r.Account != null){
                cName = inv.Opportunity__r.Account.Name;

            }
            if(inv.Opportunity__r.Account.Contact__c != null){
                cName = inv.Opportunity__r.Account.Contact__r.Name;
            }
            String contactLine = cName + phone;

            shipAddy.Line1 = inv.Opportunity__r.Account.Name;
            shipAddy.Line2 = contactLine ;
            shipAddy.Line3 = inv.Opportunity__r.Account.ShippingStreet;
            //shipAddy.City = inv.Opportunity__r.Account.ShippingCity;

            shipAddy.Line4 = inv.Opportunity__r.Account.ShippingCity + ', '+ 
                               inv.Opportunity__r.Account.ShippingState + '  ' +
                               inv.Opportunity__r.Account.ShippingPostalCode + '\n';
            //shipAddy.CountrySubDivisionCode = inv.Opportunity__r.Account.ShippingState;
            ///shipAddy.PostalCode = inv.Opportunity__r.Account.ShippingPostalCode;
            shipAddy.Lat = String.valueOf(inv.Opportunity__r.Account.ShippingLatitude);
            shipAddy.Long_x = String.valueOf(inv.Opportunity__r.Account.ShippingLongitude);
            invoiceObj.ShipAddr = shipAddy;
        }

        //map line detail fields
        QBInvoiceJSON.ItemRef itemRef = new QBInvoiceJSON.ItemRef();
        //Pull this from QB instance
        //Map to 1 product
        //@todo unhardcode this
        itemRef.name = 'Sales';//Sandbox: 'Services';
        itemRef.value = '25'; //Sandbox: '19'; Prod '1'
        
        detail.ItemRef = itemRef;

        //map taxable status for an invoice
        detail.TaxCodeRef = new QBInvoiceJSON.ItemRef();
        detail.TaxCodeRef.value = 'TAX';
        detail.Qty = 1;
        detail.UnitPrice = 2;
        line.SalesItemLineDetail = detail;

        invoiceObj.Line.add(line);

        return JSON.serialize(invoiceObj, True).replace('"Long_x":', '"Long":');
    }

    /**
     * Map an purchase order from Salesforce to QBO JSON
     * @param po The purchase order that is used for the mapping
     * @return The json String that is used for the body of the request callout 
     */
    public static String mapPurchaseOrder(Purchase_Order__c po,List<Purchase_Order_Item__c> poli){
        //Initialize purchase order object
        QBPOJSON purchaseOrderObj = new QBPOJSON();
        
        //Initialize line items for invoice mapping
        QBPOJSON.Line line = new QBPOJSON.Line();
        QBPOJSON.ItemBasedExpenseLineDetail detail = new QBPOJSON.ItemBasedExpenseLineDetail();
        
        purchaseOrderObj.Line = new List<QBPOJSON.Line>();
        //map line item fields
        line.Amount = 0;
        //@todo unhardcode this
        line.DetailType = 'ItemBasedExpenseLineDetail';        
        purchaseOrderObj.Id = po.QBO_Id__c;
        purchaseOrderObj.SyncToken = po.QBO_SyncToken__c;
        String invNumber = po.name.replace('PO-', '');
        purchaseOrderObj.DocNumber  = invNumber;
        purchaseOrderObj.EmailStatus = 'NotSet';

        QBPOJSON.POEmail email = new QBPOJSON.POEmail();
        email.Address = po.Vendor_Account__r.contact__r.email;
        purchaseOrderObj.POEmail = email;

        QBPOJSON.VendorRef vendorRef = new QBPOJSON.VendorRef();
        //vendorRef.value = po.Vendor_Account__r.QBO_Id__c;
        vendorRef.value = '63';
        vendorRef.Name = 'Test Vendor';
        purchaseOrderObj.VendorRef = vendorRef;

        QBPOJSON.APAccountRef APAccountRef = new QBPOJSON.APAccountRef();
        APAccountRef.value = '135';
        APAccountRef.Name = 'Accounts Payable (A/P)';
        purchaseOrderObj.APAccountRef = APAccountRef;

        //Create Shipping Address
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
        for(Purchase_Order_Item__c poi : poli){
            //map line detail fields
            //QBPOJSON.ItemRef itemRef = new QBPOJSON.ItemRef();
            //@todo unhardcode this
            //itemRef.name = poi.Product__r.Name;//Sandbox: 'Services';
            //itemRef.value = poi.Product__r.QBO_Id__c; //Sandbox: '19'; Prod '1'
            //detail.ItemRef = itemRef;
        }
        QBPOJSON.ItemRef itemRef = new QBPOJSON.ItemRef();
            //@todo unhardcode this
            itemRef.name = 'SoClo-DataBackup';//Sandbox: 'Services';
            itemRef.value = '27'; //Sandbox: '19'; Prod '1'
            detail.ItemRef = itemRef;

        purchaseOrderObj.Id = po.QBO_Id__c;
        purchaseOrderObj.SyncToken = po.QBO_SyncToken__c;
        purchaseOrderObj.TotalAmt = 0;

        //map taxable status for an invoice
        detail.TaxCodeRef = new QBPOJSON.TaxCodeRef();
        detail.TaxCodeRef.value = 'TAX';
        line.ItemBasedExpenseLineDetail = detail;
        system.debug(purchaseOrderObj);

        purchaseOrderObj.Line.add(line);
                //return null;
        return JSON.serialize(purchaseOrderObj, True).replace('"Long_x":', '"Long":');
    }

        /**
     * Map an product from Salesforce to QBO JSON
     * @param p The product that is used for the mapping
     * @return The json String that is used for the body of the request callout 
     */
    public static String mapItem(Product2 p){
        //Initialize item object
        QBItemJSON itemObj = new QBItemJSON();
        itemObj.IncomeAccountRef = new QBItemJSON.IncomeAccountRef();
        itemObj.TrackQtyOnHand = false;
        itemObj.Name = p.Name;
        itemObj.Type = 'NonInventory';

        QBItemJSON.IncomeAccountRef IncomeAccountRef = new QBItemJSON.IncomeAccountRef();
        IncomeAccountRef.value = '121';
        IncomeAccountRef.name = p.Name;
        itemObj.IncomeAccountRef = IncomeAccountRef;
        
        return JSON.serialize(itemObj, True).replace('"Long_x":', '"Long":');
    }

}