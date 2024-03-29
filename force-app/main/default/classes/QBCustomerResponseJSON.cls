public class QBCustomerResponseJSON {

	public class CurrencyRef {
		public String value;
		public String name;
	}

	public class Customer {
		public Boolean Taxable;
		public Boolean Job;
		public Boolean BillWithParent;
		public Decimal Balance;
		public Decimal BalanceWithJobs;
		public CurrencyRef CurrencyRef;
		public String PreferredDeliveryMethod;
		public Boolean IsProject;
		public String domain;
		public Boolean sparse;
		public String Id;
		public String SyncToken;
		public MetaData MetaData;
		public String GivenName;
		public String FamilyName;
		public String FullyQualifiedName;
		public String CompanyName;
		public String DisplayName;
		public String PrintOnCheckName;
		public Boolean Active;
		public PrimaryEmailAddr PrimaryEmailAddr;
		public DefaultTaxCodeRef DefaultTaxCodeRef;
	}

	public class MetaData {
		public String CreateTime;
		public String LastUpdatedTime;
	}

	public Customer Customer;
	public String times;

	public class DefaultTaxCodeRef {
		public String value;
	}

	public class PrimaryEmailAddr {
		public String Address;
	}

	
	public static QBCustomerResponseJSON parse(String json) {
		return (QBCustomerResponseJSON) System.JSON.deserialize(json, QBCustomerResponseJSON.class);
	}
}