public class CourseRatesTriggerHandler {
    
    
    Public static void updateCourseRateName(List<Course_Rate__c> crs){
        
        set<ID> courseRateIds = new set<ID>();
        
        for (Course_Rate__c a: crs){
            
         
            courseRateIds.add(a.Id);
            a.Name = a.Instructor__r.firstname + ' ' + a.Instructor__r.lastname + ' - ' + a.Course__r.Name;
        }
       
        map<ID,Course_Rate__c> crmap = new map<ID,Course_Rate__c>([SELECT ID,Name,Instructor__r.firstname,Instructor__r.lastname,Course__r.Name FROM Course_Rate__c WHERE ID in:courseRateIds]);
        //Loops through course rates and renames with course name + instructor name
        
        
        
        for(Course_Rate__c cr: crs){
            
            cr.Name = crmap.get(cr.ID).Course__r.Name + ' - ' +crmap.get(cr.ID).Instructor__r.firstname + ' ' + crmap.get(cr.ID).Instructor__r.lastname ;
            
        }
        
    }

}