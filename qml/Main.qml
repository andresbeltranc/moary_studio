import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "pages/dashboard"
import "layouts"
import "themes"

Item{
    id: master

    property alias currentTheme: theme.currentTheme

    Theme{
        id: theme
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
