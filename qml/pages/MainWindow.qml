import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../pages/dashboard"
import "../pages/Project"

import "../layouts"
import Qt5Compat.GraphicalEffects


Window {
    id: root_window
    width: 1000
    minimumWidth: 800
    height: 800
    minimumHeight: 600
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"
    Timer {
        id: redrawTimer
        interval: 100
        onTriggered: {
            root.width  = root_window.width
            root.height = root_window.height
        }
    }
    Component.onCompleted: {
        console.log("onCl")
        windowController.restoreAndMoveWindow(root_window)
        root_window.visible= true
        root_window.raise()


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
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            Layout.fillWidth: true
            height: 30
        }

        LoadProject{
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

        }

        // Dashboard{
        //     anchors.top: header.bottom
        //     anchors.left: parent.left
        //     anchors.right: parent.right
        //     anchors.bottom: parent.bottom
        //     Layout.fillWidth: true
        //     Layout.fillHeight: true
        // }

    }
}
