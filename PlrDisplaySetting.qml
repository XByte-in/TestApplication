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

Item {
    property bool pCompLoaded: false
    property bool pEnableSave: false
    property var pRecommendedResolution: ["1920 x 1080", "1080 x 1920", "2560 x 1080"]
    property int pDefaultWidth: 1920
    property int pDefaultHeight: 1080
    property string pParentWindow: ""
    property UiRadioButton pDefaultResBtn: null
    property UiRadioButton pDefaultDpiBtn: iDpi240
    property UiRadioButton pDefaultCursorBtn: iDefaultCursor
    property var pDefaultResComboboxIdx: 0

    property bool pWidthWarningPopupOpen: false
    property bool pHeightWarningPopupOpen: false

    Component.onCompleted: {
        if (!pCompLoaded) {
            fInitUi()
        }
        pCompLoaded = true
    }

    ButtonGroup {
        id: iResolutionBtnGrp
        onCheckedButtonChanged: {
            if (pCompLoaded) {
                var res = checkedButton.text.split("x")
                fMonitorChange()
            }
        }
    }

    ButtonGroup {
        id: iDpiBtnGrp
        onCheckedButtonChanged: {
            if (pCompLoaded) {
                var dpi = checkedButton.text.substr(0, 3)
                fMonitorChange()
            }
        }
    }

    ButtonGroup {
        id: iCursorBtnGrp
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
                    Layout.fillWidth: true
                    spacing: 12
                    Text {
                        id: iResolutionTxt
                        text: qsTranslate("QObject", "Display resolution")
                        font: UiTheme.fonts.bodyLarge
                        color: UiTheme.colors.primary10
                    }
                    UiComboBox {
                        id: iResolutionCombobox
                        pSize: UiTheme.comboBoxes.sizes.medium
                        model: [
                            qsTranslate("QObject", "Landscape"),
                            qsTranslate("QObject", "Portrait"),
                            qsTranslate("QObject", "Ultrawide"),
                            qsTranslate("QObject", "Custom")]
                        Layout.preferredWidth: 200
                    }

                    GridLayout {
                        id: iLandscapeGrid
                        columnSpacing: 40
                        rowSpacing: 12
                        rows: 2
                        columns: 3
                        UiRadioButton {
                            id: iRes960x540
                            text: "960 x 540"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes1280x720
                            text: "1280 x 720"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes1600x900
                            text: "1600 x 900"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes1920x1080
                            text: "1920 x 1080"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes2560x1440
                            text: "2560 x 1440"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                    }
                    GridLayout {
                        id: iPortraitGrid
                        columnSpacing: 40
                        rowSpacing: 12
                        rows: 2
                        columns: 3
                        visible: false

                        UiRadioButton {
                            id: iRes540x960
                            text: "540 x 960"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes720x1280
                            text: "720 x 1280"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes900x1600
                            text: "900 x 1600"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes1080x1920
                            text: "1080 x 1920"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes1440x2560
                            text: "1440 x 2560"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                    }
                    GridLayout {
                        id: iUltraWideGrid
                        columnSpacing: 40
                        rowSpacing: 12
                        rows: 2
                        columns: 3
                        visible: false

                        UiRadioButton {
                            id: iRes1680x720
                            text: "1680 x 720"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes2560x1080
                            text: "2560 x 1080"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes3440x1440
                            text: "3440 x 1440"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                        UiRadioButton {
                            id: iRes5120x2160
                            text: "5120 x 2160"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iResolutionBtnGrp
                        }
                    }
                    UiRowLayout {
                        id: iCustomResolutionRow
                        spacing: 12
                        visible: false
                        Text {
                            id: widthText
                            text: qsTranslate("QObject", "Width") + "(px)"
                            font: UiTheme.fonts.bodyLarge
                            color: UiTheme.colors.primary20
                            Layout.maximumWidth: 140
                            horizontalAlignment: Text.AlignLeft
                            elide: Text.ElideRight
                        }

                        UiTextField {
                            id: iCustomWidthTextField
                            pSize: UiTheme.textFields.sizes.medium
                            Layout.preferredWidth: 100
                            text: "1920"
                            validator: IntValidator {bottom: 540; top: 2560}
                            inputMethodHints: Qt.ImhDigitsOnly
                            maximumLength: 4
                            pInputValidationState: acceptableInput ? UiTextField.InputValidation.Valid : UiTextField.InputValidation.Error
                            pOpenErrorTemplate: activeFocus && pInputValidationState === UiTextField.InputValidation.Error
                            pErrorTemplateContent: qsTranslate("QObject", "Supported resolution range for Width is : %1").arg("540-2560")

                        }

                        Text {
                            text: qsTranslate("QObject", "Height") + "(px)"
                            font: UiTheme.fonts.bodyLarge
                            color: UiTheme.colors.primary20
                            Layout.maximumWidth: 140
                            horizontalAlignment: Text.AlignLeft
                            elide: Text.ElideRight
                        }

                        UiTextField {
                            id: iCustomHeightTextField
                            pSize: UiTheme.textFields.sizes.medium
                            Layout.preferredWidth: 100
                            text: "1080"
                            validator: IntValidator {bottom: 540; top: 2560}
                            inputMethodHints: Qt.ImhDigitsOnly
                            maximumLength: 4
                            pInputValidationState: acceptableInput ? UiTextField.InputValidation.Valid : UiTextField.InputValidation.Error
                            pOpenErrorTemplate: activeFocus && pInputValidationState === UiTextField.InputValidation.Error
                            pErrorTemplateContent: qsTranslate("QObject", "Supported resolution range for Height is : %1").arg("540-2560")
                            onTextChanged: {
                                if (pCompLoaded) {

                                    fMonitorChange()
                                }
                            }
                        }
                    }
                    Text {
                        Layout.fillWidth: true
                        text: {
                            qsTranslate("QObject", "Recommended resolution") + ": " +
                                    ((iResolutionCombobox.currentIndex < 3 && iResolutionCombobox.currentIndex >= 0) ?
                                         pRecommendedResolution[iResolutionCombobox.currentIndex] :
                                         "1920 x 1080")
                        }
                        font: UiTheme.fonts.bodySmall
                        color: UiTheme.colors.primary30
                        wrapMode: Text.Wrap
                    }

                    Text {
                        Layout.fillWidth: true
                        text: qsTranslate("QObject", "NOTE: Keyboard controls at these resolutions are supported only for Wild Rift. Controls may not work as expected for other games.")
                        font: UiTheme.fonts.bodySmall
                        color: UiTheme.colors.warning
                        wrapMode: Text.Wrap
                        visible: iResolutionCombobox.currentIndex === 2
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
                    Text {
                        text: qsTranslate("QObject", "Pixel Density")
                        font :UiTheme.fonts.bodyLarge
                        color: UiTheme.colors.primary10
                    }

                    UiRowLayout {
                        spacing: 40
                        UiRadioButton {
                            id: iDpi160
                            text: "160 DPI (" + qsTranslate("QObject", "Low") + ")"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iDpiBtnGrp
                        }
                        UiRadioButton {
                            id: iDpi240
                            text: "240 DPI (" + qsTranslate("QObject", "Medium") + ")"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iDpiBtnGrp
                        }
                        UiRadioButton {
                            id: iDpi320
                            text: "320 DPI (" + qsTranslate("QObject", "High") + ")"
                            Layout.preferredWidth: 142
                            ButtonGroup.group: iDpiBtnGrp
                        }
                    }
                }

                Rectangle {
                    height: 1
                    visible: iMouseCursorStlyle.visible
                    color: UiTheme.colors.primary70
                    Layout.fillWidth: true
                }

                UiColumnLayout {
                    id: iMouseCursorStlyle
                    Layout.fillWidth: true
                    spacing: 12
                    Text {
                        text: qsTranslate("QObject", "Mouse cursor style")
                        font :UiTheme.fonts.bodyLarge
                        color: UiTheme.colors.primary10
                    }

                    UiRowLayout {
                        spacing: 100
                        UiRadioButton {
                            id: iDefaultCursor
                            Layout.fillWidth: true
                            text: qsTranslate("QObject", "System default")
                            indicator.y: iDefaultCursor.topPadding + (iDefaultCursor.availableHeight - iDefaultCursor.indicator.height) / 2
                            contentItem: UiRowLayout {
                                anchors.fill: parent
                                spacing: 8
                                leftPadding: iDefaultCursor.indicator.width + iDefaultCursor.spacing
                                Layout.preferredWidth: (parent.width - parent.spacing) / 2
                                UiImage {
                                    asset: "SystemCursor"
                                    pImageWidth: 24
                                    pImageHeight: 24
                                }
                                Text {
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    text: iDefaultCursor.text
                                    font: iDefaultCursor.pSize.textFont
                                    color: UiTheme.colors.primary20
                                    wrapMode: Text.Wrap
                                }
                            }
                            ButtonGroup.group: iCursorBtnGrp
                        }
                        UiRadioButton {
                            id: iCustomCursor
                            Layout.fillWidth: true
                            text: qsTranslate("QObject", "BlueStacks")
                            indicator.y: iCustomCursor.topPadding + (iCustomCursor.availableHeight - iCustomCursor.indicator.height) / 2
                            contentItem: UiRowLayout {
                                anchors.fill: parent
                                spacing: 8
                                leftPadding: iCustomCursor.indicator.width + iCustomCursor.spacing
                                Layout.preferredWidth: (parent.width - parent.spacing) / 2
                                UiImage {
                                    asset: "BlueStacksCursor"
                                    pImageWidth: 24
                                    pImageHeight: 24
                                }
                                Text {
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    text: iCustomCursor.text
                                    font: iCustomCursor.pSize.textFont
                                    color: UiTheme.colors.primary20
                                    wrapMode: Text.Wrap
                                }
                            }
                            ButtonGroup.group: iCursorBtnGrp
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
        var fbWidth = 1920
        var fbHeight = 1080
        var dpi = 240
        var res = fbWidth + " x " + fbHeight
        var customCursor = false

        iCustomWidthTextField.text = fbWidth
        iCustomHeightTextField.text = fbHeight
        pDefaultWidth = fbWidth
        pDefaultHeight = fbHeight
        iMouseCursorStlyle.visible = pParentWindow === "plr" ? true : false

        fSelectResolutionBtn(res)

        var currIdx = 0
        if (iResolutionBtnGrp.checkedButton !== null) {
            pDefaultResBtn = iResolutionBtnGrp.checkedButton

            if (pDefaultResBtn.parent == iPortraitGrid) {
                currIdx = 1
                iResolutionCombobox.currentIndex = 1
            }
            else if (pDefaultResBtn.parent == iUltraWideGrid) {
                currIdx = 2
                iResolutionCombobox.currentIndex = 2
            }
            else
                iResolutionCombobox.currentIndex = 0
        }
        else {
            currIdx = 3
            iResolutionCombobox.currentIndex = 3
        }
        fSetResolutionOptionsVisibility(currIdx)
        pDefaultResComboboxIdx = iResolutionCombobox.currentIndex

        if (dpi === 160) {
            iDpi160.checked = true
            pDefaultDpiBtn = iDpi160
        }
        else if (dpi === 240) {
            iDpi240.checked = true
            pDefaultDpiBtn = iDpi240
        }
        else if (dpi === 320) {
            iDpi320.checked = true
            pDefaultDpiBtn = iDpi320
        }

        if(customCursor)
            iCustomCursor.checked = true
        else
            iDefaultCursor.checked = true
        pDefaultCursorBtn = iCursorBtnGrp.checkedButton

        var screenWidth = Screen.desktopAvailableWidth * Screen.devicePixelRatio
        var screenHeight = Screen.desktopAvailableHeight * Screen.devicePixelRatio
        var recommendedWidth
        var recommendedHeight
        if (screenWidth > 1920 && screenHeight > 1080) {
            recommendedWidth = 1920
            recommendedHeight = 1080
        }
        else if (screenWidth > 1600 && screenHeight > 900) {
            recommendedWidth = 1600
            recommendedHeight = 900
        }
        else if (screenWidth > 1280 && screenHeight > 720) {
            recommendedWidth = 1280
            recommendedHeight = 720
        }
        else
        {
            recommendedWidth = 960
            recommendedHeight = 540
        }

        pRecommendedResolution[0] = recommendedWidth + " x " + recommendedHeight
        pRecommendedResolution[1] = recommendedHeight + " x " + recommendedWidth

        pEnableSave = false
    }

    function fSelectResolutionBtn(res) {
        if (res === "1280 x 720")
            iRes1280x720.checked = true
        else if (res === "960 x 540")
            iRes960x540.checked = true
        else if (res === "1920 x 1080")
            iRes1920x1080.checked = true
        else if (res === "1600 x 900")
            iRes1600x900.checked = true
        else if (res === "2560 x 1440")
            iRes2560x1440.checked = true
        else if (res === "720 x 1280")
            iRes720x1280.checked = true
        else if (res === "540 x 960")
            iRes540x960.checked = true
        else if (res === "1080 x 1920")
            iRes1080x1920.checked = true
        else if (res === "900 x 1600")
            iRes900x1600.checked = true
        else if (res === "1440 x 2560")
            iRes1440x2560.checked = true
        else if (res === "1680 x 720")
            iRes1680x720.checked = true
        else if (res === "2560 x 1080")
            iRes2560x1080.checked = true
        else if (res === "3440 x 1440")
            iRes3440x1440.checked = true
        else if (res === "5120 x 2160")
            iRes5120x2160.checked = true
        else {
            pDefaultResBtn = null
            iResolutionBtnGrp.checkedButton = null
        }
    }

    function fReloadComboboxes(){
        iResolutionCombobox.currentIndex = pDefaultResComboboxIdx
    }

    function fSetPreviousState() {
        fInitUi()
    }

    function fSetResolutionOptionsVisibility(currIdx) {
        iPortraitGrid.visible = false
        iLandscapeGrid.visible = false
        iUltraWideGrid.visible = false
        iCustomResolutionRow.visible = false

        if (currIdx === 0)
            iLandscapeGrid.visible = true
        else if (currIdx === 1)
            iPortraitGrid.visible = true
        else if (currIdx === 2)
            iUltraWideGrid.visible = true
        else
            iCustomResolutionRow.visible = true
    }

    function fMonitorChange() {
        pEnableSave = true
    }

    function fDiscardChanges() {
        fInitUi()
        iSettingsWindow.fSwitchSettingPanel()
    }
}
