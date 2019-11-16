import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Extras 1.4
import "./partials"
import "./js/header_back.js" as HeaderBack



ApplicationWindow {
    id: root
    visible: true
    width: 700
    height: 480
    title: qsTr("Hello World")

    property var style: main.config['style']

    color: "white"

    header: head

    Item {
      id: head
      Header {id: headerObj; context: main;}
    }

    StackView{
      id: stack
      anchors.fill: parent
      initialItem: view1

      Component {
        id: view2
        Item {
          id: settingsItem

          Settings{
            id: settingsPage
            context: main
            parent_stack: stack
          }

          Component.onCompleted: function(){
            HeaderBack.buttonCreation(root.header.headerObj, stack)
          }

        }
      }



      Component {
        id: view1
        Item {
          id: mainItem


          SwipeView{
            id: swipeView

            anchors.fill: parent

            currentIndex: 0


            Item {
              id: firstPage
              Dash{
                  Button{
                    text: "Settings"
                    onClicked: stack.push(view2)
                  }
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.verticalCenter: parent.verticalCenter
                  context: main
              }
            }

            Item {
              id: secondPage
              Diagnostics{
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.verticalCenter: parent.verticalCenter
                  context: main
              }
            }

          }

          PageIndicator {
            id: indicator

            count: view.count
            currentIndex: view.currentIndex

            anchors.bottom: view.bottom
            anchors.horizontalCenter: parent.horizontalCenter
          }


        }
      }

      Component.onCompleted: function(){
        if(style == null)
          return;

        stategroup.state = style;

      }

      StateGroup {
        id: stategroup
        states: [
            State {
              name: "dark"
              PropertyChanges { target: root; color: "#000123"}
            }
        ]
      }






    }

}
