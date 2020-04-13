/*
* File: Rectangle.qml
* Description: A rectangle container (background) for items.
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

Rectangle {
  id: internal_rectangle
  property var style: null
  width: 100;
  height: 100;
  color: "black";
  radius: 5

  Component.onCompleted: function(){
    if(style == null)
      return

    internal_rectangle.state = style;
  }

  states: [
    State{
      name: "dark"
      PropertyChanges {
        target: internal_rectangle
        color: "black"
      }
    },
    State{
      name: "light"
      PropertyChanges {
        target: internal_rectangle
        color: "white"
        border.width: 2
      }
    },
    State{
      name: "inverted_dark"
      PropertyChanges {
        target: internal_rectangle
        color: "white"
        border.width: 2
      }
    },
    State{
      name: "inverted_light"
      PropertyChanges {
        target: internal_rectangle
        color: "black"
      }
    }
  ]
}
