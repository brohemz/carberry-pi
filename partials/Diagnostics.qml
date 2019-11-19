import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import "../items" as Items


Frame{
    id: root_diagnostics
    property var context: null
    property var time: context.time
    clip: true

    implicitWidth: 700
    implicitHeight: 420

    // onTimeChanged: {console.log("hi")}

    ListView {


      id: diagnostics_view

      implicitHeight: 300





      model: ListModel {
      id: diagnostics_model
      dynamicRoles: true


      function refreshModel(){

            clear()

            var obj = Object.keys(context.diagnostics);
            for(var i = 0; i < obj.length; i++){
              var fill = obj[i];
              var entry = {'key': fill, 'value': context.diagnostics[fill]};
              append(entry);
            }
        }

        Component.onCompleted: refreshModel()

      }




      delegate: diagnosticsDelegate

      Component {
        id: diagnosticsDelegate

        Items.Label {
          text: model.key + ": " + context.diagnostics[model.key];
          style: main.config['style']
        }
      }

    }

    Row{
      anchors.top: diagnostics_view.bottom
      Column{
        Button{
          text: "Refresh"
          onClicked: diagnostics_model.refreshModel()
        }
      }
    }


}
