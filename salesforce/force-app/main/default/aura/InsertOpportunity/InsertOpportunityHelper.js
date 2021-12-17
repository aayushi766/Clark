({
	insertOpportunity : function(component, newOpp, event ) {
		var action = component.get("c.saveRecord");
        action.setParams({"opp":newOpp});
        action.setCallback(this , function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                
                var Opps = component.get("v.Opps");
                Opps.push(response.getReturnValue());
                component.set("v.Opps", Opps);
                console.log(JSON.stringify(component.get("v.Opps")));
                $A.get('e.force:refreshView').fire();
            }else{
                
            }
        });
        $A.enqueueAction(action);
	}
})