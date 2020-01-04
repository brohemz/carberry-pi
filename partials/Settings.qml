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


      anchors.horizontalCenter: parent.horizontalCenter;
      anchors.top: parent.top;

      width: 200
      implicitHeight: 300

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
          id: configDelegate_box
          property var key: model.key
          property var options: model.value['options']
          property var value: model.value['current']
          implicitWidth: 200
          implicitHeight: 75
          anchors.horizontalCenter: parent.horizontalCenter

          clip: true

          Column{
            anchors.fill: parent

            Items.Label{
              text: configDelegate_box.key
              style: context.config['style']['current']
            }

            ComboBox {

              implicitWidth: 200
              implicitHeight: 25

              property var loaded: false


              model: configDelegate_box.options != undefined ? options : []

              Component.onCompleted: function() {
                currentIndex = this.find(configDelegate_box.value.toString())
                loaded = true
              }

              onCurrentIndexChanged: function () {
                  if(loaded){
                      context.updateConfigFromQML(configDelegate_box.key, this.textAt(this.currentIndex))
                      console.log("config-update: [" + configDelegate_box.key + " : " + this.textAt(this.currentIndex) + "]")
                      config_change_label.visible = true
                  }
              }

              // Component.onCompleted: console.log(configDelegate_box.value != undefined ? configDelegate_box.value : "null")
            }
          }

        }


      }



    }

    // Add Restart Button

    Items.Label{
      id: config_change_label
      text: "Changes will take effect on restart."
      visible: false
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: config_view.bottom
      style: context.config['style']['current']
    }


}
