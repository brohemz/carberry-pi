import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import ".."

Button {
  id: internal_button
  padding: 2
  property var style: null
  text: ""
  font.pixelSize: 16

  implicitWidth: 200
  implicitHeight: 50

  // onClicked: console.log("button: action not defined")

  Component.onCompleted: function(){
    if(style == null)
      return;

    // if(context_style == "dark")
    //   internal_button.style = style_dark

    internal_button.state = style;
  }


  // Style
  background: Rectangle {
    property var prop_color: "white"
    id: style_background
    anchors.fill: parent
    radius: 0
    color: internal_button.down ? "grey" : prop_color
    border.color: "black"
    border.width: 2
  }

  contentItem: Text {
    id: style_text
    text: internal_button.text
    color: "white"
    font: internal_button.font
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
  }


  states: [
    State {
      name: "dark"
      PropertyChanges {
        target: style_background
        prop_color: "black"
      }
      PropertyChanges {
        target: style_text
        color: "white"
      }
    },

    State {
      name: "light"
      PropertyChanges {
        target: style_background
        prop_color: "white"
      }
      PropertyChanges {
        target: style_text
        color: "black"
      }
    }

    // State {
    //   name: "light"
    //   PropertyChanges {
    //     target: internal_button
    //     background: style_light_background
    //     contentItem: style_light_text
    //   }
    // }
  ]

}
