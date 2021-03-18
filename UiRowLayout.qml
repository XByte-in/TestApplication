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
    default property alias pChildren: iRowLayout.data

    property alias pMouseArea: mouseArea

    property alias leftPadding: iRowLayout.anchors.leftMargin
    property alias topPadding: iRowLayout.anchors.topMargin
    property alias rightPadding: iRowLayout.anchors.rightMargin
    property alias bottomPadding: iRowLayout.anchors.bottomMargin
    property alias padding: iRowLayout.anchors.margins

    property alias spacing: iRowLayout.spacing

    implicitWidth: iRowLayout.implicitWidth + leftPadding + rightPadding
    implicitHeight: iRowLayout.implicitHeight + topPadding + bottomPadding
    color: "transparent"

    RowLayout {
        id: iRowLayout
        x: leftPadding
        y: topPadding
        width: parent.width - leftPadding - rightPadding
        height: parent.height - topPadding - bottomPadding
        anchors.margins: 0
        spacing: 0
    }

    MouseArea {
        id: mouseArea
        enabled: false
    }
}
