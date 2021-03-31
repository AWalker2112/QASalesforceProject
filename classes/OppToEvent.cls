public with sharing class OppToEvent {
   
   //This class is a trigger to create / update / delete calendar events for opportunities.
   
    public static void OppToEventCreate(List<Opportunity> courseOpps) {

        List<Event>  newOppEvent = new List<Event>();

        for (Opportunity oppCourse: courseOpps){
            Event calCourseOpp = new Event();
            calCourseOpp.StartDateTime = oppCourse.Start_Date__c;
            calCourseOpp.EndDateTime = oppCourse.CloseDate;
            calCourseOpp.Subject = oppCourse.Name;
            calCourseOpp.OwnerId = oppCourse.Instructor__c;
            calCourseOpp.WhatId = oppCourse.Id;
            calCourseOpp.Location = oppCourse.Course_Location__c;
            newOppEvent.add(calCourseOpp);
        }

        insert newOppEvent;


    }

    

    public static void OppToEventUpdateOrDelete(List<Opportunity> courseOpps, Map<id, Opportunity> oldRecord){

        List<Event>  newOppEvent = new List<Event>();
        List<Event> calCourseOpp = [SELECT StartDateTime,EndDateTime,Subject,OwnerId,WhatId,Location FROM Event ];
        Integer i = 0;
        if(calCourseOpp.size()>0){
        for (Opportunity opp: courseOpps){
            

            Opportunity oldOpp = oldRecord.get(opp.Id);
            Boolean oldOppIsWon = oldOpp.StageName.Equals('Scheduled');
            
            Boolean newOppIsCancelled = opp.StageName.Equals('Cancelled');

            if(oldOppIsWon&&newOppIsCancelled){
                delete [SELECT id FROM Event WHERE WhatId =:opp.id];
                i++;
                InstructorEmailFromOpportunities.InstructorEmailFromOpportunities(Trigger.New, 'delete'); //Email course opp to instructor when booked in
            }else{
                
                calCourseOpp[i].WhatId = opp.Id;
                calCourseOpp[i].StartDateTime = opp.Start_Date__c;
                calCourseOpp[i].EndDateTime = opp.CloseDate;
                calCourseOpp[i].Subject = opp.Name;
                calCourseOpp[i].OwnerId = opp.Instructor__c;
                calCourseOpp[i].Location = opp.Course_Location__c;
         
                newOppEvent.add(calCourseOpp[i]);
                i++;
                 //Email course opp to instructor when booked in
            }
        }
    }

        if(newOppEvent.size()>0){
            update newOppEvent;
        }
       
    }


}
