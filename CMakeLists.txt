cmake_minimum_required(VERSION 3.16)

project(MoaryStudio VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

set(QT_CREATOR_SKIP_CONAN_SETUP ON)

set(CONAN_LIBS_FOLDER "conan_libs")
set(CMAKE_PREFIX_PATH "${CMAKE_SOURCE_DIR}/src/libs/${CONAN_LIBS_FOLDER}")


find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Multimedia Concurrent)
qt_standard_project_setup(REQUIRES 6.5)

find_package(SndFile REQUIRED)
find_package(taglib REQUIRED)


set(APP_ICON_RESOURCE_WINDOWS "resources/moary.rc")

set(PROJECT_SOURCES
    src/utils/Singleton.h


    src/controllers/Audio/audio_controller.h
    src/controllers/Audio/audio_controller.cpp
    src/controllers/window_controller.h
    src/controllers/window_controller.cpp
    src/application_manager.h
    src/application_manager.cpp
    src/persistance/persistance_controller.h 
    src/persistance/persistance_controller.cpp
    src/main.cpp
    qml/qml.qrc
)

add_executable(MoaryStudio
  WIN32
  ${PROJECT_SOURCES}
  ${APP_ICON_RESOURCE_WINDOWS}

  )





# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
#set_target_properties(MoaryStudio PROPERTIES
##    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.MoaryStudio
#    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#    MACOSX_BUNDLE TRUE
#    WIN32_EXECUTABLE TRUE
#)

if(WIN32)
    target_link_libraries(MoaryStudio PRIVATE User32)
    add_definitions(-DNOMINMAX)
endif()

target_link_libraries(MoaryStudio PRIVATE
    Qt6::Quick
    Qt6::Multimedia
    Qt6::Concurrent
    SndFile::sndfile
    taglib::taglib
)

