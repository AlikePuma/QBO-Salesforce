public class QBInvoiceJSON {

	public static QBInvoiceJSON parse(String json) {
		return (QBInvoiceJSON) System.JSON.deserialize(json, QBInvoiceJSON.class);
	}

	// required
	public List<Line> Line;
	public EmailAddress BillEmail;
	public CustomerRef CustomerRef;
	public String SyncToken;

	// not required
	public Boolean AllowOnlineACHPayment;
	public Boolean AllowOnlineCreditCardPayment;
	public Double Balance;
	public BillAddr BillAddr;
	public List<CustomField> CustomField;
	public MemoRef CustomerMemo;
	public String DocNumber;
	public Date DueDate;
	public String EmailStatus;
	public String Id;
	public BillAddr ShipAddr;
	public SalesTermRef SalesTermRef;
	public TxnTaxDetail TxnTaxDetail;


	public class Line {
		public Decimal Amount;
		public String Description;
		public String DetailType;
		public SalesItemLineDetail SalesItemLineDetail;
	}

	public class BillAddr {
		public String Id;
		public String Line1;
		public String Line2;
		public String Line3;
		public String Line4;
		public String Line5;
		public String City;
		public String CountrySubDivisionCode;
		public String PostalCode;
		public String Lat;
		public String Long_x;
		public String Country;
	}

	public class CustomField {
		public String DefinitionId;
		public String StringValue;
		public String Type;
		public String Name;
	}

	public class CustomerRef {
		public String value;
	}	

	public class EmailAddress{
		public string Address;
	}

	public class ItemRef {
		public String value;
		public String name;
	}

	public class MemoRef{
		public string value;
	}

	public class SalesItemLineDetail {
		public ItemRef ItemRef;
		public ItemRef TaxCodeRef;
		public Decimal Qty;
		public Decimal UnitPrice;
	}

    public class SalesTermRef {
        public String value;
    }

	public class TaxLine {
		// Required
		public String DetailType;  // 'TaxLineDetail'
		public TaxLineDetail TaxLineDetail;
		// Not Required
		public Double Amount;
	}

	public class TaxLineDetail {
		// Required
		public ItemRef TaxRateRef; // Id & Name from QBO
		// Not Required
		public Double NetAmountTaxable;
		public Boolean PercentBased;
		public Decimal TaxPercent;  // 8.5 not .085
	}

	public class TxnTaxDetail {
		// Not Required
		public SalesTermRef TxnTaxCodeRef;
		public Double TotalTax ;
		public List<TaxLine> TaxLine ;
	}
}