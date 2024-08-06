trigger AccountEmailTrigger on Account (after update) {

    if(Trigger.isUpdate && Trigger.isAfter){
        System.debug('Trigger Initiated');

        AccountEmailTriggerHandler.TriggerHandlerMethod(trigger.new, trigger.oldMap);
    }

}