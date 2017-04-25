public class ObjectBuilderControler {
	private final ObectBuilder__c ObectBuilder;
    
	public void  go() {

		List<ObectBuilder__c> listOfRecordToDelete = new List<ObectBuilder__c> () ; 
        listOfRecordToDelete = [Select Id from ObectBuilder__c ] ; 
        delete listOfRecordToDelete ; 
		List<ObectBuilder__c> listOfRecord = new List<ObectBuilder__c> () ; 
		
		Integer i =0 ;
		List<String> sObjectList = new List<String>();
		List<String> sObjectListStandard = new List<String>() ; 
		List<String> sObjectListStandardNotCreatable = new List<String>() ; 		
		String objectName  ; 
		
		for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            ObectBuilder__c oneRecord = new ObectBuilder__c ()  ; 
			Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
			String name = objTyp.getDescribe().getName();
			objectName = objTyp.getDescribe().getLabel() ; 
            
			if(describeSObjectResultObj.isCustom() ) {
					if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
					 !name.containsignorecase('share') && !name.containsignorecase('feed') ) {
			
			            System.debug('objectName ='+name);
						oneRecord.Name__c = objectName ; 
						oneRecord.Api_Name__c = name ; 
						oneRecord.IsCustom__c = describeSObjectResultObj.isCustom() ; 
						List<sObject> tmp = Database.query('SELECT CreatedDate  FROM '+ name +' order by CreatedDate  desc limit 1 ');
			             if( !tmp.isEmpty() ) {
			                 for(sObject obj :tmp ) {
			                    oneRecord.Last_Used_Date__c =Date.valueOf(obj.get('CreatedDate')) ; 
			                     listOfRecord.add(oneRecord) ;
			                     
			                    System.debug('listOfRecord ::' +listOfRecord);  
			                 }
			             }
					 }
			}
           
		}
		INSERT listOfRecord ;
		
	}
	 
    public PageReference GotoPage(){
        PageReference reURL = new PageReference('/apex/TestReport');
        reURL.setRedirect(true);
        return reURL;
    }

}