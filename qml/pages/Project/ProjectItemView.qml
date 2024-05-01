import QtQuick 2.15
import "../../common/text"
import "../../common/shape"

Item {
    id: projectItem

   // property var model: {}

    signal clicked();

    Rectangle{
        id: projectRect
        color: "transparent"
        anchors.fill: parent
        MouseArea{
            id: projectItemMouseArea
            anchors.fill: parent
            onClicked: {
                projectItem.clicked()
            }
        }
        MoaryText{
            id: projectName
            text: model.name
            font.pixelSize: 16
            color: master.currentTheme.headerIconsWindowColor
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 10

        }
        MoaryText{
            id: projectPath
            text: model.path
            font.pixelSize: 10
            color: master.currentTheme.headerIconsWindowColor
            anchors.top: projectName.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
        MoaryText{
            id: lastOpened
            text: model.lastModifiedDate
            font.pixelSize: 10
            color: master.currentTheme.headerIconsWindowColor
            anchors.right: parent.right
            width: paintedWidth
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 5
        }
    }
}
