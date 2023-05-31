public abstract class WebServiceClient {
    protected HttpRequest request;
    protected HttpResponse response;

    protected void doCallout() {
        this.response = new Http().send(request);
    }

    protected Boolean isStatusCodeOk() {
        return response.getStatusCode() == 200;
    }

    protected Integer getResponseStatusCode() {
        return response.getStatusCode();
    }

    protected String getResponseBody() {
        return response.getBody();
    }

    protected virtual HttpRequest createRequest(String method) {
        request = new HttpRequest();
        request.setMethod(method);
        return request;
    }

    protected abstract Object getResponseObject();
    public class WebServiceClientException extends Exception {
    }
}
