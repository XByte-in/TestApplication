#include "mainbackend.h"
#include <QDebug>
#include <QProcess>
MainBackend::MainBackend(QObject* parent) : QObject(parent)
{

}
bool MainBackend::openMediaFolder(QString path)
{
    return QDesktopServices::openUrl(QUrl("file:///"+path, QUrl::TolerantMode));
}

void MainBackend::openMediaFolderProcess(QString path){
    QProcess* process = new QProcess();
    QStringList argument;
    QString program = "explorer";
    argument  << path; //<< "/select,"
    process->start(program, argument);
}
