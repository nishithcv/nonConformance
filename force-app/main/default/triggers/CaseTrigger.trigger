trigger CaseTrigger on Case (before insert, before update) {

    Switch on Trigger.operationType{

        when BEFORE_INSERT{
            CaseTriggerHandler.createNonConformance(Trigger.new);
        }

        when BEFORE_UPDATE{
            CaseTriggerHandler.createNonConformance(Trigger.new);
        }
    }
}