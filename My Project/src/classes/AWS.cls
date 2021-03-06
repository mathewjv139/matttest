// class to facilitate calling AWS API's
// also calculates v4 AWS Signature for signing requests

// Credit to rchasman at https://gist.github.com/rchasman/7cef6aeb505f0b0dcf564a36be2ce180

/*
// Example implementation as follows:
    public class AWSS3_GetService extends AWS {
        public override void init() {
            endpoint = new Url('https://s3.amazonaws.com/');
            resource = '/';
            region = 'us-east-1';
            service = 's3';
            accessKey = 'my-key-here';
            method = HttpMethod.XGET;
            //  Remember to set "payload" here if you need to specify a body
            //  payload = Blob.valueOf('some-text-i-want-to-send');
            //  This method helps prevent leaking secret key,
            //  as it is never serialized
            createSigningKey('my-secret-key-here');
       }
       public String[] getBuckets() {
           HttpResponse response = sendRequest();
           String[] results = new String[0];
           // Read response XML; if we get this far, no exception happened
           // This code was omitted for brevity
           return results;
       }
    }
*/

public abstract class AWS {
    
    // Post initialisation logic (after constructor, before API call)
    protected abstract void init();

    // XML Node Utility methods that will help read elements
    public static Boolean getChildNodeBoolean(Dom.XmlNode node, String ns, String name) {
        try {
            return Boolean.valueOf(node.getChildElement(name, ns).getText());
        } catch (Exception e) {
            return null;
        }
    }

    public static DateTime getChildNodeDateTime(Dom.XmlNode node, String ns, String name) {
        try {
            return (DateTime)JSON.deserialize(node.getChildElement(name, ns).getText(),
                        DateTime.class);
        } catch (Exception e) {
            return null;
        }
    }

    public static Integer getChildNodeInteger(Dom.XmlNode node, String ns, String name) {
        try {
            return Integer.valueOf(node.getChildElement(name, ns).getText());
        } catch (Exception e) {
            return null;
        }
    }
    
    public static String getChildNodeText(Dom.XmlNode node, String ns, String name) {
        try {
            return node.getChildElement(name, ns).getText();
        } catch (Exception e) {
            return null;
        }
    }

    // Turns an Amazon exception into something we can present to the user/catch
    public class ServiceException extends Exception {
        public String Code, Message, Resource, RequestId;

        public ServiceException(Dom.XmlNode node) {
            String ns = node.getNamespace();
            Code = getChildNodeText(node, ns, 'Code');
            Message = getChildNodeText(node, ns, 'Message');
            Resource = getChildNodeText(node, ns, 'Resource');
            RequestId = getChildNodeText(node, ns, 'RequestId');
        }

        public String toString() {
            return JSON.serialize(this);
        }
    }

    // Things we need to know about the service, Set these values in init()
    protected String host, region, service, resource, accessKey;
    protected Url endpoint;
    protected HttpMethod method;
    protected Blob payload; // string for some operations?
    // Not used externally, so we hide these values
    String payloadSha256;
    Blob signingKey;
    DateTime requestTime;
    Map<String, String> queryParams, headerParams;

    // Make sure we can't misspell methods
    public enum HttpMethod { XGET, XPUT, XHEAD, XOPTIONS, XDELETE, XPOST }

    // We have to replace ~ and " " correctly, or we'll break AWS on
    // those two characters
    protected String uriEncode(String value) {
        return value == 
            null ? null: EncodingUtil.urlEncode(value, 'utf-8')
                .replaceAll('%7E','~')
                .replaceAll('\\+', '%20'); 
    }

    // Add a header
    protected void setHeader(String key, String value) {
        headerParams.put(key.toLowerCase(), value);
    }

    // Add a query param
    protected void setQueryParam(String key, String value) {
        queryParams.put(key, uriEncode(value));
    }

    // call this constructor with super() in subclasses
    protected AWS() {
        requestTime = DateTime.now();
        queryParams = new Map<String, String>();
        headerParams = new Map<String, String>();
        payload = Blob.valueOf('');
    }

    //  Create a canonical query string (used during signing)
  String createCanonicalQueryString() {
    String[] results = new String[0], keys = new List<String>(queryParams.keySet());
    keys.sort();
    for(String key: keys) {
      results.add(key+'='+queryParams.get(key));
    }
    return String.join(results, '&');
  }

  // Create the canonical headers (used for signing)
  String createCanonicalHeaders(String[] keys) {
    keys.addAll(headerParams.keySet());
    keys.sort();
    String[] results = new String[0];
    for(String key: keys) {
      results.add(key+':'+headerParams.get(key));
    }
    return String.join(results, '\n')+'\n';
  }

