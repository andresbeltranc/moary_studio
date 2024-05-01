#ifndef PERSISTANCE_CONTROLLER_H
#define PERSISTANCE_CONTROLLER_H

#include <QObject>
#include <QSettings>

#include "../utils/Singleton.h"
#include <QMutex>
#include <QThread>
#include <QStandardPaths>
#include <QDate>

class PersistenceController : public QThread
{
    Q_OBJECT

private:

    QSettings* userSettings = nullptr;
    QMutex mutex;
    QString organizationName = "Moary Company";
    QString applicationName = "MoaryStudio";

public:
    explicit PersistenceController(QObject *parent = nullptr);
public slots:
    void initializeVariables();
    void restoreSettings();

    QStringList getGroupKeys(QString group);
    QStringList getGroupChildren(QString group);
    void removeGroup(QString group);



};

typedef Singleton<PersistenceController> persistenceController;
#endif // PERSISTANCE_CONTROLLER_H
