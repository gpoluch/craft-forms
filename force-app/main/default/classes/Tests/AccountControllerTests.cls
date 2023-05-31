@IsTest
private class AccountControllerTests {
    @TestSetup
    static void makeData() {
        insert TestUtils.createTestAccounts(3);
    }

    @IsTest
    static void testGetAccountsByNameAsAdmin() {
        Id adminProfileId = [SELECT Id, Name FROM Profile WHERE name = 'System Administrator' LIMIT 1].Id;
        User admin = TestUtils.createTestUser(adminProfileId, 'Test', 'User');
        insert admin;

        String accountName = 'Test_Account_1';
        List<Account> expectedAccounts = TestUtils.getAccountsByName(accountName);
        List<Account> results = null;

        Test.startTest();
        System.runAs(admin) {
            results = AccountController.getAccountsByName(accountName);
        }
        Test.stopTest();

        System.assertEquals(1, results.size(), 'Expected only one result to be returned');

        Account actualAccount = results[0];
        Account expectedAccount = expectedAccounts[0];

        System.assertEquals(expectedAccount.Id, actualAccount.Id, 'Returned account has incorrect Id');
        System.assertEquals(expectedAccount.Name, actualAccount.Name, 'Returned account has incorrect Name');
        System.assertEquals(
            expectedAccount.BillingCountry,
            actualAccount.BillingCountry,
            'Returned account has incorrect BillingCountry'
        );
    }

    @IsTest
    static void testGetAccountsByNameAsStdUser() {
        Id stdUserProfileId = [SELECT Id, Name FROM Profile WHERE name = 'Standard User' LIMIT 1].Id;
        User stdUser = TestUtils.createTestUser(stdUserProfileId, 'Test', 'User');
        insert stdUser;

        String accountName = 'Test_Account_1';
        List<Account> expectedAccounts = TestUtils.getAccountsByName(accountName);
        List<Account> results = null;

        Test.startTest();
        System.runAs(stdUser) {
            results = AccountController.getAccountsByName(accountName);
        }
        Test.stopTest();

        System.assertEquals(1, results.size(), 'Expected only one result to be returned');

        Account actualAccount = results[0];
        Account expectedAccount = expectedAccounts[0];

        System.assertEquals(expectedAccount.Id, actualAccount.Id, 'Returned account has incorrect Id');
        System.assertEquals(expectedAccount.Name, actualAccount.Name, 'Returned account has incorrect Name');
        System.assertEquals(
            expectedAccount.BillingCountry,
            actualAccount.BillingCountry,
            'Returned account has incorrect BillingCountry'
        );
    }

    @IsTest
    static void testUpdateAccountsAsAdmin() {
        Id adminProfileId = [SELECT Id, Name FROM Profile WHERE name = 'System Administrator' LIMIT 1].Id;
        User admin = TestUtils.createTestUser(adminProfileId, 'Test', 'User');
        insert admin;

        String accountName = 'Test_Account_2';
        List<Account> accountsToUpdate = TestUtils.getAccountsByName(accountName);

        accountsToUpdate[0].Name = 'UpdatedName';
        accountsToUpdate[0].BillingCountry = 'China';

        Test.startTest();
        System.runAs(admin) {
            AccountController.updateAccounts(accountsToUpdate);
        }
        Test.stopTest();

        List<Account> updatedAccounts = TestUtils.getAccountsByName(accountsToUpdate[0].Name);

        System.assertEquals(1, updatedAccounts.size(), 'Expected only one account to be updated.');

        Account actualAccount = updatedAccounts[0];

        System.assertEquals(accountsToUpdate[0].Name, actualAccount.Name, 'Unexpected value for updated account name.');
        System.assertEquals(
            accountsToUpdate[0].BillingCountry,
            actualAccount.BillingCountry,
            'Unexpected value for updated account billing country.'
        );
    }

    @IsTest
    static void testUpdateAccountsAsStdUser() {
        Id stdUserProfileId = [SELECT Id, Name FROM Profile WHERE name = 'Standard User' LIMIT 1].Id;
        User stdUser = TestUtils.createTestUser(stdUserProfileId, 'Test', 'User');
        insert stdUser;

        String accountName = 'Test_Account_2';
        List<Account> accountsToUpdate = TestUtils.getAccountsByName(accountName);

        accountsToUpdate[0].Name = 'UpdatedName';
        accountsToUpdate[0].BillingCountry = 'China';

        Test.startTest();
        System.runAs(stdUser) {
            AccountController.updateAccounts(accountsToUpdate);
        }
        Test.stopTest();

        List<Account> updatedAccounts = TestUtils.getAccountsByName(accountsToUpdate[0].Name);

        System.assertEquals(1, updatedAccounts.size(), 'Expected only one account to be updated.');

        Account actualAccount = updatedAccounts[0];

        System.assertEquals(accountsToUpdate[0].Name, actualAccount.Name, 'Unexpected value for updated account name.');
        System.assertEquals(
            accountsToUpdate[0].BillingCountry,
            actualAccount.BillingCountry,
            'Unexpected value for updated account billing country.'
        );
    }

    @IsTest
    static void testUpdateAccountsWithAuraHandledException() {
        String accountName = 'Test_Account_3';
        List<Account> accountsToUpdate = TestUtils.getAccountsByName(accountName);

        Exception actualException = null;
        accountsToUpdate[0].Name = null;

        Test.startTest();
        try {
            AccountController.updateAccounts(accountsToUpdate);
        } catch (Exception ex) {
            actualException = ex;
        }
        Test.stopTest();

        System.assert(actualException != null, 'Expected exception to be thrown but no exception was caught.');
        System.assert(actualException instanceof AuraHandledException, 'Unexpected exception type caught.');
    }
}
