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
import QtQuick.Window 2.15

Window {
    id: messageWindow
    width: dialog.width + 2 * shadowContainer.shadowThickness
    height: dialog.height + 2 * shadowContainer.shadowThickness
    x: transientParent.x + (transientParent.width - width) / 2
    y: transientParent.y + (transientParent.height - height) / 2
    screen: transientParent.screen
    flags: Qt.Dialog | Qt.FramelessWindowHint
    modality: Qt.ApplicationModal
    color: "transparent"

    property alias pDialogType: dialog.pDialogType
    property alias pButtonsList: dialog.pButtonsList
    property alias pDescription: dialog.pDescription
    property alias pNotice: dialog.pNotice
    property alias pDialogImageSource: dialog.pDialogImageSource
    property alias pCheckBoxText: dialog.pCheckBoxText
    property bool pCheckBoxState: dialog.pCheckBoxState

    signal closeClicked

    onVisibleChanged: {
        if (visible)
            dialog.open()
    }

    UiShadowContainer {
        id: shadowContainer
        UiDialog {
            id: dialog
            title: messageWindow.title
            closePolicy: Popup.NoAutoClose
            onCloseClicked: {
                messageWindow.closeClicked()
                close()
            }
            onClosed: {
                messageWindow.close()
                messageWindow.destroy()
            }
        }
    }
}
