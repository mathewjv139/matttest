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
        window.location.href = '/s/tquilaenquiry'
    },
    
    navigateToEnquiryPardot : function(component){
        window.location.href = '/s/tquilaenquirypardot'
    },
    
    navigateToHome : function(component){
        window.location.href = '/s/home'
    },
     navigateToLogin : function(component){
        window.location.href = '/s/login'
    },


})