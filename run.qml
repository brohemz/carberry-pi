import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Extras 1.4
import "./partials"
import "./js/header_back.js" as HeaderBack
import "./js/header_info.js" as HeaderInfo
import "./items" as Items




ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 480
    title: "Carberry Pi [Development]"

    // Variables
    property var style: main.config['style']['current']
    property var header_list: {
      'info': false,
      'text': "",
      'stack': stack
    }
    property variant diagnostics_ignore_list: [
      'code-exists',
      // 'connection-established',
    ]

    color: "white"

    header: head

    // Source: https://forum.qt.io/topic/62267/how-we-can-create-2-second-delay-or-wait-in-qml/7
    Timer {
      id: timer
      running: false
      repeat: false

      property var callback

      onTriggered: callback()
    }

    function setTimeout(callback, delay)
    {
      if(timer.running){
        console.error("nested calls to setTimeout are not supported!");
      }
      timer.callback = callback;

      timer.interval = delay;
      timer.running = true;
    }

    function sendInfo(text){
      header_list['info'] = true;
      header_list['text'] = text;
      headerObj.list = header_list;
      setTimeout(function(){
        header_list['info'] = false;
        headerObj.list = header_list;
      }, 1000)
    }

    Item {
      id: head
      Header {
        id: headerObj
        list: header_list
        context: main
      }
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
          objectName: "Settings"

          Settings{
            id: settingsPage
            context: main
            parent_stack: stack

            Component.onCompleted: sendInfo(settingsItem.objectName)

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter


            Items.Button {
              id: exit_button
              text: "Exit"
              style: main.config['style']['current']

              // anchors.horizontalCenter: parent.horizontalCenter
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.bottom: parent.bottom
              onClicked: stack.sig_exit(0)
            }
          }

          Component.onCompleted: function(){
            HeaderBack.buttonCreation()
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

            onCurrentIndexChanged: function(){
              // console.log(this.currentIndex)
              var text = ""
              if(this.currentIndex == 0)
                text = firstPage.objectName
              else
                text = secondPage.objectName
              sendInfo(text);
              // HeaderInfo.create(header_list['text'])
            }


            Item {
              id: firstPage
              objectName: "Dashboard"

              Dash{
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.verticalCenter: parent.verticalCenter
                  context: main
              }
            }

            Item {
              id: secondPage
              objectName: "Diagnostics"

              Diagnostics{
                  Items.Button{
                    text: "Settings"
                    style: main.config['style']['current']
                    implicitWidth: 100
                    onClicked: stack.push(view2)
                    anchors.bottom: parent.bottom
                  }
                  ignore_list: diagnostics_ignore_list
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
          if(main.config['test'])
            console.log("cool")

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
            },
            State {
              name: "light"
              PropertyChanges { target: root; color: "white"}
            }
        ]
      }






    }

}
