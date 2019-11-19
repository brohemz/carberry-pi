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
        anchors.horizontalCenter: parent.horizontalCenter

        // flow: GridView.FlowTopToBottom

        // model: context

        // delegate: dashDelegate

        // Loader { sourceComponent: dashDelegate; dash_context: context }

        // Component {
        //     id: dashDelegate

            Column{
              id: dashboard
              // Component.onCompleted: RectScript.rectCreation(dashboard, model)
              anchors.horizontalCenter: parent.left
              Row{

                  // Label{text: "Speed: " + model.speedValue}
                  CircularGauge {
                    id: speedGauge
                    objectName: "gauge_speed"
                    value: context.handler['speed']
                    minimumValue: 0
                    maximumValue: 140
                  }
                  // Label{text: "RPM: " + model.rpmValue}
                  CircularGauge {
                    id: rpmGauge
                    objectName: "gauge_rpm"
                    value: context.handler['rpm']
                    minimumValue: 0
                    maximumValue: 8000



                    style: CircularGaugeStyle{
                      labelStepSize: 1000
                      tickmarkStepSize: 500
                      minorTickmarkCount: 10
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


              Row{
                padding: 10
                Items.Thermometer{value: context.handler['engine_temp']}
                Items.Label{text: "Engine Temp"; padding: 30;
                    style: context.config['style']}
              }


            // }




          }








    }



}
