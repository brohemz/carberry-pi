import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import "../items" as Items


Rectangle {
    id: internal_rectangle

    property var context: null
    property var list: null

    width: parent.width
    height: 40
    color: "steelblue"

    Items.Label{
      id: header_time
      text: context.config['show-time']['current'] && !list['info'] ? context.time: ""
      style: context.config['style']['current']
      font.bold: true
      visible: !list['info'] && context.config['show-time']['current']
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter
    }

    Component.onCompleted: function(){
      if(context['diagnostics']['code-exists']){
        // pageLoader.sourceComponent = "header_engine_code"
        console.log("EngineCode Loaded!")
      }
    }

    onListChanged: function(){
      header_info.visible = list['info']
      header_time.visible = !list['info']
    }

    Items.Label{
      id: header_info
      text: list['text']
      style: context.config['style']['current']
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter
    }


    Loader{
      id: pageLoader

      sourceComponent: internal_rectangle.context.diagnostics['code-exists'] ? header_engine_code_component : undefined

      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter

      property var loader_style: internal_rectangle.context.config['style']['current']

      Component{
        id: header_engine_code_component
        Items.EngineCode{
          id: header_engine_code
          amount: 2
          style: loader_style
          stack: internal_rectangle.list['stack']
        }

      }

    }



}
