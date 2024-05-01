import QtQuick 2.0

Item {
    id: theme
    property QtObject currentTheme: darkTheme


    QtObject {
        id: darkTheme
        property color dashboardBackgroundColor: "#2c2c2c"
        property color headerBackgroundColor: "#1f1f1f"
        property color headerTextColor: "white"
        property color headerTitleColor: "white"
        property color headerIconsWindowColor: "#D9B561"//#D9B561
        property color commonTextColor: "#00dfc3"
        property FontLoader projectFont: FontLoader {source: "qrc:/qml/assets/fonts/IndieFlower-Regular.ttf"}

    }
    QtObject {
        id: blueTheme
        property color dashboardBackgroundColor: "#2F4550"
        property color headerBackgroundColor: "#13293D"
        property color headerTextColor: "white"
        property color headerTitleColor: "white"
        property color headerIconsWindowColor: "white"
    }
    QtObject {
        id: lightTheme
        property color dashboardBackgroundColor: "#2F4550"
        property color headerBackgroundColor: "#13293D"
        property color headerTextColor: "white"
        property color headerTitleColor: "white"
        property color headerIconsWindowColor: "white"
    }

}



