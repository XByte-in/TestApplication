#include "directoryvalidator.h"
#include <QQuickItem>

DirectoryValidator::DirectoryValidator(QObject *parent)
    : QValidator(parent)
{
}

void DirectoryValidator::fixup(QString & input) const
{
    QValidator::fixup(input);
}

QLocale DirectoryValidator::locale() const
{
    return QValidator::locale();
}

void DirectoryValidator::setLocale(const QLocale & locale)
{
    QValidator::setLocale(locale);
}

QValidator::State DirectoryValidator::validate(QString & input, int & pos) const
{
    Q_UNUSED(pos) //change cursor position
    QQuickItem* attachee = qobject_cast<QQuickItem*>(this->parent());
    if(attachee)
    {
        if(QDir(input).exists())
        {
            attachee->setProperty("pInputValidationState", 0);
            return Acceptable;
        }
        attachee->setProperty("pInputValidationState", 1);
        return Intermediate;
    }
    attachee->setProperty("pInputValidationState", 2);
    return Invalid;
}
