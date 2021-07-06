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

UiImage {
    id: iControl
    property bool pAllowClickThrough: true
    property bool pPropagateComposedEvents: true
    property int pAcceptedButtons: Qt.LeftButton | Qt.RightButton

    signal pressed(var mouse)
    signal sPositionChanged(var mouse)
    signal sReleased(var mouse)
    MouseArea {
        anchors.fill: iControl
        propagateComposedEvents: pPropagateComposedEvents
        acceptedButtons: pAcceptedButtons
        onPressed: {
            if(pAllowClickThrough) {
                mouse.accepted = mainBackend.isTransparentClickAccepted(iControl.source, iControl.width, iControl.height, mouse.x, mouse.y)
                if(mouse.accepted)
                   iControl.pressed(mouse)
            } else iControl.pressed(mouse)
        }
        onPositionChanged: {
            sPositionChanged(mouse)
        }
        onReleased: sReleased(mouse)
    }
}
