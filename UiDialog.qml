/*
 * Copyright (C) 2020-2021 BlueStack Systems, Inc.
 * All Rights Reserved
 *
 * THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF BLUESTACK SYSTEMS, INC.
 * The copyright notice above does not evidence any actual or intended
 * publication of such source code.
 */

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import DialogButtonModelList 1.0

Dialog {
    id: iControl

    enum DialogTypes {
        SimpleNarrow,
        Simple,
        Descriptive,
        Tall
    }

    property QtObject pSize: pDialogType === UiDialog.DialogTypes.SimpleNarrow
                             ? UiTheme.dialogs.sizes.simpleNarrow : pDialogType === UiDialog.DialogTypes.Simple
                               ? UiTheme.dialogs.sizes.simple : pDialogType === UiDialog.DialogTypes.Descriptive
                                 ? UiTheme.dialogs.sizes.descriptive : UiTheme.dialogs.sizes.tall
    property QtObject pColor: UiTheme.dialogs.colors.accent

    property int pDialogType
    property DialogButtonModelList pButtonsList: DialogButtonModelList { }
    property string pDescription
    property string pSubtitle: ""
    property string pNotice: ""
    property string pDialogImageSource: ""
    property string pCheckBoxText: ""
    property string pHyperlink: ""
    property bool pCheckBoxState: iDialogCheckBox.checked
    property bool pCloseBtnVisible: true

    signal closeClicked()
    signal checkBoxClicked(var checked)
    signal hyperlinkClicked()

    width: pSize.width
    height: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                     implicitContentHeight + topPadding + bottomPadding
                     + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                     + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: pSize.padding
    topPadding: pSize.contentTopMargin
    bottomPadding: pSize.contentBottomMargin

    background: Rectangle {
        color: iControl.pColor.background
        border {
            color: iControl.pColor.border
            width: 1
        }
    }

    header: UiColumnLayout {
        spacing: iControl.pSize.headerVerticalSpacing
        UiRowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: iControl.padding
            Layout.rightMargin: iControl.padding
            Layout.topMargin: iControl.padding
            spacing: iControl.pSize.headerHorizontalSpacing
            UiImage {
                visible: pDialogImageSource != ""
                         && (iControl.pDialogType === UiDialog.DialogTypes.Simple || iControl.pDialogType === UiDialog.DialogTypes.SimpleNarrow)
                asset: pDialogImageSource
                Layout.preferredWidth: iControl.pSize.iconWidth
                Layout.preferredHeight: iControl.pSize.iconHeight
            }
            Text {
                visible: iControl.pDialogType === UiDialog.DialogTypes.SimpleNarrow
                         || iControl.pDialogType === UiDialog.DialogTypes.Simple
                         || iControl.pDialogType === UiDialog.DialogTypes.Descriptive
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignLeft
                text: iControl.title
                font: iControl.pSize.titleFont
                color: iControl.pColor.title
                elide: Text.ElideRight
            }
            UiImageButton {
                visible: iControl.pCloseBtnVisible
                asset: "CloseIcon"
                Layout.preferredHeight: 16
                Layout.preferredWidth: 16
                Layout.alignment: Qt.AlignRight
                onClicked: {
                    iControl.closeClicked()
                }
            }
        }
        UiImage {
            visible: pDialogImageSource != "" && iControl.pDialogType === UiDialog.DialogTypes.Tall
            asset: pDialogImageSource
            Layout.preferredWidth: iControl.pSize.iconWidth
            Layout.preferredHeight: iControl.pSize.iconHeight
            Layout.alignment: Qt.AlignHCenter
        }
    }

    contentItem: UiRowLayout {
        spacing: iControl.pSize.contentHorizontalSpacing
        UiImage {
            visible: pDialogImageSource != "" && iControl.pDialogType === UiDialog.DialogTypes.Descriptive
            asset: pDialogImageSource
            Layout.preferredWidth: iControl.pSize.iconWidth
            Layout.preferredHeight: iControl.pSize.iconHeight
            Layout.alignment: Qt.AlignTop
        }
        UiColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: iControl.pSize.contentVerticalSpacing
            Text {
                visible: iControl.pDialogType === UiDialog.DialogTypes.Tall && text !== ""
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: iControl.title
                font: iControl.pSize.titleFont
                color: iControl.pColor.title
                wrapMode: Text.Wrap
            }
            Text {
                visible: text !== ""
                Layout.fillWidth: true
                text: iControl.pSubtitle
                horizontalAlignment: iControl.pDialogType === UiDialog.DialogTypes.Tall ? Text.AlignHCenter : undefined
                font: iControl.pSize.subtitleFont
                color: iControl.pColor.subtitle
                wrapMode: Text.Wrap
            }
            Text {
                visible: text !== ""
                Layout.fillWidth: true
                text: iControl.pDescription
                horizontalAlignment: iControl.pDialogType === UiDialog.DialogTypes.Tall ? Text.AlignHCenter : undefined
                font: iControl.pSize.descriptionFont
                color: iControl.pColor.description
                wrapMode: Text.Wrap
            }
            Text {
                visible: text !== ""
                Layout.fillWidth: true
                horizontalAlignment: iControl.pDialogType === UiDialog.DialogTypes.Tall ? Text.AlignHCenter : undefined
                text: iControl.pNotice
                font: iControl.pSize.noticeFont
                color: iControl.pColor.notice
                wrapMode: Text.Wrap
            }
            Text {
                id: iHyperlinkText
                visible: text !== ""
                Layout.fillWidth: true
                horizontalAlignment: iControl.pDialogType === UiDialog.DialogTypes.Tall ? Text.AlignHCenter : undefined
                text: iControl.pHyperlink
                font: UiTheme.fonts.bodySmall
                color: UiTheme.colors.accentNormal
                wrapMode: Text.Wrap
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onEntered:  {
                        iHyperlinkText.font.underline = true
                    }
                    onExited:  {
                        iHyperlinkText.font.underline = false
                    }
                    onClicked: {
                        iControl.hyperlinkClicked()
                    }
                }
            }
            UiCheckBox {
                id: iDialogCheckBox
                visible: text !== ""
                Layout.maximumWidth: parent.width
                Layout.alignment: iControl.pDialogType === UiDialog.DialogTypes.Tall ? Qt.AlignHCenter : Qt.AlignLeft
                pSize: UiTheme.checkBoxes.sizes.medium
                text: iControl.pCheckBoxText
                onClicked: {
                    iControl.checkBoxClicked(checked)
                }
            }
        }
    }

    footer: Control {
        id: iControlFooter

        implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
        implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                 topPadding + bottomPadding + listView.contentItem.childrenRect.height)

        spacing: iControl.pDialogType === UiDialog.DialogTypes.Tall
                 ? iControl.pSize.footerVerticalSpacing : iControl.pSize.footerHorizontalSpacing
        topPadding: 0
        leftPadding: iControl.padding +
                     ((pDialogImageSource != "" && iControl.pDialogType === UiDialog.DialogTypes.Descriptive)
                      ? iControl.pSize.iconWidth + iControl.pSize.contentHorizontalSpacing : 0)
        rightPadding: iControl.padding
        bottomPadding: iControl.padding

        contentItem: ListView {
            id: listView
            model: iControl.pButtonsList.pButtons
            spacing: iControlFooter.spacing
            orientation: iControl.pDialogType === UiDialog.DialogTypes.Tall ? ListView.Vertical : ListView.Horizontal
            layoutDirection: Qt.RightToLeft
            onCountChanged:{
                if(listView.contentWidth > iControlFooter.availableWidth)
                    listView.orientation = ListView.Vertical
            }

            delegate: UiButton {
                pSize: model.modelData.pSize === null ? UiTheme.buttons.sizes.medium : model.modelData.pSize
                pColor: model.modelData.pColor === null ? UiTheme.buttons.colors.accent : model.modelData.pColor
                text: model.modelData.pText
                width: listView.orientation ===  ListView.Vertical ?iControlFooter.availableWidth:implicitWidth
                onClicked: {
                    model.modelData.clicked()
                }
            }
        }

        background: Rectangle {
            color: "transparent"
        }
    }
}
