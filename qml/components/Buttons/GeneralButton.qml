import QtQuick 2.15

import "../../common/shape"
import "../../common/text"

MoaryRectangle{
    id: generalButton

    property real currentBrightness: 0.2
    property string textColor: master.currentTheme.headerIconsWindowColor

    effectBrightness: generalButton.currentBrightness
    property string text: ""
    radius: 4
    border.width: 1
    border.color: master.currentTheme.headerIconsWindowColor
    // flickerAnimation: true
    // color: master.currentTheme.headerIconsWindowColor

    signal clicked()
    signal entered()
    signal exited()


    MoaryText{
        id: generalButtonText
        text: generalButton.text
        font.pixelSize: 20
        font.bold: true
        effectBrightness: generalButton.currentBrightness
        font.family: master.currentTheme.projectFont.name
        color: generalButton.textColor
        anchors.centerIn: parent
    }
    MouseArea{
        id: newProjectMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            generalButton.clicked()
        }
        onEntered: {
            generalButton.currentBrightness = 0.5
            generalButton.entered()
        }
        onExited: {
            generalButton.currentBrightness = 0.2
            generalButton.exited()

        }
    }
}
