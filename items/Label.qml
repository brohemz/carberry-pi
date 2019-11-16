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
  color: "black"
  font.pixelSize: 22

  Component.onCompleted: function(){
    if(style == null)
      return;

    internal_label.state = style;
  }

  states: [
    State {
      name: "dark"
      PropertyChanges { target: internal_label; color: "white"}
    }
  ]
}
