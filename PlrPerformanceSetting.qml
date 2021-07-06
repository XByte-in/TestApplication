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
Item {
    property bool   pCompLoaded: false
    property bool   pEnableSave: false
    property string pParentWindow: ""
    property string pVmName: ""

    property int    pMaxRam: 4096
    property int    pMaxCpu: 8

    property int    pDefaultCpu: -1
    property int    pDefaultRam: -1

    property int pCurrentCpu: -11
    property ListModel pCustomCpuModel: ListModel{}
    Component.onCompleted: {
        if (!pCompLoaded) {
            fGetMaxRamAndCpu()
            fInitUi()
        }
        pCompLoaded = true
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
                    Text {
                        text: qsTranslate("QObject", "CPU allocation")
                        font: UiTheme.fonts.bodyLarge
                        color: UiTheme.colors.primary10
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                    }
                    UiRowLayout {
                        spacing: 8
                        UiComboBox {
                            id: iCpuCombobox
                            pSize: UiTheme.comboBoxes.sizes.medium
                            model: [
                                { value: 4, text: qsTranslate("QObject", "High (%1 Cores)").arg("4") },
                                { value: 2, text: qsTranslate("QObject", "Medium (%1 Cores)").arg("2") },
                                { value: 1, text: qsTranslate("QObject", "Low (1 Core)") },
                                { value: 1, text: qsTranslate("QObject", "Custom") }
                            ]
                            textRole: "text"
                            valueRole: "value"
                            Layout.preferredWidth: 200
                            onActivated: {
                                if (pCompLoaded) {
                                    pCurrentCpu = 2
                                    fMonitorChange()
                                }
                            }
                        }
                        UiComboBox {
                            id: iCustomCpuCombobx
                            pSize: UiTheme.comboBoxes.sizes.medium
                            model: pCustomCpuModel
                            Layout.preferredWidth: 200
                            visible: false
                            onActivated: {
                                if (pCompLoaded && iCpuCombobox.currentIndex === 3) {
                                    fMonitorChange()
                                }
                            }
                        }
                    }
                }
                UiTextUrl {
                    id: iRawModewarningText                    
                    Layout.fillWidth: true
                    text: qsTranslate("QObject", "BlueStacks is currently limited to using 1 CPU core. To utilize more CPU cores, please enable hardware-assisted virtualization.") + " " + "<a href=\"javascript:void(0)\">" + qsTranslate("QObject", "View solution") + "</a>"

                    font: UiTheme.fonts.bodySmall
                    color: UiTheme.colors.warning
                    linkColor: UiTheme.colors.accentNormal
                }
                Text {
                    id: iMaxCpuwarningTxt
                    visible: !iRawModewarningText.visible && (pCurrentCpu === pMaxCpu)
                    Layout.fillWidth: true
                    text: qsTranslate("QObject", "Assigning all CPU cores to BlueStacks will cause overall system to lag/slowdown")
                    font: UiTheme.fonts.bodySmall
                    color: UiTheme.colors.warning
                    wrapMode: Text.Wrap
                }

                Rectangle {
                    height: 1
                    color: UiTheme.colors.primary70
                    Layout.fillWidth: true
                }
                UiColumnLayout {
                    spacing: 12
                    Text {
                        text: qsTranslate("QObject", "RAM allocation")
                        font: UiTheme.fonts.bodyLarge
                        color: UiTheme.colors.primary10
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                    }
                    UiRowLayout {
                        spacing: 8
                        UiComboBox {
                            id: iRamCombobox
                            pSize: UiTheme.comboBoxes.sizes.medium
                            model: [
                                { value: "4096", text: qsTranslate("QObject", "High") + "(4 GB)" },
                                { value: "2048", text: qsTranslate("QObject", "Medium") + "(2 GB)" },
                                { value: "1024", text: qsTranslate("QObject", "Low") + "(1 GB)" },
                                { value: "1024", text: qsTranslate("QObject", "Custom") + " (MB)" }
                            ]
                            textRole: "text"
                            valueRole: "value"
                            Layout.preferredWidth: 200

                        }
                        UiTextField {
                            id: iCustomRamTextField
                            pSize: UiTheme.textFields.sizes.medium
                            Layout.preferredWidth: 200
                            visible: false
                            text: "4096"
                            validator: IntValidator {bottom: 600; top: pMaxRam}
                            inputMethodHints: Qt.ImhDigitsOnly
                            maximumLength: 5
                            pInputValidationState: acceptableInput ? UiTextField.InputValidation.Valid : UiTextField.InputValidation.Error
                            pOpenErrorTemplate: activeFocus && pInputValidationState === UiTextField.InputValidation.Error
                            pErrorTemplateContent: qsTranslate("QObject", "Supported RAM range is : %1").arg("600-" + pMaxRam)

                        }
                    }
                }
                Rectangle {
                    height: 1
                    color: UiTheme.colors.primary70
                    Layout.fillWidth: true
                }

                UiColumnLayout {
                    Layout.fillWidth: true
                    spacing: 12
                    UiSlider {
                        id: iFrameRateSlider
                        pSize: UiTheme.sliders.sizes.medium
                        enabled: pParentWindow == "plr" ? !pIsEcoModeEnabled : true
                        from: 1
                        to: 60
                        stepSize: 1
                        value: 100
                        Layout.fillWidth: true
                        pSelectedValueText: qsTranslate("QObject", "Frame rate") + " : "+ value
                        pRangeValueVisibility: true

                    }
                    UiColumnLayout {
                        spacing: 4
                        Layout.fillWidth: true
                        Text {
                            text: qsTranslate("QObject", "Recommended FPS")
                            font : UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary30
                        }
                        Text {
                            Layout.fillWidth: true
                            text: qsTranslate("QObject", "60 FPS for smoother gameplay (may effect performance on some entry level PC’s) 20 FPS for multi-instance (few games might fail to run smoothly)")
                            font : UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary30
                            wrapMode: Text.Wrap
                        }
                    }
                    UiColumnLayout {
                        Layout.fillWidth: true
                        visible: pParentWindow ==="plr"?true:false
                        spacing: 12
                        UiRowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            Text {
                                text: qsTranslate("QObject", "Enable high frame rate")
                                font : UiTheme.fonts.bodyMedium
                                color: UiTheme.colors.primary20
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                            UiToggleButton {
                                id: iEnableHighFpsToggleBtn

                            }
                        }
                        UiRowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            Text {
                                text: qsTranslate("QObject", "Enable VSync (To prevent screen tearing)")
                                font : UiTheme.fonts.bodyMedium
                                color: UiTheme.colors.primary20
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                            UiToggleButton {
                                id: iEnableVSyncToggleBtn

                            }
                        }
                        UiRowLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            Text {
                                text: qsTranslate("QObject", "Display FPS during gameplay")
                                font : UiTheme.fonts.bodyMedium
                                color: UiTheme.colors.primary20
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                            UiToggleButton {
                                id: iEnableFpsDisplayToggleBtn

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
                text: qsTranslate("QObject", "Some changes will apply on next launch")
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

    function fGetMaxRamAndCpu() {
        var machineRam = parseFloat(4096)
        var maxRam = machineRam * 0.75


            pMaxRam = maxRam

        var machineCpu = 8
        if (machineCpu < pMaxCpu)
            pMaxCpu = machineCpu

        for (var i = 1; i <= pMaxCpu; i++) {
            pCustomCpuModel.append({ name: i})
        }
    }

    function fInitUi() {
        pDefaultCpu = 2
        pCurrentCpu = pDefaultCpu
        pDefaultRam = 4096
        var fpsValue = parseInt(20)
        iEnableFpsDisplayToggleBtn.checked = true
        iEnableVSyncToggleBtn.checked = true
        iEnableHighFpsToggleBtn.checked = false

        if(iEnableHighFpsToggleBtn.checked) {
            iFrameRateSlider.to = 240
        }
        else {
            if(fpsValue > 60)
                fpsValue = 60
            iFrameRateSlider.to = 60
        }
        iFrameRateSlider.value = fpsValue

        fReloadComboboxes()
    }

    function fReloadComboboxes() {
        iCustomCpuCombobx.visible = false
        iCustomRamTextField.visible = false

        if (pDefaultCpu === 4) {
            iCpuCombobox.currentIndex = 0
        }
        else if (pDefaultCpu === 2) {
            iCpuCombobox.currentIndex = 1
        }
        else if (pDefaultCpu === 1) {
            iCpuCombobox.currentIndex = 2
        }
        else {
            iCpuCombobox.currentIndex = 3
            iCustomCpuCombobx.visible = true
        }
        iCustomCpuCombobx.currentIndex = pDefaultCpu - 1

        if (pDefaultRam === 4096) {
            iRamCombobox.currentIndex = 0
        }
        else if (pDefaultRam === 2048) {
            iRamCombobox.currentIndex = 1
        }
        else if (pDefaultRam === 1024) {
            iRamCombobox.currentIndex = 2
        }
        else {
            iRamCombobox.currentIndex = 3
            iCustomRamTextField.visible = true
        }
        iCustomRamTextField.text = pDefaultRam

        pEnableSave = false
    }

    function fMonitorChange() {
        pEnableSave = true
    }

    function fUpdateFpsSliderValueAndText(checked) {
        if (checked) {
            iFrameRateSlider.to = 240
        } else {
            if (parseInt(iFrameRateSlider.value) > 60) {
                iFrameRateSlider.value = 60
            }
            iFrameRateSlider.to = 60
        }
    }

    function fHandleConfChange() {

    }

    function fDiscardChanges() {
        fInitUi()
        iSettingsWindow.fSwitchSettingPanel()
    }
}
