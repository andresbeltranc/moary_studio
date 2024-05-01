#ifndef PROJECTFACTORY_H
#define PROJECTFACTORY_H
#include <QSharedPointer>
#include <QObject>
#include "./models/project/project.h"



class ProjectFactory
{
public:
    static QSharedPointer<Project> createProject(ProjectType type); // Factory method declaration

};

#endif // PROJECTFACTORY_H
