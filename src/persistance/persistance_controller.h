#ifndef PERSISTANCE_CONTROLLER_H
#define PERSISTANCE_CONTROLLER_H

#include <QObject>
#include <QSettings>

#include "../utils/Singleton.h"
#include <QMutex>


class PersistenceController : public QObject
{
    Q_OBJECT

private:
    struct userSettings{
        QString group;
        QString variable;
        QVariant value;
    };
    QSettings* settings = nullptr;
    QMutex mutex;
    QString organizationName = "Moary Company";
    QString applicationName = "MoaryStudio";
    QList<userSettings> userSettingsList;
    QList<QString> deviceSettingsList;


public:
    explicit PersistenceController(QObject *parent = nullptr);


public slots:
    void initializeVariables();
    void restoreSettings();
    QVariant getSettings(const QString &group,const QString &variable);
    QVariant getAdminSettings(const QString &group,const QString &variable);
    void setSettings(const QString &group,const QString &variable, const QVariant &value);
    QStringList getGroupKeys(QString group);
    QStringList getGroupChildren(QString group);
    void printDebugAllSettings();
    void deleteAllSettings();
    void removeSetting(const QString &group,const QString &variable);
    void removeGroup(QString group);



};

typedef Singleton<PersistenceController> persistenceController;
#endif // PERSISTANCE_CONTROLLER_H
