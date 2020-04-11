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
  property var context: null

  width: 80
  height: 35


  Row {
    id: internal_row
    anchors.rightMargin: 10

    height: parent.height

    Image{
      id: internal_image
      source: "../resources/alert.svg"

      height: parent.height
      width: this.height

      MouseArea{
        anchors.fill: parent
        onPressed: function() {
          stack.push(view3)
          internal_item.opacity = 0.5
        }
        onReleased: function(){
          internal_item.opacity = 0
          internal_item.enabled = false
        }
        // onClicked: stack.push(stack.view1)
      }

      OpacityAnimator{
        id: animation
        target: internal_item
        from: 0
        to: 1
        duration: 500
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
      id: alertItem
      objectName: "Alerts"

      Frame{
        id: alertPage
        width: 700
        height: 420

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Items.Label{
          id: alertLabel
          text: "Alerts"
          style: internal_item.style
          anchors.horizontalCenter: parent.horizontalCenter
        }

        ListView{
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: alertLabel.bottom

          id: alert_view

          implicitHeight: alertPage.height
          implicitWidth: alertPage.width - 50

          clip: true

          model: ListModel {
            id: alert_model
            dynamicRoles: true
            Component.onCompleted: ()=>{
              for(var iter = 0; iter < (context.handler['code']).length; iter++){
                this.append({key: 'Engine Code', value: context.handler['code'][0]})
              }

            }
          }

          delegate: alert_model_delegate

          Component {
            id: alert_model_delegate

            Item{
              width: alert_view.implicitWidth
              height: 40
              Items.Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: model.key + ":\t " + model.value
                width: parent.width;
                style: internal_item.style
              }
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
