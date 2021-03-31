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

UiRowLayout {
    id: iToastRow
    readonly property real pDefaultTime: 3000
    property real pTime: pDefaultTime
    readonly property real pFadeTime: 300
    property real pMargin: 8
    property bool pShowCross: true

    color: UiTheme.colors.overLayBlack

    x: parent.x + parent.width/2 - width/2
    y: parent.y + 20

    leftPadding: 10
    rightPadding: 10
    topPadding: 5
    bottomPadding: 5

    spacing: 10

    visible: false
    Layout.alignment: Qt.AlignVCenter
    Text {
        id: iMessage
        color: UiTheme.colors.secondaryHover
        font: UiTheme.fonts.bodySmall
        wrapMode: Text.Wrap
    }
    UiImageButton{
        asset: "CloseIcon"
        width: 16
        height: 16
        visible: pShowCross
        onClicked: {
            iCloseAnimation.start()
            iToastRow.visible = false
        }
    }
    SequentialAnimation on opacity {
        id: iFullAnimation
        running: false


        NumberAnimation {
            to: 1
            duration: pFadeTime
        }

        PauseAnimation {
            duration: pTime - 2 * pFadeTime
        }

        NumberAnimation {
            to: 0
            duration: pFadeTime
        }
        onRunningChanged: {
            if(!running)
                iToastRow.visible = false
        }
    }

    SequentialAnimation on opacity {
        id: iCloseAnimation
        running: false

        NumberAnimation {
            to: 0
            duration: pFadeTime
        }
        onRunningChanged: {
            if(!running)
                iToastRow.visible = false
        }
    }


    function fShow(text, duration) {
        iMessage.text = text;
        if (typeof duration !== "undefined") { // checks if parameter was passed
            pTime = Math.max(duration, 2 * pFadeTime);
        }
        else {
            pTime = pDefaultTime;
        }
        iToastRow.visible = true
        iFullAnimation.start();
    }
}
