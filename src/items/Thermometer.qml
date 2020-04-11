import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import ".."

Gauge {
  id: internal_gauge
  property var context_style: null
  property var prop_color: "black"
  minimumValue: 100
  maximumValue: 300
  value: 50
  height: 100;
  width: 50;

  minorTickmarkCount: 0

  tickmarkStepSize: 50

  style: GaugeStyle{

    tickmark: Rectangle{
      implicitWidth: 15
      implicitHeight: 1
      color: internal_gauge.prop_color
      anchors.leftMargin: 3
      anchors.rightMargin: 3
    }

    tickmarkLabel: Text{
      text: styleData.value
      color: internal_gauge.prop_color
    }

  }

  Component.onCompleted: function() {
    if(context_style == null)
      return

    internal_gauge.state = context_style
  }

  states: [
    State{
      name: "dark"
      PropertyChanges {
        target: internal_gauge
        prop_color: "white"
      }
    },
    State{
      name: "light"
      PropertyChanges {
        target: internal_gauge
        prop_color: "black"
      }
    }
  ]




}
