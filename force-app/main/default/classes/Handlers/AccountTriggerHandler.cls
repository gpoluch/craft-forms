public with sharing class AccountTriggerHandler extends TriggerHandler {
    public override void afterUpdate(Map<Id, SObject> updatedRecordsMap, Map<Id, SObject> oldRecordsMap) {
        if (!System.isFuture()) {
            AccountTriggerHandlerUtils.updateCreditCards(updatedRecordsMap.keySet());
        }
    }
}
