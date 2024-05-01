import QtQuick 2.15
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtCore
import QtQuick.Dialogs
import "../../common/popups"
import "../../common/text"
import "../../common/shape"
import "../../components/TextFields"
import "../../components/Buttons"

MoaryPopup {
    Overlay.modal: Rectangle {
        color: "#CC181818" // Use whatever color/opacity you like
    }
    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"
        MoaryText{
            id: newProjectText
            text: qsTr("New Project")
            font.pixelSize: 30
            font.bold: true
            font.family: master.currentTheme.projectFont.name
            color: master.currentTheme.headerIconsWindowColor
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.topMargin: 20
        }

        GridLayout {
            id: grid
            columns: 3
            anchors.top: newProjectText.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            rowSpacing: 20

            //spacing: 20
            MoaryText {
                text: qsTr("Project Name:")
                font.pixelSize: 20
                font.bold: true
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                Layout.rightMargin: 10
            }
            FormTextField {
                id: projectName
                placeholderText: qsTr("Enter Project Name")
                font.pixelSize: 20
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                Layout.preferredHeight: 35

            }
            Rectangle{
                id: t
                Layout.fillHeight: true
                Layout.fillWidth: true
                color:"transparent"
            }
            MoaryText{
                text:qsTr("Project Location:")
                font.pixelSize: 20
                font.bold: true
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                Layout.rightMargin: 10


            }
            FormTextField {
                id: projectLocation
                placeholderText: qsTr("select the project location")
                font.pixelSize: 20
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                Layout.maximumWidth: 400
                Layout.preferredHeight: 35
                Layout.rightMargin: 10

            }
            FolderDialog {
                id: folderDialog
                currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
                onAccepted: {
                    var path = String(folderDialog.currentFolder)
                    projectLocation.text = path.replace("file:///", "")
                }
            }
            GeneralButton{
                id: selectFolderBtn
                text: qsTr("🗁")
                currentBrightness: 0.2

                Layout.preferredHeight: 30
                Layout.preferredWidth: 35
                textColor: master.currentTheme.headerIconsWindowColor
                border.color: master.currentTheme.headerIconsWindowColor
                onClicked: {
                    folderDialog.open()
                }
            }
        }


        GeneralButton{
            id: createProjectBtn

            anchors.bottom: parent.bottom
            //anchors.bottomMargin: 10
            anchors.right: parent.right
            //anchors.rightMargin: 20
            text: qsTr("Create")
            height: 35
            width: 80
            textColor: "#00987E"
            border.color: "#00987E"
            onClicked: {
                var path =  String((projectLocation.text)).replace("file:///", "")


                projectController.createProject(0,projectName.text, projectLocation.text,"andres")

            }
        }


        // RowLayout {
        //     anchors.top: newProjectText.bottom
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     spacing: 20
        //     MoaryText {
        //         text: qsTr("Project Name")
        //         font.pixelSize: 20
        //         font.bold: true
        //         font.family: master.currentTheme.projectFont.name
        //         color: master.currentTheme.headerIconsWindowColor
        //     }
        //     TextField {
        //         id: projectName
        //         placeholderText: qsTr("Enter Project Name")
        //         font.pixelSize: 20
        //         font.family: master.currentTheme.projectFont.name
        //         color: master.currentTheme.headerIconsWindowColor
        //         width: 250
        //     }
        // }


    }
}
