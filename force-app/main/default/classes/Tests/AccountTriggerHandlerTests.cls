@IsTest
private class AccountTriggerHandlerTests {
    @TestSetup
    static void makeData() {
        insert TestUtils.createTestAccount('Test_Account', 'Poland', '1111-1111-1111-1111');
    }

    @isTest
    static void testUpdateAccount() {
        String accountName = 'Test_Account';
        String creditCard = '1212-1221-1121-1234';
        List<Account> accountsToUpdate = TestUtils.getAccountsByName(accountName);

        CreditCardsCalloutMock.CreditCardResponseMock expectedResponse = new CreditCardsCalloutMock.CreditCardResponseMock();
        expectedResponse.id = 100;
        expectedResponse.uid = '2c2c3be2-fe1c-44d1-9439-88612419d75c';
        expectedResponse.credit_card_number = creditCard;
        expectedResponse.credit_card_expiry_date = Date.today();
        expectedResponse.credit_card_type = 'switch';

        Test.setMock(HttpCalloutMock.class, new CreditCardsCalloutMock(expectedResponse, 200));

        Test.startTest();
        update accountsToUpdate;
        Test.stopTest();

        List<Account> actualAccounts = TestUtils.getAccountsByName(accountName);

        System.assertEquals(1, actualAccounts.size(), 'Expected only one account to be updated.');

        Account actualAccount = actualAccounts[0];

        System.assertEquals(
            creditCard,
            actualAccount.CreditCard__c,
            'Unexpected value for updated account credit card number.'
        );
    }
}
