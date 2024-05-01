#include "project_factory.h"
#include "./models/project/music_project.h"
#include <QSharedPointer>
#include <stdexcept>

QSharedPointer<Project> ProjectFactory::createProject(ProjectType type)
{

    switch (type) {
        case ProjectType::MUSIC_PROJECT:
            qDebug() << "Creating music project";
            return QSharedPointer<Project>(new MusicProject());
        default:
            throw std::invalid_argument("Invalid user type");
    }
}
