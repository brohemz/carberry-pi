/*
* File: header_info.js
* Description: JavaScript for loading informational text in header
* Project: Carberry Pi
* Author: Ryan McHugh
* Year: 2020
*/
var component;
var obj;
var info_text;


function create(text){
  component = Qt.createComponent("../items/Label.qml");
  info_text = text;
  if(component.status == Component.Ready){
    finishCreation();
  }else{
    component.statusChanged.connect(finishCreation)
  }
}


function finishCreation(){
  if(component.status == Component.Ready){
    obj = component.createObject(headerObj,
      {
        style: style,
        text: info_text,
        'anchors.horizontalCenter': headerObj.horizontalCenter
      });

    if(obj == null)
      console.log("Err: header_info creation failed.");
    else {
      obj.destroy(1000);
      header_list['info'] = false;
    }
  }else if(component.status == Component.Error){
    console.log("Err: header_info component could not be loaded.")
  }
}
