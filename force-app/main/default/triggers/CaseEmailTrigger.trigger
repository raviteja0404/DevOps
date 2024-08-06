trigger CaseEmailTrigger on case (before insert) {

    if(trigger.isInsert && trigger.isBefore){
        System.debug('CaseEmailTrigger is invoked');
        caseTriggerHandler.caseTriggerMethod(trigger.new);
    }

}