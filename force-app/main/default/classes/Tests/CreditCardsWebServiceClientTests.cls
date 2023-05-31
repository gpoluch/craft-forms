@IsTest
private class CreditCardsWebServiceClientTests {
    @isTest
    static void testGetCreditCard() {
        CreditCardsCalloutMock.CreditCardResponseMock expectedResponse = new CreditCardsCalloutMock.CreditCardResponseMock();
        expectedResponse.id = 100;
        expectedResponse.uid = '2c2c3be2-fe1c-44d1-9439-88612419d75c';
        expectedResponse.credit_card_number = '1212-1221-1121-1234';
        expectedResponse.credit_card_expiry_date = Date.today();
        expectedResponse.credit_card_type = 'switch';

        Test.setMock(HttpCalloutMock.class, new CreditCardsCalloutMock(expectedResponse, 200));
        CreditCardsWebServiceClient client = new CreditCardsWebServiceClient();

        Test.startTest();
        CreditCardResponse creditCard = client.getCreditCard();
        Test.stopTest();

        System.assertEquals(
            expectedResponse.id,
            creditCard.id,
            'The credit card id does not match the expected response.'
        );
        System.assertEquals(
            expectedResponse.uid,
            creditCard.uid,
            'The credit card uid does not match the expected response.'
        );
        System.assertEquals(
            expectedResponse.credit_card_number,
            creditCard.credit_card_number,
            'The credit card number does not match the expected response.'
        );
        System.assertEquals(
            expectedResponse.credit_card_expiry_date,
            creditCard.credit_card_expiry_date,
            'The credit card expiry date does not match the expected response.'
        );
        System.assertEquals(
            expectedResponse.credit_card_type,
            creditCard.credit_card_type,
            'The credit card type does not match the expected response.'
        );
    }

    @IsTest
    static void testGetCreditCardWithBadStatusCode() {
        CreditCardsCalloutMock.CreditCardResponseMock expectedResponse = new CreditCardsCalloutMock.CreditCardResponseMock();

        Test.setMock(HttpCalloutMock.class, new CreditCardsCalloutMock('{}', 404));
        CreditCardsWebServiceClient client = new CreditCardsWebServiceClient();
        Exception actualException = null;
        CreditCardResponse creditCard = null;

        Test.startTest();
        try {
            creditCard = client.getCreditCard();
        } catch (Exception ex) {
            actualException = ex;
        }
        Test.stopTest();

        System.assertEquals(null, creditCard, 'Unexpected credit card response');
        System.assert(
            actualException instanceof WebServiceClient.WebServiceClientException,
            'Unexpected exception occurred during callout'
        );
    }

    @IsTest
    static void testGetCreditCardWithBadJson() {
        CreditCardsCalloutMock.CreditCardResponseMock expectedResponse = new CreditCardsCalloutMock.CreditCardResponseMock();

        Test.setMock(HttpCalloutMock.class, new CreditCardsCalloutMock('{ bad json }', 200));
        CreditCardsWebServiceClient client = new CreditCardsWebServiceClient();
        Exception actualException = null;
        CreditCardResponse creditCard = null;

        Test.startTest();
        try {
            creditCard = client.getCreditCard();
        } catch (Exception ex) {
            actualException = ex;
        }
        Test.stopTest();

        System.assertEquals(null, creditCard, 'Unexpected credit card response');
        System.assert(actualException instanceof JSONException, 'Unexpected exception occurred during callout');
    }
}
