import QtQuick 
import "../"
import org.Moary 1.0
import QtQuick.Effects
import CustomQml 1.0
import QtQuick.Controls.Basic
import QtQuick.Layouts
import AudioSample 1.0
import MusicProject 1.0
import "../../common/text"
import "../../common/shape"

Rectangle{
    id: dashboardItem
    width: parent.width
    height: parent.height
    color:"transparent"
    property var listAmplituded: []
    property real songDuration: 0

    property MusicProject currentProject: projectController.currentProject
    property var audioController: currentProject.audioController
    property AudioSample currentAudioSample: currentProject.currentAudioSample
    property var listOfAudioSamples: currentProject.audioSamples

    onCurrentAudioSampleChanged: {
        console.log("new audio Sample Selected",currentAudioSample)

        if(currentAudioSample != null){
            var audioSample = audioController.getAudioSampleFromFile(currentAudioSample.filePath)
            dashboardItem.listAmplituded = audioSample.interpolatedDataList
            dashboardItem.songDuration = audioSample.secondsToRead
        }
    }
    Component.onCompleted: {
        console.log("listOfAudioSamples Dashboard",listOfAudioSamples)
    }



    DragDropSong{
        id: dragDropSong
        anchors.left: parent.left
        width: 300
        anchors.top: parent.top
        anchors.bottom: panelControl.top
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.topMargin: 15
        anchors.bottomMargin: 15
    }
    Viewer3D{
        id: viewer3D
        anchors.left: dragDropSong.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: panelControl.top
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.topMargin: 15
        anchors.bottomMargin: 15


    }
    Rectangle{
        id: panelControl
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height/3.5
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.topMargin: 15
        anchors.bottomMargin: 15
        anchors.bottom: parent.bottom
        color: master.currentTheme.dashboardBackgroundColor
        radius: 5
        layer.enabled: true
        layer.effect:MultiEffect {
            //source: buttonBackground
            //anchors.fill: buttonBackground
            autoPaddingEnabled: true
            shadowBlur: 1.0
            shadowEnabled: true
            shadowVerticalOffset: 3
            shadowHorizontalOffset: 1
            //opacity: button.pressed ? 0.75 : 1.0
        }

        Rectangle{
            id: timeLineContainer
            height: 30
            anchors.left: parent.left
            anchors.right: parent.right
            color: master.currentTheme.dashboardBackgroundColor
            layer.enabled: true
            layer.effect:MultiEffect {
                autoPaddingEnabled: true
                shadowBlur: 1.0
                shadowEnabled: true
                shadowVerticalOffset: 1
                shadowHorizontalOffset: 0
            }
            Rectangle{
                id: timeLineGeneralActions
                width: parent.width * 0.10
                height: parent.height
                color: "transparent"

                MoaryText{
                    id: timeLineText
                    text: "Tracks"
                    //font.family: master.currentTheme.projectFont.name
                    font.pixelSize: 18
                    color: master.currentTheme.headerIconsWindowColor
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                id: timeLineMetricsContainer
                anchors.left: timeLineGeneralActions.right
                anchors.right: parent.right
                height: parent.height
                color: "transparent"

                // Create tick marks\
                RowLayout{
                    id: columnTicks
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: 5
                    Repeater {
                        model: 30
                        Rectangle {
                            width: 2
                            height: 10
                            color: master.currentTheme.headerIconsWindowColor
                        }
                    }
                }
            }
        }
        ScrollView{
            id: scrollTracks
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: timeLineContainer.bottom
            anchors.bottom: parent.bottom
            ColumnLayout{
                id: columnTracks
                width: parent.width

                spacing: 10


                Rectangle{
                    id: amplitudeRect
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 70
                    color: master.currentTheme.dashboardBackgroundColor
                    Layout.topMargin: 5

                    layer.enabled: true
                    layer.effect:MultiEffect {
                        autoPaddingEnabled: true
                        shadowBlur: 1.0
                        shadowEnabled: true
                        shadowVerticalOffset: 1
                        shadowHorizontalOffset: 0
                    }

                    Rectangle{
                        id: amplitudTrackInteractive
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        width: parent.width * 0.10
                        color: master.currentTheme.dashboardBackgroundColor

                        layer.enabled: true
                        layer.effect:MultiEffect {
                            autoPaddingEnabled: true
                            shadowBlur: 1.0
                            shadowEnabled: true
                            shadowVerticalOffset: 0
                            shadowHorizontalOffset: 1
                        }

                        MoaryText{
                            id: trackTitle
                            text: "Amplitude"
                           //font.family: master.currentTheme.projectFont.name
                            font.pixelSize: 16
                            color: master.currentTheme.headerIconsWindowColor
                            anchors.centerIn: parent
                        }
                    }
                    CustomQml{
                        anchors.left: amplitudTrackInteractive.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        anchors.bottom: parent.bottom
                        lineColor: master.currentTheme.headerIconsWindowColor
                        amplitudeData: dashboardItem.listAmplituded
                        duration: dashboardItem.songDuration // Total duration in seconds
                       // color: master.currentTheme.dashboardBackgroundColor


                    }
                }
            }
        }





    }

}


