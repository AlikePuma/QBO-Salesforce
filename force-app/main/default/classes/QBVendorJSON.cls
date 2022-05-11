public class QBVendorJSON {

	public class BillAddr {
		public String Id;
		public String Line1;
		public String City;
		public String CountrySubDivisionCode;
		public String PostalCode;
		public String Lat;
		public String Long_x;
		public String Country;
	}

	public class ParentRef {
		public String value;
	}

	public class CurrencyRef {
		public String value;
		public String name;
	}

	public QueryResponse QueryResponse;
	public String timeString;

	public class PrimaryPhone {
		public String FreeFormNumber;
	}

	public class Vendor {
		public Boolean Vendor1099 {get;set;} 
		public String domain {get;set;} 
		public String DisplayName {get;set;} 
		public String SyncToken {get;set;} 
		public String PrintOnCheckName {get;set;} 
		public Boolean sparse {get;set;} 
		public Boolean Active {get;set;} 
		public Double Balance {get;set;} 
		public String Id {get;set;} 
		public MetaData MetaData {get;set;} 
		public BillAddr BillAddr {get;set;} 
		public String CompanyName {get;set;} 
		public TermRef TermRef {get;set;} 
		public PrimaryPhone PrimaryPhone {get;set;} 
		public String GivenName {get;set;} 
		public PrimaryPhone Mobile {get;set;} 
		public String FamilyName {get;set;} 
		public String TaxIdentifier {get;set;} 
		public String AcctNum {get;set;} 
		public WebAddr WebAddr {get;set;} 
		public PrimaryEmailAddr PrimaryEmailAddr {get;set;} 

	}
	public class TermRef {
		public String value {get;set;} 
	}
	public class WebAddr {
		public String URI {get;set;} 
	}
	public class MetaData {
		public String CreateTime;
		public String LastUpdatedTime;
	}

	public class QueryResponse {
		public List<Vendor> Vendor;
		public Integer startPosition;
		public Integer maxResults;
	}

	public class PrimaryEmailAddr {
		public String Address;
	}

	
	public static QBVendorJSON parse(String json) {
		return (QBVendorJSON) System.JSON.deserialize(json, QBVendorJSON.class);
	}

	//Custom method to parse Customer data
	public static QBVendorJSON.Vendor parseCustomer(String json) {
		return (QBVendorJSON.Vendor) System.JSON.deserialize(json, QBVendorJSON.Vendor.class);
	}
}