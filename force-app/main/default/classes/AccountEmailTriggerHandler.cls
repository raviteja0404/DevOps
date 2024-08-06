public with sharing class AccountEmailTriggerHandler {
    public static void TriggerHandlerMethod(List<Account> newAccList, Map<Id, Account> oldAccMap){

        //get the last updated time details from the account
        Map<Id, Datetime> ParentAccountLastupdateMap = new Map<Id, Datetime>();
        Account oldAcc = new Account();
        Set<Id> AccOwnerList = new Set<Id>();
        System.debug('Trigger.new value is '+newAccList);

        if(!newAccList.isEmpty()){
          //compare the old account updation time with new account updation time
            for(Account acc : newAccList){
               if(oldAccMap != null){
                   oldAcc = oldAccMap.get(acc.Id);
                    if(oldAcc.LastModifiedDate != acc.LastModifiedDate){
                        ParentAccountLastupdateMap.put(acc.Id, oldAcc.LastModifiedDate);
                        AccOwnerList.add(acc.OwnerId);
                    }
                }
            }
            System.debug('Owner Id list is '+AccOwnerList);
            System.debug('Parent Id map is '+ParentAccountLastupdateMap);
        }
        if(ParentAccountLastupdateMap != null){
                List<Contact> updatedContacts = [ Select Id, Name, LastModifiedDate, AccountId FROM Contact 
                      WHERE AccountId in : ParentAccountLastupdateMap.keySet() AND 
                      LastModifiedDate >: ParentAccountLastupdateMap.values() AND
                      LastModifiedDate <= :System.now()];
                      String emailBody = 'The following Contacts have been updated:\n';

            for(Contact con: updatedContacts) {
                emailBody += 'name : '+con.name+'\n';
            }
            System.debug('email body for multiple updates '+emailBody);
            Map<Id, User> ownerIdtoUserMap = new Map<Id, User>([Select Id, Email from User where Id in :AccOwnerList ]);
            Map<Id, String> accountOwnerEmails = new Map<Id, String>();
            for(Account acc : newAccList){
                if(ownerIdtoUserMap.containsKey(acc.OwnerId)){
                    accountOwnerEmails.put(acc.Id, ownerIdtoUserMap.get(acc.OwnerId).Email);
                }
            }
            System.debug('accountOwnerEmails map details '+accountOwnerEmails);
            List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
            for(Id accId : accountOwnerEmails.keySet()){

             Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
             email.setToAddresses(new List<String>{accountOwnerEmails.get(accId)});
             email.setSubject('Update contacts in your account');
             email.setPlainTextBody(emailBody);
             emailList.add(email);
            }
            System.debug('email List is '+emailList);

            Messaging.sendEmail(emailList);
        }

    }
}