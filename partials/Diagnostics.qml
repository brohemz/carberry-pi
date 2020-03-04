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
    property alias testProps: diagnostics_model
    // property var time: context.time
    property var ignore_list: {
          'connection-established' : true,
          'STATUS': true
        }

    clip: true

    implicitWidth: 700
    implicitHeight: 420

    // onTimeChanged: {console.log("hi")}

    ListView {

      anchors.horizontalCenter: parent.horizontalCenter

      id: diagnostics_view

      implicitHeight: root_diagnostics.implicitHeight - 100
      implicitWidth: root_diagnostics.implicitWidth - 50

      clip: true

      model: ListModel {
        id: diagnostics_model
        dynamicRoles: true


        function refreshModel(){

              clear()

              // console.log(ignore_list)

              var obj = Object.keys(context.diagnostics);
              for(var i = 0; i < obj.length; i++){
                var fill = obj[i];
                var entry = {'key': fill, 'value': context.diagnostics[fill]};
                if(ignore_list[fill] == undefined && context.diagnostics[fill] != [])
                  append(entry);
              }



              // if(empty())
              //   append({'key': "Status", 'value': "Not Connected"})
          }

          Component.onCompleted: refreshModel()

        }




        delegate: diagnosticsDelegate

        Component {
          id: diagnosticsDelegate

          Item{
            width: diagnostics_view.implicitWidth
            height: 50
            clip: true

              Items.Rectangle{
                style: context.config['style']['current']
                width: parent.width
                height: 40

                Row{
                  anchors.fill: parent
                  Column{
                    anchors.rightMargin: 50
                    Items.Label {
                      text: model.key;
                      style: context.config['style']['current']
                    }
                    width: parent.width / 2
                  }

                  Column{
                    anchors.leftMargin: 50
                    Items.Label {
                      text: context.diagnostics[model.key];
                      style: context.config['style']['current']
                    }
                    width: parent.width / 2
                  }
                }
              }

          }

        }

    }

    Row{
      anchors.top: diagnostics_view.bottom
      anchors.topMargin: 20
      anchors.horizontalCenter: parent.horizontalCenter
      Column{
        Items.Button{
          text: "Refresh"
          style: context.config['style']['current']
          onClicked: function(){
            // setTimeout(function(){""}, 1000)
            diagnostics_model.refreshModel()
          }
        }
      }
    }


}
