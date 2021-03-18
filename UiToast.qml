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

Rectangle {

    id: iToastRect

    readonly property real pDefaultTime: 3000
    property real pTime: pDefaultTime
    readonly property real pFadeTime: 300
    property real pMargin: 8

    height: iMessage.height + pMargin
    width: iMessage.width + pMargin * 2
    radius: height / 2
    opacity: 0
    color: UiTheme.colors.overLayBlack
    anchors {
        left: parent.left
        right: parent.right
        margins: pMargin
    }

    UiRowLayout{
        id: iLayout
        anchors.fill: parent
        spacing: 0
        Layout.alignment: Qt.AlignVCenter
        Text {
            id: iMessage
            color: UiTheme.colors.secondaryHover
            font: UiTheme.fonts.titleSmall
            wrapMode: Text.Wrap
            Layout.leftMargin: 8
            width: iToastRect.width - 40
            Layout.maximumWidth: iToastRect.width - 40
            horizontalAlignment: Text.AlignHCenter
        }
        UiImageButton{
            asset: "CloseIcon"
            width: 16
            height: 16
            Layout.rightMargin: 8
            onClicked: {
                iCloseAnimation.start()
                iToastRect.visible = false
            }
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
                iToastRect.visible = false
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
                iToastRect.visible = false
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
        iToastRect.visible = true
        iFullAnimation.start();
    }
}
