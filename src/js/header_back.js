/*
* File: header_back.js
* Description: JavaScript for dynamic creation of 'HeaderButton'
* Project: Carberry Pi
* Author: Ryan McHugh
* Year: 2020
*/
var component;
var button;


function buttonCreation(){
  component = Qt.createComponent("../items/HeaderButton.qml");
  if(component.status == Component.Ready){
    finishCreation();
  }else{
    component.statusChanged.connect(finishCreation)
  }
}

function finishCreation(){
  if(component.status == Component.Ready){
    button = component.createObject(headerObj, {parent_stack: stack, destroy: true, style: style});
    if(button == null)
      console.log("Err: header_back creation failed.");
  }else if(component.status == Component.Error){
    console.log("Err: header_back component could not be loaded.")
  }
}
