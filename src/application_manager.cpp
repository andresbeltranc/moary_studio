#include "application_manager.h"
#include "controllers/window_controller.h"

#include <QQmlContext>
#include "controllers/Audio/audio_controller.h"
#include "controllers/Audio/customqml.h"
#include "persistance/project_controller.h"
#include "persistance/models/project/project.h"
#include "persistance/models/project/music_project.h"
#include "persistance/models/project/audio_sample.h"


ApplicationManager::ApplicationManager(QObject *parent)
{

}

void ApplicationManager::setupApplication()
{
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenVG);
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);

    initQmlEngine();

}
void ApplicationManager::initQmlEngine()
{
    if(engine == nullptr){
        engine = new QQmlApplicationEngine();
        WindowController* windowController = new WindowController();
        //ProjectController* projectController = new ProjectController();


        qmlRegisterType<CustomQml>("CustomQml", 1, 0, "CustomQml");
        qmlRegisterType<ProjectController>("ProjectController", 1, 0, "ProjectController");
        qmlRegisterUncreatableType<Project>("org.Moary",1,0,"Project","");
        qmlRegisterType<MusicProject>("MusicProject", 1, 0, "MusicProject");
        qmlRegisterType<AudioSample>("AudioSample", 1, 0, "AudioSample");
        engine->rootContext()->setContextProperty("windowController", windowController);
        engine->rootContext()->setContextProperty("appManager", this);
        engine->load(QStringLiteral("qrc:/qml/Main.qml"));
    }
}

void ApplicationManager::initCoreCppConnections()
{

}

void ApplicationManager::initCoreQmlConnections(QQuickItem* rootObject)
{

}
