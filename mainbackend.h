#ifndef MAINBACKEND_H
#define MAINBACKEND_H


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
};

#endif // MAINBACKEND_H
