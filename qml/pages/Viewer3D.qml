import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import QtCore
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick3D.AssetUtils

Rectangle {
    id: rendererRect
    radius: 5
    color: master.currentTheme.dashboardBackgroundColor
    clip: true
    layer.enabled: true
    Component.onCompleted: {
        importNode.source = "C:/Moary Project/moary_studio/qml/assets/3D/stage.obj"

    }

    layer.effect:MultiEffect {
        //source: buttonBackground
        //anchors.fill: buttonBackground
        autoPaddingEnabled: true
        shadowBlur: 1.0
        shadowEnabled: true
        shadowVerticalOffset: 1
        shadowHorizontalOffset: 1
        //opacity: button.pressed ? 0.75 : 1.0
    }
    View3D {
        id: view3D
        anchors.fill: parent
        environment: SceneEnvironment {
            id: env
            backgroundMode: SceneEnvironment.TonemapModeFilmic
            // lightProbe: Texture {
            //     textureData: ProceduralSkyTextureData{}
            // }
            InfiniteGrid {
                visible: helper.gridEnabled
                gridInterval: helper.gridInterval
            }
        }
        function resetView() {
            if (importNode.status === RuntimeLoader.Success) {
                helper.resetController()
            }
        }

        // DirectionalLight {
        //     eulerRotation.x: 0
        //     eulerRotation.y: 0
        //     eulerRotation.z: 1000
        //     castsShadow: false
        // }
        Node {
            id: orbitCameraNode
            PerspectiveCamera {
                id: orbitCamera
            }
        }
        PerspectiveCamera {
            id: wasdCamera
            onPositionChanged: {
                // Near/far logic copied from OrbitController
                let distance = position.length()
                if (distance < 1) {
                    clipNear = 0.01
                    clipFar = 100
                } else if (distance < 100) {
                    clipNear = 0.1
                    clipFar = 1000
                } else {
                    clipNear = 1
                    clipFar = 10000
                }
            }
        }
        QtObject {
            id: helper
            property real boundsDiameter: 0
            property vector3d boundsCenter
            property vector3d boundsSize
            property bool orbitControllerEnabled: true
            property bool gridEnabled: true
            property real cameraDistance: orbitControllerEnabled ? orbitCamera.z : wasdCamera.position.length()
            property real gridInterval: Math.pow(10, Math.round(Math.log10(cameraDistance)) - 1)

            function updateBounds(bounds) {
                boundsSize = Qt.vector3d(bounds.maximum.x - bounds.minimum.x,
                                         bounds.maximum.y - bounds.minimum.y,
                                         bounds.maximum.z - bounds.minimum.z)
                boundsDiameter = Math.max(boundsSize.x, boundsSize.y, boundsSize.z)
                boundsCenter = Qt.vector3d((bounds.maximum.x + bounds.minimum.x) / 2,
                                           (bounds.maximum.y + bounds.minimum.y) / 2,
                                           (bounds.maximum.z + bounds.minimum.z) / 2 )

                wasdController.speed = boundsDiameter / 1000.0
                wasdController.shiftSpeed = 3 * wasdController.speed
                wasdCamera.clipNear = boundsDiameter / 100
                wasdCamera.clipFar = boundsDiameter * 10
                view3D.resetView()
            }

            function resetController() {
                orbitCameraNode.eulerRotation = Qt.vector3d(0, 0, 0)
                orbitCameraNode.position = boundsCenter
                orbitCamera.position = Qt.vector3d(0, 0, 2 * helper.boundsDiameter)
                orbitCamera.eulerRotation = Qt.vector3d(0, 0, 0)
                orbitControllerEnabled = true
            }

            function switchController(useOrbitController) {
                if (useOrbitController) {
                    let wasdOffset = wasdCamera.position.minus(boundsCenter)
                    let wasdDistance = wasdOffset.length()
                    let wasdDistanceInPlane = Qt.vector3d(wasdOffset.x, 0, wasdOffset.z).length()
                    let yAngle = Math.atan2(wasdOffset.x, wasdOffset.z) * 180 / Math.PI
                    let xAngle = -Math.atan2(wasdOffset.y, wasdDistanceInPlane) * 180 / Math.PI

                    orbitCameraNode.position = boundsCenter
                    orbitCameraNode.eulerRotation = Qt.vector3d(xAngle, yAngle, 0)
                    orbitCamera.position = Qt.vector3d(0, 0, wasdDistance)

                    orbitCamera.eulerRotation = Qt.vector3d(0, 0, 0)
                } else {
                    wasdCamera.position = orbitCamera.scenePosition
                    wasdCamera.rotation = orbitCamera.sceneRotation
                    wasdController.focus = true
                }
                orbitControllerEnabled = useOrbitController
            }
        }

        RuntimeLoader {
            id: importNode
            onBoundsChanged: helper.updateBounds(bounds)

            SpotLight {
               position: Qt.vector3d(0, 0, 0)
               color: "green"
               brightness: 50
               z:800
               eulerRotation.y: -20
               coneAngle: 30
               innerConeAngle: 10

               //intensity: 0.5
           }
        }

    }
    OrbitCameraController {
        id: orbitController
        origin: orbitCameraNode
        camera: orbitCamera
        enabled: helper.orbitControllerEnabled
    }
    WasdController {
        id: wasdController
        controlledObject: wasdCamera
        enabled: !helper.orbitControllerEnabled
    }

}

