#include "application_manager.h"
#include "controllers/window_controller.h"

#include <QQmlContext>
#include "controllers/Audio/audio_controller.h"


ApplicationManager::ApplicationManager(QObject *parent)
{

}

void ApplicationManager::setupApplication()
{
    QQuickWindow::setGraphicsApi(QSGRendererInterface::Direct3D12);
    initQmlEngine();

}



void ApplicationManager::initQmlEngine()
{
    if(engine == nullptr){
        engine = new QQmlApplicationEngine();
        WindowController* windowController = new WindowController();
        AudioController* audioExtractor  = new AudioController();
        engine->rootContext()->setContextProperty("windowController", windowController);
        engine->rootContext()->setContextProperty("audioExtractor", audioExtractor);
        engine->load(QStringLiteral("qrc:/qml/Main.qml"));
    }
}

void ApplicationManager::initCoreCppConnections()
{

}

void ApplicationManager::initCoreQmlConnections()
{

}
