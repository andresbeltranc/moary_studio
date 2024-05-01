import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../pages/dashboard"
import "../pages/Project"

import "../layouts"
import Qt5Compat.GraphicalEffects


Window {
    id: mainWindow
    width: Screen.width * 0.6
    minimumWidth: 800
    height:  Screen.height * 0.7
    minimumHeight: 600
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"


    function changeLoaderSource(source){
        //mainWindowLoader.source = ""
        mainWindowLoader.source = source
    }
    Timer {
        id: redrawTimer
        interval: 100
        onTriggered: {
            root.width  = mainWindow.width
            root.height = mainWindow.height
        }
    }
    Component.onCompleted: {
        windowController.restoreAndMoveWindow(mainWindow)
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
        mainWindow.visible= true
        mainWindow.raise()


    }
    Rectangle{
        id: root
        width: parent.width
        height: parent.height
        color: master.currentTheme.dashboardBackgroundColor
        border.width: 2
        border.color: master.currentTheme.headerBackgroundColor
        radius: 10
        clip: true


        Header{
            id: header
            objectName: "header"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            Layout.fillWidth: true
            height: 30
        }
        Loader{
            id: mainWindowLoader
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            Component.onCompleted: {
                mainWindowLoader.source = "qrc:/qml/pages/Project/LoadProject.qml"
            }
        }
    }
}
