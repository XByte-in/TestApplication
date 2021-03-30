#ifndef UIDIALOGBUTTONMODEL_H
#define UIDIALOGBUTTONMODEL_H

#include <QObject>

class UiDialogButtonModel: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QObject* pSize READ size WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(QObject* pColor READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QString pText READ text WRITE setText NOTIFY textChanged)

public:
    UiDialogButtonModel(QObject* parent = nullptr);

    QObject* size() const;
    void setSize(QObject*);

    QObject* color() const;
    void setColor(QObject*);

    QString text() const;
    void setText(const QString&);

signals:
    void sizeChanged();
    void colorChanged();
    void textChanged();
    void clicked();

private:
    QObject* pSize;
    QObject* pColor;
    QString pText;
};

#endif // UIDIALOGBUTTONMODEL_H
