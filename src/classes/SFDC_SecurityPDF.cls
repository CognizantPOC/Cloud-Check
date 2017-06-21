public with sharing class SFDC_SecurityPDF {
public String salesOrg {get;set;}
    public String users {get;set;}
    public Datetime dateLastMonth {get;set;}
    public Boolean validationPDF = false;
    public Boolean Region = false;
    public Map<Id,String> mapRole {get;set;}
    public Map<Id,String> mapProfile {get;set;}
    public Map<Id,String> mapSubRole {get;set;}
    public Map<Id,String> mapUser {get;set;}
    
    public Datetime startDate {get;set;}
    public Datetime endDate {get;set;}
    //commentaire 
    public SFDC_SecurityPDF() {
        //List<PG_SubRole__c> subRoles;
        List<User> listUsers;
        
        if (ApexPages.currentPage().getParameters().get('select') !=  null) {
            startDate = Datetime.newInstance(date.today().year(),integer.valueof(ApexPages.currentPage().getParameters().get('select')) , 1);
            endDate = startDate.addMonths(1);
        } else {
            startDate = Datetime.newInstance(date.today().year(),date.today().month(), 1);
            endDate = startDate.addMonths(1);
        }
        
        users = '%for '  + ' %';
        
        mapRole = new Map<Id,String>();
        List<UserRole> roles = [select id,name from UserRole];
        for(UserRole r : roles){
            mapRole.put(r.id, r.name); 
        }
            
        mapProfile = new Map<Id,String>();
        List<Profile> profiles = [select id,name from Profile];
        for(Profile p : profiles){
            mapProfile.put(p.id, p.name); 
        }
        
        if (ApexPages.currentPage().getParameters().get('Region') ==  'true') {
            //subRoles = [select id,name from PG_SubRole__c];
            //listUsers = [select id,name from User where PG_UserType__c = :PG_Enums.USER_TYPE.Internal.name() and isActive = true];
            Region = true;
        } 
        
        mapSubRole = new Map<Id,String>();
        /*for(PG_SubRole__c sr : subRoles){
            mapSubRole.put(sr.id, sr.name); 
        }*/
        
        mapUser = new Map<Id,String>();
        for(User u : listUsers){
            mapUser.put(u.id, u.name); 
        }
    }
    
    public class actifUser {
        public String wwid {get;set;}
        public String userName {get;set;}
        public String name {get;set;}
        public Boolean isActive {get;set;}
        public String lastLoginDate {get;set;}
        public String passwordChangeDate {get;set;}
        public String subRoleId {get;set;}
        public String subRoleName {get;set;}
        public Id roleId {get;set;}
        public String roleName {get;set;}
        public Id profileId {get;set;}
        public String profileName {get;set;}
        public String SalesOrg {get;set;}
    }
    
    public list<User> getActiveUsers() {
        
            return [select Username, name, isActive, LastLoginDate, userRoleId, profileId from User where isActive = true];
        
    }
    
    public list<actifUser> getListActifUsers() {
        List<actifUser> listActiveUsers = new List<actifUser>();
        
        List<User> users = getActiveUsers();
        
        for (User u : users) {
            actifUser au = new actifUser();
            
            
            au.userName = u.Username;
            au.name = u.Name;
            au.isActive = u.IsActive;
            
            if (u.LastLoginDate != null) {
                Datetime lld = u.LastLoginDate;
                au.lastLoginDate = lld.day() + '/' + lld.month() + '/' + lld.year();
            } else {
                au.lastLoginDate = '';
            }
            
            if (Date.Today() != null) {
                Datetime lpcd = Date.Today();
                au.passwordChangeDate = lpcd.day() + '/' + lpcd.month() + '/' + lpcd.year();
            } else {
                au.passwordChangeDate = '';
            }
            
           /* au.subRoleId = u.PG_SubRole__c;
            au.subRoleName = u.PG_SubRole_Name__c;
            au.roleId = u.userRoleId;
            au.roleName = mapRole.get(u.userRoleId);
            au.profileId = u.profileId;
            au.profileName = mapProfile.get(u.profileId);
            au.SalesOrg = u.PG_SalesOrg__c;
            
            listActiveUsers.add(au);*/
        }
        return listActiveUsers;
    }
    
    public class subRoleHistory {
        public Id subRoleHistoryId {get;set;}
        public Id subRoleId {get;set;}
        public String subRoleName {get;set;}
        public String fieldChanged {get;set;}
        public String oldValue {get;set;}
        public String newValue {get;set;}
        public Id UserId {get;set;}
        public String Username {get;set;}
        public String updateTime {get;set;}
    }

    
    public list<subRoleHistory> getListSubRoleHistory() {
        List<subRoleHistory> listSubRoleHistories = new List<subRoleHistory>();
        
        
        /*for (PG_SubRole__History s : subRoles) {
            subRoleHistory srh = new subRoleHistory();
            
            srh.subRoleHistoryId = s.id;
            srh.subRoleId = s.ParentId;
            srh.subRoleName = mapSubRole.get(s.ParentId);
            srh.fieldChanged = s.Field;
            srh.oldValue = String.valueOf(s.OldValue);
            srh.newValue = String.valueOf(s.NewValue);
            srh.UserId = s.CreatedById;
            srh.Username = mapUser.get(s.CreatedById);
            Datetime cd = s.CreatedDate;
            srh.updateTime = cd.day() + '/' + cd.month() + '/' + cd.year() + ' ' + cd.hour() + ':' + cd.minute() + ':' + cd.second();
            
            listSubRoleHistories.add(srh);
        }*/
        return listSubRoleHistories;
    }
    
    public class setupAuditTrail{
        public Id setupAuditTrailId {get;set;}
        public String section {get;set;}
        public String auditType {get;set;}
        public String oldValue {get;set;}
        public String newValue {get;set;}
        public Id UserId {get;set;}
        public String Username {get;set;}
        public String updateTime {get;set;}
    }
    
    /*
    public list<SFDC_Setup_Audit_Trail__c> getAuditTrailRole() {
        return [select Id, section__c, Action_short__c, user__c, user__r.name, Username__c, Date__c from SFDC_Setup_Audit_Trail__c where section__c = :PG_Constants.AuditManageUsers and Action_short__c like :PG_Constants.AuditRole and (not Action_short__c like :users) and Date__c >= :startDate and Date__c < :endDate order by Date__c desc];
    }
    
    public list<SFDC_Setup_Audit_Trail__c> getAuditTrailPermission() {
        return [select Id, section__c, Action_short__c, user__c, user__r.name, Username__c, Date__c from SFDC_Setup_Audit_Trail__c where section__c = :PG_Constants.AuditManageUsers and Action_short__c like :PG_Constants.AuditPermset and (not Action_short__c like :users) and Date__c >= :startDate and Date__c < :endDate order by Date__c desc];
    }
    
    public list<SFDC_Setup_Audit_Trail__c> getAuditTrailUser() {
        return [select Id, section__c, Action_short__c, user__c, user__r.name, Username__c, Date__c from SFDC_Setup_Audit_Trail__c where section__c = :PG_Constants.AuditManageUsers and Action_short__c like :users and Date__c >= :startDate and Date__c < :endDate order by Date__c desc];
    }
    
    public list<setupAuditTrail> getListAuditTrailProfile() {
        list<SFDC_Setup_Audit_Trail__c> auditProfile = getAuditTrailProfile();
        return getListAuditTrail(auditProfile,PG_Enums.AUDIT_TYPE.Profile.name());
    }
    
    public list<setupAuditTrail> getListAuditTrailRole() {
        list<SFDC_Setup_Audit_Trail__c> auditRole = getAuditTrailRole();
        return getListAuditTrail(auditRole,PG_Enums.AUDIT_TYPE.Role.name());
    }
    
    public list<setupAuditTrail> getListAuditTrailPermission() {
        list<SFDC_Setup_Audit_Trail__c> auditPermset = getAuditTrailPermission();
        return getListAuditTrail(auditPermset,PG_Enums.AUDIT_TYPE.PermissionSet.name());
    }
    
    public list<setupAuditTrail> getListAuditTrailUser() {
        list<SFDC_Setup_Audit_Trail__c> auditUser = getAuditTrailUser();
        return getListAuditTrail(auditUser,PG_Enums.AUDIT_TYPE.User.name());
    }*/
    
    public list<setupAuditTrail> getListAuditTrail(list<SFDC_Setup_Audit_Trail__c> setupAuditTrails, String auditType) {
        List<setupAuditTrail> listSetupAuditTrails = new List<setupAuditTrail>();
        
        for (SFDC_Setup_Audit_Trail__c u : setupAuditTrails) {
            setupAuditTrail sat = new setupAuditTrail();
            
            sat.setupAuditTrailId = u.id;
            sat.section = u.section__c;
            sat.auditType = auditType;
            
            String actionFrom = u.Action_short__c;
            String actionTo = u.Action_short__c;
            sat.oldValue = actionFrom;
            sat.newValue = actionTo;
            
            sat.userId = u.user__c;
            sat.Username = u.user__r.name;
            
            Datetime cd = u.Date__c;
            sat.updateTime = cd.day() + '/' + cd.month() + '/' + cd.year() + ' ' + cd.hour() + ':' + cd.minute() + ':' + cd.second();
            
            listSetupAuditTrails.add(sat);
        }
        
        if (auditType == 'true') {
            List<SFDC_SecurityUserHistory__c> suh = [select name,UserUpdated__r.name,Field_Changed__c,Old_Value__c,New_Value__c,User__c,User__r.name,DateOfUpdate__c from SFDC_SecurityUserHistory__c]; 

            for (SFDC_SecurityUserHistory__c s : suh) {
                setupAuditTrail sat = new setupAuditTrail();
                 
                sat.setupAuditTrailId = s.id;
                sat.section = s.UserUpdated__r.name + ' : ' + s.Field_Changed__c;
                sat.auditType = s.name;
                
                sat.oldValue = s.Old_Value__c;
                sat.newValue = s.New_Value__c;
                
                sat.userId = s.User__c;
                sat.Username = s.User__r.name;
                
                Datetime cd = s.DateOfUpdate__c;
                sat.updateTime = cd.day() + '/' + cd.month() + '/' + cd.year() + ' ' + cd.hour() + ':' + cd.minute() + ':' + cd.second();
                
                listSetupAuditTrails.add(sat);  
            }
        }
        
        return listSetupAuditTrails;
    }
}