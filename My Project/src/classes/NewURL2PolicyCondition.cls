global class NewURL2PolicyCondition implements TxnSecurity.PolicyCondition {

 public boolean evaluate(TxnSecurity.Event e) {
AggregateResult[] results = [SELECT ApiType FROM LoginHistory WHERE UserId = :e.userId AND LoginTime = LAST_N_DAYS:2 GROUP BY ApiType];

  if(!results.isEmpty() && results.size() > 1) {
   return true;
 }

 return false; 
}
 }