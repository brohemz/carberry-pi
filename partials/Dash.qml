import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import "../js/rectCreation.js" as RectScript
import "../items" as Items


Frame{
    id: root_dash
    property var context: null
    clip: true

    implicitWidth: 700
    implicitHeight: 420

    Item{

        // anchors.fill: parent
        id: grid
        anchors.fill: parent

        // flow: GridView.FlowTopToBottom

        // model: context

        // delegate: dashDelegate

        // Loader { sourceComponent: dashDelegate; dash_context: context }

        // Component {
        //     id: dashDelegate
        Component.onCompleted: function() {
          if(context == null)
            return

          grid.state = context.config['style']['current']
        }

            Column{
              id: dashboard
              // Component.onCompleted: RectScript.rectCreation(dashboard, model)
              anchors.horizontalCenter: parent.horizontalCenter
              Row{
                  leftPadding: 20
                  // Label{text: "Speed: " + model.speedValue}
                  Column {
                    padding: 10
                    CircularGauge {
                      id: speedGauge
                      objectName: "gauge_speed"
                      property var prop_color: "black"
                      value: context.handler['speed']
                      minimumValue: 0
                      maximumValue: context.config['locality']['current'] == "en-US" ? 140 : 250

                      style: CircularGaugeStyle{
                        tickmark: Rectangle {
                          implicitWidth: outerRadius * 0.02
                          implicitHeight: outerRadius * 0.05
                          color: speedGauge.prop_color
                          antialiasing: true
                        }

                        labelStepSize: context.config['locality']['current'] == "en-US" ? 10 : parent.maximumValue / 10

                        tickmarkLabel: Text{
                          font.pixelSize: Math.max(6, outerRadius * 0.1)
                          text: styleData.value
                          color: speedGauge.prop_color
                        }

                        minorTickmark: Rectangle {
                          implicitWidth: outerRadius * 0.01
                          implicitHeight: outerRadius * 0.03
                          color: speedGauge.prop_color
                          antialiasing: true
                        }
                      }
                      Items.Label{
                        style: context.config['style']['current'] + "_grey"
                        text: context.config['locality']['current'] == "en-US" ? "mph" : "km / h"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        padding: 0
                      }

                    }



                  }

                  Column {
                    padding: 10
                    // Label{text: "RPM: " + model.rpmValue}
                    CircularGauge {
                      id: rpmGauge
                      objectName: "gauge_rpm"
                      property var prop_color: "black"
                      value: context.handler['rpm']
                      minimumValue: 0
                      maximumValue: 8000



                      style: CircularGaugeStyle{
                        labelStepSize: 1000
                        tickmarkStepSize: 500
                        minorTickmarkCount: 10

                        tickmark: Rectangle {
                          implicitWidth: outerRadius * 0.02
                          implicitHeight: outerRadius * 0.05
                          color: rpmGauge.prop_color
                          antialiasing: true
                        }

                        tickmarkLabel: Text{
                          font.pixelSize: Math.max(6, outerRadius * 0.1)
                          text: styleData.value
                          color: rpmGauge.prop_color
                        }

                        minorTickmark: Rectangle {
                          implicitWidth: outerRadius * 0.01
                          implicitHeight: outerRadius * 0.03
                          color: rpmGauge.prop_color
                          antialiasing: true
                        }
                        // needle: Rectangle{
                        //   y: outerRadius * 0.15
                        //   implicitWidth: outerRadius * 0.03
                        //   implicitHeight: outerRadius * 0.9
                        //   antialiasing: true
                        //   color: "blue"
                        // }
                      }
                    }
                  }


              }


              Column{
                padding: 5
                anchors.right: parent.horizontalCenter
                Row{
                  // rightPadding: 40
                  Items.Label{
                      Component.onCompleted: function(){
                        var loc = context.config['locality']['current']
                        if(loc == "en-US")
                          text = "Engine Temp (°F)"
                        else
                          text = "Engine Temp (°C)"
                      }
                      text: "Engine Temp" ; padding: 30;
                      style: context.config['style']['current'] + "_grey"
                    }
                  Items.Thermometer{value: context.handler['engine_temp']; context_style: context.config['style']['current']}
                }

                // Row{
                //   leftPadding: 40
                //   Items.Thermometer{value: context.diagnostics['OIL_TEMP']; context_style: context.config['style']['current']}
                //   Items.Label{text: "Oil Temp"; padding: 30;
                //       style: context.config['style']['current']}
                // }


              }


            // }




          }

          states: [
            State {
              name: "dark"
              PropertyChanges {
                target: speedGauge
                prop_color: "white"
              }
              PropertyChanges {
                target: rpmGauge
                prop_color: "white"
              }
            },
            State {
              name: "light"
              PropertyChanges {
                target: speedGauge
                prop_color: "black"
              }
              PropertyChanges {
                target: rpmGauge
                prop_color: "black"
              }
            }
          ]


    }



}
