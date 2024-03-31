import QtQuick
import "../"
Rectangle{
    width: parent.width
    height: parent.height
    color:"transparent"


    DragDropSong{
        id: dragDropSong
        anchors.left: parent.left
        width: 250
        anchors.top: parent.top
        anchors.bottom: panelControl.top
    }
    Viewer3D{
        id: viewer3D
        anchors.left: dragDropSong.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: panelControl.top


    }
    Rectangle{
        id: panelControl
        width: parent.width
        height: parent.height/3.5
        anchors.bottom: parent.bottom
        color: "transparent"

    }

}
