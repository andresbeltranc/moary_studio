#include "persistance_controller.h"




PersistenceController::PersistenceController(QObject *parent)
{
    userSettings = new QSettings(QSettings::Format::NativeFormat,QSettings::Scope::UserScope,organizationName,applicationName);
    userSettings->setPath(QSettings::NativeFormat,QSettings::UserScope,"//"+organizationName+"//"+applicationName);
}

void PersistenceController::initializeVariables()
{

}

void PersistenceController::restoreSettings()
{
    mutex.lock();
    qDebug("Restoring settings...");
    userSettings->clear();
    mutex.unlock();
}

QStringList PersistenceController::getGroupKeys(QString group)
{
    mutex.lock();
    QSettings settingsScan(organizationName,applicationName);
    settingsScan.beginGroup(group);
    QStringList keys = settingsScan.allKeys();
    settingsScan.deleteLater();
    mutex.unlock();
    return keys;
}

QStringList PersistenceController::getGroupChildren(QString group)
{
    mutex.lock();
    QSettings settingsScan(organizationName,applicationName);
    settingsScan.beginGroup(group);
    QStringList children = settingsScan.childGroups();
    settingsScan.deleteLater();
    mutex.unlock();
    return children;
}



void PersistenceController::removeGroup(QString group)
{
    mutex.lock();
    QSettings settingsScan(organizationName,applicationName);
    settingsScan.remove(group);
    settingsScan.deleteLater();
    mutex.unlock();
}
