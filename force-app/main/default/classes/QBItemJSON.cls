public class QBItemJSON {
	public String Id;
	public String SyncToken;
	public String Name;
	public String InvStartDate;
	public String Type;
	public Boolean TrackQtyOnHand;
	public Double UnitPrice;
	public Boolean Taxable;
	public IncomeAccountRef IncomeAccountRef;
	public IncomeAccountRef AssetAccountRef;
	public ExpenseAccountRef ExpenseAccountRef;

	public class IncomeAccountRef {
		public String name;
		public String value;
	}

	public class ExpenseAccountRef {
		public String name;
		public String value;
	}
	
	public static QBItemJSON parse(String json) {
		return (QBItemJSON) System.JSON.deserialize(json, QBItemJSON.class);
	}
}