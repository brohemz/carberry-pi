var component;

var rect;

function rectCreation(obj, model){
  component = Qt.createComponent("items/Rectangle.qml");
  if(component.status == Component.Ready && model.speedValue == 0){
    finishCreation(obj);
  }

  else {
    component.statusChanged.connect(finishCreation)
  }
}

function finishCreation(parent) {
  if(component.status == Component.Ready){
    rect = component.createObject(parent, {color: "blue"});
    if(rect == null)
      console.log("Err: component creation failed.");
  }else if(component.status == Component.Error){
    console.log("Err: component could not be loaded.");
  }

}
