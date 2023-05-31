public with sharing class CreditCardsWebServiceClient extends WebServiceClient {
    public override Object getResponseObject() {
        try {
            return JSON.deserialize(getResponseBody(), CreditCardResponse.class);
        } catch (JSONException ex) {
            throw new JSONException('Response deserialization has failed.');
        }
    }

    public CreditCardResponse getCreditCard() {
        createRequest();
        doCallout();
        return handleResponse();
    }

    private void createRequest() {
        request = super.createRequest(Constants.HTTP_METHOD_GET);
        request.setEndpoint('callout:CreditCards');
    }

    private CreditCardResponse handleResponse() {
        if (isStatusCodeOk()) {
            return (CreditCardResponse) getResponseObject();
        } else {
            throw new WebServiceClientException('Invalid status code: ' + getResponseStatusCode());
        }
    }
}
