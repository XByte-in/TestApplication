#ifndef DIRECTORYVALIDATOR_H
#define DIRECTORYVALIDATOR_H
#include <QValidator>
#include <QDir>

class DirectoryValidator : public QValidator
{
    Q_OBJECT

public:
    DirectoryValidator(QObject * parent = 0);
    void fixup(QString & input) const override;
    QLocale locale() const;
    void setLocale(const QLocale & locale);
    State validate(QString & input, int & pos) const override;
};
#endif
