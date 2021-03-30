#ifndef UIDIALOGBUTTONMODELLIST_H
#define UIDIALOGBUTTONMODELLIST_H

#include <QObject>
#include <QQmlListProperty>
#include "UiDialogButtonModel.h"

class UiDialogButtonModelList: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<UiDialogButtonModel> pButtons READ buttons NOTIFY buttonsChanged)

public:
    UiDialogButtonModelList(QObject* parent = nullptr);

    QQmlListProperty<UiDialogButtonModel> buttons();
    void appendButton(UiDialogButtonModel* newButton);

signals:
    void buttonsChanged();

private:
    QList<UiDialogButtonModel*> pButtons;
};

#endif // UIDIALOGBUTTONMODELLIST_H
