import QtQuick 2.15
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

Rectangle {
    id: customItem
    property real effectBrightness: 0.2
    property bool flickerAnimation: false
    property bool hoverAnimation: false

    clip: true
    color: "transparent"
    layer.enabled: true



    layer.effect:MultiEffect{
        id: multiEffect
        brightness: customItem.effectBrightness
        saturation: 0.5
        blurEnabled: true
        blurMax: 30
        blur: 0.1

        SequentialAnimation {
            id: hoverAnimation
            loops: Animation.Infinite
            running: customItem.hoverAnimation
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

        SequentialAnimation {
            loops: Animation.Infinite
            running: customItem.flickerAnimation
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


