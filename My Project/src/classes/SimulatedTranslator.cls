/*
 * Name: SimulatedTranslator
 * Description: provide a simulation of a Translation Service (e.g. Google Translate)
 * Author: Stephen Moss
 * Date: 12/12/2016
 * Notes: from Chapter 7 of "Advanced Apex Programming (Third Edition)"
 */
global class SimulatedTranslator {
	public SimulatedTranslator() {
		
	}

	// mock a callout
	global class MockTranslator implements HttpCalloutMock
	{
		global HTTPResponse respond(HTTPRequest req) {
			String requestBody = req.getBody();
			HTTPResponse res = new HTTPResponse();
			res.setHeader('Content-Type', 'text');
			res.setBody(requestBody + ' in Spanish');
			res.setStatusCode(200);
			return res;
		}
	}

	// simulate or perform a callout
	// translator override has an HttpRequest object that
	// takes advantage of Salesforce platform to "mock"
	// callouts when in Test mode
	public static HTTPResponse translate(HTTPRequest req) {
		// Replace the following with call to actual translation service
		// rreq.setEndpoint('http://api.salesforce.com/foo/bar');

		// Just simulate the call for now - remove if really implemented
		// Test class should use Test.setMock() method to re-direct
		// callouts to MockTranslator.respond
		if (!Test.isRunningTest()) {
			// Call the mock translator
			MockTranslator mock = new MockTranslator();
			return mock.respond(req);
			
			// or, if you enable this endpoint in your security settings, you
			// can uncomment these lines and have some fun :-)
			// String endpoint ='http://isithackday.com/arrpi.php?format=text&text=' + EncodingUtil.urlEncode( req.getBody(),'UTF-8');
			// req.setBody('');
			// req.setEndpoint(endpoint);
		}
		req.setMethod('GET');
		Http h = new Http();
		HTTPResponse res = h.send(req);
		return res;
	}

	// Note - there is an existing platform bug in which mock callouts fails in
	// queueable Apex. We are temporarily bypassing this issue by detecting the
	// failure and calling code that simulates the callout directly.
	public static String translate(String sourceText) {
		HttpRequest req = new HttpRequest();
		req.setBody(sourceText);
		req.setHeader('Content-Type', 'text');
		HttpResponse result;
		try {
			result = translate(req);
		} catch (System.CalloutException ex) {
			if (System.isBatch() && Test.isRunningTest() && ex.getMessage()=='Callout loop not allowed') 
				return translate2(sourceText);
			else throw ex;
		}
		return result.getBody();
	}

	private static Integer callCounter = 0;

	// Workaround for mock Apex issue in queueable
	public static String translate2(String sourceText) {
		if (!Test.isRunningTest()) {
			return translate(sourceText);
		}
		callCounter++;
		if (callCounter > Limits.getLimitCallouts())
			throw new SimulatedException('Too many simulated callouts');

		return sourceText + '  in Spanish';
	}

	public class SimulatedException extends Exception{}
	
}