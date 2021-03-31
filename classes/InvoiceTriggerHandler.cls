public class InvoiceTriggerHandler {
    
    Public static void UpdateAutoNumbers(List<Course_Invoice__c>courseInvoice){

    AutoNumber__c serviceNumber = [SELECT Service_Invoice_Number__c FROM AutoNumber__c WHERE Name = 'Service Invoice Number' Limit 1]; 
    AutoNumber__c expenseNumber = [SELECT Expense_Invoice_Number__c FROM AutoNumber__c WHERE Name = 'Expense Invoice Number' Limit 1];

    
        
    List<AutoNumber__c> updateList = new List<AutoNumber__c>()  ;
    
    String serviceRecordType = Schema.SObjectType.Course_Invoice__c.getRecordTypeInfosByName().get('Service Invoice').getRecordTypeId();
    String expenseRecordType = Schema.SObjectType.Course_Invoice__c.getRecordTypeInfosByName().get('Expense Invoice').getRecordTypeId();
    
    for(Course_Invoice__c  i:courseInvoice){
        if (i.RecordTypeId == serviceRecordType){
            
            Decimal decSize = serviceNumber.Service_Invoice_Number__c.intValue(); 
            String stringSize = decSize.toPlainString();
            
            Integer size = stringSize.length();
            Integer addZeros = 4-size;
            String zeros = '';
            
            for(Integer k = 0; k < addZeros; k++){
                zeros += 0;
            }
            
            i.Name = 'INV-{' + zeros + serviceNumber.Service_Invoice_Number__c + '}';  //0124L0000000AopQAE
            
            serviceNumber.Service_Invoice_Number__c++;

            // AutoNumber__c serviceNumberUpdate = serviceNumber[0];
            // serviceNumberUpdate.Service_Invoice_Number__c ++;
            //updateList.add(serviceNumberUpdate);
                      
        }
        
        else if(i.RecordTypeId == expenseRecordType){
            
            Decimal decSizeE = expenseNumber.Expense_Invoice_Number__c.intValue(); 
            String stringSizeE = decSizeE.toPlainString();
            
            Integer sizeE = stringSizeE.length();
            Integer addZerosE = 4-sizeE;
            String zerosE = '';
            
            for(Integer k = 0; k < addZerosE; k++){
                zerosE += 0;
            }
            
            i.Name = 'EXPINV-{' + zerosE + expenseNumber.Expense_Invoice_Number__c + '}';  //0124L0000000Atf 
            expenseNumber.Expense_Invoice_Number__c++;

            // AutoNumber__c expenseNumberUpdate = expenseNumber;
            // expenseNumberUpdate.Expense_Invoice_Number__c ++;
            // updateList.add(expenseNumberUpdate);
            
        }
    }
        update serviceNumber;
        update expenseNumber;
    }
}