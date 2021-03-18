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
import UiToolTipControl 1.0

Button {
    id: iControl

    property string asset
    property string extn: ".svg"
    property var pMouseCursor

    horizontalPadding: 0
    verticalPadding: 0
    spacing: 0
    opacity: enabled ? 1 : 0.4

    display: AbstractButton.IconOnly
    UiToolTip.visible: hovered

    background: Rectangle {
        color: "transparent"
    }

    contentItem: UiImage {
        anchors.centerIn: parent
        asset: iControl.asset + (iControl.down ? "_click" : (iControl.hovered ? "_hover" : ""))
        extn: iControl.extn
        width: iControl.availableWidth
        height: iControl.availableHeight
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: iControl.pMouseCursor
        onPressed: {
            UiToolTip.visible = false
            mouse.accepted = false
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
