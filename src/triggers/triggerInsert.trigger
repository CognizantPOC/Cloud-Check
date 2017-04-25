trigger triggerInsert on ObectBuilder__c (after insert) {
	if (trigger.isInsert) {
		for (ObectBuilder__c objet : trigger.new) {
			if (objet.Api_Name__c != null && objet.Api_Name__c.length() > 0){
				sObject ob = Database.query('SELECT CreatedDate FROM ' +objet.Api_Name__c +' order by CreatedDate  desc limit 1');
               
                    
                    	objet.Last_Used_Date__c = Date.valueOf(ob.get('CreatedDate')) ;     
                    
                
                
			}
		}
	}
}