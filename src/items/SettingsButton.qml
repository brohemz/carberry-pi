/*
* File: SettingsButton.qml
* Description: The 'settings' specific icon with button funcionality.
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
import "../items" as Items
import "../resources/"
import "../js/header_back.js" as HeaderBack
import "../partials"

Item {
  id: internal_item

  property var style: null
  property var stack: null

  width: 80
  height: 35

  Image{
    id: internal_image
    source: "../resources/gears.svg"

    height: parent.height
    width: this.height

    MouseArea{
      anchors.fill: parent
      onPressed: function() {
        stack.push(view2)
        internal_item.opacity = 0.5
      }
      onReleased: function(){
        internal_item.opacity = 0
        internal_item.enabled = false
      }
      // onClicked: internal_item.stack.push(stack.view2)
    }

    OpacityAnimator{
      id: animation
      target: internal_item
      from: 0
      to: 1
      duration: 500
    }

  }


  Component {
    id: view2
    Item {
      id: settingsItem
      objectName: "Settings"

      Settings{
        id: settingsPage
        context: main

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Row{
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom

          Items.Button {
            id: exit_button
            text: "Exit"
            style: internal_item.style

            // anchors.horizontalCenter: parent.horizontalCenter
            // anchors.bottom: parent.bottom
            onClicked: internal_item.stack.sig_exit(0)
          }

          Items.Button {
            id: restart_button
            text: "Restart"
            style: internal_item.style
            onClicked: internal_item.stack.sig_restart(0)
            // anchors.left:
          }
        }


      }

      Component.onCompleted: function(){
        HeaderBack.buttonCreation()
      }

      Component.onDestruction: function(){
        internal_item.enabled = true
        animation.start()
      }

    }
  }






  // Component.onCompleted: function(){
  //   if(style == null)
  //     return;
  //
  //   internal_item.state = style;
  // }
  //
  // states: [
  //   State {
  //     name: "dark"
  //     PropertyChanges { target: amountLabel; color: "white"}
  //   }
  // ]
}
