#include "project_controller.h"
#include "./project_factory.h"
#include <QGuiApplication>
#include <QDir>
#include <QFileInfo>
ProjectController::ProjectController(): currentProject(nullptr) {
    projectsStorage = new QSettings(QSettings::Format::IniFormat,QSettings::Scope::UserScope,QGuiApplication::organizationName(),QGuiApplication::applicationDisplayName());
    qDebug() << "Project Controller Initialized...";
    qDebug() << "organizationName" << QGuiApplication::organizationName();
    qDebug() << "applicationDisplayName" << QGuiApplication::applicationDisplayName();

    projectsStorage->beginGroup("app");
    projectsStorage->setValue("version","0.1");
    projectsStorage->endGroup();
    loadProjectsFromLocalStorage();
}


void ProjectController::loadProjectsFromLocalStorage()
{

    QStringList projectsList;
    projectsStorage->beginGroup("projects");
    const QStringList keys = projectsStorage->childKeys();
    for (const QString &projectKey : keys) {
        qDebug() << "projectKey: " << projectKey;

        QString currentProjectPath = projectsStorage->value(projectKey).toString();
        QSettings currentProjectSettings(currentProjectPath,QSettings::Format::IniFormat);
        ProjectType projectType = getProjectTypeFromInt(currentProjectSettings.value("type").toInt());
        QSharedPointer<Project> project = ProjectFactory::createProject(projectType);
        qDebug() << "currentProjectPath: " << currentProjectPath;
        if(project->loadProjectFromLocalStorage(currentProjectPath+"/"+projectKey+".ini")){
            qDebug() << "project load succefully";
            qDebug() << "Project Name: " << project->getName();

            addProject(projectKey,project);
        }
    }
    projectsStorage->endGroup();
    qDebug() << "Finished Loading Local Projects Basics...";

}

void ProjectController::setCurrentProject(Project *project)
{
    currentProject = project;
    emit currentProjectChanged(project);
}

Project *ProjectController::getCurrentProject()
{
    return currentProject;
}

QList<Project*> ProjectController::getProjectsMap()
{
    QVariantMap projectMap;

    QList<Project*> currentProjects;

    QMapIterator<QString, QSharedPointer<Project>> projectIterator(projects);

    while (projectIterator.hasNext()) {
        projectIterator.next();
        QString key = projectIterator.key(); // Store key for creating QVariant object
        Project *project = projects[key].get();
        currentProjects.append(project);
        ///QVariant projectVariant = QVariant::fromValue(static_cast<QObject*>(projectIterator.value()));
        //projectMap[key] = projectVariant;
    }
    return currentProjects;
}



QVariantList ProjectController::getProjects()
{
    QVariantList resp;
    QMapIterator<QString, QSharedPointer<Project>> projectIterator(projects);

    while (projectIterator.hasNext()) {
        projectIterator.next();
        QSharedPointer<Project> currentProject = projectIterator.value();
        QVariantMap projectData;

        projectData["name"] = currentProject->getName();
        projectData["path"] = currentProject->getPath();
        projectData["owner"] = currentProject->getOwner();
        projectData["creationDate"] = currentProject->getCreationDate();
        projectData["lastModifiedDate"] = currentProject->getLastModifiedDate();

        resp.append(projectData);
        // qDebug() << "Project Name: " << currentProject->getName();
        // currentcurrentProjectInfo.append(currentProject->getName());
        // currentcurrentProjectInfo.append(currentProject->getPath());
        // currentcurrentProjectInfo.append(currentProject->getOwner());
        // currentcurrentProjectInfo.append(currentProject->getCreationDate());
        // currentcurrentProjectInfo.append(currentProject->getLastModifiedDate());

       // const QList<QVariant> finalizedProjectInfo = currentcurrentProjectInfo;
       // QVariant packagedProjectInfo = QVariant(finalizedProjectInfo);

       //  resp.append(packagedProjectInfo);
       //
       // qmlMap[projectIterator.key()] = projectObject.;
    }
    //const QList<QVariant> elem = resp;
    //QVariant sender = QVariant(elem);
    return resp;
}

Project* ProjectController::getProject(QString projectName)
{
    if(projects.contains(projectName)){
        Project *project = projects[projectName].get();
        qDebug() << "c name" << project->getName();
        return projects[projectName].get();
       // return projects[projectName];
    }

}

void ProjectController::addProject(const QString &projectName, QSharedPointer<Project> project)
{
    projects.insert(projectName,project);
    emit projectAdded();


}

ProjectType ProjectController::getProjectTypeFromInt(int type)
{
    if(type == 0){
        return ProjectType::MUSIC_PROJECT;
    }
    else if(type == -1){
        return ProjectType::UNKNOWN_PROJECT;
    }
    return ProjectType::UNKNOWN_PROJECT;

}

QSharedPointer<Project> ProjectController::createProject(int type, QString projectName, QString projectPath, QString owner)
{
    qDebug() << "type" <<type ;
    qDebug() << "projectName" <<projectName ;
    qDebug() << "projectPath" <<projectPath ;
    qDebug() << "owner" <<owner ;
    qDebug() << "getProjectTypeFromInt(type)" <<type ;

    qDebug() << "project Folder path" <<projectPath+"/"+projectName ;

    QDir dir(projectPath+"/"+projectName);
    if (!dir.exists()) {
        if (dir.mkpath(projectPath+"/"+projectName)) {
            qDebug() << "Folder created successfully:" << projectPath+"/"+projectName;
        } else {
            qDebug() << "Error creating folder:" << projectPath+"/"+projectName;
        }
    } else {
        qDebug() << "Folder already exists:" << projectPath+"/"+projectName;
    }

    QSharedPointer<Project> project = ProjectFactory::createProject(getProjectTypeFromInt(type));

    if(project->getType() == ProjectType::MUSIC_PROJECT){
        qDebug() << "project type" << "MUSIC_PROJECT";
    }
    project->setName(projectName);
    project->setPath(projectPath);
    project->setOwner(owner);
    project->setCreationDate(QDateTime::currentDateTime());
    project->setLastModifiedDate(QDateTime::currentDateTime());
    project->saveProjectToLocalStorage();
    projectsStorage->setValue("projects/"+projectName,projectPath+"/"+projectName);
    return project;
}
