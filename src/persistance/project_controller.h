#ifndef PROJECTSCONTROLLER_H
#define PROJECTSCONTROLLER_H

#include <QObject>
#include <QList>
#include <QSettings>
#include "./models/project/project.h"
#include "./models/project/music_project.h"
#include <QtQml/qqmlregistration.h>

#include "../utils/Singleton.h"


namespace ProjectDerivedForeign
{
Q_NAMESPACE
QML_NAMED_ELEMENT(Project)
QML_FOREIGN_NAMESPACE(MusicProject)
}


class ProjectController: public QObject
{
    Q_OBJECT

    QML_ELEMENT

    Q_PROPERTY(Project *currentProject READ getCurrentProject WRITE setCurrentProject NOTIFY currentProjectChanged)
    Q_PROPERTY(QList<Project*> projectsList READ getProjectsMap NOTIFY projectsLoaded)
    //Q_PROPERTY(QString path READ getPath WRITE setPath NOTIFY pathChanged)
    //Q_PROPERTY(QString owner READ getOwner WRITE setOwner NOTIFY ownerChanged)
   // Q_PROPERTY(QDateTime creationDate READ getCreationDate WRITE setCreationDate NOTIFY creationDateChanged)
   // Q_PROPERTY(QDateTime lastModifiedDate READ getLastModifiedDate WRITE setLastModifiedDate NOTIFY lastModifiedDateChanged)
   // Q_PROPERTY(ProjectType type READ getType WRITE setProjectType NOTIFY projectTypeChanged)

public:
    ProjectController();
    Q_INVOKABLE void loadProjectsFromLocalStorage();
    Q_INVOKABLE void setCurrentProject(Project *project);

public slots:
    Q_INVOKABLE Project *getCurrentProject();
    Q_INVOKABLE QList<Project*> getProjectsMap();
    Q_INVOKABLE QVariantList getProjects();



    Q_INVOKABLE Project* getProject(QString projectName);
    Q_INVOKABLE void addProject(const QString &projectName, QSharedPointer<Project> project);
    Q_INVOKABLE ProjectType getProjectTypeFromInt(int type);
    Q_INVOKABLE QSharedPointer<Project> createProject(int type, QString projectName, QString projectPath, QString owner);
    //Project getProjectObjectByType(ProjectType type);

signals:
    void currentProjectChanged(Project *project);
    void projectAdded();
    void projectDeleted();
    void projectsLoaded();

private:
    QSettings* projectsStorage = nullptr;
    QMap<QString,QSharedPointer<Project>> projects;
    QList<Project*> projectsList;
    Project *currentProject;
};

typedef Singleton<ProjectController> projectController;


#endif // PROJECTSCONTROLLER_H
