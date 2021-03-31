@isTest
public with sharing class CourseRateTriggerHandler_Test {


    @testSetup
    private static void testSetupObjectDataFactory() {

    Course__c newCourse = new Course__c (Name='Test Course');
    insert newCourse;
    
    
    Course_Rate__c cr = new Course_Rate__c (Name='Test', 
                    Instructor__c='0054L000000FztcQAC',
                    Course__c=newCourse.id, Hourly_Rate__c=5.0);   

    insert cr;

    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    User u = [SELECT Id FROM User WHERE profileId = :p.Id LIMIT 1];
    System.runAs(u){
        }
    }

    @isTest
    public static void updateCourseRateName_Test() {

        Test.startTest();
            Course_Rate__c cr = [Select Name,Instructor__c,Course__c,Hourly_Rate__c From Course_Rate__c];
            cr.Name = '2';
            update cr;
        Test.stopTest();
        system.debug([Select Name,Instructor__c,Course__c,Hourly_Rate__c From Course_Rate__c]);

        Course_Rate__c output = [SELECT Name FROM Course_Rate__c Limit 1 ];
        String outputString = output.Name;
        System.assertEquals('Test Course - Mary Stevens', outputString);

    }
}
