import QtQuick 2.15
import QtQuick.Controls.Basic
import QtQuick.Effects
import "../common/text"

Rectangle{
    id: root_rect
   // anchors.fill: parent
    color: master.currentTheme.headerBackgroundColor
    layer.enabled: true

    layer.effect:MultiEffect {
        //source: buttonBackground
        //anchors.fill: buttonBackground
        autoPaddingEnabled: true
        shadowBlur: 1.0
        shadowEnabled: true
        shadowVerticalOffset: 1
        shadowHorizontalOffset: 0

        //opacity: button.pressed ? 0.75 : 1.0
    }


    Component.onCompleted: {
        console.log(root_rect.childrenRect)
    }
    // MouseArea {
    //     id: dragArea
    //     anchors.fill: parent
    //     property point dragPosition
    //     property point dragPositionWhenMax
    //     property bool fromMaxtoNormal : false


    //     onPressed: {
    //         dragPosition = Qt.point(mouseX, mouseY)
    //     }


    //     onPositionChanged: {
    //         if (dragArea.pressed) {

    //             mainWindow.x += mouseX - dragPosition.x
    //             mainWindow.y += mouseY - dragPosition.y

    //         }
    //     }
    // }
    // onWindowChanged:{
    //     console.log(mainWindow.visibility)
    // }

    function windowClose() {
        mainWindow.close();
    }

    function windowMaximize() {
        mainWindow.visibility = Window.Maximized;
        console.log(mainWindow.visibility)
    }

    function windowRestore() {
        mainWindow.visibility = Window.Windowed;
        mainWindow.x = 480

        console.log(mainWindow.visibility)

    }

    function windowIconified() {

        mainWindow.visibility = Window.Minimized;
    }
    MoaryText{
        id: moaryTitle
        text: qsTr("MS")
        font.pixelSize: 16
        height: parent.height
        width: moaryTitle.contentWidth
        anchors.left: parent.left
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 10
        anchors.topMargin: 10
        font.bold: true
        font.family: master.currentTheme.projectFont.name
        color: master.currentTheme.headerIconsWindowColor
        flickerAnimation: true
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                projectController.currentProject = null
                mainWindow.changeLoaderSource("qrc:/qml/pages/Project/LoadProject.qml")
            }
        }

    }
    MoaryText{
        id: moaryCurrentProject
        text: projectController.currentProject === null ? qsTr("") : projectController.currentProject.name
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 2
        font.bold: true
        font.family: master.currentTheme.projectFont.name
        color: master.currentTheme.headerIconsWindowColor
        anchors.horizontalCenter: parent.horizontalCenter
        flickerAnimation: true

    }

    // Text {
    //     height: parent.height
    //     width: paintedWidth
    //     anchors.left: parent.left
    //     anchors.leftMargin: 10
    //     font.family: master.currentTheme.projectFont.name
    //     text: qsTr("Moary Studio")
    //     color: master.currentTheme.headerIconsWindowColor
    //     horizontalAlignment: Text.AlignHCenter
    //     verticalAlignment: Text.AlignVCenter

    // }

    // Minimize Button
    Button {
        id: minimize_button
        height: parent.height
        width: 25
        anchors.right: max_res_button.left
        background: Rectangle{
            anchors.fill: parent
            anchors.centerIn: parent
            color:"transparent"
        }
        contentItem: Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "--"
            color: master.currentTheme.headerIconsWindowColor
            font.bold: parent.font.bold
            font.pixelSize: parent.font.pixelSize
            layer.enabled: true
            layer.effect: MultiEffect{
                brightness: 0.3
                saturation: 0.5
                blurEnabled: true
                blurMax: 30
                blur: 0.1

            }
        }
        onClicked:{
            console.log("click")
            root_rect.windowIconified()
        }
    }

    // Maximize/Restore Button
    Button {
        id: max_res_button
        height: parent.height
        width: 25
        anchors.right: close_button.left

        contentItem: Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: mainWindow.visibility === Qt.WindowMaximized ? "🗖": "🗗"
            color: master.currentTheme.headerIconsWindowColor
            font.bold: parent.font.bold
            font.pixelSize: parent.font.pixelSize
            layer.enabled: true
            layer.effect: MultiEffect{
                brightness:  0.3
                saturation: 0.5
                blurEnabled: true
                blurMax: 30
                blur: 0.1

            }

        }
        background: Rectangle{
            anchors.fill: parent
            color:"transparent"
        }
        onClicked: {
            if (mainWindow.visibility === Window.Maximized) {
                mainWindow.visibility = Window.Windowed;
            } else {
                mainWindow.visibility = Window.Maximized;
            }
        }
    }

    // Close Button
    Button {

        id: close_button

        height: parent.height
        width: 25
        anchors.right: parent.right


        contentItem: Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "x"
            color: master.currentTheme.headerIconsWindowColor
            font.bold: parent.font.bold
            font.pixelSize: 16
            layer.enabled: true
            layer.effect: MultiEffect{
                brightness:  0.3
                saturation: 0.5
                blurEnabled: true
                blurMax: 30
                blur: 0.1

            }
        }
        background: Rectangle{
            anchors.fill: parent
            color:"transparent"
        }
        onClicked: root_rect.windowClose()
    }
}

