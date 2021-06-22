#ifndef _UI_DIALOG_WINDOW_H
#define _UI_DIALOG_WINDOW_H

#include <QObject>
#include <QQuickWindow>
#include "UiDialogButtonModelList.h"

class UiDialogWindow: public QQuickWindow
{
    Q_OBJECT
    Q_PROPERTY(int pDialogType READ dialogType WRITE setDialogType NOTIFY dialogTypeChanged)
    Q_PROPERTY(UiDialogButtonModelList* pButtonsList READ buttonsList WRITE setButtonsList NOTIFY buttonsListChanged)
    Q_PROPERTY(QString pSubtitle READ subtitle WRITE setSubtitle NOTIFY subtitleChanged)
    Q_PROPERTY(QString pDescription READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString pNotice READ notice WRITE setNotice NOTIFY noticeChanged)
    Q_PROPERTY(QString pDialogImageSource READ dialogImageSource WRITE setDialogImageSource NOTIFY dialogImageSourceChanged)
    Q_PROPERTY(QString pCheckBoxText READ checkBoxText WRITE setCheckBoxText NOTIFY checkBoxTextChanged)
    Q_PROPERTY(bool pCheckBoxState READ checkBoxState WRITE setCheckBoxState NOTIFY checkBoxStateChanged)
    Q_PROPERTY(QString pHyperlink READ hyperlink WRITE setHyperlink NOTIFY hyperlinkChanged)
    Q_PROPERTY(bool pCloseBtnVisible READ closeBtnVisible WRITE setCloseBtnVisible NOTIFY closeBtnVisibleChanged)
    Q_PROPERTY(int pOwnership READ getDialogOwnership)

public:
    UiDialogWindow(QWindow* parent = nullptr);

    int dialogType() const;
    void setDialogType(const int&);

    UiDialogButtonModelList* buttonsList() const;
    void setButtonsList(UiDialogButtonModelList*);

    QString subtitle() const;
    void setSubtitle(const QString&);

    QString description() const;
    void setDescription(const QString&);

    QString notice() const;
    void setNotice(const QString&);

    QString dialogImageSource() const;
    void setDialogImageSource(const QString&);

    QString checkBoxText() const;
    void setCheckBoxText(const QString&);

    bool checkBoxState() const;
    void setCheckBoxState(const bool&);

    QString hyperlink() const;
    void setHyperlink(const QString&);

    bool closeBtnVisible() const;
    void setCloseBtnVisible(const bool&);

    int getDialogOwnership();

signals:
    void dialogTypeChanged();
    void buttonsListChanged();
    void subtitleChanged();
    void descriptionChanged();
    void noticeChanged();
    void dialogImageSourceChanged();
    void checkBoxTextChanged();
    void checkBoxStateChanged();
    void hyperlinkChanged();
    void closeBtnVisibleChanged();
    void closeClicked();
    void hyperlinkClicked();

private:
    int pDialogType;
    UiDialogButtonModelList* pButtonsList;
    QString pSubtitle;
    QString pDescription;
    QString pNotice;
    QString pDialogImageSource;
    QString pCheckBoxText;
    bool pCheckBoxState;
    QString pHyperlink;
    bool pCloseBtnVisible;
};

#endif // _UI_DIALOG_WINDOW_H
