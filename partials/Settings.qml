import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import "../items" as Items



Frame{

    property var context: null
    property var parent_stack: null



    implicitWidth: 700
    implicitHeight: 420


    ListView{
      id: config_view

      anchors.fill: parent

      model: config_model

      ListModel{
        id: config_model
        dynamicRoles: true

        function refreshModel(){
            clear();

            var obj = Object.keys(context.config);
            for(var i = 0; i < obj.length; i++){
              var fill = obj[i];
              var entry = {'key': fill, 'value': context.config[fill]};
              append(entry);
            }
        }
        Component.onCompleted: refreshModel()
      }




      delegate: configDelegate

      Component {
        id: configDelegate

        Item{
          implicitWidth: 200
          implicitHeight: 25
          anchors.horizontalCenter: parent.horizontalCenter
          Column{
            Items.Label{
              text: model.key + ": " + context.config[model.key]
              style: context.config['style']
            }
          }




        }
      }



    }








}
