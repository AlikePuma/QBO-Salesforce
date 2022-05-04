public class QBItemJSON {

	public Boolean TrackQtyOnHand;
	public String Name;
	public Double UnitPrice;
	public Boolean Taxable;
	public IncomeAccountRef IncomeAccountRef;
	public IncomeAccountRef AssetAccountRef;
	public String InvStartDate;
	public String Type;
	public IncomeAccountRef ExpenseAccountRef;

	public class IncomeAccountRef {
		public String name;
		public String value;
	}

	
	public static QBItemJSON parse(String json) {
		return (QBItemJSON) System.JSON.deserialize(json, QBItemJSON.class);
	}
}