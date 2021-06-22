#ifndef _UI_TOOL_TIP_H
#define _UI_TOOL_TIP_H

#include <QObject>
#include <qqml.h>

class UiToolTipAttached : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText)
    Q_PROPERTY(QString confShortcutProperty READ confShortcutProperty WRITE setConfShortcutProperty)
    Q_PROPERTY(bool visible READ visible WRITE setVisible NOTIFY visibileChanged)
    QML_ANONYMOUS

public:
    UiToolTipAttached(QObject* parent = 0);

    QString text() const;
    Q_INVOKABLE void setText(const QString&);

    QString confShortcutProperty() const;
    Q_INVOKABLE void setConfShortcutProperty(const QString&);

    bool visible() const;
    Q_INVOKABLE void setVisible(bool);

signals:
    void visibileChanged();

private:
    QString mText;
    QString mConfShortcutProperty;
    bool mVisible;
};

class UiToolTip : public QObject
{
    Q_OBJECT
    QML_ATTACHED(UiToolTipAttached)
    QML_ELEMENT

public:
    static UiToolTipAttached* qmlAttachedProperties(QObject*);
};

#endif // _UI_TOOL_TIP_H
