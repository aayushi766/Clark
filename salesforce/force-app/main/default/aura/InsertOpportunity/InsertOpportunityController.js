(
    {
        insertOpportunityA:function(component,event,helper){
        	var newOpp = component.get("v.Opp");
            console.log("Site Info Controller " + JSON.stringify(newOpp));
            helper.insertOpportunity(component,newOpp, event );
        }
    }
)