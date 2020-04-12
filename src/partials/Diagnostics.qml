/*
* File: Diagnostics.qml
* Description: Diagnostics screen that displays various engine information in a
*               scrollable table.
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
import "../items" as Items


Frame{
    id: root_diagnostics
    property var context: null
    property alias props: diagnostics_model
    // property var time: context.time

    property var ignore_list: {
          'connection-established' : true,
          'STATUS': true,
        }

    clip: true

    implicitWidth: 700
    implicitHeight: 420

    // onTimeChanged: {console.log("hi")}

    ListView {

      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter

      id: diagnostics_view

      implicitHeight: root_diagnostics.implicitHeight - 50
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
                  this.append(entry);
              }


              if(this.count == 0)
                this.append({'key': "Response", 'value': "No Content to Display"})


          }

          Component.onCompleted: refreshModel()

        }




        delegate: diagnosticsDelegate

        Component {
          id: diagnosticsDelegate

          Item{
            id: diagnosticsItem
            width: diagnostics_view.implicitWidth

            function get_preferred_height(){
              var w_key = model.key.length
              // var w_val = context.diagnostics[model.key].toString().length
              var w_val = model.value.length
              var ret = '';
              if(w_key > w_val)
                ret = w_key;
              else
                ret = w_val;
              // return (Math.pow(40, ret / (diagnosticsItem.width / 2) + 1)) + 20;
              ret = (ret / 40) * 45;
              return ret > 50 ? ret : 50;
            }

            height: get_preferred_height();
            clip: true

              Items.Rectangle{
                style: context.config['style']['current']
                width: parent.width
                height: parent.height - 10

                Row{
                  anchors.fill: parent

                  Column{
                    anchors.rightMargin: 25
                    clip: true
                    height: parent.height
                    width: parent.width / 2
                    Items.Label {
                      text: model.key
                      width: parent.width
                      style: context.config['style']['current']
                    }
                  }

                  Items.Rectangle{
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width: 5;
                    height: parent.height - 10;
                    style: "inverted_" + context.config['style']['current']
                  }

                  Column{
                    anchors.leftMargin: 25
                    clip: true
                    height: parent.height
                    width: parent.width / 2
                    Items.Label {
                      text: model.value
                      width: parent.width
                      style: context.config['style']['current']
                    }
                  }
                }
              }

          }

        }

    }

    // Row{
    //   anchors.top: diagnostics_view.bottom
    //   anchors.topMargin: 20
    //   anchors.horizontalCenter: parent.horizontalCenter
    //   Column{
    //     Items.Button{
    //       text: "Refresh"
    //       style: context.config['style']['current']
    //       onClicked: function(){
    //         // setTimeout(function(){""}, 1000)
    //         diagnostics_model.refreshModel()
    //       }
    //     }
    //   }
    // }


}
