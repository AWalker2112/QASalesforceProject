public with sharing class PdfEmailControllerServiceInvoiceInvoke {
    

        //allows the service invoice pdf controller to be invocable.
    
        Public class FlowInput{
            @InvocableVariable public ID accountId;
        }
        @InvocableMethod(label='Send Expense Invoice' description='')
        public static void PdfEmailControlInvoke(list<FlowInput> request) {
    
    
                    ID accountID = request[0].accountId;
                    
                    PdfEmailControllerServiceInvoice con = new PdfEmailControllerServiceInvoice();
        
                    con.accountId = accountID;
                    con.email = 'alexwalker2112@googlemail.com';
                    con.sendPdf();
        }
    }
    
