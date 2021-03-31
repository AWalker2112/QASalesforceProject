public with sharing class InstructorEmailFromOpportunities {
    
    

    public static void InstructorEmailFromOpportunities(List<Opportunity> courseOpps , String cred) {

        set<id> courseID = new set<id>();
        set<id> instructorID = new set<id>();
        List<Opportunity> course = [SELECT CloseDate,Start_Date__c,Name FROM Opportunity ];
        List<Messaging.SingleEmailMessage> mails = new List <Messaging.SingleEmailMessage>();
        List<User> users = [SELECT Name,lastName,email,id FROM User ];
        
        
        //for(Opportunity dataLimit : [SELECT Id FROM Opportunity WHERE IN :courseOpps]){
            for(Opportunity op : courseOpps){
                List<User> newUsers = new List<User>();
                if (op.Instructor__c != null){
                    instructorID.add(op.Instructor__c);
                    courseID.add(op.Id);

                }
                system.debug(users.size());
                Integer j = 0;
                for(user u: users){
                    

                    system.debug(j + ' ' + users[j].id);
                    system.debug(j + ' ' + op.Instructor__c);
                    

                    if(users[j].id==op.Instructor__c){
                    
                    newUsers.add(u);
                    
                    }
                    j++;
                }

                
                if(newUsers.size()>0){

                   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                // List<String> sendto = new List<String>();
                // sendto.add(users.email);
                // mail.setToAddresses(sendTo);

                    String sendto = newUsers[0].id;
                    mail.setTargetObjectId(sendto);
                    mail.setTreatTargetObjectAsRecipient(true);
                    mail.saveAsActivity = false;

                    mail.setReplyTo('AWalker@qa.com');
                    mail.setSenderDisplayName('Training Co-ordinator');

                    switch on cred {
                        when 'create'{
                            mail.setSubject('Course Scheduled');
                            String emailBody = 'Dear ' + newUsers[0].Name + '. You have a course scheduled: '  + op.Name + '. Start Date: ' + op.Start_Date__c;
                            mail.setHtmlBody(emailBody);
                            mails.add(mail);
                        }
                        when 'update'{
                            mail.setSubject('Course Updated');
                            String emailBody = 'Dear ' + newUsers[0].Name + '. You have a course updated: '  + op.Name + '. Start Date: ' + op.Start_Date__c;
                            mail.setHtmlBody(emailBody);
                            mails.add(mail);
                        }
                        when 'delete'{
                            mail.setSubject('Course Cancelled');
                            String emailBody = 'Dear ' + newUsers[0].Name + '. You have a course cancelled: '  + op.Name + '. Start Date: ' + op.Start_Date__c;
                            mail.setHtmlBody(emailBody);
                            mails.add(mail);

                        }
                    }    
                }
                

                

                

                //mail.setHtmlBody(emailBody);
                //mails.add(mail);
                
                }
                Messaging.sendEmail(mails);

        
           

        //}
    }
}
