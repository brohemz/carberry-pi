import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import ".."

Item {
  property var destroy: false
  property var parent_stack: null

  Button{
    text: "<"

    onClicked: function(){
      if(destroy){
        console.log("destroyed back button");
        this.destroy();
      }

      parent_stack.pop();
    }
  }
}
