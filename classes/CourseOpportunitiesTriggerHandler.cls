public with sharing class CourseOpportunitiesTriggerHandler {
    
    
    
    
    public static void courseOppAutomaticSharing(List<Opportunity> coursesToShare) {
        
        List<OpportunityShare> oppList= new List<OpportunityShare>();
        OpportunityShare opshare;

        Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        system.debug('ProfileName' + profileName);
        
        if(profileName != 'Instructor'){
        
        
            for (Opportunity opp: coursesToShare){

                opshare = new OpportunityShare();
                opShare.OpportunityId = opp.Id;
                opShare.UserOrGroupId = opp.Instructor__c;
                opShare.OpportunityAccessLevel  = 'edit';
                
                oppList.add(opShare);


        }
    }

    insert oppList;

    
    }

    
}
