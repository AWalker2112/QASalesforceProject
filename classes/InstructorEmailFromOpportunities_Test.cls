@isTest
public with sharing class InstructorEmailFromOpportunities_Test {
    
    @testSetup
        private static void testSetupObjectDataFactory() {
    
            List<Opportunity> oppList = new List<Opportunity>();
            //for(Integer i =0; i < 201; i++){
                Opportunity testCourse = new Opportunity (StageName='Scheduled',Name='Test Company Ltd', Start_Date__c =Date.newInstance(Date.today().year(), 9, 1),
                                                        CloseDate= Date.newInstance(Date.today().year(), 9, 3),
                                                        Mail_To_Account__c='0014L000006zgOvQAI',Billing_Account__c='0014L000006zgOvQAI',
                                                        OwnerId='0054L000000FqUAQA0', Course_Name__c='a024L000003151JQAQ',Instructor__c='0054L000000FztcQAC') ;
                oppList.add(testCourse);
                
            //}
            insert oppList;
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
            User u = [SELECT Id FROM User WHERE profileId = :p.Id LIMIT 1];
            System.runAs(u){
        }
    }
    
    
    @isTest
    public static void InstructorEmailFromOpportunitiesCreate_Test() {

        List<Opportunity> oppList = [SELECT Id, StageName,Name,Start_Date__c,CloseDate,Mail_To_Account__c,Billing_Account__c,OwnerId,Course_Name__c,Instructor__c FROM Opportunity ];

        Test.startTest();
                       
        InstructorEmailFromOpportunities.InstructorEmailFromOpportunities(oppList, 'create');
                
        Integer actualLimits = Limits.getEmailInvocations();
        Test.stopTest(); 

        
        System.assertEquals(1, actualLimits, 'wrong limits before');
    }

    @isTest
    public static void InstructorEmailFromOpportunitiesUpdate_Test() {

        List<Opportunity> oppList = [SELECT Id, StageName,Name,Start_Date__c,CloseDate,Mail_To_Account__c,Billing_Account__c,OwnerId,Course_Name__c,Instructor__c FROM Opportunity ];

        Test.startTest();
                       
        InstructorEmailFromOpportunities.InstructorEmailFromOpportunities(oppList, 'update');
                
        Integer actualLimits = Limits.getEmailInvocations();
        Test.stopTest(); 

        
        System.assertEquals(1, actualLimits, 'wrong limits before');
    }

    @isTest
    public static void InstructorEmailFromOpportunitiesDelete_Test() {

        List<Opportunity> oppList = [SELECT Id, StageName,Name,Start_Date__c,CloseDate,Mail_To_Account__c,Billing_Account__c,OwnerId,Course_Name__c,Instructor__c FROM Opportunity ];

        Test.startTest();
                       
        InstructorEmailFromOpportunities.InstructorEmailFromOpportunities(oppList, 'delete');
                
        Integer actualLimits = Limits.getEmailInvocations();
        Test.stopTest(); 

        
        System.assertEquals(1, actualLimits, 'wrong limits before');
    }
}
