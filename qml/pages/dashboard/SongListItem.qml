import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: songItem
    property bool currentItem: false

    Component.onCompleted: {
        dashboardItem.onCurrentSongObjectChanged.connect(function(obj){
            if(obj === songItem){
                currentItem = true
            }else{
                currentItem = false
            }
        })
    }
    Rectangle{
        id: songRect
        anchors.fill: parent
        color: master.currentTheme.dashboardBackgroundColor
        layer.enabled: true
        radius: 5
        layer.effect: DropShadow {
            color: currentItem ? "white" :master.currentTheme.headerIconsWindowColor
            radius: 5
            horizontalOffset: 0
            verticalOffset: 0.5
        }
        MouseArea{
            id: textMouseArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {

                if (rectFileName.width < textFileName.contentWidth) {
                    if(!textScrollAnimation.running){
                        textScrollAnimation.running = true;
                    }
                }
            }
            onExited:{
                if(textScrollAnimation.running){
                    textScrollAnimation.running = false;
                    textFileName.x = 0
                }
            }
            onClicked: {
                if(dashboardItem.currentSongObject != songItem){
                    dashboardItem.currentSongObject = songItem
                    currentItem = true
                }
            }

        }
        Rectangle{
            id:rectFileName
            anchors.leftMargin: 5
            width: parent.width * 0.96
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height/3
            clip: true
            color: "transparent"

            Text {
                id: textFileName
                width: parent.width
                verticalAlignment: Text.AlignVCenter
                color: master.currentTheme.headerIconsWindowColor
                text: name
                font.bold: true
                NumberAnimation on x {
                    id: textScrollAnimation
                    from: 0
                    to: rectFileName.width - textFileName.contentWidth - 20
                    duration: 5000
                    easing.type: Easing.Linear
                    loops: Animation.Infinite
                    running: false
                }
            }
        }

        // Text {
        //     id: songName
        //     text: name
        //     color: master.currentTheme.headerIconsWindowColor
        //     font.pixelSize: 15
        //     anchors.left: parent.left
        //     anchors.leftMargin: 10
        //     //anchors.verticalCenter: parent.verticalCenter
        // }
    }
}
