import QtQuick 2.15
import QtQuick.Controls
import "../shape"
import "../text"

Popup {
    id: moaryPopup
    closePolicy: Popup.CloseOnEscape
    modal: true
    focus: true

    topInset: -15
    leftInset: -25
    rightInset: -25
    bottomInset: -25

    background: MoaryRectangle{
        border.width: 2
        border.color: master.currentTheme.headerIconsWindowColor
        color: master.currentTheme.dashboardBackgroundColor
        effectBrightness: 0
        radius: 5
        Rectangle{
            width: 25
            height: 25
            color: "transparent"
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            MoaryRectangle{
                width: 3
                height: parent.height * 0.7
                color: master.currentTheme.headerIconsWindowColor
                rotation: 45
                anchors.centerIn: parent
                radius: 4


            }
            MoaryRectangle{
                width: parent.height * 0.7
                height: 3
                rotation: 45
                color: master.currentTheme.headerIconsWindowColor
                anchors.centerIn: parent
                radius: 4
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    moaryPopup.close()
                }
            }
        }
    }
}
