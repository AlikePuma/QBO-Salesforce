public class QBInvoiceResponseJSON {

	public class Line {
		public String Id {get;set;} 
		public Integer LineNum {get;set;} 
		public Double Amount {get;set;} 
		public String Description {get;set;} 
		public String DetailType {get;set;} 
		public SalesItemLineDetail SalesItemLineDetail {get;set;} 
		public LinkedTxn SubTotalLineDetail {get;set;} 

		public Line(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Id') {
							Id = parser.getText();
						} else if (text == 'LineNum') {
							LineNum = parser.getIntegerValue();
						} else if (text == 'Amount') {
							Amount = parser.getDoubleValue();
						} else if (text == 'Description') {
							Description = parser.getText();
						} else if (text == 'DetailType') {
							DetailType = parser.getText();
						} else if (text == 'SalesItemLineDetail') {
							SalesItemLineDetail = new SalesItemLineDetail(parser);
						} else if (text == 'SubTotalLineDetail') {
							SubTotalLineDetail = new LinkedTxn(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Line consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CurrencyRef {
		public String value {get;set;} 
		public String name {get;set;} 

		public CurrencyRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CurrencyRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Invoice {
		public Integer Deposit {get;set;} 
		public Boolean AllowIPNPayment {get;set;} 
		public Boolean AllowOnlinePayment {get;set;} 
		public Boolean AllowOnlineCreditCardPayment {get;set;} 
		public Boolean AllowOnlineACHPayment {get;set;} 
		public String domain {get;set;} 
		public Boolean sparse {get;set;} 
		public String Id {get;set;} 
		public String SyncToken {get;set;} 
		public MetaData MetaData {get;set;} 
		public List<CustomField> CustomField {get;set;} 
		public String DocNumber {get;set;} 
		public String TxnDate {get;set;} 
		public CurrencyRef CurrencyRef {get;set;} 
		public List<LinkedTxn> LinkedTxn {get;set;} 
		public List<Line> Line {get;set;} 
		public CurrencyRef CustomerRef {get;set;} 
		public ShipFromAddr ShipFromAddr {get;set;} 
		public String DueDate {get;set;} 
		public Double TotalAmt {get;set;} 
		public Boolean ApplyTaxAfterDiscount {get;set;} 
		public String PrintStatus {get;set;} 
		public String EmailStatus {get;set;} 
		public Double Balance {get;set;} 
		public TxnTaxDetail TxnTaxDetail {get;set;}

		public Invoice(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Deposit') {
							Deposit = parser.getIntegerValue();
						} else if (text == 'AllowIPNPayment') {
							AllowIPNPayment = parser.getBooleanValue();
						} else if (text == 'AllowOnlinePayment') {
							AllowOnlinePayment = parser.getBooleanValue();
						} else if (text == 'AllowOnlineCreditCardPayment') {
							AllowOnlineCreditCardPayment = parser.getBooleanValue();
						} else if (text == 'AllowOnlineACHPayment') {
							AllowOnlineACHPayment = parser.getBooleanValue();
						} else if (text == 'domain') {
							domain = parser.getText();
						} else if (text == 'sparse') {
							sparse = parser.getBooleanValue();
						} else if (text == 'Id') {
							Id = parser.getText();
						} else if (text == 'SyncToken') {
							SyncToken = parser.getText();
						} else if (text == 'MetaData') {
							MetaData = new MetaData(parser);
						} else if (text == 'CustomField') {
							CustomField = arrayOfCustomField(parser);
						} else if (text == 'DocNumber') {
							DocNumber = parser.getText();
						} else if (text == 'TxnDate') {
							TxnDate = parser.getText();
						} else if (text == 'CurrencyRef') {
							CurrencyRef = new CurrencyRef(parser);
						} else if (text == 'TxnTaxDetail') {
							TxnTaxDetail = new TxnTaxDetail(parser);
						} else if (text == 'LinkedTxn') {
							LinkedTxn = arrayOfLinkedTxn(parser);
						} else if (text == 'Line') {
							Line = arrayOfLine(parser);
						} else if (text == 'CustomerRef') {
							CustomerRef = new CurrencyRef(parser);
						} else if (text == 'ShipFromAddr') {
							ShipFromAddr = new ShipFromAddr(parser);
						} else if (text == 'DueDate') {
							DueDate = parser.getText();
						} else if (text == 'TotalAmt') {
							TotalAmt = parser.getDoubleValue();
						} else if (text == 'ApplyTaxAfterDiscount') {
							ApplyTaxAfterDiscount = parser.getBooleanValue();
						} else if (text == 'PrintStatus') {
							PrintStatus = parser.getText();
						} else if (text == 'EmailStatus') {
							EmailStatus = parser.getText();
						} else if (text == 'Balance') {
							Balance = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Invoice consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class TaxCodeRef {
		public String value {get;set;} 

		public TaxCodeRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'TaxCodeRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ShipFromAddr {
		public String Id {get;set;} 
		public String Line1 {get;set;} 
		public String Line2 {get;set;} 

		public ShipFromAddr(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Id') {
							Id = parser.getText();
						} else if (text == 'Line1') {
							Line1 = parser.getText();
						} else if (text == 'Line2') {
							Line2 = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ShipFromAddr consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class MetaData {
		public String CreateTime {get;set;} 
		public String LastUpdatedTime {get;set;} 

		public MetaData(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'CreateTime') {
							CreateTime = parser.getText();
						} else if (text == 'LastUpdatedTime') {
							LastUpdatedTime = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'MetaData consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public Invoice Invoice {get;set;} 
	//public String time {get;set;} 

	public QBInvoiceResponseJSON(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'Invoice') {
						Invoice = new Invoice(parser);
					} else if (text == 'time') {
						//1time = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'QBInvoiceResponseJSON consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class SalesItemLineDetail {
		public CurrencyRef ItemRef {get;set;} 
		public CurrencyRef ItemAccountRef {get;set;} 
		public TaxCodeRef TaxCodeRef {get;set;} 

		public SalesItemLineDetail(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'ItemRef') {
							ItemRef = new CurrencyRef(parser);
						} else if (text == 'ItemAccountRef') {
							ItemAccountRef = new CurrencyRef(parser);
						} else if (text == 'TaxCodeRef') {
							TaxCodeRef = new TaxCodeRef(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'SalesItemLineDetail consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CustomField {
		public String DefinitionId {get;set;} 
		public String Type_Z {get;set;} // in json: Type
		public String StringValue {get;set;} 
		public String Name {get;set;} 

		public CustomField(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'DefinitionId') {
							DefinitionId = parser.getText();
						} else if (text == 'Type') {
							Type_Z = parser.getText();
						} else if (text == 'StringValue') {
							StringValue = parser.getText();
						} else if (text == 'Name') {
							Name = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CustomField consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public class LinkedTxn {

		public LinkedTxn(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						{
							System.debug(LoggingLevel.WARN, 'LinkedTxn consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class SalesTermRef {
		public String value {get;set;} 

		public SalesTermRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'SalesTermRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class TaxLine {
		public String DetailType {get;set;} 
		public Double Amount {get;set;} 
		public TaxLineDetail TaxLineDetail {get;set;} 

		public TaxLine(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'DetailType') {
							DetailType = parser.getText();
						} else if (text == 'Amount') {
							Amount = parser.getDoubleValue();
						} else if (text == 'TaxLineDetail') {
							TaxLineDetail = new TaxLineDetail(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'TaxLine consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class TaxLineDetail {
		public Double NetAmountTaxable {get;set;} 
		public Integer TaxPercent {get;set;} 
		public SalesTermRef TaxRateRef {get;set;} 
		public Boolean PercentBased {get;set;} 

		public TaxLineDetail(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'NetAmountTaxable') {
							NetAmountTaxable = parser.getDoubleValue();
						} else if (text == 'TaxPercent') {
							TaxPercent = parser.getIntegerValue();
						} else if (text == 'TaxRateRef') {
							TaxRateRef = new SalesTermRef(parser);
						} else if (text == 'PercentBased') {
							PercentBased = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'TaxLineDetail consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class TxnTaxDetail {
		public SalesTermRef TxnTaxCodeRef {get;set;} 
		public Double TotalTax {get;set;} 
		public List<TaxLine> TaxLine {get;set;} 

		public TxnTaxDetail(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'TxnTaxCodeRef') {
							TxnTaxCodeRef = new SalesTermRef(parser);
						} else if (text == 'TotalTax') {
							TotalTax = parser.getDoubleValue();
						} else if (text == 'TaxLine') {
							TaxLine = arrayOfTaxLine(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'TxnTaxDetail consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static QBInvoiceResponseJSON parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new QBInvoiceResponseJSON(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	



    private static List<CustomField> arrayOfCustomField(System.JSONParser p) {
        List<CustomField> res = new List<CustomField>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new CustomField(p));
        }
        return res;
    }

	private static List<TaxLine> arrayOfTaxLine(System.JSONParser p) {
        List<TaxLine> res = new List<TaxLine>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new TaxLine(p));
        }
        return res;
    }







    private static List<Line> arrayOfLine(System.JSONParser p) {
        List<Line> res = new List<Line>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Line(p));
        }
        return res;
    }





    private static List<LinkedTxn> arrayOfLinkedTxn(System.JSONParser p) {
        List<LinkedTxn> res = new List<LinkedTxn>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new LinkedTxn(p));
        }
        return res;
    }






}