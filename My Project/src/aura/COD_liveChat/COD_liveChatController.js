({
init : function(component, event, helper) {
   /* if (!window._laq) { 
        window._laq = []; 
        console.log('MM-LC++++ - !window._laq');
    }
    window._laq.push(function(){
    	console.log('Entered laq')
        liveagent.showWhenOnline('5732800000007p1', document.getElementById('liveagent_button_online_5732800000007p1'));
		liveagent.showWhenOffline('5732800000007p1', document.getElementById('liveagent_button_offline_5732800000007p1'));        console.log('MM-LC++++ - window._laq.push');
    });
    liveagent.init('https://d.la1-c2-ukb.salesforceliveagent.com/chat', '5722800000007c0', '00D28000001iwPB'); */
},


    startChat : function(component, event, helper) {
        liveagent.startChat('5732800000007p1');
    },

    chatSetup : function(component){
		console.log('Entered LiveAgent');
    if (!window._laq) { 
        window._laq = []; 
        console.log('MM-LC++++ - !window._laq');
    }
    window._laq.push(function(){
    	console.log('Entered laq')
        liveagent.showWhenOnline('5732800000007p1', document.getElementById('liveagent_button_online_5732800000007p1'));
		liveagent.showWhenOffline('5732800000007p1', document.getElementById('liveagent_button_offline_5732800000007p1'));        console.log('MM-LC++++ - window._laq.push');
    });
    liveagent.init('https://d.la1-c2-ukb.salesforceliveagent.com/chat', '5722800000007c0', '00D28000001iwPB'); 
	}
})