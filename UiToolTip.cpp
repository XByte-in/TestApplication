#include <algorithm>
#include <QGuiApplication>
#include <QQuickItem>
#include <QQuickWindow>
#include <QScreen>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "UiTheme.h"
#include "UiToolTip.h"

UiToolTipAttached::UiToolTipAttached(QObject* parent)
    : QObject(parent), mText(""), mConfShortcutProperty(""),  mVisible(false)
{
}

QString UiToolTipAttached::text() const
{
    return mText;
}

void UiToolTipAttached::setText(const QString& text)
{
    mText = text;
}

QString UiToolTipAttached::confShortcutProperty() const
{
    return mConfShortcutProperty;
}

void UiToolTipAttached::setConfShortcutProperty(const QString& confShortcutProperty)
{
    mConfShortcutProperty = confShortcutProperty;
}

bool UiToolTipAttached::visible() const
{
    return mVisible;
}

QWindow* toolTipWindow = nullptr;

void UiToolTipAttached::setVisible(bool isShow)
{
    QQuickItem* attachee = qobject_cast<QQuickItem*>(this->parent());
    if (attachee)
    {
        if (toolTipWindow != nullptr)
        {
            toolTipWindow->close();
            toolTipWindow->destroy();
            delete toolTipWindow;
            toolTipWindow = nullptr;
        }

        mVisible = isShow;
        if (isShow && mText != "")
        {
            QQmlApplicationEngine* engine = new QQmlApplicationEngine;
            engine->rootContext()->setContextProperty("UiTheme", UiTheme::instance());
            QQmlComponent* toolTipComponent = new QQmlComponent(engine, QUrl(QStringLiteral("qrc:/UiToolTip.qml")));
            toolTipWindow = qobject_cast<QWindow*>(toolTipComponent->create());

            toolTipWindow->setProperty("toolTipText", mText);
            toolTipWindow->setProperty("confShortcutProperty", mConfShortcutProperty);

            QPointF pos = attachee->mapToGlobal(QPointF(0, 0));
            QScreen* screen = QGuiApplication::screenAt(pos.toPoint());
            if (!screen)
                return;

            toolTipWindow->setScreen(screen);

            int x = (int)pos.x() - toolTipWindow->width() / 2;
            x = std::min(x, screen->geometry().right() - toolTipWindow->width());
            x = std::max(x, screen->geometry().left());

            toolTipWindow->setX(x);
            toolTipWindow->setY((int)pos.y() + attachee->height());

            toolTipWindow->show();
        }
        emit UiToolTipAttached::visibileChanged();
    }
}

UiToolTipAttached* UiToolTip::qmlAttachedProperties(QObject* object)
{
    return new UiToolTipAttached(object);
}
