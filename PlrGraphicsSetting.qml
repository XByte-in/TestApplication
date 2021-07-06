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
import UiToolTipControl 1.0

Item {
    property bool pCompLoaded: false
    property bool pEnableSave: false

    property string pParentWindow: ""

    property UiRadioButton pDefautEngineBtn: iPgaBtn
    property UiRadioButton pDefautRendererBtn: iOpenglBtn
    property bool pIsHwAstcSupported: false

    property ListModel pAstcConfigModel : ListModel {}

    ListModel {
        id: qtRendererModel
        ListElement {
            text: "Auto"
            value: "Auto"
        }
        ListElement {
            text: "Software"
            value: "Software"
        }
        ListElement {
            text: "OpenGL"
            value: "OpenGLRhi"
        }
        ListElement {
            text: "DirectX"
            value: "Direct3D11Rhi"
        }
    }

    Component.onCompleted: {
        if (!pCompLoaded) {
            fInitUi()
        }
        pCompLoaded = true
    }

    ButtonGroup {
        id: iGraphicsEngineBtnGrp
        onCheckedButtonChanged: {
            if (pCompLoaded) {
                fMonitorChange()
            }
        }
    }

    ButtonGroup {
        id: iGraphicsRendereBtnGrp
        onCheckedButtonChanged: {
            if (pCompLoaded) {
                fMonitorChange()
            }
        }
    }

    UiColumnLayout {
        anchors.fill: parent
        spacing: 24
        UiScrollView {
            id: iScrollView
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            clip: true
            contentWidth: iContentLayout.width
            contentHeight: iContentLayout.height + 20

            UiColumnLayout {
                id: iContentLayout
                width: 520
                Layout.alignment: Qt.AlignTop
                spacing: 16
                UiColumnLayout {
                    spacing: 12
                    Layout.fillWidth: true
                    Text {
                        text: qsTranslate("QObject", "Graphics engine mode")
                        font: UiTheme.fonts.bodyLarge
                        color: UiTheme.colors.primary10
                    }
                    UiRowLayout {
                        Layout.fillWidth: true
                        spacing: 40
                        UiColumnLayout {
                            Layout.alignment: Qt.AlignTop
                            Layout.preferredWidth: (parent.width - parent.spacing) / 2
                            UiRadioButton {
                                id: iAgaBtn
                                text: qsTranslate("QObject", "Compatibility")
                                ButtonGroup.group: iGraphicsEngineBtnGrp
                                Layout.fillWidth: true
                            }
                            Text {
                                text: qsTranslate("QObject", "Advanced mode")
                                Layout.leftMargin: 23
                                font: UiTheme.fonts.bodySmall
                                color: UiTheme.colors.primary30
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                        }
                        UiColumnLayout {
                            Layout.alignment: Qt.AlignTop
                            Layout.preferredWidth: (parent.width - parent.spacing) / 2
                            UiRadioButton {
                                id: iPgaBtn
                                text: qsTranslate("QObject", "Performance")
                                checked: true
                                Layout.fillWidth: true
                                ButtonGroup.group: iGraphicsEngineBtnGrp
                            }
                            Text {
                                text: qsTranslate("QObject", "Legacy mode")
                                Layout.leftMargin: 23
                                font: UiTheme.fonts.bodySmall
                                color: UiTheme.colors.primary30
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
                Rectangle {
                    height: 1
                    color: UiTheme.colors.primary70
                    Layout.fillWidth: true
                }
                UiColumnLayout {
                    spacing: 12
                    Layout.fillWidth: true
                    UiRowLayout {
                        spacing: 8
                        Text {
                            text: qsTranslate("QObject", "Graphics renderer")
                            font: UiTheme.fonts.bodyLarge
                            color: UiTheme.colors.primary10
                        }
                        UiImageButton {
                            asset: "MenuHelp"
                            pImageWidth: 16
                            pImageHeight: 16
                            UiToolTip.text: qsTranslate("QObject", "Help")
                            pMouseCursor: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    UiRowLayout {
                        Layout.fillWidth: true
                        spacing: 40
                        UiRadioButton {
                            id: iOpenglBtn
                            Layout.preferredWidth: (parent.width - parent.spacing) / 2
                            Layout.alignment: Qt.AlignTop
                            text: "OpenGL"
                            checked: true
                            ButtonGroup.group: iGraphicsRendereBtnGrp
                        }
                        UiRadioButton {
                            id: iDirectxBtn
                            Layout.preferredWidth: (parent.width - parent.spacing) / 2
                            Layout.alignment: Qt.AlignTop
                            text: "DirectX"
                            ButtonGroup.group: iGraphicsRendereBtnGrp
                        }
                    }
                }
                Rectangle {
                    height: 1
                    color: UiTheme.colors.primary70
                    Layout.fillWidth: true
                }
                UiColumnLayout {
                    spacing: 12
                    Layout.fillWidth: true
                    UiRowLayout {
                        spacing: 8
                        Text {
                            text: qsTranslate("QObject", "Interface renderer")
                            font: UiTheme.fonts.bodyLarge
                            color: UiTheme.colors.primary10
                        }
                        UiImageButton {
                            asset: "MenuHelp"
                            pImageWidth: 16
                            pImageHeight: 16
                            UiToolTip.text: qsTranslate("QObject", "Help")
                            pMouseCursor: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    UiComboBox {
                        id: iQtRendererCombobox
                        pSize: UiTheme.comboBoxes.sizes.medium
                        model: qtRendererModel
                        textRole: "text"
                        valueRole: "value"
                        Layout.preferredWidth: 200
                        onActivated: {
                            if (pCompLoaded) {
                                fMonitorChange()
                            }
                        }
                    }
                }
                Rectangle {
                    height: 1
                    color: UiTheme.colors.primary70
                    Layout.fillWidth: true
                    visible: pParentWindow === "plr"
                }
                UiColumnLayout {
                    spacing: 12
                    visible: pParentWindow === "plr"
                    UiRowLayout {
                        spacing: 8
                        Text {
                            text: qsTranslate("QObject", "ASTC Textures (Beta)")
                            font: UiTheme.fonts.bodyLarge
                            color: UiTheme.colors.primary10
                        }
                        UiImageButton {
                            asset: "MenuHelp"
                            pImageWidth: 16
                            pImageHeight: 16
                            UiToolTip.text: qsTranslate("QObject", "Help")
                            pMouseCursor: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    UiComboBox {
                        id: iAstcCombobox
                        pSize: UiTheme.comboBoxes.sizes.medium
                        model: pAstcConfigModel
                        textRole: "display_name"
                        Layout.preferredWidth: 200
                        onActivated: {
                            if (pCompLoaded) {
                                iHwAstcNotSuppportedWarningTxt.visible = (!pIsHwAstcSupported && currentIndex === 2)
                                fMonitorChange()
                            }
                        }
                    }

                    Text {
                        id: iHwAstcNotSuppportedWarningTxt
                        Layout.fillWidth: true
                        text: qsTranslate("QObject", "Hardware decoding is not available, instead Software decoding will be used")
                        font: UiTheme.fonts.bodySmall
                        color: UiTheme.colors.warning
                        wrapMode: Text.Wrap
                        horizontalAlignment: Text.AlignLeft
                    }
                }
                Rectangle {
                    height: 1
                    color: UiTheme.colors.primary70
                    Layout.fillWidth: true
                    visible: pParentWindow === "plr"
                }
                UiColumnLayout {
                    spacing: 12
                    Layout.fillWidth: true
                    visible: pParentWindow === "plr"
                    UiColumnLayout {
                        spacing: 4
                        UiRowLayout {
                            spacing: 8
                            Text {
                                text: qsTranslate("QObject", "GPU in use")
                                font: UiTheme.fonts.bodyLarge
                                color: UiTheme.colors.primary10
                                horizontalAlignment: Text.AlignLeft
                            }
                            UiImageButton {
                                asset: "MenuHelp"
                                pImageWidth: 16
                                pImageHeight: 16
                                UiToolTip.text: qsTranslate("QObject", "Help")
                                pMouseCursor: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                            }
                        }
                        Text {
                            id: iAvailableGpuTxt
                            text: "NVIDIA GeForce RTX 2080Ti"
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary30
                            horizontalAlignment: Text.AlignLeft
                            Layout.fillWidth: true
                        }
                    }
                    UiRowLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        Text {
                            text: qsTranslate("QObject", "Prefer dedicated GPU(for NVIDIA GPU's)")
                            font: UiTheme.fonts.bodyMedium
                            color: UiTheme.colors.primary20
                            horizontalAlignment: Text.AlignLeft
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }
                        UiToggleButton {
                            id: iToggleDedicatedGraphics
                            onCheckedChanged: {
                                fMonitorChange()
                            }
                        }
                    }
                }
            }
        }

        UiRowLayout {
            spacing: 4
            Layout.fillWidth: true
            Layout.preferredHeight: 36

            UiImage {
                asset: "MenuInfo"
                pImageWidth: 12
                pImageHeight: 12
            }

            Text {
                text: qsTranslate("QObject", "Changes will apply on next launch")
                font : UiTheme.fonts.bodySmall
                color: UiTheme.colors.primary20
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                elide: Text.ElideRight
            }

            UiButton{
                pSize: UiTheme.buttons.sizes.medium
                pColor: UiTheme.buttons.colors.accent
                text: qsTranslate("QObject", "Save changes")
                opacity: pEnableSave ? 1 : 0.4
                enabled: pEnableSave

            }
        }
    }

    function fInitUi() {
        var engine = "pga"
        var renderer = "gl"
        iToggleDedicatedGraphics.checked = true


        if (engine === "pga")
            pDefautEngineBtn = iPgaBtn
        else
            pDefautEngineBtn = iAgaBtn

        if (renderer === "gl")
            pDefautRendererBtn = iOpenglBtn
        else
            pDefautRendererBtn = iDirectxBtn

        pDefautEngineBtn.checked = true
        pDefautRendererBtn.checked = true

        iQtRendererCombobox.currentIndex = find(qtRendererModel, function(item) { return item.value === "gl" });

        pAstcConfigModel.clear()
        pAstcConfigModel.append({ display_name: qsTranslate("QObject", "Disabled"), name: "disabled" })
        pAstcConfigModel.append({ display_name: qsTranslate("QObject", "Software Decoding"), name: "software"})
        pAstcConfigModel.append({ display_name: qsTranslate("QObject", "Hardware Decoding"), name: "hardware"})
        pEnableSave = false
    }

    function fSetPreviousState() {
        fInitUi()
    }

    function fMonitorChange() {
        pEnableSave = true
    }

    function fDiscardChanges() {
        fInitUi()
        iSettingsWindow.fSwitchSettingPanel()
    }

    function fHandleConfChange() {
    }

    function find(model, criteria) {
        for(var i = 0; i < model.count; ++i)
            if (criteria(model.get(i)))
                return i
        return -1
    }
}
