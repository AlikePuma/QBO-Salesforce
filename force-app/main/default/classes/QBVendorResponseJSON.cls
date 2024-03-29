//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//
// The supplied json has fields with names that are not valid in apex
// and so can only be parsed with explicitly generated code, this option
// was auto selected for you.

public class QBVendorResponseJSON {

	public class BillAddr {
		public String City {get;set;} 
		public String Country {get;set;} 
		public String Line3 {get;set;} 
		public String Line2 {get;set;} 
		public String Line1 {get;set;} 
		public String PostalCode {get;set;} 
		public String CountrySubDivisionCode {get;set;} 
		public String Id {get;set;} 

		public BillAddr(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'City') {
							City = parser.getText();
						} else if (text == 'Country') {
							Country = parser.getText();
						} else if (text == 'Line3') {
							Line3 = parser.getText();
						} else if (text == 'Line2') {
							Line2 = parser.getText();
						} else if (text == 'Line1') {
							Line1 = parser.getText();
						} else if (text == 'PostalCode') {
							PostalCode = parser.getText();
						} else if (text == 'CountrySubDivisionCode') {
							CountrySubDivisionCode = parser.getText();
						} else if (text == 'Id') {
							Id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'BillAddr consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CurrencyRef {
		public String name {get;set;} 
		public String value {get;set;} 

		public CurrencyRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'value') {
							value = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CurrencyRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PrimaryPhone {
		public String FreeFormNumber {get;set;} 

		public PrimaryPhone(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'FreeFormNumber') {
							FreeFormNumber = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'PrimaryPhone consuming unrecognized property: '+text);
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
	
	public class Vendor {
		public String domain {get;set;} 
		public PrimaryEmailAddr PrimaryEmailAddr {get;set;} 
		public String DisplayName {get;set;} 
		public CurrencyRef CurrencyRef {get;set;} 
		public String GivenName {get;set;} 
		public String Title {get;set;} 
		public PrimaryPhone PrimaryPhone {get;set;} 
		public Boolean Active {get;set;} 
		public MetaData MetaData {get;set;} 
		public Boolean Vendor1099 {get;set;} 
		public BillAddr BillAddr {get;set;} 
		public PrimaryPhone Mobile {get;set;} 
		public WebAddr WebAddr {get;set;} 
		public Integer Balance {get;set;} 
		public String SyncToken {get;set;} 
		public String Suffix {get;set;} 
		public String CompanyName {get;set;} 
		public String FamilyName {get;set;} 
		public String TaxIdentifier {get;set;} 
		public String AcctNum {get;set;} 
		public String PrintOnCheckName {get;set;} 
		public Boolean sparse {get;set;} 
		public String Id {get;set;} 

		public Vendor(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'domain') {
							domain = parser.getText();
						} else if (text == 'PrimaryEmailAddr') {
							PrimaryEmailAddr = new PrimaryEmailAddr(parser);
						} else if (text == 'DisplayName') {
							DisplayName = parser.getText();
						} else if (text == 'CurrencyRef') {
							CurrencyRef = new CurrencyRef(parser);
						} else if (text == 'GivenName') {
							GivenName = parser.getText();
						} else if (text == 'Title') {
							Title = parser.getText();
						} else if (text == 'PrimaryPhone') {
							PrimaryPhone = new PrimaryPhone(parser);
						} else if (text == 'Active') {
							Active = parser.getBooleanValue();
						} else if (text == 'MetaData') {
							MetaData = new MetaData(parser);
						} else if (text == 'Vendor1099') {
							Vendor1099 = parser.getBooleanValue();
						} else if (text == 'BillAddr') {
							BillAddr = new BillAddr(parser);
						} else if (text == 'Mobile') {
							Mobile = new PrimaryPhone(parser);
						} else if (text == 'WebAddr') {
							WebAddr = new WebAddr(parser);
						} else if (text == 'Balance') {
							Balance = parser.getIntegerValue();
						} else if (text == 'SyncToken') {
							SyncToken = parser.getText();
						} else if (text == 'Suffix') {
							Suffix = parser.getText();
						} else if (text == 'CompanyName') {
							CompanyName = parser.getText();
						} else if (text == 'FamilyName') {
							FamilyName = parser.getText();
						} else if (text == 'TaxIdentifier') {
							TaxIdentifier = parser.getText();
						} else if (text == 'AcctNum') {
							AcctNum = parser.getText();
						} else if (text == 'PrintOnCheckName') {
							PrintOnCheckName = parser.getText();
						} else if (text == 'sparse') {
							sparse = parser.getBooleanValue();
						} else if (text == 'Id') {
							Id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Vendor consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public Vendor Vendor {get;set;} 
	public String time_Z {get;set;} // in json: time

	public QBVendorResponseJSON(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'Vendor') {
						Vendor = new Vendor(parser);
					} else if (text == 'time') {
						time_Z = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'QBVendorResponseJSON consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class PrimaryEmailAddr {
		public String Address {get;set;} 

		public PrimaryEmailAddr(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Address') {
							Address = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'PrimaryEmailAddr consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WebAddr {
		public String URI {get;set;} 

		public WebAddr(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'URI') {
							URI = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WebAddr consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static QBVendorResponseJSON parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new QBVendorResponseJSON(parser);
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
	











}