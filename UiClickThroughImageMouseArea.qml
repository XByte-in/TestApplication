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
import QtQuick.Shapes 1.12

import UiToolTipControl 1.0

UiImage {
    id: rytImage
    asset: "EditorDpad"
    pImageWidth: 200
    pImageHeight: pImageWidth
    MouseArea {
        propagateComposedEvents: true
        anchors.fill: parent
        onClicked: {
            console.log("Right Image clicked 2")
        }
    }
}
