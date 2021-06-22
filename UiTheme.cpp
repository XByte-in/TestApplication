#include "UiTheme.h"
#include <QQmlComponent>
#include <QQmlApplicationEngine>

UiTheme* UiTheme::mTheme = nullptr;
UiTheme::UiTheme(QObject* parent) : QObject(parent)
{
}

UiTheme* UiTheme::instance()
{
    if (mTheme == nullptr)
    {
        QQmlComponent* themeComponent = new QQmlComponent(new QQmlApplicationEngine, QUrl(QStringLiteral("qrc:/UiThemeObject.qml")));
        QObject* theme = qobject_cast<QObject*>(themeComponent->create());
        mTheme = reinterpret_cast<UiTheme*>(theme);
    }
    return mTheme;
}
