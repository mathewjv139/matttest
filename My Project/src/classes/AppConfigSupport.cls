/*
 * Name: AppConfigSupport
 * Description: provide managed access to App Custom Settings
 * Author: Stephen Moss
 * Date: 12/12/2016
 * Notes: from Chapter 7 of "Advanced Apex Programming (Third Edition)"
 */
public with sharing class AppConfigSupport {
	// copy of object to use during testing
	// When running tests, a new instance is
	// always created and initialised to default
	// values
	private static AppConfig__c testConfig = null;

	public static AppConfig__c getAppConfig() {
		// return pre-initialised object if in a test
		if (Test.isRunningTest() && testConfig != null) return testConfig;

		// retrieve default Settings
		AppConfig__c theobject = AppConfig__c.getInstance('default');
		if (theObject==null || Test.isRunningTest()) {
			theObject = new AppConfig__c();
			theObject.name = 'default';
			theObject.EnableDiagnostics__c = (Test.isRunningTest())? true: false;
			theObject.AppEnabled__c = true;
			if(!Test.isRunningTest()) Database.Insert(theobject);
			else testconfig = theObject;
		}
		return theObject;
	}

	public static Boolean diagnosticsEnabled
	{ 
		get
		{
			return getAppConfig().EnableDiagnostics__c;
		}
	}
	
	public static Boolean appEnabled
	{
		get
		{
			return getAppConfig().AppEnabled__c;
		}
	}

	public static String AWSAPIEndpoint
	{
		get
		{
			return getAppConfig().AWS_API_Endpoint__c;
		}
	}

	public static String AWSAccessKey
	{
		get
		{
			return getAppConfig().AWS_Access_Key__c;
		}
	}

	public static String AWSSecretKey
	{
		get
		{
			return getAppConfig().AWS_Secret_Key__c;
		}
	}

	public static String AWSRegion
	{
		get
		{
			return getAppConfig().AWS_API_Region__c;
		}
	}

	public static String AWSServiceIdentifier
	{
		get
		{
			return getAppConfig().AWS_Service__c;
		}
	}

	
}