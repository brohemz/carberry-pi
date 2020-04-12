/*
* File: run.qml
* Description: Main controller/view for the frontend. Root element that
*               instantiates all components.  Lasts the runtime of the GUI.
* Project: Carberry Pi
* Author: Ryan McHugh
* Year: 2020
*/

// root

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
      'stack': stack,
    }
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

    Timer {
      id: timer_extended
      running: false
      repeat: false

      property var callback

      onTriggered: callback()
    }

    // Javascript Functions
    function setTimeout(callback, delay)
    {
      if(timer.running){
        console.error("nested calls to setTimeout are not supported!");
      }
      timer.callback = callback;
      timer.interval = delay;
      timer.running = true;
    }

    function setTimeoutRepeated(callback, delay, cont){
      if(timer.running){
        console.error("nested calls to setTimeoutRepeated are not supported!");
      }
      timer_extended.callback = callback;
      timer_extended.interval = delay;
      timer_extended.repeat = cont;
      timer_extended.running = true;
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


    // run function to return conditional
    function sendInfoExtended(text, run){
      setTimeoutRepeated(function(){
        header_list['info'] = !run();
        header_list['text'] = text;
        headerObj.list = header_list;
      }, 1000, !run())
    }

    function printTest(){

      console.log("\n_____TESTING_____\n\n")

      var test_dict = stack.currentItem.children[0].testValues()

      console.log("\n___DASH___")
      console.log(`Speed: ${main.handler['speed'] == test_dict['SPEED'] ? "YES" : "No"}`)
      console.log(`RPM: ${main.handler['rpm'] == test_dict['RPM'] ? "YES" : "No"}`)
      console.log(`Coolant: ${main.handler['engine_temp'] == test_dict['COOLANT'] ? "YES" : "No"}`)

      console.log("\n___Diagnostics___");
      // console.log(test_dict['diag_1'] == 22 ? "YES" : "No")
      for(var iter = 1; iter <= 6; iter++){
          console.log(`temp${iter}: ${main.diagnostics[test_dict['diag'].get(iter - 1)['key']] == test_dict['diag'].get(iter - 1)['value'] ? "YES" : "No"}`)
          // console.log(test_dict['diag'].get(0)['value'])
          // console.log(main.diagnostics['temp1'])
      }
      console.log("\n_____END TESTING_____\n\n")


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

      onCurrentItemChanged: currentItem.objectName != "" ? sendInfo(currentItem.objectName) : null

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
      signal sig_restart(var exit_code)



      Component {
        id: view1
        Item {
          id: mainItem
          SwipeView{
            id: swipeView
            anchors.fill: parent

            currentIndex: 0

            function testValues(){
              var dict = {
                'SPEED': dashObj.speedVal,
                'RPM': dashObj.rpmVal,
                'COOLANT': dashObj.coolantVal,
                'diag': diagObj.props,
              }
              return dict
            }

            onCurrentIndexChanged: function(){
              // console.log(this.currentIndex)
              var text = ""
              if(this.currentIndex == 0)
                text = firstPage.objectName
              else{
                text = secondPage.objectName
                if(text == "Diagnostics")
                  diagObj.props.refreshModel();
              }

              sendInfo(text);
              // HeaderInfo.create(header_list['text'])
            }


            Item {
              id: firstPage
              objectName: "Dashboard"

              Dash{
                  id: dashObj
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.verticalCenter: parent.verticalCenter
                  context: main
              }
            }

            Item {
              id: secondPage
              objectName: "Diagnostics"

              Diagnostics{
                  id: diagObj
                  // Items.Button{
                  //   text: "Settings"
                  //   style: main.config['style']['current']
                  //   implicitWidth: 100
                  //   onClicked: stack.push(view2)
                  //   anchors.bottom: parent.bottom
                  // }
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

          sendInfoExtended("Connecting...", function(){
            // console.log("connection-established: " + main.diagnostics['connection-established'])
            return main.diagnostics['connection-established']
          });

          if(main.handler['dev']){
            console.log("DEV MODE ENABLED!")
            printTest()
          }


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
