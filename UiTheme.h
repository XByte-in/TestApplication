#ifndef _UI_THEME_H
#define _UI_THEME_H

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

#endif // _UI_THEME_H
