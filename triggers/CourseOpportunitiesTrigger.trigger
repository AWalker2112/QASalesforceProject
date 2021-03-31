trigger CourseOpportunitiesTrigger on Opportunity (before insert, before update,before delete, after insert,after update, after delete) {

   
   
    

    if (trigger.isBefore){ //Before Triggers
        if(trigger.isInsert){
            
        }
        else if(trigger.isUpdate){
            
        }
        else if(trigger.isDelete){
            

            
        }
        else if(trigger.isUndelete){                      
        }
    } else { //After Triggers
        if(trigger.isInsert){ 

            CourseOpportunitiesTriggerHandler.courseOppAutomaticSharing(Trigger.New);  //automatically shares the course opp with the instructor when created
            OppToEvent.OppToEventCreate(Trigger.New); //adds the opp to the calandar when updated
            
            InstructorEmailFromOpportunities.InstructorEmailFromOpportunities(Trigger.New, 'create'); //Email course opp to instructor when booked in
        }
        else if(trigger.isUpdate){


            CourseOpportunitiesTriggerHandler.courseOppAutomaticSharing(Trigger.New); //automatically shares the course opp with the instructor when updated
            OppToEvent.OppToEventUpdateOrDelete(Trigger.New, Trigger.oldMap);
            InstructorEmailFromOpportunities.InstructorEmailFromOpportunities(Trigger.New, 'update');

            ServiceInvoiceStatusCompleted.ServiceInvoiceStatusCompleted(Trigger.New, Trigger.oldMap);
        }
        else if(trigger.isDelete){

            
        }
        else if(trigger.isUndelete){                                
        }                        
    }

}