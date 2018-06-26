({
    doInit : function(component,event){
        var baseURL = window.location.href;
        if(baseURL.includes('#')){
            var selectedMenuIndex = parseInt(baseURL.split('#')[1]);
            component.set("v.selectedNavigationIndex",selectedMenuIndex);
        }

    
    },
    waiting : function(component,event){
        var spinner = component.find("LOADING_SPINNER");
        $A.util.removeClass(spinner,"slds-hide");
    },
    doneWaiting : function(component,event){
        var spinner = component.find("LOADING_SPINNER");
        $A.util.addClass(spinner,"slds-hide");
    },
    
    navigateToEnquiry : function(component){
        window.location.href = '/council/s/enquiry'
    },
    
    navigateToHome : function(component){
        window.location.href = '/PartnerCommunity/s/civic-website#1'
    },
     navigateToLogin : function(component){
        window.location.href = '/PartnerCommunity/s/partnerregistration'
    },
     /*chatSetup : function(component){

        console.log('Entered LiveAgent');

        window._laq.push(function(){
            console.log('Entered LiveAgent 2'); 
            liveagent.showWhenOnline('5732800000007p1', component.find('liveagent_button_online_5732800000007p1'));
            liveagent.showWhenOffline('5732800000007p1', component.find('liveagent_button_offline_5732800000007p1')); 
        } 
     },*/


})