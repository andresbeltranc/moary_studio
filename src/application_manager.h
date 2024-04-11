#ifndef APPLICATIONMANAGER_H
#define APPLICATIONMANAGER_H

#include <QObject>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include "controllers/Audio/audio_controller.h"


class ApplicationManager: public QObject {
    Q_OBJECT
public:
    ApplicationManager(QObject* parent = nullptr);
    void initCoreQmlConnections(QQuickItem* rootObject);
    void setupApplication();

public slots:
    bool connectToAudioController(QQuickItem* item);

private:
    QQmlApplicationEngine *engine = nullptr;
    AudioController *audioController = nullptr;

    void initQmlEngine();
    void initCoreCppConnections();

};

#endif // APPLICATIONMANAGER_H
