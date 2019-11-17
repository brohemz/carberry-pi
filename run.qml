import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Extras 1.4
import "./partials"
import "./js/header_back.js" as HeaderBack



ApplicationWindow {
    id: root
    visible: true
    width: 800
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
      objectName: "stack"

      Transition {
        id: transition_enter
        PropertyAnimation{
          property: "opacity"
          from: 0
          to: 1
          duration: 500
        }
      }

      Transition {
        id: transition_exit
        PropertyAnimation{
          property: "opacity"
          from: 1
          to: 0
          duration: 500
        }
      }

      popEnter: transition_enter
      popExit: transition_exit
      pushEnter: transition_enter
      pushExit: transition_exit


      signal sig_exit(var exit_code)

      Component {
        id: view2
        Item {
          id: settingsItem

          Settings{
            id: settingsPage
            context: main
            parent_stack: stack

            Button {
              objectName: "exit_button"
              text: "Exit"

              anchors.horizontalCenter: parent.horizontalCenter
              anchors.bottom: settingsPage.bottom
              onClicked: stack.sig_exit(0)
            }
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

            count: swipeView.count
            currentIndex: swipeView.currentIndex

            anchors.bottom: swipeView.bottom
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
