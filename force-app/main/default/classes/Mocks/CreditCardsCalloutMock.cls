@IsTest
public class CreditCardsCalloutMock implements HttpCalloutMock {
    private CreditCardResponseMock responseMock;
    private String responseMockText;
    private Integer statusCode;

    public CreditCardsCalloutMock(CreditCardResponseMock responseMock, Integer statusCode) {
        this.responseMock = responseMock;
        this.statusCode = statusCode;
    }

    public CreditCardsCalloutMock(String responseMockText, Integer statusCode) {
        this.responseMockText = responseMockText;
        this.statusCode = statusCode;
    }

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        if (String.isBlank(this.responseMockText)) {
            res.setBody(JSON.serialize(this.responseMock));
        } else {
            res.setBody(this.responseMockText);
        }

        res.setStatusCode(this.statusCode);
        return res;
    }

    public class CreditCardResponseMock {
        public Integer id;
        public String uid;
        public String credit_card_number;
        public Date credit_card_expiry_date;
        public String credit_card_type;
    }
}
