#include "UiDialogButtonModelList.h"
#include "UiDialogButtonModel.h"
#include <QQmlListProperty>

UiDialogButtonModelList::UiDialogButtonModelList(QObject* parent) : QObject(parent), pButtons({})
{
}

QQmlListProperty<UiDialogButtonModel> UiDialogButtonModelList::buttons()
{
    return QQmlListProperty<UiDialogButtonModel>(this, &pButtons);
}

void UiDialogButtonModelList::appendButton(UiDialogButtonModel* newButton)
{
    pButtons.append(newButton);
}
