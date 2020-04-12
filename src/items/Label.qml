/*
* File: Label.qml
* Description: A baseline label for displaying text data.
* Project: Carberry Pi
* Author: Ryan McHugh
* Year: 2020
*/
import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import ".."

Label {
  id: internal_label
  padding: 10
  property var style: null
  text: "text"
  wrapMode: Text.Wrap
  color: "black"
  font.pixelSize: 22

  height: get_preferred_height()

  function get_preferred_height(){
    var ret = (contentWidth / width) * 45
    return ret > 50 ? ret : 50;
  }

  Component.onCompleted: function(){
    if(style == null)
      return;

    internal_label.state = style;
  }

  states: [
    State {
      name: "dark"
      PropertyChanges { target: internal_label; color: "white"}
    },
    State {
      name: "dark_grey"
      PropertyChanges { target: internal_label; color: "grey"}
    },
    State {
      name: "light"
      PropertyChanges { target: internal_label; color: "black"}
    },
    State {
      name: "light_grey"
      PropertyChanges { target: internal_label; color: "grey"}
    },
    State {
      name: "caution"
      PropertyChanges { target: internal_label; color: "orange"; font.underline: true}
    }
  ]
}
