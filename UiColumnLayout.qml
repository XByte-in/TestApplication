/*
 * Copyright (C) 2020-2021 BlueStack Systems, Inc.
 * All Rights Reserved
 *
 * THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF BLUESTACK SYSTEMS, INC.
 * The copyright notice above does not evidence any actual or intended
 * publication of such source code.
 */

import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    default property alias pChildren: iColumnLayout.data

    property alias pMouseArea: mouseArea

    property alias leftPadding: iColumnLayout.anchors.leftMargin
    property alias topPadding: iColumnLayout.anchors.topMargin
    property alias rightPadding: iColumnLayout.anchors.rightMargin
    property alias bottomPadding: iColumnLayout.anchors.bottomMargin
    property alias padding: iColumnLayout.anchors.margins

    property alias spacing: iColumnLayout.spacing

    implicitWidth: iColumnLayout.implicitWidth + leftPadding + rightPadding
    implicitHeight: iColumnLayout.implicitHeight + topPadding + bottomPadding
    color: "transparent"

    MouseArea {
        id: mouseArea
        enabled: false
    }

    ColumnLayout {
        id: iColumnLayout
        x: leftPadding
        y: topPadding
        width: parent.width - leftPadding - rightPadding
        height: parent.height - topPadding - bottomPadding
        anchors.margins: 0
        spacing: 0
    }
}
