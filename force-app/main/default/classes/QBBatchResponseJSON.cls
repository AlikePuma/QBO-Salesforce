public class QBBatchResponseJSON {

	public class ParentRef {
		public String value {get;set;} 
		public String name {get;set;} 

		public ParentRef(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ParentRef consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Item {
		public String Name {get;set;} 
		public Boolean Active {get;set;} 
		public Boolean SubItem {get;set;} 
		public ParentRef ParentRef {get;set;} 
		public Integer Level {get;set;} 
		public String FullyQualifiedName {get;set;} 
		public Boolean Taxable {get;set;} 
		public Integer UnitPrice {get;set;} 
		public String Type {get;set;} 
		public ParentRef IncomeAccountRef {get;set;} 
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
						} else if (text == 'Active') {
							Active = parser.getBooleanValue();
						} else if (text == 'SubItem') {
							SubItem = parser.getBooleanValue();
						} else if (text == 'ParentRef') {
							ParentRef = new ParentRef(parser);
						} else if (text == 'Level') {
							Level = parser.getIntegerValue();
						} else if (text == 'FullyQualifiedName') {
							FullyQualifiedName = parser.getText();
						} else if (text == 'Taxable') {
							Taxable = parser.getBooleanValue();
						} else if (text == 'UnitPrice') {
							UnitPrice = parser.getIntegerValue();
						} else if (text == 'Type') {
							Type = parser.getText();
						} else if (text == 'IncomeAccountRef') {
							IncomeAccountRef = new ParentRef(parser);
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
	
	public List<BatchItemResponse> BatchItemResponse {get;set;} 
	public String time_Z {get;set;} // in json: time

	public QBBatchResponseJSON(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'BatchItemResponse') {
						BatchItemResponse = arrayOfBatchItemResponse(parser);
					} else if (text == 'time') {
						time_Z = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'QBBatchResponseJSON consuming unrecognized property: '+text);
						consumeObject(parser);
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
	
	public class Error {
		public String Message {get;set;} 
		public String Detail {get;set;} 
		public String code {get;set;} 
		public String element {get;set;} 

		public Error(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Message') {
							Message = parser.getText();
						} else if (text == 'Detail') {
							Detail = parser.getText();
						} else if (text == 'code') {
							code = parser.getText();
						} else if (text == 'element') {
							element = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Error consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Fault {
		public List<Error> Error {get;set;} 
		public String type {get;set;} 

		public Fault(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Error') {
							Error = arrayOfError(parser);
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Fault consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class BatchItemResponse {
		public Fault Fault {get;set;} 
		public String bId {get;set;} 
		public Item Item {get;set;} 

		public BatchItemResponse(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'Fault') {
							Fault = new Fault(parser);
						} else if (text == 'bId') {
							bId = parser.getText();
						} else if (text == 'Item') {
							Item = new Item(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'BatchItemResponse consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static QBBatchResponseJSON parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new QBBatchResponseJSON(parser);
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
	

    private static List<Error> arrayOfError(System.JSONParser p) {
        List<Error> res = new List<Error>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Error(p));
        }
        return res;
    }




    private static List<BatchItemResponse> arrayOfBatchItemResponse(System.JSONParser p) {
        List<BatchItemResponse> res = new List<BatchItemResponse>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new BatchItemResponse(p));
        }
        return res;
    }




}