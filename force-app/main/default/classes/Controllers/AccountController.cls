public with sharing class AccountController {
    @AuraEnabled
    public static List<Account> getAccountsByName(String name) {
        SObjectAccessDecision decision = Security.stripInaccessible(
            AccessType.READABLE,
            [
                SELECT Id, Name, BillingCountry
                FROM Account
                WHERE Name = :name
                ORDER BY Name
            ]
        );

        return (List<Account>) decision.getRecords();
    }

    @AuraEnabled
    public static void updateAccounts(List<Account> accountsToUpdate) {
        try {
            SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, accountsToUpdate);
            update decision.getRecords();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
