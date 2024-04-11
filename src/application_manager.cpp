#include "application_manager.h"
#include "controllers/window_controller.h"

#include <QQmlContext>
#include "controllers/Audio/audio_controller.h"


ApplicationManager::ApplicationManager(QObject *parent)
{

}

void ApplicationManager::setupApplication()
{
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenVG);
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::Floor);

    initQmlEngine();

}
void ApplicationManager::initQmlEngine()
{
    if(engine == nullptr){
        engine = new QQmlApplicationEngine();
        WindowController* windowController = new WindowController();
        qmlRegisterType<AudioController>("AudioController", 1, 0, "AudioController");
        engine->rootContext()->setContextProperty("windowController", windowController);
        engine->rootContext()->setContextProperty("appManager", this);

        engine->load(QStringLiteral("qrc:/qml/Main.qml"));
    }
}

void ApplicationManager::initCoreCppConnections()
{

}
bool ApplicationManager::connectToAudioController(QQuickItem* item)
{
    if(audioController == nullptr) audioController  = new AudioController();

    connect(item,SIGNAL(loadAudio(QString)),audioController,SLOT(loadAudio(QString)));


    return true;
}

void ApplicationManager::initCoreQmlConnections(QQuickItem* rootObject)
{

}
