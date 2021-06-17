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
import QtQuick.Window 2.15
import QtQuick.Shapes 1.12

UiWindowedPopup {
    id: iPopup

    enum ArrowPosition {
        TopCenter,
        BottomCenter
    }

    default property alias pChildren: iInnerLayout.pChildren

    property int arrowPosition: UiHelpPopup.ArrowPosition.BottomCenter
    property alias pInnerLayout: iInnerLayout

    contentWidth: 200
    contentHeight: iInnerLayout.implicitHeight
    screen: transientParent.screen

    UiColumnLayout {
        id: iInnerLayout
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Shape {
        width: 16
        anchors.top: iPopup.arrowPosition === UiHelpPopup.ArrowPosition.BottomCenter
                     ? iInnerLayout.bottom : iPopup.arrowPosition === UiHelpPopup.ArrowPosition.TopCenter
                       ? iInnerLayout.top : undefined
        anchors.horizontalCenter: iPopup.arrowPosition === UiHelpPopup.ArrowPosition.BottomCenter || iPopup.arrowPosition === UiHelpPopup.ArrowPosition.TopCenter
                                  ? iInnerLayout.horizontalCenter : undefined
        height: 8
        ShapePath {
            strokeColor: iInnerLayout.color
            fillColor: iInnerLayout.color
            startX: 0
            startY: iPopup.arrowPosition === UiHelpPopup.ArrowPosition.TopCenter ? 1 : -1
            PathLine {
                x: 8
                y: iPopup.arrowPosition === UiHelpPopup.ArrowPosition.TopCenter ? -8 : 8
            }
            PathLine {
                x: 16
                y: iPopup.arrowPosition === UiHelpPopup.ArrowPosition.TopCenter ? 1 : -1
            }
        }
        ShapePath {
            strokeColor: iInnerLayout.border.color
            fillColor: iInnerLayout.color
            startX: 0
            startY: 0
            PathLine {
                x: 8
                y: iPopup.arrowPosition === UiHelpPopup.ArrowPosition.BottomCenter ? 8 : -8
            }
            PathLine {
                x: 16
                y: 0
            }
        }
    }

    onClosePopup: {
        iPopup.close()
        iPopup.destroy()
    }
}
