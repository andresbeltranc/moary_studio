import QtQuick 2.15
import QtQuick.Effects

Text{

    property bool flickerAnimation: false
    property real effectBrightness: 0.2
    layer.enabled: true
    layer.effect: MultiEffect{
        id: multiEffect
        brightness: effectBrightness
        saturation: 0.5
        blurEnabled: true
        blurMax: 30
        blur: 0.1
        SequentialAnimation {
            loops: Animation.Infinite
            running: flickerAnimation
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
