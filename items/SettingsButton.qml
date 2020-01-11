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
        parent_stack: internal_item.stack

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter


        Items.Button {
          id: exit_button
          text: "Exit"
          style: internal_item.style

          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom
          onClicked: internal_item.stack.sig_exit(0)
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
