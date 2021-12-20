# Clark

Task-001 (Object Creation)
      Create 2 new objects:
      a. "Config__c" - 
      fields: Label - (Text, Unique)
      Type - (Text)
      Amount - (Number)
      b. "Case_Config__c" - 
      fields: Label - (Text, Unique)
      Type - (Text)
      Amount - (Number)
      Case (Lookup to Case object)
      
Task-002
  Create a LWC component to show Available Configs
  a. Displays all Config records in a 3-column list: Label, Type and Amount.
  b. User can select multiple records and after pressing the “Add” button they will be
  added to the Case Configs list (also new Case Config records are saved to the
  database).
  c. If a Config record has already been added to the Case Configs list it cannot be
  added a second time.
  
Task-003
  Create a LWC component to show Case Configs
  a. Displays added Config records in a 3-column list: Label, Type and Amount.
  b. When a user adds new Config records, new records appear in this list without
  having to refresh the page.
  
Task-004(Enable Save button on Case Config Component and do API call)
    “Case Configs” component has an “Send” button:
    a. Sets the status of the Case to “Closed”.
    b. When the send button is pressed, a request is sent to the external service.
    c. The request format should follow the following JSON structure:
    {
    "caseId": "50068000005QOhbAAG",
    "status": "Closed",
    "caseConfigs": [{
    "label": "Test Label",
    "type": "Test Type",
    "amount": 10.00 }]
    }
    d. When the “Send” button is pressed you cannot add new Config records and send
    the request a second time.
    e. Request is sent as POST.
    f. Errors of the external system need to be handled:
    i. All 200 responses are considered as OK
    ii. Any non-200 response is handled as ERROR
    g. For this use case generate a new endpoint URL at https://requestcatcher.com/
    h. Implement it using Apex
    5. A test coverage of at least 85% for APEX is required.
    6. Please use Apex for DML and SOQL queries.
