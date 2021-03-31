public with sharing class ServiceInvoiceStatusCompleted {

    //When Opportunity stage is changed to 'Completed' then service invoice is automatically created.
public static Boolean isFirstTime = true;

    public static void ServiceInvoiceStatusCompleted( List<Opportunity> oppNew, Map<id, Opportunity> oppOld) {

        List<Course_Invoice__c> newInvoice = new List<Course_Invoice__c>();
        String serviceRecordType = Schema.SObjectType.Course_Invoice__c.getRecordTypeInfosByName().get('Service Invoice').getRecordTypeId();

            for(Opportunity o: oppNew){

                

                    if(o.StageName == 'Completed' && oppOld.get(o.Id).StageName!='Completed'){

                    Course_Invoice__c serviceInvoice = new Course_Invoice__c();
                    
                    serviceInvoice.Course_Opportunity__c = o.Id;
                    serviceInvoice.RecordTypeId = serviceRecordType;
                    serviceInvoice.Name = '1';
                    serviceInvoice.Status__c = 'Draft';
                    newInvoice.add(serviceInvoice);
                    System.debug(newInvoice.size());
                    } 
                
            }
 
            if(newInvoice.size()>0){
                insert newInvoice;

            }
            
    }
}
