import QtQuick 2.15
import QtQuick.Controls.Basic
import QtQuick.Layouts
import "../../common/popups"
import "../../common/text"
import "../../common/shape"
import "../../components/TextFields"

MoaryPopup {
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
            columns: 2
            anchors.top: newProjectText.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            rowSpacing: 20

            //spacing: 20
            MoaryText {
                text: qsTr("Project Name")
                font.pixelSize: 20
                font.bold: true
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
            }
            FormTextField {
                id: projectName
                placeholderText: qsTr("Enter Project Name")
                font.pixelSize: 20
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                width: 250

            }
            MoaryText{
                text:qsTr("Project Location:")
                font.pixelSize: 20
                font.bold: true
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor

            }
            FormTextField {
                id: projectLocation
                placeholderText: qsTr("Enter Project Location:")
                font.pixelSize: 20
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                width: 250
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
