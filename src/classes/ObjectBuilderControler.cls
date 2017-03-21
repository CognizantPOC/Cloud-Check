public class ObjectBuilderControler {
<<<<<<< HEAD
	private final ObectBuilder__c ObectBuilder;
    
	public void  go() {
=======
	 private final ObectBuilder__c ObectBuilder;
    
    public void  go() {
>>>>>>> 632949f... POC for custom object

		List<ObectBuilder__c> listOfRecordToDelete = new List<ObectBuilder__c> () ; 
        listOfRecordToDelete = [Select Id from ObectBuilder__c ] ; 
        delete listOfRecordToDelete ; 
		List<ObectBuilder__c> listOfRecord = new List<ObectBuilder__c> () ; 
		
		Integer i =0 ;
		List<String> sObjectList = new List<String>();
		List<String> sObjectListStandard = new List<String>() ; 
		List<String> sObjectListStandardNotCreatable = new List<String>() ; 		
		String objectName  ; 
<<<<<<< HEAD
		
		for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
=======
		//String myquery = 'SELECT LastModifiedDate FROM '+ objectName +' order by LastModifiedDate desc limit 1 ' ; 

		sObject s ;
		for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
		{
>>>>>>> 632949f... POC for custom object
            ObectBuilder__c oneRecord = new ObectBuilder__c ()  ; 
			Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
			String name = objTyp.getDescribe().getName();
			objectName = objTyp.getDescribe().getLabel() ; 
            
			if(describeSObjectResultObj.isCustom() ) {
<<<<<<< HEAD
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
=======
				if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
				 !name.containsignorecase('share') && !name.containsignorecase('feed') ) {
        
                    System.debug('objectName ='+name);
					oneRecord.Name__c = objectName ; 
					oneRecord.Api_Name__c = name ; 
					oneRecord.IsCustom__c = describeSObjectResultObj.isCustom() ; 
					List<sObject> tmp = Database.query('SELECT CreatedDate  FROM '+ name +' order by CreatedDate  desc limit 1 ');
                    System.debug('tmp list '+tmp);
					//oneRecord.Name__c = tmp.get(0) ; 
                     if( !tmp.isEmpty() ) {
                         for(sObject obj :tmp ) {
                            oneRecord.Last_Used_Date__c =Date.valueOf(obj.get('CreatedDate')) ; 
                             listOfRecord.add(oneRecord) ;
                             
                            System.debug('listOfRecord ::' +listOfRecord);
                             
                         }
                         
                     }
                     //System.debug('one Record ='+oneRecord);
				 }
			}
           
		}
		
		INSERT listOfRecord ;
		
	} 
    Public PageReference GotoPage(){
>>>>>>> 632949f... POC for custom object
        PageReference reURL = new PageReference('/apex/TestReport');
        reURL.setRedirect(true);
        return reURL;
    }

}