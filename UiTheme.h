#ifndef UITHEME_H
#define UITHEME_H

#include <QObject>

class UiTheme : public QObject
{
    Q_OBJECT

public:
    static UiTheme* instance();

private:
    UiTheme(QObject* parent = nullptr);
    static UiTheme* mTheme;
};

#endif // UITHEME_H
