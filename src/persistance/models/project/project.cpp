#include "project.h"


void Project::setName(QString name)
{
    this->name = name;
    emit nameChanged();
}

QString Project::getName()
{
    return this->name;
}

void Project::setPath(QString path)
{
    this->path = path;
    emit pathChanged();
}

QString Project::getPath()
{
    return this->path;
}

void Project::setOwner(QString owner)
{
    this->owner = owner;
    emit ownerChanged();
}

QString Project::getOwner()
{
    return this->owner;
}

void Project::setCreationDate(QDateTime creationDate)
{
    this->creationDate = creationDate;
    emit creationDateChanged();
}

QDateTime Project::getCreationDate()
{
    return this->creationDate;
}

void Project::setLastModifiedDate(QDateTime lastModifiedDate)
{
    this->lastModifiedDate = lastModifiedDate;
    emit lastModifiedDateChanged();
}

QDateTime Project::getLastModifiedDate()
{
    return this->lastModifiedDate;
}

ProjectType Project::getType()
{
    return this->type;
}

void Project::setProjectType(ProjectType type)
{
    this->type = type;
    emit projectTypeChanged();
}


