import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import "../items" as Items


Rectangle {

    property var context: null
    width: parent.width
    height: 40
    color: "steelblue"


    // RowLayout{
    //   anchors.fill: parent
    //
    //   Button{
    //     text: "<"
    //     Layout.alignment: Qt.AlignLeft
    //   }
    //
    //   Items.Label{
    //     id: header_time
    //     text: context.time
    //     Layout.alignment: anchors.horizontalCenter
    //   }
    //
    // }

    Items.Label{
      id: header_time
      text: context.time
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter
    }

}
