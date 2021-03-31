public with sharing class InoviceCloneInvoke {

    Public class FlowInput{
        @InvocableVariable public ID Id;
    }

    @InvocableMethod(label='Expense Invoice Clone' description='')
    public static void InoviceCloneInvoke(list<FlowInput> request) {


        ID Id = request[0].Id;

        List<Course_Invoice__c> ciList = new List<Course_Invoice__c>();

                
        InvoiceClone.InvoiceClone();

        Course_Invoice__c c = [SELECT ID,NAME, Status__c,Submitted_Date__c,Course_Opportunity__c FROM Course_Invoice__c where name = 'EXPINV-{0008}'];

        List<Course_Invoice__c> ci = new List<Course_Invoice__c>();
        ci.add(c);

        InvoiceClone.InvoiceClone(ci);

    }
}
