/*
 * Copyright (C) 2020-2021 BlueStack Systems, Inc.
 * All Rights Reserved
 *
 * THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF BLUESTACK SYSTEMS, INC.
 * The copyright notice above does not evidence any actual or intended
 * publication of such source code.
 */

import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    property string toolTipText: ""
    id: mainWindow
    width: toolTipTextBox.width + 10 + 2 * toolTipShadowContainer.shadowThickness
    height: toolTipTextBox.height + 10 + 2 * toolTipShadowContainer.shadowThickness
    color: "transparent"
    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.NoFocus

    UiShadowContainer{
        id: toolTipShadowContainer
        glowRadius: 2
        cornerRadius: 4
        Rectangle {
            id: toolTipRect
            anchors.fill: parent
            color: UiTheme.colors.primary80
            border.width: 1
            border.color: UiTheme.colors.primary60
            Text {
                id: toolTipTextBox
                anchors.centerIn: parent
                anchors.margins: 4
                text: toolTipText
                color: UiTheme.colors.primary10
                font: UiTheme.fonts.bodyMedium
            }
        }
    }
}
