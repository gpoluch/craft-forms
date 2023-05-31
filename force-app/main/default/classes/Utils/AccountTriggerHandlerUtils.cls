public with sharing class AccountTriggerHandlerUtils {
    @Future(callout=true)
    public static void updateCreditCards(Set<Id> recordIds) {
        CreditCardsWebServiceClient client = new CreditCardsWebServiceClient();
        List<Account> accountsToUpdate = new List<Account>();

        try {
            for (Id recId : recordIds) {
                CreditCardResponse creditCard = client.getCreditCard();
                accountsToUpdate.add(new Account(Id = recId, CreditCard__c = creditCard.credit_card_number));
            }

            SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, accountsToUpdate);
            update decision.getRecords();
        } catch (Exception e) {
            // TODO Add logger based on Platform Event here
        }
    }
}
