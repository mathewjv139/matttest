public class GenericSOAPController {
 
    //AsyncSOAPStockQuoteService.GetStockQuoteResponse_elementFuture stockQuoteFuture;
    AsyncCalculatorServices.doAddResponseFuture sumAsync;
    Public Double resultSync {get;set;}
    public Double resultAsync {get;set;}

    // Asynchronous Action method
    public Continuation startRequestAsync() {    
       Integer TIMEOUT_INT_SECS = 60;  
       Continuation cont = new Continuation(TIMEOUT_INT_SECS);
       cont.continuationMethod = 'processResponse';
       
       AsyncCalculatorServices.AsyncCalculatorImplPort calcServiceAsync = new AsyncCalculatorServices.AsyncCalculatorImplPort();
       sumAsync = calcServiceAsync.beginDoAdd(cont,10,20);     
       return cont;   
    }    
    
    // Callback method
    public Object processResponse() {    
       resultAsync = sumAsync.getValue();
       // Return null to re-render the original Visualforce page
       return null; 
    }
   
   //Synchronous Action Method. 
   
   public double startRequestSync() {
       calculatorServices.CalculatorImplPort calcServiceSync= new calculatorServices.CalculatorImplPort();
       resultSync = calcServiceSync.doAdd(10,20);
       
       return null;
   
   }
    
}