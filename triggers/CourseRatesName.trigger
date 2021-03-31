trigger CourseRatesName on Course_Rate__c (before update) {
         
        
    

    CourseRatesTriggerHandler.updateCourseRateName(Trigger.New);
   
    
}