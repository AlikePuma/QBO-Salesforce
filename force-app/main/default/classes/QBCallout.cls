public class QBCallout {
    //Access token used for authentication in QB
    private String accessToken{get;set;}
    private String refreshToken{get;set;}
    private String namedCredential = 'callout:QBO';   
    private QBO_Metadata__mdt QBData = [SELECT Company_Id__c, minorversion__c FROM QBO_Metadata__mdt WHERE DeveloperName = 'Default'];


    public QBBatchResponseJSON createQbBatchCall(List<QBProductAndWoliWrapper> wrappers){
        System.debug('********** In QBCallout.createQbBatchCall()');

        final String API_CALL = 'batch';
        
        //Map inv data to QB Invoice JSON
        String body = QBMap.mapProductsToBatchItems(wrappers);

        //Initialze url endpoint
        QBO_Metadata__mdt QBData = [SELECT ID,
                            base_url__c,
                            Company_Id__c,
                            minorversion__c
                    FROM QBO_Metadata__mdt];
        String url = QBData.base_url__c + '/v3/company/' + QBData.Company_Id__c + '/' + API_CALL + '?minorversion=' + QBData.minorversion__c;


        //Start http request
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setBody(body);
        System.debug(body);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setheader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');
        res = h.send(req);
        System.debug(res.getBody());
        handleResponseError(res.getBody());

        return QBBatchResponseJSON.parse(res.getBody());
    }


    public QBCustomerJSON getCustomer(Account acc){
        System.debug('********** In QBCallout.getCustomer()');

        if(acc == null){
            Throw new NullPointerException();
        }
        //Initilize query
        String query = 'Select+*+from+Customer+where+job=False+and+' +
                             'DisplayName=+\'' + acc.Name.replaceAll(' ', '+') +'\'' ;
        if(acc.QBO_Id__c != null){
            query = 'select+*+from+Customer+where+job=False+and+Id=+\'' + Acc.QBO_Id__c + '\'';
        }
        String custPath = '/v3/company/'+ QBData.Company_Id__c +'/query?query='+query+'&minorversion='+QBData.minorversion__c;
        String method = 'GET';
        String body = null;
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json'};
        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        handleResponseError(res.getBody());
        QBCustomerJSON json = QBCustomerJSON.parse(res.getBody());
        return json;
    }
        

    /**
     * Create a QB customer using account object
     * @param acc Account used to create  
     */
    public QBCustomerResponseJSON createCustomerCall(Account acc){
        System.debug('********** In QBCallout.createCustomerCall()');

        //Map acc data to QB Customer JSON
        String body = QBMap.mapAccountData(acc);

        String custPath = '/v3/company/'+ QBData.Company_Id__c + '/customer?minorversion=' + QBData.minorversion__c;
        String method = 'POST';
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json', 'Content-Type' => 'application/json'};            
        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        handleResponseError(res.getBody());
        QBCustomerResponseJSON json = QBCustomerResponseJSON.parse(res.getBody());

        return json;
    }


    public QBCustomerJSON getSubCustomer(String qboId, String accountName, String jobNumber){
        System.debug('********** In QBCallout.getSubCustomer()');

        String fullyQualifiedName = accountName + ':' + jobNumber;

        //Initilize query
        String query;
        if(!String.isBlank(qboId)){
            query = 'SELECT+*+FROM+Customer+WHERE+job=True+and+Id=+\'' + qboId + '\'';
        } else {
            query = 'SELECT+*+FROM+Customer+WHERE+job=True+and+' +
                             'FullyQualifiedName=+\'' + fullyQualifiedName.replaceAll(' ', '+') +'\'' ;
        }
        
        String custPath = '/v3/company/'+ QBData.Company_Id__c +'/query?query='+query+'&minorversion='+QBData.minorversion__c;
        String method = 'GET';
        String body = null;
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json'};
        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        handleResponseError(res.getBody());
        QBCustomerJSON json = QBCustomerJSON.parse(res.getBody());
        System.debug(json);

        return json;
    }

    public QBCustomerResponseJSON createSubCustomerCall(WorkOrder wo){
        System.debug('********** In QBCallout.createSubCustomerCall()');

        //Map acc data to QB Customer JSON
        String body = QBMap.mapWorkOrderToSubCustomer(wo);

        String custPath = '/v3/company/'+ QBData.Company_Id__c + '/customer?minorversion=' + QBData.minorversion__c;
        String method = 'POST';
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json', 'Content-Type' => 'application/json'};            
        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        handleResponseError(res.getBody());
        QBCustomerResponseJSON json = QBCustomerResponseJSON.parse(res.getBody());

        return json;
    }


    public QBInvoiceQueryJSON getInvoice(Invoice__c inv){
        System.debug('********** In QBCallout.getInvoice()');

        if(inv == null){
            Throw new NullPointerException();
        }
        if(inv.QBO_Id__c == null || inv.QBO_SyncToken__c == null){
            return null;
        }
        //Initilize query
        String query = 'Select+*+from+invoice+where+id=\'' + inv.QBO_Id__c + '\'';        
        String custPath = '/v3/company/'+ QBData.Company_Id__c +'/query?query='+query+'&minorversion='+QBData.minorversion__c;
        String method = 'GET';
        String body = null;
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json'};

        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req);               
        handleResponseError(res.getBody());
        QBInvoiceQueryJSON json = QBInvoiceQueryJSON.parse(res.getBody());
        return json;
    }


    /**
     * Create an invoice for QBO from invoice__c object
     * @param inv The invoice that is needed to create an invoice in QBO
     * @return Response object     
     */
    public QBInvoiceResponseJSON createInvoiceFromWorkOrderCall(Invoice__c inv, WorkOrder wo, List<WorkOrderLineItem> woliList){
        System.debug('********** In QBCallout.createInvoiceFromWorkOrderCall()');
        
        String apiCall = 'invoice';
        String method = 'POST';


        //Map inv data to QB Invoice JSON
        String body = QBMap.mapInvoice(inv, wo, woliList);
        String custPath = '/v3/company/'+ QBData.Company_Id__c + '/' + apiCall + '?minorversion=' + QBData.minorversion__c;
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json', 'Content-Type' => 'application/json'};
        
        HttpRequest req = buildReq(namedCredential, custPath, method, body, headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req);   
        handleResponseError(res.getBody());
        return QBInvoiceResponseJSON.parse(res.getBody());
    }
    

    public QBPOQueryJSON getPurchaseOrder(Purchase_Order__c po){
        System.debug('********** In QBCallout.getPurchaseOrder()');

        if(po == null){
            Throw new NullPointerException();
        }
        if(po.QBO_Id__c == null || po.QBO_SyncToken__c == null){
            return null;
        }
        //Initilize query
        String query = 'Select+*+from+PurchaseOrder+where+id=\'' + po.QBO_Id__c + '\'';
        String custPath = '/v3/company/'+ QBData.Company_Id__c +'/query?query='+query+'&minorversion='+QBData.minorversion__c;
        String method = 'GET';
        String body = null;
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json'};

        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req);  
        handleResponseError(res.getBody());

        QBPOQueryJSON json = QBPOQueryJSON.parse(res.getBody());
        System.debug(json);
        return json;
    }


    /**
     * Create an purchase order for QBO from Purchase_Order__c object
     * @param po The purchase order that is needed to create an invoice in QBO
     * @return Response object     
     */
    public QBPOResponseJSON createPurchaseOrderCall(Purchase_Order__c po, List<Purchase_Order_Item__c> poli){
        System.debug('********** In QBCallout.createPurchaseOrderCall()');

        //Map inv data to QB purchase order JSON
        String body = QBMap.mapPurchaseOrder(po,poli);
        String custPath = '/v3/company/'+ QBData.Company_Id__c + '/purchaseorder?minorversion=' + QBData.minorversion__c;
        String method = 'POST';
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json', 'Content-Type' => 'application/json'};

        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req);   
        handleResponseError(res.getBody());
        return QBPOResponseJSON.parse(res.getBody());
    }


    public QBItemQueryJSON getItem(Product2 p){
        System.debug('********** In QBCallout.getItem()');

        if(p == null){
            Throw new NullPointerException();
        }

        //Initilize query
        String query = 'select * from Item where ';
        if(!String.isBlank(p.QBO_Id__c)){  // Search by Id or name
            query += 'Id=\'' + p.QBO_Id__c + '\'';
        } else {
            query += 'Name=\'' + p.Name + '\'';    
        }
        query = EncodingUtil.urlEncode(query, 'UTF-8');
        system.debug(query);

        String custPath = '/v3/company/'+ QBData.Company_Id__c +'/query?query='+query+'&minorversion='+QBData.minorversion__c;
        String method = 'GET';
        String body = null;
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json'};

        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        system.debug('req');
        Http http = new Http();
        HTTPResponse res = http.send(req);  
        system.debug(res.getBody());
        handleResponseError(res.getBody());
        
        QBItemQueryJSON json = QBItemQueryJSON.parse(res.getBody());
        System.debug(json);
        return json;
    }

        
    /**
     * Create an product for QBO from Product2 object
     * @param p The product that is needed to create an item in QBO
     * @return Response object     
     */
    public QBItemResponseJSON createItemCall(Product2 p){
        System.debug('********** In QBCallout.createItemCall()');
        
        //Map product data to QB item JSON
        String body = QBMap.mapItem(p);
        String custPath = '/v3/company/'+ QBData.Company_Id__c + '/item?minorversion=' + QBData.minorversion__c;
        String method = 'POST';
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json', 'Content-Type' => 'application/json'};

        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        system.debug(res.getBody());  
        handleResponseError(res.getBody());
        return QBItemResponseJSON.parse(res.getBody());
    }


    public QBVendorJSON getVendor(Account acc){
        System.debug('********** In QBCallout.getVendor()');

        if(acc == null){
            Throw new NullPointerException();
        }
        //Initilize query
        String query = 'Select+*+from+Vendor+where+' +
                             'DisplayName=+\'' + acc.Name.replaceAll(' ', '+') +'\'' ;
        if(acc.QBO_Id__c != null){
            query = 'select+*+from+Vendor+where+Id=+\'' + Acc.QBO_Id__c + '\'';
        }
        system.debug(query);
        String custPath = '/v3/company/'+ QBData.Company_Id__c +'/query?query='+query+'&minorversion='+QBData.minorversion__c;
        String method = 'GET';
        String body = null;
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json'};

        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        system.debug(res.getBody());
        handleResponseError(res.getBody());
        QBVendorJSON json = QBVendorJSON.parse(res.getBody());
        return json;
    }


    /**
     * Create a QB vendor using account object
     * @param acc Account used to create  
     */
    public QBVendorResponseJSON createVendorCall(Account acc){
        System.debug('********** In QBCallout.createVendorCall()');

        //Map acc data to QB Customer JSON
        String body = QBMap.mapAccountDataVendor(acc);
        system.debug('createVendorCall');
        String custPath = '/v3/company/'+ QBData.Company_Id__c + '/vendor?minorversion=' + QBData.minorversion__c;
        String method = 'POST';
        Map<String,String> headerMap = new Map<String,String>{'Accept' => 'application/json', 'Content-Type' => 'application/json'};            
        HttpRequest req = buildReq(namedCredential,custPath,method,body,headerMap);
        Http http = new Http();
        HTTPResponse res = http.send(req); 
        handleResponseError(res.getBody());
        QBVendorResponseJSON json = QBVendorResponseJSON.parse(res.getBody());

        return json;
    }
        

    /**
     * Throws exception if there is an error in the callout
     * @param body The json response from the QB callout
     */
    public void handleResponseError(String body){
        QBOErrorJSON error = QBOErrorJSON.parse(body);
        if(error != null){
            if(error.Fault != null && error.Fault.Error != null && error.Fault.Error.size() > 0){
                System.debug(error.Fault.Error[0]);
                Throw new QBException(String.valueOf(error.Fault.Error[0]));
            }
            
        }
    }


    /**
     * Create an http request
     * @param namCred The named credential used for the request
     * @param custPath The custom path added tot he url on the named credential
     * @param method Is this a GET, POST, SET, etc..
     * @param body The request body, set to null if not applicable
     * @param headers All headers needed for request in key, value format
     * @return http request    
     */
    private HttpRequest buildReq(String namCred, String custPath, String method, String body, Map<String,String> headers){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(namCred+custPath);
        req.setMethod(method);
        if(body!=null){
          req.setBody(body);
        }
        if(headers!=null){
        for(String key: headers.keySet()){
            req.setHeader(key, headers.get(key));
        }
    }
        return req;
    }
}