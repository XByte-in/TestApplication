#include "mainbackend.h"
#include <QDebug>
#include <QProcess>
#include <QPixmap>
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

bool MainBackend::isTransparent(int x, int y) {
//    QPixmap pixmap = QPixmap::grabWindow(QApplication::desktop()->winId(), x, y, 1, 1);
//     QRgb pixelValue = pixmap.toImage().pixel(0,0);
    return false;
}
