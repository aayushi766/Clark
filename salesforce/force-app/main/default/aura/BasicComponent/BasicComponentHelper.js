({
      // Fetch the attachments from the Apex controller
      getAttachmentList: function(component) {
        var action = component.get('c.getAccountMethod');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            console.log(actionResult.getReturnValue());
         component.set('v.accounts', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
      }
    })