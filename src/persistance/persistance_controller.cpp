#include "persistance_controller.h"




PersistenceController::PersistenceController(QObject *parent)
{
    settings = new QSettings(QSettings::Format::IniFormat,QSettings::Scope::UserScope,organizationName,applicationName);

}

void PersistenceController::initializeVariables()
{
    mutex.lock();
    qDebug() << "Initializing Settings...";
    //settings->scope(QSettings::Scope::UserScope);
    QSettings settingsInit(organizationName,applicationName);
    for(int i = 0; i <userSettingsList.length(); i++ ){
        userSettings currentUserSettings = userSettingsList[i];
        settingsInit.beginGroup(currentUserSettings.group);
        if(!currentUserSettings.variable.isNull()){
            settingsInit.setValue(currentUserSettings.variable,currentUserSettings.value);
        }else{
            qDebug() << "key without value:" << currentUserSettings.group;
        }
        settingsInit.endGroup();
    }
    settingsInit.deleteLater();
    mutex.unlock();
}

void PersistenceController::restoreSettings()
{
    mutex.lock();
    qDebug("Restoring settings...");
    settings->clear();
    mutex.unlock();
}

QVariant PersistenceController::getSettings(const QString &group, const QString &variable)
{
    QVariant resp = settings->value(group+"/"+variable);
    return resp;
}

QVariant PersistenceController::getAdminSettings(const QString &group, const QString &variable)
{
    QVariant resp = settings->value(group+"/"+variable);
    return resp;
}

void PersistenceController::setSettings(const QString &group, const QString &variable, const QVariant &value)
{
    mutex.lock();
    settings->setValue(group+"/"+variable,value);
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

void PersistenceController::printDebugAllSettings()
{
    qDebug()<<"__Printing Settings__";
    QSettings settingsDebug(QSettings::UserScope,organizationName,applicationName);
    QList<QString> listUSettings = settingsDebug.allKeys();
    for(int i = 0; i <userSettingsList.length(); i++ ){
        userSettings currentUserSetting = userSettingsList[i];
        QString userS = currentUserSetting.group+"/"+ currentUserSetting.variable;
        if( listUSettings.contains(userS) == true){
            QString settingValue = getSettings(currentUserSetting.group, currentUserSetting.variable).toString();
            qDebug()<<"Setting: "<<userS<<" Value: "<<settingValue;
        }
        else{
            qDebug()<<"Missing setting: "<<userS;
        }
    }
}

void PersistenceController::deleteAllSettings()
{
    mutex.lock();
    settings->clear();
    mutex.unlock();
}

void PersistenceController::removeSetting(const QString &group, const QString &variable)
{
    mutex.lock();
    settings->remove(group+"/"+variable);
    mutex.unlock();
}

void PersistenceController::removeGroup(QString group)
{
    mutex.lock();
    QSettings settingsScan(organizationName,applicationName);
    settingsScan.remove(group);
    settingsScan.deleteLater();
    mutex.unlock();
}
