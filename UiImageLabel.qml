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

Control {
    id: iControl

    default property alias children: iContentLayout.pChildren

    property QtObject pSize
    property string pText
    property string pImageAsset
    property bool pHovered: hovered
    property color pBackgroundColor: "transparent"

    signal clicked

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + leftInset + rightInset,
                             implicitContentHeight + leftPadding + rightPadding)

    spacing: pSize.spacing
    font: pSize.textFont

    background: Rectangle {
        color: iControl.pBackgroundColor
    }

    contentItem: UiRowLayout {
        id: iContentLayout
        spacing: iControl.spacing
        UiImage {
            asset: iControl.pImageAsset + (iControl.pHovered ? "_hover" : "")
            pImageWidth: iControl.pSize.imageWidth
            pImageHeight: iControl.pSize.imageHeight
        }
        Text {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: iControl.pText
            font: iControl.font
            color: iControl.pHovered ? UiTheme.colors.primary10 : UiTheme.colors.primary20
            elide: Text.ElideRight
            lineHeightMode: Text.FixedHeight
            lineHeight: 16
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked:{
            iControl.clicked()
        }
    }
}
