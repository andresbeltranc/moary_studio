#ifndef APPLICATIONMANAGER_H
#define APPLICATIONMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QGuiApplication>


class ApplicationManager: public QObject {
    Q_OBJECT
public:
    ApplicationManager(QObject* parent = nullptr);
    void setupApplication();


private:
    QQmlApplicationEngine *engine = nullptr;
    void initQmlEngine();
    void initCoreCppConnections();
    void initCoreQmlConnections();

};

#endif // APPLICATIONMANAGER_H
