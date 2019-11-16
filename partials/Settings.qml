import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import "../items" as Items



Item{

    property var context: null
    property var parent_stack: null
    anchors.fill: parent

    Column{
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter

      Items.Label{
        text: "style test"
        style: context.config['style']
      }

    }



}
