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
    id: iRoot
    color: "transparent"
    visible: pSettingsButtonVisible
    property bool pSettingsButtonVisible: true
    property alias pSettingBtnText: iSettingsText.text
    property alias pSettingBtnColor: iSettingsText.color
    property bool pSelected: false
    property int pSettingIdx: 0

    signal settingClicked()

    focus: true
    Layout.preferredWidth: 180
    Layout.preferredHeight: iSettingsBtnLayout.implicitHeight

    UiColumnLayout {
        id: iSettingsBtnLayout
        topPadding: 6
        bottomPadding: 6
        Text {
            id: iSettingsText
            text: "Display"
            color: iHighlighter.visible ? UiTheme.colors.primary10 : UiTheme.colors.primary20
            font: UiTheme.fonts.bodyLarge
            Layout.maximumWidth: iRoot.width
            Layout.alignment: Qt.AlignLeft
            elide: Text.ElideRight
        }

        Rectangle {
            id: iHighlighter
            Layout.preferredWidth: iSettingsText.width
            Layout.preferredHeight: 1.5
            color: UiTheme.colors.accentNormal
            opacity: pSelected ? 1 : 0
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            settingClicked()
            iRoot.forceActiveFocus()
        }
    }
}
