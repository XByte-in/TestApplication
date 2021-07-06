#include "mainbackend.h"
#include <QDebug>
#include <QProcess>
#include <QPixmap>
#include <qqmlfile.h>
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

bool MainBackend::isTransparentClickAccepted(QUrl source, int parentWidth, int parentHeight, int x, int y) {
    QImage m_maskImage = QImage(QQmlFile::urlToLocalFileOrQrc(source));
    x = x * m_maskImage.width() / parentWidth;
    y = y * m_maskImage.height() / parentHeight;
    if (x >= 0 && x <= m_maskImage.width() && y >= 0 && y <= m_maskImage.height()) {
        int alpha = qAlpha(m_maskImage.pixel(x, y));
        //XLOGI("Alpha: %s", alpha);
        if(alpha < 10)
            return false;
    }
    return true;
}
