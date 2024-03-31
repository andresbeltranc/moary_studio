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
        property color headerIconsWindowColor: "#00dfc3"
        property color commonTextColor: "#00dfc3"
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



