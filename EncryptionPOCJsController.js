({
	onInit : function(component, event, helper) {
        var action = component.get("c.showButton");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.isVisible",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
	
    doSave: function(component, event, helper) {
        if (component.find("fileId").get("v.files").length > 0) {
            console.log('Start');
            helper.uploadHelper(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
    
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No file is selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    }

})