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

Item {
  id: internal_item

  property var style: null
  property var amount: 0
  property var stack: null

  width: 80
  height: 35


  Row {
    id: internal_row
    anchors.rightMargin: 10

    height: parent.height

    Image{
      source: "../resources/alert.svg"

      height: parent.height
      width: this.height

      MouseArea{
        anchors.fill: parent
        onClicked: stack.push(view3)
        // onClicked: stack.push(stack.view1)
      }

    }



    Items.Label{
      id: amountLabel
      text: amount
      style: internal_item.style
    }



  }

  Component{
    id: view3
    Item {
      id: engineCodeItem

      Frame{
        id: engineCodePage
        width: 500
        height: 420

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Component.onCompleted: function(){
          HeaderBack.buttonCreation(root.header.headerObj, stack)
        }
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
