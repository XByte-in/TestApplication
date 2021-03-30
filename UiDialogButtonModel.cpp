#include "UiDialogButtonModel.h"

UiDialogButtonModel::UiDialogButtonModel(QObject* parent) : QObject(parent), pSize(nullptr), pColor(nullptr), pText("")
{
}

QObject* UiDialogButtonModel::size() const
{
    return pSize;
}

void UiDialogButtonModel::setSize(QObject* size)
{
    pSize = size;
}

QObject* UiDialogButtonModel::color() const
{
    return pColor;
}

void UiDialogButtonModel::setColor(QObject* color)
{
    pColor = color;
}

QString UiDialogButtonModel::text() const
{
    return pText;
}

void UiDialogButtonModel::setText(const QString& text)
{
    pText = text;
}
