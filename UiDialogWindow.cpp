#include "UiDialogWindow.h"
#include <QQmlEngine>

UiDialogWindow::UiDialogWindow(QWindow* parent)
    : QQuickWindow(parent), pDialogType(1), pButtonsList(new UiDialogButtonModelList(parent)), pSubtitle(""),
    pDescription(""), pNotice(""), pDialogImageSource(""), pCheckBoxText(""), pCheckBoxState(false), pHyperlink(""), pCloseBtnVisible(true)
{
    QObject::connect(this, &UiDialogWindow::visibleChanged, [=] { if (transientParent() != nullptr) { this->setScreen(transientParent()->screen()); } });
}

int UiDialogWindow::dialogType() const
{
    return pDialogType;
}

void UiDialogWindow::setDialogType(const int& dialogType)
{
    pDialogType = dialogType;
    emit dialogTypeChanged();
}

UiDialogButtonModelList* UiDialogWindow::buttonsList() const
{
    return pButtonsList;
}

void UiDialogWindow::setButtonsList(UiDialogButtonModelList* buttonsList)
{
    pButtonsList = buttonsList;
    emit buttonsListChanged();
}

QString UiDialogWindow::subtitle() const
{
    return pSubtitle;
}

void UiDialogWindow::setSubtitle(const QString& subtitle)
{
    pSubtitle = subtitle;
    emit subtitleChanged();
}

QString UiDialogWindow::description() const
{
    return pDescription;
}

void UiDialogWindow::setDescription(const QString& description)
{
    pDescription = description;
    emit descriptionChanged();
}

QString UiDialogWindow::notice() const
{
    return pNotice;
}

void UiDialogWindow::setNotice(const QString& notice)
{
    pNotice = notice;
    emit noticeChanged();
}

QString UiDialogWindow::dialogImageSource() const
{
    return pDialogImageSource;
}

void UiDialogWindow::setDialogImageSource(const QString& dialogImageSource)
{
    pDialogImageSource = dialogImageSource;
    emit dialogImageSourceChanged();
}

QString UiDialogWindow::checkBoxText() const
{
    return pCheckBoxText;
}

void UiDialogWindow::setCheckBoxText(const QString& checkBoxText)
{
    pCheckBoxText = checkBoxText;
    emit checkBoxTextChanged();
}

bool UiDialogWindow::checkBoxState() const
{
    return pCheckBoxState;
}

void UiDialogWindow::setCheckBoxState(const bool& checkBoxState)
{
    pCheckBoxState = checkBoxState;
    emit checkBoxStateChanged();
}

QString UiDialogWindow::hyperlink() const
{
    return pHyperlink;
}

void UiDialogWindow::setHyperlink(const QString& hyperlink)
{
    pHyperlink = hyperlink;
    emit hyperlinkChanged();
}

bool UiDialogWindow::closeBtnVisible() const
{
    return pCloseBtnVisible;
}

void UiDialogWindow::setCloseBtnVisible(const bool& closeBtnVisible)
{
    pCloseBtnVisible = closeBtnVisible;
    emit closeBtnVisibleChanged();
}

int UiDialogWindow::getDialogOwnership()
{
    return QQmlEngine::objectOwnership(this);
}
