#include <QGuiApplication>
#include "application_manager.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QGuiApplication::setApplicationDisplayName("Moary Studio");
    QGuiApplication::setOrganizationName("Moary");
    ApplicationManager appManager;
    appManager.setupApplication();
    return app.exec();
}
