// example generic class to execute protected AWS API Gateway method

public with sharing class AWS_API_GatewayInvoke extends AWS{

    private HttpMethod requestMethod;
    private Map<String,String> requestParams;
    private String requestPayload;
    private String requestResource;

    //public AWS_API_GatewayInvoke() {

    //}

    public AWS_API_GatewayInvoke(String RESTmethod, Map<String, String> queryParameters,
                                        String APIpayload, String APIresource) {
        // initialise private variables
        // for Production code there will need to be a lot
        // more validation for these assignments and values
        try {
			requestMethod = getRESTMethod(RESTMethod);	
		} catch (Exception ex) {
			throw ex;
			return;
		}
		        
        
		requestParams = queryParameters;
        requestPayload = APIpayload;
        requestResource = APIresource;
    }

    public override void init() {

        // initialise constant values
        endpoint = new Url(AppConfigSupport.AWSAPIEndpoint);
        resource = requestResource;
        region = AppConfigSupport.AWSRegion;
        service = AppConfigSupport.AWSServiceIdentifier;
        accessKey = AppConfigSupport.AWSAccessKey;
        
        method = requestMethod;
        
        System.debug(LoggingLevel.INFO, '[AWS_API_GatewayInvoke.init] resource = ' + resource);
        
        // initialise query parameters (if required)
		// Note that Encoding is performed by base AWS class
        if (requestParams != null) {
            Set<String> paramKeys = requestParams.keySet();
            for (String key : paramKeys) {
                setQueryParam(key, requestParams.get(key));
            }
        }

        // initialise payload (if required)
        if (requestPayload != null) {
            payload = Blob.valueOf(requestPayload);
        }
        
        
        // Remember to set "payload" here if you need to specify a body
        // payload = Blob.valueOf('some-text-i-want-to-send');
        // This method helps prevent leaking secrey key,
        // as it is never serialized
        
        System.debug(LoggingLevel.INFO, '[AWS_API_GatewayInvoke.init] Calling createSigningKey...');
        createSigningKey(AppConfigSupport.AWSSecretKey);
    }

    // send the request to AWS
    public void sendAWSRequest() {
        HttpResponse response = sendRequest();
        System.debug(LoggingLevel.INFO, '[AWS_API_GatewayInvoke.sendAWSRequest] Response Status = ' + response.getStatusCode());
        System.debug(LoggingLevel.INFO, '[AWS_API_GatewayInvoke.sendAWSRequest] Response Body = ' + response.getBody());
		if (response.getStatusCode() <> 200) {
			throw new 
				AWSInvokeException('UNSUCCESSFUL_STATUS - Unsuccessful Status Code Received - ' + 
					response.getStatusCode() + '\nFurther Information: ' + response.getBody());
		} 
    }

	private HttpMethod getRESTMethod(String method) {
        if (method == 'GET') {
            return HttpMethod.XGET;
        } else if (method == 'POST') {
            return HttpMethod.XPOST;
        } else if (method == 'PUT') {
            return HttpMethod.XPUT;
        } else if (method == 'HEAD') {
            return HttpMethod.XHEAD;
        } else if (method == 'OPTIONS') {
            return HttpMethod.XOPTIONS;
        } else if (method == 'DELETE') {
            return HttpMethod.XDELETE;
        } else {
			// Illegal method passed
			throw new AWSInvokeException('ILLEGAL_METHOD - Illegal REST Method specified - ' + method);
		}
	}

	public class AWSInvokeException extends Exception {}
}