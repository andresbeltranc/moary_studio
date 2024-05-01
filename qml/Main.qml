import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "pages/dashboard"
import "layouts"
import "themes"
import ProjectController 1.0
import org.Moary 1.0 // Assuming version 1.0 for your interface
import MusicProject 1.0

Item{
    id: master

    property alias currentTheme: theme.currentTheme
    Theme{
        id: theme
    }
    ProjectController{
        id: projectController
        onCurrentProjectChanged: {
            console.log("currentProjectChanged",currentProject)
        }
    }
    signal initApp()
    onInitApp: {
        console.log("InitApp....")
        var component = Qt.createComponent("pages/MainWindow.qml");
        if (component.status === Component.Ready) {
            var window = component.createObject(master);
            if (window === null) {
                console.log("Error creating object");
            }
        } else if (component.status === Component.Error) {
            console.log("Error loading component:", component.errorString());
        }
    }
    Component.onCompleted: {
        initApp()
    }
}
