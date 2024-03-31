import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls

Item {
    id:root

    function processUrls(urls) {
        for (var i = 0; i < urls.length; ++i) {
            var url = urls[i];
            var fileExtension = url.toString().split('.').pop().toLowerCase();

            // Check for music file extensions
            if (["mp3", "wav", "flac", "aac", "m4a", "ogg"].indexOf(fileExtension) !== -1) {
                //root.musicDropped(url);
                var audioData = audioExtractor.loadAudio(url.toString().replace("file:///", ""));
               // console.log("audioData",JSON.stringify(audioData))
                console.log("audioName:",audioData.audioName)
                console.log("secondsToRead:",audioData.secondsToRead)
                console.log("sampleRate:",audioData.sampleRate)
                console.log("framesPerRead:",audioData.framesPerRead)
                console.log("numberOfChannels:",audioData.numberOfChannels)
                console.log("leftChannel",audioData.leftChannel.length)
                console.log("rightChannel",audioData.rightChannel.length)

                //console.log(arrayMagnitude[0])

            }
        }
    }

    Rectangle{
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        color: "transparent"
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
            ListView{
                id: listView
                width: parent.width
                height: parent.height
                model: musicModel
                spacing: 13
                ListModel{
                    id: musicModel
                    ListElement{
                        name:"Test TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest"
                        size:"458"
                        process:"100"
                        state:"rendering"
                    }
                    ListElement{
                        name:"Test"
                        size:"458"
                        process:"100"
                        state:"rendering"
                    }
                    ListElement{
                        name:"Test"
                        size:"458"
                        process:"100"
                        state:"rendering"
                    }
                }
                delegate: SongListItem {
                    width: listView.width * 0.95
                    anchors.horizontalCenter: parent.horizontalCenter

                    height: 50
                }
            }
        }
    }

}
