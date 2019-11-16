var component;
var button;


function buttonCreation(header, stack){
  component = Qt.createComponent("../items/HeaderButton.qml");
  if(component.status == Component.Ready){
    finishCreation(header, stack);
  }else{
    component.statusChanged.connect(finishCreation)
  }
}

function finishCreation(){
  if(component.status == Component.Ready){
    button = component.createObject(header, {parent_stack: stack, destroy: true});
    // console.log("wow");
    // console.log(header);
    if(button == null)
      console.log("Err: header_back creation failed.");
  }else if(component.status == Component.Error){
    console.log("Err: header_back component could not be loaded.")
  }
}
