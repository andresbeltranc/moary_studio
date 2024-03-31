#include <QGuiApplication>
#include "application_manager.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    ApplicationManager appManager;
    appManager.setupApplication();
    return app.exec();
}
