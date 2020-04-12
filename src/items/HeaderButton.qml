/*
* File: HeaderButton.qml
* Description: A dynamic button for going backward in the stack.
* Project: Carberry Pi
* Author: Ryan McHugh
* Year: 2020
*/
import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import ".."
import "." as Items

Item {
  property var destroy: false
  property var parent_stack: null
  property var style: null

  width: 75
  height: headerObj.height

  Items.Button{
    text: "<"

    width: parent.width
    height: parent.height

    style: parent.style

    onClicked: function(){
      if(destroy){
        console.log("destroyed back button");
        this.destroy();
      }

      parent_stack.pop();
    }
  }
}
