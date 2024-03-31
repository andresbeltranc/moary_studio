import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Basic

Item {
    id: root_header
    width: parent.width
    height: parent.height
    Rectangle{
        id: root_rect
        anchors.fill: parent
        color: master.currentTheme.headerBackgroundColor
        MouseArea {
            id: dragArea
            anchors.fill: parent
            property point dragPosition
            property point dragPositionWhenMax
            property bool fromMaxtoNormal : false


            onPressed: {
                dragPosition = Qt.point(mouseX, mouseY)
            }


            onPositionChanged: {
                if (dragArea.pressed) {

                    root_window.x += mouseX - dragPosition.x
                    root_window.y += mouseY - dragPosition.y

                }
            }
        }
        onWindowChanged:{
            console.log(root_window.visibility)
        }

        function windowClose() {
            root_window.close();
        }

        function windowMaximize() {
            root_window.visibility = Window.Maximized;
            console.log(root_window.visibility)
        }

        function windowRestore() {
            root_window.visibility = Window.Windowed;
            root_window.x = 480

            console.log(root_window.visibility)

        }

        function windowIconified() {

            root_window.visibility = Window.Minimized;
        }

        Text {
            height: parent.height
            width: paintedWidth
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: qsTr("Moary Studio")
            color: master.currentTheme.headerTitleColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

        }

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
                text: root_window.visibility === Qt.WindowMaximized ? "🗖": "🗗"
                color: master.currentTheme.headerIconsWindowColor
                font.bold: parent.font.bold
                font.pixelSize: parent.font.pixelSize
            }
            background: Rectangle{
                anchors.fill: parent
                color:"transparent"
            }
            onClicked: {
                if (root_window.visibility === Window.Maximized) {
                    root_window.visibility = Window.Windowed;
                } else {
                    root_window.visibility = Window.Maximized;
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
            }
            background: Rectangle{
                anchors.fill: parent
                color:"transparent"
            }
            onClicked: root_rect.windowClose()
        }
    }
}
