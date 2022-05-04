public class QBItemQueryResponseJSON {

	public class Item {
		public String Name {get;set;} 
		public String Description {get;set;} 
		public Boolean Active {get;set;} 
		public String FullyQualifiedName {get;set;} 
		public Boolean Taxable {get;set;} 
		public Integer UnitPrice {get;set;} 
		public String Type {get;set;} 
		public IncomeAccountRef IncomeAccountRef {get;set;} 
		public Integer PurchaseCost {get;set;} 
		public Boolean TrackQtyOnHand {get;set;} 
		public String domain {get;set;} 
		public Boolean sparse {get;set;} 
		public String Id {get;set;} 
		public String SyncToken {get;set;} 
		public MetaData MetaData {get;set;} 

		public Item(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Name') {
							Name = parser.getText();
						} else if (text == 'Description') {
							Description = parser.getText();
						} else if (text == 'Active') {
							Active = parser.getBooleanValue();
						} else if (text == 'FullyQualifiedName') {
							FullyQualifiedName = parser.getText();
						} else if (text == 'Taxable') {
							Taxable = parser.getBooleanValue();
						} else if (text == 'UnitPrice') {
							UnitPrice = parser.getIntegerValue();
						} else if (text == 'Type') {
							Type = parser.getText();
						} else if (text == 'IncomeAccountRef') {
							IncomeAccountRef = new IncomeAccountRef(parser);
						} else if (text == 'PurchaseCost') {
							PurchaseCost = parser.getIntegerValue();
						} else if (text == 'TrackQtyOnHand') {
							TrackQtyOnHand = parser.getBooleanValue();
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
						} else {
							System.debug(LoggingLevel.WARN, 'Item consuming unrecognized property: '+text);
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
	
	public class QueryResponse {
		public List<Item> Item {get;set;} 
		public Integer startPosition {get;set;} 
		public Integer maxResults {get;set;} 

		public QueryResponse(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Item') {
							Item = arrayOfItem(parser);
						} else if (text == 'startPosition') {
							startPosition = parser.getIntegerValue();
						} else if (text == 'maxResults') {
							maxResults = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'QueryResponse consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class IncomeAccountRef {
		public String value {get;set;} 
		public String name {get;set;} 

		public IncomeAccountRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'IncomeAccountRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public QueryResponse QueryResponse {get;set;} 
	public String time_Z {get;set;} // in json: time

	public QBItemQueryResponseJSON(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'QueryResponse') {
						QueryResponse = new QueryResponse(parser);
					} else if (text == 'time') {
						time_Z = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'QBItemQueryResponseJSON consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static QBItemQueryResponseJSON parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new QBItemQueryResponseJSON(parser);
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
	

    private static List<Item> arrayOfItem(System.JSONParser p) {
        List<Item> res = new List<Item>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Item(p));
        }
        return res;
    }



}