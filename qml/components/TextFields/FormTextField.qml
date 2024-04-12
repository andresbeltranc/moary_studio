import QtQuick.Controls.Basic

import "../../common/shape"
TextField {
    id: projectName
    placeholderText: qsTr("Enter Project Name")
    font.pixelSize: 20
    //font.family: master.currentTheme.projectFont.name
    color: master.currentTheme.headerIconsWindowColor
    background: MoaryRectangle {
        border.width: 1
        border.color: master.currentTheme.headerIconsWindowColor
        color: "transparent"
        effectBrightness: 0
        radius: 5
    }
}
