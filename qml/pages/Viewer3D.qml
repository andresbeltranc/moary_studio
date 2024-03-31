import QtQuick
import QtQuick3D

Item {
    id: root

    Rectangle {
        id: rendererRect
        anchors.fill: parent
        color: "transparent"
        View3D {
            id: view
            anchors.fill: parent

            environment: SceneEnvironment {
                clearColor: "black"
                backgroundMode: SceneEnvironment.Color
            }
        }
    }
}
