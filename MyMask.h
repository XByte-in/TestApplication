#ifndef MYMASK_H
#define MYMASK_H

#include <QObject>
#include <QImage>
#include <QString>

class MyMask : public QObject, public QImage
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
public:
    explicit MyMask(QObject *parent = nullptr);

    QString source() const;
    void setSource(const QString &source);

signals:
    void sourceChanged();
public slots:
    QColor color(int x, int y);

private:
    QString m_source;
};

#endif // MYMASK_H