  // Create the entire canonical request
  String createCanonicalRequest(String[] headerKeys) {
    return String.join(
        new String[] {
        method.name().removeStart('X'),    //  METHOD
        new Url(endpoint, resource).getPath(),  //  RESOURCE
        createCanonicalQueryString(),    //  CANONICAL QUERY STRING
        createCanonicalHeaders(headerKeys),  //  CANONICAL HEADERS
        String.join(headerKeys, ';'),    //  SIGNED HEADERS
        payloadSha256        //  SHA256 PAYLOAD
        },
      '\n'
    );
  }

  // Create the entire string to sign
  String createStringToSign(String[] signedHeaders) {
    String result = createCanonicalRequest(signedHeaders);
    System.debug('Canonical Request: '  + result);
    return String.join(
        new String[] {
        'AWS4-HMAC-SHA256',
        headerParams.get('x-amz-date'),
        String.join(new String[] { requestTime.formatGMT('YYYYMMdd'), region, service, 'aws4_request' },'/'),
        EncodingUtil.convertToHex(Crypto.generateDigest('sha256', Blob.valueof(result)))
        },
        '\n'
        );
  }

  // Create our signing key
  protected void createSigningKey(String secretKey) {
    System.debug(LoggingLevel.INFO, '[AWS.createSigningKey] Creating Signing Key...');  
    signingKey = Crypto.generateMac('hmacSHA256', Blob.valueOf('aws4_request'),
        Crypto.generateMac('hmacSHA256', Blob.valueOf(service),
          Crypto.generateMac('hmacSHA256', Blob.valueOf(region),
            Crypto.generateMac('hmacSHA256', Blob.valueOf(requestTime.formatGMT('YYYYMMdd')), Blob.valueOf('AWS4'+secretKey))
            )
          )
        );
    System.debug(LoggingLevel.INFO, '[AWS.createSigningKey] Signing Key = ' + signingKey);  
  }

  // Create all of the bits and pieces using all utility functions above
  HttpRequest createRequest() {
    System.debug(LoggingLevel.INFO, '[AWS.createRequest] Executing createRequest...');    
    init();
    System.debug(LoggingLevel.DEBUG, '[AWS.createRequest] Payload = ' + payload);
    System.debug(LoggingLevel.INFO, '[AWS.createRequest] Endpoint = ' + endpoint);
    System.debug(LoggingLevel.INFO, '[AWS.createRequest] Resource = ' + resource);  
    payloadSha256 = EncodingUtil.convertToHex(Crypto.generateDigest('sha-256', payload));
    setHeader('x-amz-date', requestTime.formatGMT('YYYYMMdd\'T\'HHmmss\'Z\''));
    if(host == null) {
      host = endpoint.getHost();
    }
    System.debug(LoggingLevel.INFO, '[AWS.createRequest] Host = ' + host);    
    setHeader('host', host);
    HttpRequest request = new HttpRequest();
    request.setMethod(method.name().removeStart('X'));
    if(payload.size() > 0) {
      setHeader('x-amz-content-sha256', payloadSha256);
      setHeader('Content-Length', String.valueOf(payload.size()));
      request.setBodyAsBlob(payload);
    }
    String
      finalEndpoint = new Url(endpoint, resource).toExternalForm(),
                    queryString = createCanonicalQueryString();
    System.debug('[AWS.createRequest] Final Endpoint:  ' + finalEndpoint);
    System.debug('[AWS.createRequest] Canonical Query String:  ' + queryString);
    if(queryString != '') {
      finalEndpoint += '?'+queryString;
    }
    request.setEndpoint(finalEndpoint);
    for(String key: headerParams.keySet()) {
      request.setHeader(key, headerParams.get(key));
    }
    String[] headerKeys = new String[0];
    String stringToSign = createStringToSign(headerKeys);
    System.debug('String To Sign: '  + stringToSign);
    request.setHeader(
        'Authorization',
        String.format(
          'AWS4-HMAC-SHA256 Credential={0}, SignedHeaders={1}, Signature={2}',
          new String[] {
          String.join(new String[] { accessKey, requestTime.formatGMT('YYYYMMdd'), region, service, 'aws4_request' },'/'),
          String.join(headerKeys,';'), EncodingUtil.convertToHex(Crypto.generateMac('hmacSHA256', Blob.valueOf(stringToSign), signingKey))}
          ));
    System.debug('Authorization Header: ' + request.getHeader('Authorization'));
    return request;
  }

  // Actually perform the request, and throw exception if response code is not valid
  protected HttpResponse sendRequest(Set<Integer> validCodes) {
    System.debug(LoggingLevel.INFO, '[AWS.sendRequest] Creating and Sending Request...');    
    HttpResponse response = new Http().send(createRequest());
    System.debug('***Response: ' + response.getBody());
    //if(!validCodes.contains(response.getStatusCode())) {
    //    throw new ServiceException(response.getBodyDocument().getRootElement());
    //}
    return response;
  }

  //  Same as above, but assume that only 200 is valid
  //  This method exists because most of the time, 200 is what we expect
  protected HttpResponse sendRequest() {
    return sendRequest(new Set<Integer> { 200 });
  }
}