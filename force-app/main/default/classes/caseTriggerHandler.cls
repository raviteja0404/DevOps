public with sharing class caseTriggerHandler {

    public static void caseTriggerMethod(List<Case> newCaseList) {

        Set<String> caseEmails = new Set<String>();
        Map<String, Contact> ContactMap = new Map<String, Contact>();
        List<Contact> listToInsert = new List<Contact>();
        Map<String, Id> emailToContactIdMap = new Map<String, Id>();

        if(!newCaseList.isEmpty()){
            System.debug('Trigger.new details is ' +newCaseList);
            for(Case newcase: newCaseList){
                if(newcase.SuppliedEmail != null){
                    caseEmails.add(newcase.SuppliedEmail);
                }
            }
        }
        if(!caseEmails.isEmpty()){
            System.debug('Email Provided while creating the case is ' +caseEmails);
            for(Contact con: [Select Id, Email FROM Contact WHERE Email IN : caseEmails]){
                ContactMap.put(con.Email, con);
            }
            System.debug('Contact details with Same Email is ' +ContactMap);
            for(Case cs : newCaseList){    
                if(ContactMap.containsKey(cs.SuppliedEmail)){
                    Contact existingContact = contactMap.get(cs.SuppliedEmail);
                    emailToContactIdMap.put(existingContact.Email,existingContact.Id);
                    //cs.ContactId = existingContact.Id;
                }
                else {                     
                    Contact newCon = new Contact();
                    newCon.LastName = 'Case Contact';
                    newCon.Email = cs.SuppliedEmail;
                    listToInsert.add(newCon);
                }    
            }
            System.debug('List to insert details are' +listToInsert);
            if(!listToInsert.isEmpty()){
                insert listToInsert;
                for(Contact newContact : listToInsert){
                    emailToContactIdMap.put(newContact.Email,newContact.Id);
                }
            }
               System.debug('emailToContactIdMap details' +emailToContactIdMap);
               for(Case csRecord : newCaseList){
                 if(emailToContactIdMap.containsKey(csRecord.SuppliedEmail)){
                    csRecord.ContactId = emailToContactIdMap.get(csRecord.SuppliedEmail);
                 }                                
               }
        }
    }
}