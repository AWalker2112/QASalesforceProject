@isTest
public with sharing class CourseOpportunitiesTriggerHandler_Test {

        @testSetup
        private static void testSetupObjectDataFactory() {
    
            List<Opportunity> oppList = new List<Opportunity>();
            for(Integer i =0; i < 201; i++){
                Opportunity testCourse = new Opportunity (StageName='Scheduled',Name='Test Company Ltd', Start_Date__c =Date.newInstance(Date.today().year(), 9, 1),
                                                        CloseDate= Date.newInstance(Date.today().year(), 9, 3),
                                                        Mail_To_Account__c='0014L000006zgOvQAI',Billing_Account__c='0014L000006zgOvQAI',
                                                        OwnerId='0054L000000FqUAQA0', Course_Name__c='a024L000003151JQAQ',Instructor__c='0054L000000FztcQAC') ;
                oppList.add(testCourse);
                
            }
    
            insert oppList;
    
            List<AutoNumber__c> autoNumberList = new List<AutoNumber__c>();
            AutoNumber__c autoNumService = new AutoNumber__c (Name = 'Service Invoice Number', Service_Invoice_Number__c = 1);
            autoNumberList.add( autoNumService);
            AutoNumber__c autoNumExpense = new AutoNumber__c (Name = 'Expense Invoice Number', Service_Invoice_Number__c = 1);
            autoNumberList.add( autoNumExpense);
            insert autoNumberList;
    
            
            
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
            User u = [SELECT Id FROM User WHERE profileId = :p.Id LIMIT 1];
            System.runAs(u){
            }
    
    
        }
        
        @isTest
        public static void OppToEventUpdateOrDelete_Test() {
    
            
    
            Test.startTest();
                List<Opportunity> oppList = [SELECT Id, StageName,Name,Start_Date__c,CloseDate,Mail_To_Account__c,Billing_Account__c,OwnerId,Course_Name__c,Instructor__c FROM Opportunity ];
                System.debug('oppList bring in ' + oppList);
                for(Integer i = 0; i < oppList.size(); i++){
    
                    oppList[0].Start_Date__c = Date.newInstance(Date.today().year(), 9, 2);
                    
                }
                System.debug('The number'+oppList.size());
                update oppList;   
            Test.stopTest();
            System.assertEquals(201, [SELECT count() FROM Event ]);
    
        }
    
        @isTest
        public static void OppToEventUpdateOrDeleteDelete_Test() {
    
            Test.startTest();
    
                List<Opportunity> oppListDelete = [SELECT Id, StageName,Name,Start_Date__c,CloseDate,Mail_To_Account__c,Billing_Account__c,OwnerId,Course_Name__c,Instructor__c FROM Opportunity ];
                delete oppListDelete;
    
            Test.stopTest();
    
            System.assertEquals(0, [SELECT count() FROM Event ]);
    
        }
        @isTest
        private static void courseOppAutomaticSharingTest(){
            
            List<Opportunity> activeOpp = [SELECT Id, StageName,Name,Start_Date__c,CloseDate,Mail_To_Account__c,Billing_Account__c,OwnerId,Course_Name__c,Instructor__c FROM Opportunity LIMIT 1];
            Opportunity opportunity = activeOpp[0];
            
            Test.startTest();
                        
            Test.stopTest();
    
            System.assertEquals(402, [SELECT count() FROM OpportunityShare ]); //Double as shared with the Admin and Mary Stevens
            
        }
    

        @isTest
        public static void AutoNumberSerive_Test() {

        

        Test.startTest();
                List<Opportunity> oppList = [SELECT Id, StageName,Name,Start_Date__c,CloseDate,Mail_To_Account__c,Billing_Account__c,OwnerId,Course_Name__c,Instructor__c FROM Opportunity ];
               
            for(Integer i = 0; i < oppList.size(); i++){

                oppList[i].Start_Date__c = Date.newInstance(Date.today().year(), 9, 2);
                oppList[i].StageName = 'Completed';
            }

            update oppList;   
        Test.stopTest();
        
        System.assertEquals(201, [SELECT count() FROM Course_Invoice__c ]);

        Course_Invoice__c firstInput = [SELECT Name FROM Course_Invoice__c Order By Name  ASC Limit 1];
        String firstEntry = firstInput.Name;
   
        Course_Invoice__c lastInput = [SELECT Name FROM Course_Invoice__c Order By Name DESC Limit 1];
        String lastEntry = lastInput.Name;

        
        System.assertEquals('INV-{0001}', firstEntry);
        System.assertEquals('INV-{0201}', lastEntry);

    }
    @isTest
    public static void AutoNumberExpense_Test() {
        String expenseRecordType = Schema.SObjectType.Course_Invoice__c.getRecordTypeInfosByName().get('Expense Invoice').getRecordTypeId();
        List<Course_Invoice__c> expenseList = new List<Course_Invoice__c>();

        for(Integer i =0; i < 201; i++){
            Course_Invoice__c expenseInvoices = new Course_Invoice__c (Name='1', RecordTypeId=expenseRecordType,Status__c='Draft', Course_Opportunity__c='0064L000006v5taQAA') ;
            expenseList.add(expenseInvoices);
            
        }
        insert expenseList;

        Test.startTest();
        Test.stopTest();

        Course_Invoice__c firstInput = [SELECT Name FROM Course_Invoice__c Order By Name  ASC Limit 1];
        String firstEntry = firstInput.Name;
   
        Course_Invoice__c lastInput = [SELECT Name FROM Course_Invoice__c Order By Name DESC Limit 1];
        String lastEntry = lastInput.Name;

        System.assertEquals(201, [SELECT count() FROM Course_Invoice__c ]);
        System.assertEquals('EXPINV-{0001}', firstEntry);
        System.assertEquals('EXPINV-{0201}', lastEntry);
    }

    @isTest
    public static void pdfEmailControlInvoke_Test() {

        String expenseRecordType = Schema.SObjectType.Course_Invoice__c.getRecordTypeInfosByName().get('Expense Invoice').getRecordTypeId();
        List<Course_Invoice__c> expenseList = new List<Course_Invoice__c>();

        for(Integer i =0; i < 201; i++){
            Course_Invoice__c expenseInvoices = new Course_Invoice__c (Name='1', RecordTypeId=expenseRecordType,Status__c='Draft', Course_Opportunity__c='0064L000006v5taQAA', Submitted_Date__c = Date.newInstance(Date.today().year(), 1, 1) );
            expenseList.add(expenseInvoices);
            
        }
        insert expenseList;

        
        Test.startTest();
        //for(Integer j =0; j < 201; j++){
            
        expenseList[0].Status__c = 'Submitted';
            
        //}
        update expenseList;
        Test.stopTest();

        Integer actualLimits = Limits.getEmailInvocations();
        System.assertEquals(4, actualLimits, 'wrong limits before');

    }

}