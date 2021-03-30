#include <QGuiApplication>
#include <QQuickItem>
#include <QQuickWindow>
#include <QScreen>
#include <QQmlComponent>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <algorithm>
#include "UiToolTip.h"
#include "UiTheme.h"

UiToolTipAttached::UiToolTipAttached(QObject* parent)
    : QObject(parent), mText(""), mVisible(false)
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
