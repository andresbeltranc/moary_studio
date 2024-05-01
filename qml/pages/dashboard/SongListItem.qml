import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import "../../common/shape"
import "../../common/text"
import QtQuick.Effects

Item {
    id: songItem
    property bool currentItem: false

    Component.onCompleted: {
        // dashboardItem.onCurrentSongObjectChanged.connect(function(obj){
        //     if(obj === songItem){
        //         currentItem = true
        //     }else{
        //         currentItem = false
        //     }
        // })
    }
    MoaryRectangle{
        id: songRect
        anchors.fill: parent
        color: master.currentTheme.dashboardBackgroundColor
        radius: 4
        border.width: 0
       // border.color: master.currentTheme.headerIconsWindowColor
        effectBrightness: 0.0
        layer.enabled: true
        layer.effect:MultiEffect {
            //source: buttonBackground
            //anchors.fill: buttonBackground
            //shadowColor: master.currentTheme.headerIconsWindowColor
            autoPaddingEnabled: true
            shadowBlur: 0.8
            shadowScale: 1.019
            shadowEnabled: true
            shadowVerticalOffset: 0
            shadowHorizontalOffset: 0
            //opacity: button.pressed ? 0.75 : 1.0
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
            id:rectImage
            anchors.top: parent.top
            anchors.left: parent.left
            width: parent.width * 0.15
            height: parent.height
            color: "transparent"
            MoaryText{
                font.pixelSize: 30
                text:"𝄞"
                anchors.top: parent.top
                anchors.topMargin: 2
                font.bold: true
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                flickerAnimation: true
                anchors.centerIn: parent
            }

        }
        Rectangle{
            id:rectSampleContent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: rectImage.right
            anchors.right: sampleActions.left
            color: "transparent"

            Text{
                id: titleName
                font.pixelSize: 12
                text:"File Name:"
                anchors.top: parent.top
                anchors.topMargin: 3
                anchors.left: parent.left
                anchors.right: parent.right
                height: paintedHeight
                font.bold: true
                //font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                //flickerAnimation: true
            }
            Rectangle{
                id:rectFileName
                anchors.top: titleName.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height/3
                clip: true
                color: "transparent"

                Text {
                    id: textFileName
                    width: parent.width
                    verticalAlignment: Text.AlignVCenter
                    color: master.currentTheme.headerIconsWindowColor
                    text: model.fileName
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
            Text{
                id:sampleDuration
                font.pixelSize: 12
                text:"Duration: " + model.duration
                anchors.top: rectFileName.bottom
                anchors.topMargin: 3
                anchors.left: parent.left
                anchors.right: parent.right
                height: paintedHeight
                font.bold: true
                //font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                //flickerAnimation: true
            }

            MouseArea{
                id: loadAsCurrentSample
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    currentAudioSample = listOfAudioSamples[model.index]
                }
            }

        }
        Rectangle{
            id:sampleActions
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: parent.width * 0.10
            color: "transparent"
            MoaryText{
                id:playSample
                font.pixelSize: 16
                text:"II"
                anchors.top: sampleActions.top
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.right: parent.right
                height: paintedHeight
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                //font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor
                //flickerAnimation: true
            }
            MoaryText{
                id:deleteSample
                font.pixelSize: 16
                text:"✘"
                anchors.bottom: sampleActions.bottom
                anchors.bottomMargin: 5
                anchors.left: parent.left
                anchors.right: parent.right
                height: paintedHeight
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                //font.family: master.currentTheme.projectFont.name
                color: "red"
                //flickerAnimation: true

                MouseArea{
                    id: deleteSampleMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        console.log("model index",model.index)
                        currentProject.deleteAudioSample(listOfAudioSamples[model.index])
                        musicModel.remove(model.index)
                    }
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
