#ifndef MAINBACKEND_H
#define MAINBACKEND_H

#include <QImage>
#include <QObject>
#include <QNetworkReply>
#include <QDesktopServices>

class MainBackend : public QObject
{
   Q_OBJECT
public:
    MainBackend(QObject* parent = nullptr);

public slots:
    bool openMediaFolder(QString path);
    void openMediaFolderProcess(QString path);
    bool isTransparentClickAccepted(QUrl source, int parentWidth, int parentHeight, int x, int y);
};

#endif // MAINBACKEND_H
