//Generated by wsdl2apex

public class wwwStrikeironCom {
    public class ServiceOutput {
        public wwwStrikeironCom.SIWsStatus ServiceStatus;
        private String[] ServiceStatus_type_info = new String[]{'ServiceStatus','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceStatus'};
    }
    public class GetHistoricalRates_element {
        public String CommaSeparatedListOfCurrenciesFrom;
        public String SingleCurrencyTo;
        public String Date_x;
        private String[] CommaSeparatedListOfCurrenciesFrom_type_info = new String[]{'CommaSeparatedListOfCurrenciesFrom','http://www.strikeiron.com',null,'0','1','false'};
        private String[] SingleCurrencyTo_type_info = new String[]{'SingleCurrencyTo','http://www.strikeiron.com',null,'0','1','false'};
        private String[] Date_x_type_info = new String[]{'Date','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'CommaSeparatedListOfCurrenciesFrom','SingleCurrencyTo','Date_x'};
    }
    public class ExchangeRateResult {
        public wwwStrikeironCom.ArrayOfExchangeRateListing Listings;
        private String[] Listings_type_info = new String[]{'Listings','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'Listings'};
    }
    public class GetHistoricalRangeRatesResponse_element {
        public wwwStrikeironCom.ExchangeRateOutput GetHistoricalRangeRatesResult;
        private String[] GetHistoricalRangeRatesResult_type_info = new String[]{'GetHistoricalRangeRatesResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetHistoricalRangeRatesResult'};
    }
    public class SupportedCurrenciesOutput {
        public wwwStrikeironCom.SupportedCurrenciesResult ServiceResult;
        private String[] ServiceResult_type_info = new String[]{'ServiceResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceResult'};
    }
    public class ArrayOfCurrencyListing {
        public wwwStrikeironCom.CurrencyListing[] CurrencyListing;
        private String[] CurrencyListing_type_info = new String[]{'CurrencyListing','http://www.strikeiron.com',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'CurrencyListing'};
    }
    public class ServiceInfoOutput {
        public wwwStrikeironCom.SIServiceInfoResult ServiceResult;
        private String[] ServiceResult_type_info = new String[]{'ServiceResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceResult'};
    }
    public class GetLatestRatesResponse_element {
        public wwwStrikeironCom.ExchangeRateOutput GetLatestRatesResult;
        private String[] GetLatestRatesResult_type_info = new String[]{'GetLatestRatesResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetLatestRatesResult'};
    }
    public class GetAllLatestRatesToUSDResponse_element {
        public wwwStrikeironCom.ExchangeRateOutput GetAllLatestRatesToUSDResult;
        private String[] GetAllLatestRatesToUSDResult_type_info = new String[]{'GetAllLatestRatesToUSDResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetAllLatestRatesToUSDResult'};
    }
    public class GetHistoricalRangeRates_element {
        public String SingleCurrencyFrom;
        public String SingleCurrencyTo;
        public String DateFrom;
        public String DateTo;
        private String[] SingleCurrencyFrom_type_info = new String[]{'SingleCurrencyFrom','http://www.strikeiron.com',null,'0','1','false'};
        private String[] SingleCurrencyTo_type_info = new String[]{'SingleCurrencyTo','http://www.strikeiron.com',null,'0','1','false'};
        private String[] DateFrom_type_info = new String[]{'DateFrom','http://www.strikeiron.com',null,'0','1','false'};
        private String[] DateTo_type_info = new String[]{'DateTo','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'SingleCurrencyFrom','SingleCurrencyTo','DateFrom','DateTo'};
    }
    public class SIWsStatus {
        public Integer StatusNbr;
        public String StatusDescription;
        private String[] StatusNbr_type_info = new String[]{'StatusNbr','http://www.strikeiron.com',null,'1','1','false'};
        private String[] StatusDescription_type_info = new String[]{'StatusDescription','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'StatusNbr','StatusDescription'};
    }
    public class ArrayOfExchangeRateListing {
        public wwwStrikeironCom.ExchangeRateListing[] ExchangeRateListing;
        private String[] ExchangeRateListing_type_info = new String[]{'ExchangeRateListing','http://www.strikeiron.com',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ExchangeRateListing'};
    }
    public class ServiceInfoRecord {
        public String InfoKey;
        public String InfoValue;
        private String[] InfoKey_type_info = new String[]{'InfoKey','http://www.strikeiron.com',null,'0','1','false'};
        private String[] InfoValue_type_info = new String[]{'InfoValue','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'InfoKey','InfoValue'};
    }
    public class GetServiceInfo_element {
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class ArrayOfServiceInfoRecord {
        public wwwStrikeironCom.ServiceInfoRecord[] ServiceInfoRecord;
        private String[] ServiceInfoRecord_type_info = new String[]{'ServiceInfoRecord','http://www.strikeiron.com',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceInfoRecord'};
    }
    public class GetAllLatestRatesToUSD_element {
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class SIServiceInfoResult {
        public wwwStrikeironCom.ArrayOfServiceInfoRecord ServiceInfo;
        private String[] ServiceInfo_type_info = new String[]{'ServiceInfo','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceInfo'};
    }
    public class GetSupportedCurrencies_element {
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class GetHistoricalRatesResponse_element {
        public wwwStrikeironCom.ExchangeRateOutput GetHistoricalRatesResult;
        private String[] GetHistoricalRatesResult_type_info = new String[]{'GetHistoricalRatesResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetHistoricalRatesResult'};
    }
    public class CurrencyListing {
        public String Symbol;
        public String Unit;
        public String Country;
        private String[] Symbol_type_info = new String[]{'Symbol','http://www.strikeiron.com',null,'0','1','false'};
        private String[] Unit_type_info = new String[]{'Unit','http://www.strikeiron.com',null,'0','1','false'};
        private String[] Country_type_info = new String[]{'Country','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'Symbol','Unit','Country'};
    }
    public class GetServiceInfoResponse_element {
        public wwwStrikeironCom.ServiceInfoOutput GetServiceInfoResult;
        private String[] GetServiceInfoResult_type_info = new String[]{'GetServiceInfoResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetServiceInfoResult'};
    }
    public class GetAllLatestUSDToCurrenciesResponse_element {
        public wwwStrikeironCom.ExchangeRateOutput GetAllLatestUSDToCurrenciesResult;
        private String[] GetAllLatestUSDToCurrenciesResult_type_info = new String[]{'GetAllLatestUSDToCurrenciesResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetAllLatestUSDToCurrenciesResult'};
    }
    public class StatusCodeOutput {
        public wwwStrikeironCom.StatusCodeResult ServiceResult;
        private String[] ServiceResult_type_info = new String[]{'ServiceResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceResult'};
    }
    public class StatusCodeResult {
        public wwwStrikeironCom.ArrayOfSIWsStatus Statuses;
        private String[] Statuses_type_info = new String[]{'Statuses','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'Statuses'};
    }
    public class ExchangeRateOutput {
        public wwwStrikeironCom.ExchangeRateResult ServiceResult;
        private String[] ServiceResult_type_info = new String[]{'ServiceResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceResult'};
    }
    public class SupportedCurrenciesResult {
        public wwwStrikeironCom.ArrayOfCurrencyListing Listings;
        private String[] Listings_type_info = new String[]{'Listings','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'Listings'};
    }
    public class SIWsResult {
        public Integer Count;
        private String[] Count_type_info = new String[]{'Count','http://www.strikeiron.com',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'Count'};
    }
    public class GetAllLatestUSDToCurrencies_element {
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class ArrayOfSIWsStatus {
        public wwwStrikeironCom.SIWsStatus[] SIWsStatus;
        private String[] SIWsStatus_type_info = new String[]{'SIWsStatus','http://www.strikeiron.com',null,'0','-1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'SIWsStatus'};
    }
    public class GetLatestRates_element {
        public String CommaSeparatedListOfCurrenciesFrom;
        public String SingleCurrencyTo;
        private String[] CommaSeparatedListOfCurrenciesFrom_type_info = new String[]{'CommaSeparatedListOfCurrenciesFrom','http://www.strikeiron.com',null,'0','1','false'};
        private String[] SingleCurrencyTo_type_info = new String[]{'SingleCurrencyTo','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'CommaSeparatedListOfCurrenciesFrom','SingleCurrencyTo'};
    }
    public class GetSupportedCurrenciesResponse_element {
        public wwwStrikeironCom.SupportedCurrenciesOutput GetSupportedCurrenciesResult;
        private String[] GetSupportedCurrenciesResult_type_info = new String[]{'GetSupportedCurrenciesResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetSupportedCurrenciesResult'};
    }
    public class GetAllStatuses_element {
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class GetAllStatusesResponse_element {
        public wwwStrikeironCom.StatusCodeOutput GetAllStatusesResult;
        private String[] GetAllStatusesResult_type_info = new String[]{'GetAllStatusesResult','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'GetAllStatusesResult'};
    }
    public class ExchangeRateListing {
        public Double Value;
        public String Currency_x;
        public String PerCurrency;
        public String Date_x;
        private String[] Value_type_info = new String[]{'Value','http://www.strikeiron.com',null,'1','1','false'};
        private String[] Currency_x_type_info = new String[]{'Currency','http://www.strikeiron.com',null,'0','1','false'};
        private String[] PerCurrency_type_info = new String[]{'PerCurrency','http://www.strikeiron.com',null,'0','1','false'};
        private String[] Date_x_type_info = new String[]{'Date','http://www.strikeiron.com',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.strikeiron.com','true','false'};
        private String[] field_order_type_info = new String[]{'Value','Currency_x','PerCurrency','Date_x'};
    }
    public class ForeignExchangeRatesSoap {
        public String endpoint_x = 'http://ws.strikeiron.com/StrikeIron/ForeignExchangeRate/ForeignExchangeRates';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        public wsStrikeironCom.SubscriptionInfo SubscriptionInfo;
        public wsStrikeironCom.LicenseInfo LicenseInfo;
        private String SubscriptionInfo_hns = 'SubscriptionInfo=http://ws.strikeiron.com';
        private String LicenseInfo_hns = 'LicenseInfo=http://ws.strikeiron.com';
        private String[] ns_map_type_info = new String[]{'http://www.strikeiron.com', 'wwwStrikeironCom', 'http://ws.strikeiron.com', 'wsStrikeironCom'};
        public wwwStrikeironCom.ExchangeRateOutput GetAllLatestRatesToUSD() {
            wwwStrikeironCom.GetAllLatestRatesToUSD_element request_x = new wwwStrikeironCom.GetAllLatestRatesToUSD_element();
            wwwStrikeironCom.GetAllLatestRatesToUSDResponse_element response_x;
            Map<String, wwwStrikeironCom.GetAllLatestRatesToUSDResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetAllLatestRatesToUSDResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetAllLatestRatesToUSD',
              'http://www.strikeiron.com',
              'GetAllLatestRatesToUSD',
              'http://www.strikeiron.com',
              'GetAllLatestRatesToUSDResponse',
              'wwwStrikeironCom.GetAllLatestRatesToUSDResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetAllLatestRatesToUSDResult;
        }
        public wwwStrikeironCom.ExchangeRateOutput GetLatestRates(String CommaSeparatedListOfCurrenciesFrom,String SingleCurrencyTo) {
            wwwStrikeironCom.GetLatestRates_element request_x = new wwwStrikeironCom.GetLatestRates_element();
            request_x.CommaSeparatedListOfCurrenciesFrom = CommaSeparatedListOfCurrenciesFrom;
            request_x.SingleCurrencyTo = SingleCurrencyTo;
            wwwStrikeironCom.GetLatestRatesResponse_element response_x;
            Map<String, wwwStrikeironCom.GetLatestRatesResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetLatestRatesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetLatestRates',
              'http://www.strikeiron.com',
              'GetLatestRates',
              'http://www.strikeiron.com',
              'GetLatestRatesResponse',
              'wwwStrikeironCom.GetLatestRatesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetLatestRatesResult;
        }
        public wwwStrikeironCom.SupportedCurrenciesOutput GetSupportedCurrencies() {
            wwwStrikeironCom.GetSupportedCurrencies_element request_x = new wwwStrikeironCom.GetSupportedCurrencies_element();
            wwwStrikeironCom.GetSupportedCurrenciesResponse_element response_x;
            Map<String, wwwStrikeironCom.GetSupportedCurrenciesResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetSupportedCurrenciesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetSupportedCurrencies',
              'http://www.strikeiron.com',
              'GetSupportedCurrencies',
              'http://www.strikeiron.com',
              'GetSupportedCurrenciesResponse',
              'wwwStrikeironCom.GetSupportedCurrenciesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetSupportedCurrenciesResult;
        }
        public wwwStrikeironCom.ExchangeRateOutput GetAllLatestUSDToCurrencies() {
            wwwStrikeironCom.GetAllLatestUSDToCurrencies_element request_x = new wwwStrikeironCom.GetAllLatestUSDToCurrencies_element();
            wwwStrikeironCom.GetAllLatestUSDToCurrenciesResponse_element response_x;
            Map<String, wwwStrikeironCom.GetAllLatestUSDToCurrenciesResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetAllLatestUSDToCurrenciesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetAllLatestUSDToCurrencies',
              'http://www.strikeiron.com',
              'GetAllLatestUSDToCurrencies',
              'http://www.strikeiron.com',
              'GetAllLatestUSDToCurrenciesResponse',
              'wwwStrikeironCom.GetAllLatestUSDToCurrenciesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetAllLatestUSDToCurrenciesResult;
        }
        public wwwStrikeironCom.StatusCodeOutput GetAllStatuses() {
            wwwStrikeironCom.GetAllStatuses_element request_x = new wwwStrikeironCom.GetAllStatuses_element();
            wwwStrikeironCom.GetAllStatusesResponse_element response_x;
            Map<String, wwwStrikeironCom.GetAllStatusesResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetAllStatusesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetAllStatuses',
              'http://www.strikeiron.com',
              'GetAllStatuses',
              'http://www.strikeiron.com',
              'GetAllStatusesResponse',
              'wwwStrikeironCom.GetAllStatusesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetAllStatusesResult;
        }
        public wwwStrikeironCom.ExchangeRateOutput GetHistoricalRangeRates(String SingleCurrencyFrom,String SingleCurrencyTo,String DateFrom,String DateTo) {
            wwwStrikeironCom.GetHistoricalRangeRates_element request_x = new wwwStrikeironCom.GetHistoricalRangeRates_element();
            request_x.SingleCurrencyFrom = SingleCurrencyFrom;
            request_x.SingleCurrencyTo = SingleCurrencyTo;
            request_x.DateFrom = DateFrom;
            request_x.DateTo = DateTo;
            wwwStrikeironCom.GetHistoricalRangeRatesResponse_element response_x;
            Map<String, wwwStrikeironCom.GetHistoricalRangeRatesResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetHistoricalRangeRatesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetHistoricalRangeRates',
              'http://www.strikeiron.com',
              'GetHistoricalRangeRates',
              'http://www.strikeiron.com',
              'GetHistoricalRangeRatesResponse',
              'wwwStrikeironCom.GetHistoricalRangeRatesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetHistoricalRangeRatesResult;
        }
        public wwwStrikeironCom.ServiceInfoOutput GetServiceInfo() {
            wwwStrikeironCom.GetServiceInfo_element request_x = new wwwStrikeironCom.GetServiceInfo_element();
            wwwStrikeironCom.GetServiceInfoResponse_element response_x;
            Map<String, wwwStrikeironCom.GetServiceInfoResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetServiceInfoResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetServiceInfo',
              'http://www.strikeiron.com',
              'GetServiceInfo',
              'http://www.strikeiron.com',
              'GetServiceInfoResponse',
              'wwwStrikeironCom.GetServiceInfoResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetServiceInfoResult;
        }
        public wwwStrikeironCom.ExchangeRateOutput GetHistoricalRates(String CommaSeparatedListOfCurrenciesFrom,String SingleCurrencyTo,String Date_x) {
            wwwStrikeironCom.GetHistoricalRates_element request_x = new wwwStrikeironCom.GetHistoricalRates_element();
            request_x.CommaSeparatedListOfCurrenciesFrom = CommaSeparatedListOfCurrenciesFrom;
            request_x.SingleCurrencyTo = SingleCurrencyTo;
            request_x.Date_x = Date_x;
            wwwStrikeironCom.GetHistoricalRatesResponse_element response_x;
            Map<String, wwwStrikeironCom.GetHistoricalRatesResponse_element> response_map_x = new Map<String, wwwStrikeironCom.GetHistoricalRatesResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://www.strikeiron.com/GetHistoricalRates',
              'http://www.strikeiron.com',
              'GetHistoricalRates',
              'http://www.strikeiron.com',
              'GetHistoricalRatesResponse',
              'wwwStrikeironCom.GetHistoricalRatesResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetHistoricalRatesResult;
        }
        public void GetRemainingHits() {
            wsStrikeironCom.GetRemainingHits_element request_x = new wsStrikeironCom.GetRemainingHits_element();
            wsStrikeironCom.GetRemainingHitsResponse_element response_x;
            Map<String, wsStrikeironCom.GetRemainingHitsResponse_element> response_map_x = new Map<String, wsStrikeironCom.GetRemainingHitsResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://ws.strikeiron.com/StrikeIron/ForeignExchangeRate/ForeignExchangeRates/GetRemainingHits',
              'http://ws.strikeiron.com',
              'GetRemainingHits',
              'http://ws.strikeiron.com',
              'GetRemainingHitsResponse',
              'wsStrikeironCom.GetRemainingHitsResponse_element'}
            );
            response_x = response_map_x.get('response_x');
        }
    }
}