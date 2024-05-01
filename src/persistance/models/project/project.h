#ifndef PROJECT_H
#define PROJECT_H

#include <QObject>
#include <QDateTime>
#include <QSettings>
#include <QQmlEngine>

enum class ProjectType {
    MUSIC_PROJECT = 0,
    UNKNOWN_PROJECT= -1
};

class Project: public QObject
{
    Q_OBJECT
    //QML_INTERFACE
   // Q_GADGET

    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString path READ getPath WRITE setPath NOTIFY pathChanged)
    Q_PROPERTY(QString owner READ getOwner WRITE setOwner NOTIFY ownerChanged)
    Q_PROPERTY(QDateTime creationDate READ getCreationDate WRITE setCreationDate NOTIFY creationDateChanged)
    Q_PROPERTY(QDateTime lastModifiedDate READ getLastModifiedDate WRITE setLastModifiedDate NOTIFY lastModifiedDateChanged)
    Q_PROPERTY(ProjectType type READ getType WRITE setProjectType NOTIFY projectTypeChanged)

    QML_VALUE_TYPE(project)

public:
    Q_ENUM(ProjectType)
    Q_INVOKABLE void setName(QString name);
    Q_INVOKABLE QString getName();
    Q_INVOKABLE void setPath(QString path);
    Q_INVOKABLE QString getPath();
    Q_INVOKABLE void setOwner(QString owner);
    Q_INVOKABLE QString getOwner();
    Q_INVOKABLE void setCreationDate(QDateTime creationDate);
    Q_INVOKABLE QDateTime getCreationDate();
    Q_INVOKABLE void setLastModifiedDate(QDateTime lastModifiedDate);
    Q_INVOKABLE QDateTime getLastModifiedDate();
    Q_INVOKABLE ProjectType getType();
    Q_INVOKABLE void setProjectType(ProjectType type);

    Q_INVOKABLE virtual bool loadProjectFromLocalStorage(QString projectPath) = 0;
    Q_INVOKABLE virtual void saveProjectToLocalStorage() = 0;
    Q_INVOKABLE virtual void deleteProjectFromLocalStorage() = 0;

private:
    ProjectType type;
    QString name;
    QString path;
    QString owner;
    QDateTime creationDate;
    QDateTime lastModifiedDate;
signals:
    void nameChanged();
    void pathChanged();
    void ownerChanged();
    void creationDateChanged();
    void lastModifiedDateChanged();
    void projectTypeChanged();

};
//Q_DECLARE_INTERFACE(Project, "org.Moary.1.0")
#endif // PROJECT_H
