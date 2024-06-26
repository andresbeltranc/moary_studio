import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Layouts
import "../../common/text"
import "../../common/shape"

Rectangle{
    id: loadProject
    color:"transparent"

    Component.onDestruction: {
        console.log("remove loadProject page")
    }

    CreateProjectPopup{
        id: createProjectPopup
        visible: false
        property int maxWidth: 800
        property int maxHeight:600

        width: Math.min(parent.width * 0.6, maxWidth)
        height: Math.min(parent.height * 0.5, maxHeight)
        anchors.centerIn: parent
    }



    Rectangle{
        anchors.horizontalCenter:  parent.horizontalCenter
        width: parent.width * 0.9
        height: parent.height
        color:"transparent"

        MoaryText{
            id: moaryTitle
            text: qsTr("Moary Studio")
            font.pixelSize: 35
            anchors.top: parent.top
            anchors.topMargin: 20
            font.bold: true
            font.family: master.currentTheme.projectFont.name
            color: master.currentTheme.headerIconsWindowColor
            anchors.horizontalCenter: parent.horizontalCenter
            flickerAnimation: true

        }
        Rectangle{
            id: projectsRect
            color: "transparent"
            anchors.top: moaryTitle.bottom
            anchors.bottom: parent.bottom
            width: parent.width * 0.6
            MoaryText{
                id: projectsSubtitle
                text: qsTr("Projects")
                font.pixelSize: 25
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.topMargin: 10
                // font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor

            }

            Rectangle{
                id: testR
                height: 1
                width: projectList.width
                color: master.currentTheme.headerIconsWindowColor
                radius: 5
                anchors.top: projectsSubtitle.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 20
                property real effectBrightness: 0.2
                property bool flickerAnimation: true

                layer.enabled: true
                layer.effect:MultiEffect{
                    id: multiEffect
                    brightness: testR.effectBrightness
                    saturation: 0.5
                    blurEnabled: true
                    blurMax: 30
                    blur: 0.1
                    SequentialAnimation {
                        loops: Animation.Infinite
                        running: testR.flickerAnimation
                        // Animate each letter's opacity
                        PropertyAnimation {
                            target: multiEffect
                            property: "brightness"
                            from: 0.5 // Initial opacity (adjust as desired)
                            to: 0.1
                            duration: 5000 // Duration of one pulse (in milliseconds)
                        }
                        PropertyAnimation {
                            target: multiEffect
                            property: "brightness"
                            from: 0.1// Initial opacity (adjust as desired)
                            to: 0.5
                            duration: 5000 // Duration of one pulse (in milliseconds)
                        }

                        // Pause between letters (adjust as needed)
                        // PauseAnimation { duration: 100 }
                    }

                }



            }

            Rectangle{
                id: projectList
                color:"transparent"
                anchors.top: projectsSubtitle.bottom
                anchors.topMargin: 20
                anchors.bottomMargin: 10
                anchors.leftMargin: 20
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                width: parent.width
                property var listOfProjects: []
                ListModel{
                    id: moaryProjects
                }
                ListView{
                    id: projectListView
                    anchors.fill: parent
                    spacing: 30
                    Component.onCompleted: {
                        projectList.listOfProjects = projectController.projectsList
                        for (var i = 0; i < projectList.listOfProjects.length; i++){
                            var currentProject = projectList.listOfProjects[i]
                            moaryProjects.append(currentProject)
                        }
                        model = moaryProjects
                    }

                    delegate: ProjectItemView{
                        id: projectItem
                        width: parent.width
                        height: 50
                        onClicked: {
                            var currentProjectObject = projectController.projectsList[index]
                            projectController.setCurrentProject(currentProjectObject)
                            currentProjectObject.loadAudioSamplesFromLocalStorage()
                            mainWindow.changeLoaderSource("qrc:/qml/pages/dashboard/Dashboard.qml")
                            ///console.log("clicked",projectController.currentProject.name)
                        }
                    }
                }
            }
        }
        Rectangle{
            id: getStarted
            color: "transparent"
            anchors.top: moaryTitle.bottom
            anchors.bottom: parent.bottom
            anchors.left: projectsRect.right
            anchors.right: parent.right
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            MoaryText{
                id: getStartedSubtitle
                text: qsTr("Get started")
                font.pixelSize: 25
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.top: parent.top
                anchors.topMargin: 10
                font.family: master.currentTheme.projectFont.name
                color: master.currentTheme.headerIconsWindowColor

            }

            MoaryRectangle{
                width: 200
                height: 50
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.top: getStartedSubtitle.bottom
                anchors.topMargin: 10
                effectBrightness: newprojectIcon.currentBrightness

                radius: 4
                border.width: 1
                border.color: master.currentTheme.headerIconsWindowColor
                // flickerAnimation: true
                // color: master.currentTheme.headerIconsWindowColor

                Rectangle{
                    id: newprojectIcon
                    width: 50
                    height: parent.height
                    property real currentBrightness: 0.2
                    color: "transparent"
                    MoaryRectangle{
                        width: 2
                        height: parent.height * 0.55
                        effectBrightness: newprojectIcon.currentBrightness
                        color: master.currentTheme.headerIconsWindowColor
                        anchors.centerIn: parent
                        radius: 4


                    }
                    MoaryRectangle{
                        width: parent.height * 0.55
                        height: 2
                        effectBrightness: newprojectIcon.currentBrightness
                        color: master.currentTheme.headerIconsWindowColor
                        anchors.centerIn: parent
                        radius: 4
                    }


                }
                MoaryText{
                    id: newProjectText
                    text: qsTr("New Project")
                    font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: newprojectIcon.right
                    anchors.leftMargin: 10
                    effectBrightness: newprojectIcon.currentBrightness
                    font.bold: true
                    anchors.right: parent.right
                    font.family: master.currentTheme.projectFont.name

                    color: master.currentTheme.headerIconsWindowColor
                }
                MouseArea{
                    id: newProjectMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if(!createProjectPopup.opened){
                            createProjectPopup.open()
                        }
                    }
                    onClipChanged: {
                        if(clip){
                            newprojectIcon.currentBrightness = 0.3
                        }
                    }

                    onEntered: {
                        newprojectIcon.currentBrightness = 0.5

                    }
                    onExited: {
                        newprojectIcon.currentBrightness = 0.2

                    }

                }
            }
        }
    }
}
