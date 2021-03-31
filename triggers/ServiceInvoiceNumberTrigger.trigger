trigger ServiceInvoiceNumberTrigger on Course_Invoice__c (before insert) {
    InvoiceTriggerHandler.UpdateAutoNumbers(trigger.new);
    
    
    
}