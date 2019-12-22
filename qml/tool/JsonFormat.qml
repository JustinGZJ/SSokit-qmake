import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import src.jsonformat 1.0

import "../widgets" as Widgets


ColumnLayout{
    JsonFormat{
        id:jsonFormat
    }
    TabBar {
        id: tabBar
        width: parent.width
        currentIndex: contentLayout.currentIndex
        Widgets.TopButton {
            name:"格式化"
        }
        Widgets.TopButton{
            name:"树形"
        }

    }
    StackLayout{
        id:contentLayout

        currentIndex: tabBar.currentIndex
        JsonFormatView{
            id:jsonFormatView
        }
        JsonTreeView{
            jsonModel: jsonFormat.jsonModel
        }
    }

    Shortcut{
        sequences: ["Ctrl+F"]
        onActivated: {
            jsonFormat.checkJonsStr(jsonFormatView.getText())
            jsonFormat.convertJsonToTree(jsonFormatView.getText())
        }

    }


    Component.onCompleted: {
        jsonFormat.formattedJson.connect(jsonFormatView.formattedJson)

    }

    Component.onDestruction: {
        jsonFormat.formattedJson.disconnect(jsonFormatView.formattedJson)
    }

}
