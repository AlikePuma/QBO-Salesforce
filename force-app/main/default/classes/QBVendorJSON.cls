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
		public Boolean Vendor1099;
		public String domain;
		public String DisplayName;
		public String SyncToken;
		public String PrintOnCheckName;
		public Boolean sparse;
		public Boolean Active;
		public Double Balance;
		public String Id;
		public MetaData MetaData;
		public BillAddr BillAddr;
		public String CompanyName;
		public TermRef TermRef;
		public PrimaryPhone PrimaryPhone;
		public String GivenName;
		public PrimaryPhone Mobile;
		public String FamilyName;
		public String TaxIdentifier;
		public String AcctNum;
		public WebAddr WebAddr;
		public PrimaryEmailAddr PrimaryEmailAddr;

	}
	public class TermRef {
		public String value;
	}
	public class WebAddr {
		public String URI;
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