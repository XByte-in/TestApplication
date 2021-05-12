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

Button {
    id: iControl

    property QtObject pSize
    property QtObject pColor
    property QtObject pColorState: down ? pColor.click :
                                          hovered ? pColor.hover : pColor.normal
    property string asset
    property string extn: ".svg"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: pSize.height

    horizontalPadding: pSize.horizontalPadding
    verticalPadding: 0
    spacing: pSize.spacing

    text: "Label"
    font: pSize.textFont

    background: Rectangle {
        color: iControl.pColorState.background
        radius: iControl.pSize.radius
    }

    contentItem: UiRowLayout {
        spacing: iControl.spacing
        UiImage {
            asset: iControl.asset
            extn: iControl.extn
            visible: asset != ""
            Layout.preferredWidth: iControl.pSize.iconWidth
            Layout.preferredHeight: iControl.pSize.iconHeight
            sourceSize.width: (iControl.extn === ".svg") ? iControl.pSize.iconWidth : undefined
            sourceSize.height: (iControl.extn === ".svg") ? iControl.pSize.iconHeight : undefined
        }
        Text {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: iControl.text
            font: iControl.font
            color: iControl.pColorState.textColor
            elide: Text.ElideRight
        }
    }
}
