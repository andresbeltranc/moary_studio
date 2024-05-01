import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls.Basic
import QtQuick.Effects
import QtQuick.Layouts

import AudioSample 1.0

Rectangle {
    id:root

    color: master.currentTheme.dashboardBackgroundColor
    layer.enabled: true
    clip: true
    radius: 5
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
    ListModel{
        id: musicModel
    }
    function sampledAdded(sample){
        console.log("sampledAdded",sample)
        musicModel.append({fileName:sample.fileName, duration:sample.secondsToRead})
    }
    function listOfAudioSamplesChanged(){
        console.log( console.log("Changed listOfAudioSamples",listOfAudioSamples ))
    }
    // function newMusicSampledAdded(){
    //     console.log("newMusicSampledAdded")
    //     var audioSamples = currentProject.audioSamples

    //     console.log("new audioSamples", audioSamples)
    //     musicModel.clear()
    //     for(var i = 0; i < audioSamples.length; i++){
    //       //  musicModel.append(audioSamples[i])
    //         musicModel.insert(audioSamples[i])
    //         //var currentAudioSample = audioSamples[i]
    //         //console.log("name",currentAudioSample.fileName)
    //     }

    // }
    Component.onCompleted: {

        currentProject.audioSampleAdded.connect(sampledAdded)

        console.log("listOfAudioSamples",listOfAudioSamples )
        for(var i = 0; i < listOfAudioSamples.length; i++){

            var audioSample = listOfAudioSamples[i]
            musicModel.append({fileName:audioSample.fileName, duration:audioSample.secondsToRead})
        }
        currentProject.audioSamplesChanged.connect(listOfAudioSamplesChanged)

    }



    function processUrls(urls) {
        for (var i = 0; i < urls.length; ++i) {
            var url = urls[i];
            var fileExtension = url.toString().split('.').pop().toLowerCase();
            if (["mp3", "wav", "flac", "aac", "m4a", "ogg"].indexOf(fileExtension) !== -1) {
                var audioSample = audioController.getAudioSampleFromFile(url.toString().replace("file:///", ""));
               // songDuration = audioSample.secondsToRead
                currentProject.addAudioSample(audioSample)
                //listAmplituded = audioSample.interpolatedDataList
            }
        }
    }


    Rectangle{
        id: titleBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        radius: 2

        color: master.currentTheme.dashboardBackgroundColor
        layer.enabled: true
        layer.effect:MultiEffect {
            autoPaddingEnabled: true
            shadowBlur: 1.0
            shadowEnabled: true
            shadowVerticalOffset: 1
            shadowHorizontalOffset: 0
        }
        height: 30
        Text{
            text:" Music Samples"
            color: master.currentTheme.headerIconsWindowColor
            anchors.centerIn: parent
            font.pixelSize: 20
        }
    }

    Rectangle{
        id: listViewContainer
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        color: master.currentTheme.dashboardBackgroundColor
        clip: true
        MouseArea {
            anchors.fill: parent
            onClicked: fileDialog.open()
        }
        DropArea {
            anchors.fill: parent

            onDropped:function(drag) {
                console.log(drag.text)
                root.processUrls(drag.urls);
            }
        }
        FileDialog {
             id: fileDialog
             title: "Select a Music File"
             nameFilters: ["Music files (*.mp3 *.wav *.flac *.aac *.m4a *.ogg)"]
             onAccepted: {
                root.processUrls(fileDialog.fileUrls);
             }
         }

        ScrollView{
            anchors.fill: parent
            anchors.topMargin: 10
            anchors.leftMargin: 5
            ListView{
                id: listView
                width: parent.width
                height: parent.height
                model: musicModel
                spacing: 13

                delegate: SongListItem {
                    width: listView.width * 0.95
                    //anchors.horizontalCenter: parent.horizontalCenter
                    height: 60
                }
            }
        }
    }

}
