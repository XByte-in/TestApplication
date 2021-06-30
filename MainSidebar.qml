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
import QtQuick.Shapes 1.15
import Qt.labs.platform 1.1
import UiToolTipControl 1.0
//import DialogButtonModel 1.0
//import DialogButtonModelList 1.0
//import UiFolderDialog 1.0

import QtQuick.Shapes 1.12

Rectangle {
    id: iSidebar
    objectName: "sidebar"
    property int pSidebarElementSize: 32
    property int pVisibleSidebarElementsCount: 0

    property bool pIsBootComplete: false
    property bool pIsMacoFeatureEnabled: true

    //property KmmEditorWindow pKmmEditorWindow: null
    property bool pGameControlsEnabled: true
    property bool pIsGameControlsOverlayEnabled: true
    property bool pGameControlsSensitivityEnabled: false
    property bool pGameControlsPopupLoaded: false
    property bool pIsEcoModeEnabled: false


    property bool pIsMacroEnabled: true
    property bool pMouseCursorLocked: false
    property bool pIsEcoModeSoundEnabled: false
    property bool pRunTrimAnimation: false
    property var pMediaPrompt

    property string pScreenshotFilename
    property string pScreenShotNoticeText
    property bool pIsSyncEnable: true
    property bool pIsSyncColorAsset: false

    readonly property string pCollapse      : "collapse"
    readonly property string pFullscreen    : "fullscreen"
    readonly property string pVolumeUp      : "volumeUp"
    readonly property string pVolumeDown    : "volumeDown"
    readonly property string pLockCursor    : "lockCursor"
    readonly property string pGameControl   : "gameControl"
    readonly property string pSync          : "sync"
    readonly property string pMacro         : "macro"
    readonly property string pMemoryTrim    : "memoryTrim"
    readonly property string pInstallApk    : "installApk"
    readonly property string pScreenshot    : "screenShot"
    readonly property string pMediaFolder   : "mediaFolder"
    readonly property string pRotate        : "rotate"
    readonly property string pShake         : "shake"
    readonly property string pMim           : "mim"
    readonly property string pEcoMode       : "ecoMode"
    readonly property string pSettings      : "settings"
    readonly property string pBack          : "back"
    readonly property string pHome          : "home"
    readonly property string pRecent        : "recent"

    signal sidebarHideClicked
    signal sidebarSettingClicked

    //Connections { target: pKmmEditorWindow }
    property UiWindowedPopup pKebabMenuWin: null
    property UiWindowedPopup pEcoModeWin: null
    property UiWindowedPopup pGameControlsWin: null

    property list<QtObject> iAllSidebarItems: [
        MainSidebarElement {
            pElementId: pCollapse
            pAsset: "TitlebarCollapse"
            pTooltipText: "Close sidebar"
            onClicked: sidebarHideClicked()
        },
        MainSidebarElement {
            pElementId: pFullscreen
            pAsset: "SidebarFullScreen"
            pTooltipText: "Toggle fullscreen"
            pConfShortcutProperty: "toggle_fullscreen"
            pIsEnable: pIsBootComplete
            onClicked: plrBackend.onFullscreenClicked()
        },
        MainSidebarElement {
            pElementId: pVolumeUp
            pAsset: "SidebarVolumeUp"
            pTooltipText: "Increase volume"
            pConfShortcutProperty: "increase_volume"
            pIsEnable: pIsBootComplete
            onClicked: plrBackend.onVolumeUpClicked()
        },
        MainSidebarElement {
            pElementId: pVolumeDown
            pAsset: "SidebarVolumeDown"
            pTooltipText: "Decrease volume"
            pConfShortcutProperty: "decrease_volume"
            pIsEnable: pIsBootComplete
            onClicked: plrBackend.onVolumeDownClicked()
        },
        MainSidebarElement {
            pElementId: pLockCursor
            pAsset: pMouseCursorLocked ? "SidebarLockCursorActive" : "SidebarLockCursor"
            pTooltipText: "Lock mouse cursor"
            pConfShortcutProperty: "toggle_mouse_cursor_lock"
            pIsEnable: pIsBootComplete
            onClicked: plrBackend.onLockMouseCursorClicked()
        },
        MainSidebarElement {
            pElementId: pGameControl
            pAsset: "SidebarControls"
            pTooltipText: "Game controls"
            pConfShortcutProperty: ""
            pIsEnable: pIsBootComplete
            pAcceptedMouseButtons: Qt.LeftButton | Qt.RightButton
            onClicked: fOpenGameControlsPopup()
            onRightClicked: fOpenControlsEditorWindow()
        },
        MainSidebarElement {
            pElementId: pSync
            pAsset: pIsSyncColorAsset ? "SidebarSyncActive": "SidebarSync"
            pTooltipText: "Sync operations"
            pConfShortcutProperty: "open_sync_operations"
            pIsEnable: pIsBootComplete && pIsSyncEnable
            onClicked: fOpenSyncOperationsWindow()
        },
        MainSidebarElement {
            pElementId: pMacro
            pIsEnable: pIsMacroEnabled
            pAsset: "SidebarMacro"
            pTooltipText: "Open macro recorder"
            pConfShortcutProperty: "open_macro_recorder"
            pIsFeatureEnable: pIsMacoFeatureEnabled
            onClicked: fOpenMacroManagerWindow([], false)
        },
        MainSidebarElement {
            pElementId: pMemoryTrim
            pAsset: "SidebarMemoryTrim"
            pTooltipText: "Trim memory"
            pConfShortcutProperty: "trim_memory"
            pIsEnable: pIsBootComplete
            pRunImageAnimation: pRunTrimAnimation
            onClicked: fTrimMemoryClick()
        },
        MainSidebarElement {
            pElementId: pInstallApk
            pAsset: "SidebarInstallApk"
            pTooltipText: "Install apk"
            pConfShortcutProperty: "install_apk"
            pIsEnable: pIsBootComplete
            onClicked: fHandleInstallApkBtnClicked()
        },
        MainSidebarElement {
            pElementId: pScreenshot
            pAsset: "SidebarScreenshot"
            pTooltipText: "Take screenshot"
            pConfShortcutProperty: "take_screenshot"
            pIsEnable: pIsBootComplete
            onClicked: fHandleScreenshotBtnClicked()
        },
        MainSidebarElement {
            pElementId: pMediaFolder
            pAsset: "SidebarMediaFolder"
            pTooltipText: "Open media folder"
            pConfShortcutProperty: "open_media_folder"
            onClicked: plrBackend.openMediaFolder("")
        },
        MainSidebarElement {
            pElementId: pRotate
            pAsset: "SidebarRotate"
            pTooltipText: "Rotate"
            pConfShortcutProperty: "rotate"
            pIsEnable: pIsBootComplete
            onClicked: plrBackend.onRotateClicked()
        },
        MainSidebarElement {
            pElementId: pShake
            pAsset: "SidebarShake"
            pTooltipText: "Shake"
            pConfShortcutProperty: "shake"
            pIsEnable: pIsBootComplete
            onClicked: plrBackend.shake()
        },
        MainSidebarElement {
            pElementId: pMim
            pAsset: "SidebarInstanceManager"
            pTooltipText: "Multi-instance Manager"
            pConfShortcutProperty: "open_mim"
            onClicked: plrBackend.launchMultiInstanceManager()
        },
        MainSidebarElement {
            pElementId: pEcoMode
            pAsset: pIsEcoModeEnabled ? "SidebarEcoModeActive" : "SidebarEcoMode"
            pTooltipText: "Eco mode"
            pConfShortcutProperty: "toggle_eco_mode"
            pIsEnable: pIsBootComplete
            onClicked: fOpenEcoModePopup()
        },
        MainSidebarElement {
            pElementId: pSettings
            pAsset: "SidebarSettings"
            pTooltipText: "Settings"
            pConfShortcutProperty: "open_settings"
            pShowViaRepaterOnly: false
            pShowOnKebabMenu: !iSettingsBtn.visible
            onClicked: sidebarSettingClicked()
        },
        MainSidebarElement {
            pElementId: pBack
            pAsset: "SidebarBack"
            pTooltipText: "Back"
            pConfShortcutProperty: "go_back"
            pIsEnable: pIsBootComplete
            pShowViaRepaterOnly: false
            pShowOnKebabMenu: !iBackBtn.visible
            onClicked: plrBackend.onBackClicked()
        },
        MainSidebarElement {
            pElementId: pHome
            pAsset: "SidebarHome"
            pTooltipText: "Home"
            pConfShortcutProperty: "go_home"
            pIsEnable: pIsBootComplete
            pShowViaRepaterOnly: false
            pShowOnKebabMenu: !iHomeBtn.visible
            onClicked: plrBackend.onHomeClicked()
        },
        MainSidebarElement {
            pElementId: pRecent
            pAsset: "SidebarRecents"
            pTooltipText: "Recents"
            pConfShortcutProperty: "open_recent_apps"
            pIsEnable: pIsBootComplete
            pShowViaRepaterOnly: false
            pShowOnKebabMenu: !iRecentBtn.visible
            onClicked: plrBackend.onRecentAppsClicked()
        }
    ]

    Component.onCompleted: {
        //pIsMacoFeatureEnabled = uiBackend.confGetBool("bst.feature.macros", true)
        //pIsGameControlsOverlayEnabled = uiBackend.confGetBool("bst.key_controls_overlay_enabled")
        fResetSidebar()
    }

    onHeightChanged: {
        fResetSidebar()
    }

    function fResetSidebar() {
        var availableHeight = iSidebar.height
        if(availableHeight >= iRecentBtn.height) {
            iRecentBtn.visible = true
            availableHeight = availableHeight - iRecentBtn.height
        } else { iRecentBtn.visible = false }

        if(availableHeight >= iHomeBtn.height) {
            iHomeBtn.visible = true
            availableHeight = availableHeight - iHomeBtn.height
        } else { iHomeBtn.visible = false }

        if(availableHeight >= iBackBtn.height) {
            iBackBtn.visible = true
            availableHeight = availableHeight - iBackBtn.height
        } else { iBackBtn.visible = false }

        if(availableHeight >= iSettingsBtn.height) {
            iSettingsBtn.visible = true
            availableHeight = availableHeight - iSettingsBtn.height
        } else { iSettingsBtn.visible = false }

        if(availableHeight > 0) {
            var repeaterElements = 0
            for (var i = 0; i < iAllSidebarItems.length; i++)
                if(iAllSidebarItems[i].pShowViaRepaterOnly && iAllSidebarItems[i].pIsFeatureEnable)
                    repeaterElements++ ;
            var count = Math.floor(availableHeight / pSidebarElementSize)
            if(count >= repeaterElements)
            {
                iKebabMenuBtn.visible = false
                pVisibleSidebarElementsCount = repeaterElements

            } else {
                iKebabMenuBtn.visible = true
                pVisibleSidebarElementsCount = count-1
            }
        }
    }

    FileDialog {
        id: iFileDialog
        title: qsTranslate("QObject", "Please choose a file")
        nameFilters: ["Android Files (*.apk *.xapk)"]
        fileMode: FileDialog.OpenFiles
        visible: false
        onAccepted: {
            iFileDialog.close()
            for (var i = 0; i < iFileDialog.files.length; ++i) {
                var path = iFileDialog.files[i].toString()
                path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/, "")
                //plrBackend.onInstallApkClicked(path)
            }
        }
    }

//    UiFolderDialog {
//        id: iSelectMediaFolderDialog
//        visible: false
//        folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
//        onAccepted: {
//            iSelectMediaFolderDialog.close()
//            var currentPath = currentFolder.toString()
//            currentPath = currentPath.replace( /^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/, "")
//            if (plrBackend.isDirWritable(currentPath)) {
//                pMediaPrompt.close()
//                pMediaPrompt.destroy()
//                uiBackend.confSetString("bst.media_folder", currentPath)
//                uiBackend.confCommit()
//                plrBackend.takeScreenshot(currentPath)
//            } else {
//                pScreenShotNoticeText = qsTranslate("QObject", "BlueStacks does not have the required permissions to store in the folder you have selected")
//            }
//        }
//    }

//    Component {
//        id: iSelectMediaPrompt
//        UiMessageDialog {
//            title: qsTranslate("QObject", "Open media folder")
//            pDescription: qsTranslate("QObject", "Your media will be automatically saved in the Android Gallery and in the folder below. You may choose a custom folder.")
//            pDialogType: UiDialog.DialogTypes.Simple
//            pNotice: pScreenShotNoticeText
//            pButtonsList: DialogButtonModelList {
//                pButtons: [
//                    DialogButtonModel {
//                        pColor: UiTheme.buttons.colors.accent
//                        pText: qsTranslate("QObject", "Choose custom")
//                        onClicked: {
//                            iSelectMediaFolderDialog.open()
//                        }
//                    },
//                    DialogButtonModel {
//                        pColor: UiTheme.buttons.colors.secondary
//                        pText: qsTranslate("QObject", "Use current")
//                        onClicked: {
//                            plrBackend.takeScreenshot("")
//                            close()
//                        }
//                    }
//                ]
//            }
//        }
//    }

    Component {
        id: iEcoModePopupComponent
        UiWindowedPopup {
            id: iEcoModePopup
            contentWidth: 180
            contentHeight: 100
            visible: false

            Rectangle {
                anchors.centerIn: parent
                anchors.fill: parent
                color: UiTheme.colors.primary80
                border.width: 1
                border.color: UiTheme.colors.primary60
                ColumnLayout {
                    spacing: 0
                    anchors.fill: parent
                    anchors.margins: 10

                    RowLayout {
                        spacing: 0
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                        Text {
                            text: qsTranslate("QObject", "Eco mode")
                            font: UiTheme.fonts.titleExtraSmall
                            color: UiTheme.colors.primary10
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        UiImageButton {
                            asset: "MenuHelp"
                            pImageHeight: 16
                            pImageWidth: 16
                            Layout.rightMargin: 8
                            UiToolTip.text: qsTranslate("QObject", "Help")
                            onClicked: {
                                uiBackend.openHelpArticle("EcoMode_help")
                            }
                            pMouseCursor: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }

                        UiToggleButton {
                            id: iEcoModeToggleBtn
                            checked: pIsEcoModeEnabled
                            pSize: UiTheme.toggleButtons.sizes.small
                            onCheckedChanged: {
                                if(pIsEcoModeEnabled !== checked) {
                                    pIsEcoModeEnabled = checked
                                    if (!checked)
                                        pIsEcoModeSoundEnabled = false
                                    var fps = pIsEcoModeEnabled ? parseInt(iEcoModeFpsSpinBox.value) : 0
                                    //plrBackend.enableEcoMode(pIsEcoModeEnabled, fps)
                                }
                            }
                        }
                    }

                    Rectangle {
                        height: 1
                        color: UiTheme.colors.primary60
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        id: iSoundRow
                        enabled: pIsEcoModeEnabled
                        Layout.fillWidth: true
                        Layout.topMargin: 5
                        Text {
                            text: qsTranslate("QObject", "Sound")
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary10
                            opacity: enabled ? 1 : 0.5
                            Layout.preferredHeight: 20
                            horizontalAlignment: Text.AlignLeft
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        UiToggleButton {
                            id: iEcoModeSoundToggleBtn
                            checked: pIsEcoModeSoundEnabled
                            pSize: UiTheme.toggleButtons.sizes.small
                            onCheckedChanged: {
                                if(pIsEcoModeSoundEnabled != checked) {
                                    pIsEcoModeSoundEnabled = checked
                                    //plrBackend.muteUnmuteVolume()
                                }
                            }
                        }
                    }

                    RowLayout {
                        id: iEcoFPSRow
                        enabled: pIsEcoModeEnabled
                        Layout.fillWidth: true
                        Layout.topMargin: 5
                        Text {
                            text: qsTranslate("QObject", "Eco FPS(1-30)")
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary10
                            opacity: enabled ? 1 : 0.5
                            Layout.preferredHeight: 20
                            horizontalAlignment: Text.AlignLeft
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        UiSpinBox {
                            id: iEcoModeFpsSpinBox
                            realFrom: 1
                            realTo: 30
                            realStepSize: 1
                            //realValue: plrBackend.getEcoModeMaxFps()
                            decimalPlaces: 0
                            inputMethodHints: Qt.ImhDigitsOnly
                            validator: RegularExpressionValidator { regularExpression: /([1-9]|[12][0-9]|3[0])/ }
                        }
                    }
                }
            }
            onClosePopup: {
                iEcoModePopup.destroy()
                if (pIsEcoModeEnabled) {
                    //plrBackend.setEcoModeMaxFps(parseInt(iEcoModeFpsSpinBox.value))
                }
                pEcoModeWin = null
            }
        }
    }

    Component {
        id: iGameControlsPopupComponent
        UiWindowedPopup {
            id: iGameControlsPopup
            contentWidth: iContentRect.width
            contentHeight: iContentRect.height
            visible: false
            property alias schemeModel: iSchemeCombobox.model
            property alias schemeIdx: iSchemeCombobox.currentIndex

            onSchemeModelChanged: { if (schemeModel.length < 1) iSchemeColumn.visible = false }
            onWidthChanged: {
                iGameControlsPopup.x = iSidebar.mapToGlobal(0, 0).x - iGameControlsPopup.width + iGameControlsPopup.shadowThickness
            }
            function updateSenstivity() {
                iMouseSensitivityXSpinBox.realValue =  pGameControlsSensitivityEnabled ? kmmBackend.getMouseSensitivityX() : 1
                iMouseSensitivityYSpinBox.realValue =  pGameControlsSensitivityEnabled ? kmmBackend.getMouseSensitivityY() : 1
            }

            Rectangle {
                id: iContentRect
                width: iContentLayout.width + iContentLayout.anchors.leftMargin + iContentLayout.anchors.rightMargin
                height: iContentLayout.height + iContentLayout.anchors.topMargin + iContentLayout.anchors.bottomMargin
                color: UiTheme.colors.primary70
                border.width: 1
                border.color: UiTheme.colors.primary60
                ColumnLayout {
                    id: iContentLayout
                    width: Math.max(164, childrenRect.width)
                    anchors.centerIn: parent
                    anchors.margins: 8
                    spacing: 8
                    RowLayout {
                        spacing: 4
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height
                        Text {
                            text: qsTranslate("QObject", "Game controls")
                            font: UiTheme.fonts.titleExtraSmall
                            color: UiTheme.colors.primary10
                            horizontalAlignment: Text.AlignLeft
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        RowLayout {
                            Layout.preferredWidth: childrenRect.width
                            Layout.preferredHeight: childrenRect.height
                            spacing: 4
                            UiImageButton {
                                asset: "MenuHelp"
                                pImageHeight: 16
                                pImageWidth: 16
                                UiToolTip.text: qsTranslate("QObject", "Help")
                                onClicked: uiBackend.openHelpArticle("game_controls_help")
                                pMouseCursor: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                            }
                            UiToggleButton {
                                id: iGameControlsToggleBtn
                                checked: pGameControlsEnabled
                                pSize: UiTheme.toggleButtons.sizes.small
                                UiToolTip.text: qsTranslate( "QObject", "Toggle game controls")
                                // UiToolTip.confShortcutProperty: "enable_disable_game_controls"
                                onCheckedChanged: {
                                    if (pGameControlsPopupLoaded) {
                                        //plrBackend.setKeyMappingState(checked)
                                        //kmmBackend.toggleOverlayVisibility(checked ? iOverlayToggleBtn.checked : checked, false)
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: UiTheme.colors.primary60
                    }

                    RowLayout {
                        id: iOverlayRow
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height
                        spacing: 4
                        enabled: iGameControlsToggleBtn.checked
                        opacity: enabled ? 1 : 0.5
                        Text {
                            text: qsTranslate("QObject", "On-screen controls")
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary20
                            horizontalAlignment: Text.AlignLeft
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        UiToggleButton {
                            id: iOverlayToggleBtn
                            pSize: UiTheme.toggleButtons.sizes.small
                            checked: pIsGameControlsOverlayEnabled
                            UiToolTip.text: qsTranslate("QObject", "Show/Hide on-screen controls")
                            // UiToolTip.confShortcutProperty: "show_hide_on_screen_controls"
                            onClicked: {
                                pIsGameControlsOverlayEnabled = checked
                                kmmBackend.toggleOverlayVisibility(pIsGameControlsOverlayEnabled)
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height
                        spacing: 4
                        enabled: iOverlayRow.enabled && iOverlayToggleBtn.checked
                        Text {
                            text: qsTranslate("QObject", "Opacity")
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary20
                            horizontalAlignment: Text.AlignLeft
                            opacity: enabled ? 1 : 0.5
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        UiSlider {
                            pSize: UiTheme.sliders.sizes.small
                            from: 0
                            to: 100
                            stepSize: 1
                            value: uiBackend.confGetI32("bst.key_controls_overlay_opacity")
                            Layout.preferredWidth: 80
                            onValueChanged: kmmBackend.setOverlayTransparency( parseInt(value) )
                            onPressedChanged: kmmBackend.saveOverlayOpacityInConf( parseInt(value) )
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: UiTheme.colors.primary60
                        visible: iSchemeColumn.visible
                    }
                    ColumnLayout {
                        id: iSchemeColumn
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height
                        spacing: 4
                        enabled: iOverlayRow.enabled
                        opacity: enabled ? 1 : 0.5
                        Text {
                            text: qsTranslate("QObject", "Scheme")
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary10
                        }
                        UiComboBox {
                            id: iSchemeCombobox
                            pSize: UiTheme.comboBoxes.sizes.small
                            Layout.preferredHeight: 24
                            Layout.fillWidth: true
                            onActivated: {
                                if (pGameControlsPopupLoaded) {
                                    kmmBackend.setActiveScheme(model[currentIndex])
                                    pGameControlsSensitivityEnabled = kmmBackend.hasPanControl()
                                    updateSenstivity()
                                }
                            }
                        }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.preferredHeight: childrenRect.height
                        spacing: 4
                        enabled: iOverlayRow.enabled
                        visible: pGameControlsSensitivityEnabled
                        opacity: enabled ? 1 : 0.5
                        Text {
                            text: qsTranslate("QObject", "Mouse sensitivity")
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary20
                        }
                        RowLayout {
                            spacing: 16
                            Layout.preferredWidth: childrenRect.width
                            Layout.preferredHeight: childrenRect.height
                            RowLayout {
                                Layout.preferredWidth: childrenRect.width
                                Layout.preferredHeight: childrenRect.height
                                spacing: 8
                                Text {
                                    text: "X"
                                    font: UiTheme.fonts.bodySmall
                                    color: UiTheme.colors.primary20
                                    horizontalAlignment: Text.AlignLeft
                                }
                                UiSpinBox {
                                    id: iMouseSensitivityXSpinBox
                                    Layout.preferredWidth: 58
                                    Layout.preferredHeight: 24
                                    realFrom: 0.01
                                    realTo: 10
                                    realStepSize: 0.01
                                    realValue: 1
                                    decimalPlaces: 2
                                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                                    validator: RegExpValidator { regExp: /^(?=.*[0-9])\d{1}(?:\.\d{0,2})?$|^10$/}
                                    onValueChanged: {
                                        if (pGameControlsPopupLoaded && pGameControlsSensitivityEnabled) {
                                            kmmBackend.setMouseSensitivity(
                                                        iMouseSensitivityXSpinBox.value / iMouseSensitivityXSpinBox.factor,
                                                        iMouseSensitivityYSpinBox.value / iMouseSensitivityYSpinBox.factor)
                                        }
                                    }
                                }
                            }
                            RowLayout {
                                Layout.preferredWidth: childrenRect.width
                                Layout.preferredHeight: childrenRect.height
                                spacing: 8
                                Text {
                                    text: "Y"
                                    font: UiTheme.fonts.bodySmall
                                    color: UiTheme.colors.primary20
                                    horizontalAlignment: Text.AlignLeft
                                }
                                UiSpinBox {
                                    id: iMouseSensitivityYSpinBox
                                    Layout.preferredWidth: 58
                                    Layout.preferredHeight: 24
                                    realFrom: 0.01
                                    realTo: 10
                                    realStepSize: 0.01
                                    realValue: 1
                                    decimalPlaces: 2
                                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                                    validator: RegExpValidator { regExp: /^(?=.*[0-9])\d{1}(?:\.\d{0,2})?$|^10$/}
                                    onValueChanged: {
                                        if (pGameControlsPopupLoaded && pGameControlsSensitivityEnabled) {
                                            kmmBackend.setMouseSensitivity(
                                                        iMouseSensitivityXSpinBox.value / iMouseSensitivityXSpinBox.factor,
                                                        iMouseSensitivityYSpinBox.value / iMouseSensitivityYSpinBox.factor)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: UiTheme.colors.primary60
                    }
                    Text {
                        id: iOpenEditorTxt
                        text: qsTranslate("QObject", "Open advanced editor")
                        font: UiTheme.fonts.bodySmall
                        color: UiTheme.colors.primary20
                        horizontalAlignment: Text.AlignLeft
                        enabled: iGameControlsToggleBtn.checked
                        opacity: enabled ? 1 : 0.5
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                cursorShape = Qt.PointingHandCursor
                                iOpenEditorTxt.color = UiTheme.colors.primary10
                            }
                            onExited: {
                                cursorShape = Qt.ArrowCursor
                                iOpenEditorTxt.color = UiTheme.colors.primary20
                            }
                            onClicked: {
                                cursorShape = Qt.ArrowCursor
                                iGameControlsPopup.destroy()
                                fOpenControlsEditorWindow()
                            }
                        }
                    }
                }
            }

            onClosePopup: {
                if (pGameControlsPopupLoaded) kmmBackend.kmmPopupCommit()
                pGameControlsPopupLoaded = false
                pGameControlsEnabled = iGameControlsToggleBtn.checked
                iGameControlsPopup.destroy()
                pGameControlsWin = null
            }
        }
    }

    Component {
        id: iScreenshotPopupComponent
        UiWindowedPopup {
            id: iScreenshotSavedPopup
            contentWidth: iScreenshotSavedPopupRect.width
            contentHeight: iScreenshotSavedPopupRect.height
            visible: false
            onWidthChanged: {
                iScreenshotSavedPopup.x = iSidebar.mapToGlobal(0, 0).x - iScreenshotSavedPopup.width + iScreenshotSavedPopup.shadowThickness
            }

            Rectangle {
                id: iScreenshotSavedPopupRect
                width: iScreenshotContentLayout.width + iScreenshotContentLayout.anchors.leftMargin
                       + iScreenshotContentLayout.anchors.rightMargin
                height: iScreenshotContentLayout.height + iScreenshotContentLayout.anchors.topMargin
                        + iScreenshotContentLayout.anchors.bottomMargin
                color: UiTheme.colors.primary70
                border.width: 1
                border.color: UiTheme.colors.primary60
                ColumnLayout {
                    id: iScreenshotContentLayout
                    width: Math.max(164, childrenRect.width)
                    anchors.centerIn: parent
                    anchors.margins: 8
                    spacing: 8

                    Text {
                        text: qsTranslate("QObject", "Screenshot saved")
                        font: UiTheme.fonts.titleExtraSmall
                        color: UiTheme.colors.primary10
                        Layout.alignment: Qt.AlignTop
                        horizontalAlignment: Text.AlignLeft
                    }

                    Rectangle {
                        Layout.preferredHeight: 1
                        color: UiTheme.colors.primary60
                        Layout.fillWidth: true
                    }

                    Text {
                        id: iViewInWindowTxt
                        text: qsTranslate("QObject", "View in Windows folder")
                        font: UiTheme.fonts.bodySmall
                        color: UiTheme.colors.primary20
                        horizontalAlignment: Text.AlignLeft

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                iViewInWindowTxt.color = UiTheme.colors.primary10
                                cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                                iViewInWindowTxt.color = UiTheme.colors.primary20
                                cursorShape = Qt.ArrowCursor
                            }
                            onClicked: {
                                cursorShape = Qt.ArrowCursor
                                iScreenshotSavedPopup.visible = false
                                //plrBackend.openMediaFolder(pScreenshotFilename)
                            }
                        }
                    }

                    Text {
                        id: iViewInGalleryTxt
                        text: qsTranslate("QObject", "View in Gallery")
                        font: UiTheme.fonts.bodySmall
                        color: UiTheme.colors.primary20
                        Layout.topMargin: 6
                        horizontalAlignment: Text.AlignLeft

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                iViewInGalleryTxt.color = UiTheme.colors.primary10
                                cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                                iViewInGalleryTxt.color = UiTheme.colors.primary20
                                cursorShape = Qt.ArrowCursor
                            }
                            onClicked: {
                                cursorShape = Qt.ArrowCursor
                                iScreenshotSavedPopup.visible = false
                                //plrBackend.openMediaManager()
                            }
                        }
                    }
                }
            }
            onClosePopup: {
                iScreenshotSavedPopup.destroy()
            }
        }
    }

    Component {
        id: iKebabMenuPopupComponent
        UiWindowedPopup {
            id: iKebabMenuPopup
            property int pKebabMenuElementsCount: 0
            contentWidth: pSidebarElementSize * Math.ceil(pKebabMenuElementsCount / 4)
            contentHeight: Math.min(pSidebarElementSize * 4, pSidebarElementSize * pKebabMenuElementsCount)
            Rectangle {
                anchors.fill: parent
                color: UiTheme.colors.primary80
                border.width: 1
                border.color: UiTheme.colors.primary60
                Flow {
                    spacing: 0
                    anchors.fill: parent
                    flow: Flow.TopToBottom
                    Repeater {
                        model: iAllSidebarItems
                        delegate: UiImageButton {
                            Component.onCompleted: if(visible) pKebabMenuElementsCount++
                            asset: model.modelData.pAsset
                            pImageHeight: pSidebarElementSize
                            pImageWidth: pSidebarElementSize
                            enabled: model.modelData.pIsEnable
                            UiToolTip.text: qsTranslate("QObject", model.modelData.pTooltipText)
                            // UiToolTip.confShortcutProperty: model.modelData.pConfShortcutProperty
                            pImageAnimationRunning: model.modelData.pRunImageAnimation
                            visible: (index > pVisibleSidebarElementsCount-1) && model.modelData.pIsFeatureEnable && model.modelData.pShowOnKebabMenu
                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: model.modelData.pAcceptedMouseButtons
                                onClicked: mouse.button === Qt.LeftButton ? model.modelData.clicked() : model.modelData.rightClicked()
                            }
                        }
                    }
                }
            }

            onClosePopup: {
                iKebabMenuPopup.close()
                iKebabMenuPopup.destroy()
                iKebabMenuBtn.asset = "SidebarKebabClosed"
                pKebabMenuWin = null
            }
        }
    }

    UiColumnLayout {
        anchors.fill: parent
        Repeater {
            model: iAllSidebarItems
            delegate: Component {
                UiImageButton {
                    id: iBtn
                    asset: model.modelData.pAsset
                    pImageHeight: pSidebarElementSize
                    pImageWidth: pSidebarElementSize
                    enabled: model.modelData.pIsEnable
                    UiToolTip.text: qsTranslate("QObject", model.modelData.pTooltipText)
                    // UiToolTip.confShortcutProperty: model.modelData.pConfShortcutProperty
                    pImageAnimationRunning: model.modelData.pRunImageAnimation
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: model.modelData.pAcceptedMouseButtons
                        onClicked: mouse.button === Qt.LeftButton ? model.modelData.clicked() : model.modelData.rightClicked()
                    }
                    visible: (index <= pVisibleSidebarElementsCount-1) && model.modelData.pIsFeatureEnable && model.modelData.pShowViaRepaterOnly
                }
            }
        }
        UiImageButton {
            id: iKebabMenuBtn
            Layout.alignment: Qt.AlignHCenter
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize

            asset: "SidebarKebabClosed"
            onClicked: {
                asset = "SidebarKebabOpen"
                if (pKebabMenuWin != null)
                {
                    if (pKebabMenuWin.visible)
                        pKebabMenuWin.closePopup()
                    return
                }
                pKebabMenuWin = iKebabMenuPopupComponent.createObject(iAppwin)
                pKebabMenuWin.screen = iAppwin.screen
                pKebabMenuWin.x = iSidebar.mapToGlobal(0, 0).x - pKebabMenuWin.width + pKebabMenuWin.shadowThickness
                pKebabMenuWin.y = iKebabMenuBtn.mapToGlobal(0, 0).y - pKebabMenuWin.shadowThickness
                pKebabMenuWin.show()
            }
        }
        Item {
            Layout.fillHeight: true
        }
        UiImageButton {
            id: iSettingsBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            asset: "SidebarSettings"
            UiToolTip.text: qsTranslate("QObject", "Settings")
            // UiToolTip.confShortcutProperty: "open_settings"
            onClicked: sidebarSettingClicked()
        }
        UiImageButton {
            id: iBackBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            enabled: pIsBootComplete

            asset: "SidebarBack"
            UiToolTip.text: qsTranslate("QObject", "Back")
            // UiToolTip.confShortcutProperty: "go_back"
            //onClicked: plrBackend.onBackClicked()
        }
        UiImageButton {
            id: iHomeBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            enabled: pIsBootComplete

            asset: "SidebarHome"
            UiToolTip.text: qsTranslate("QObject", "Home")
            // UiToolTip.confShortcutProperty: "go_home"
            //onClicked: plrBackend.onHomeClicked()
        }
        UiImageButton {
            id: iRecentBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            enabled: pIsBootComplete

            asset: "SidebarRecents"
            UiToolTip.text: qsTranslate("QObject", "Recents")
            // UiToolTip.confShortcutProperty: "open_recent_apps"
            //onClicked: plrBackend.onRecentAppsClicked()
        }
    }

    function fUpdateMouseCursorImage(mouseStateLocked) {
        pMouseCursorLocked = mouseStateLocked
    }

    function fUpdateMacroBtnEnabled(enable) {
        pIsMacroEnabled = enable
    }

    function fTrimMemoryClick() {
        pRunTrimAnimation = true
        //plrBackend.onTrimMemoryClicked()
    }
    function fHideTrimMemoryLoader() {
        pRunTrimAnimation = false
    }

    function fHandleInstallApkBtnClicked() {
        iFileDialog.open()
    }

    function fHandleScreenshotBtnClicked() {
        var mediaFolder = uiBackend.confGetString("bst.media_folder")
        if (mediaFolder === "") {
            //mediaFolder = plrBackend.getMediaFolder()
            pScreenShotNoticeText = mediaFolder
            pMediaPrompt = iSelectMediaPrompt.createObject(iAppwin)
            pMediaPrompt.show()
        }// else { plrBackend.takeScreenshot(mediaFolder) }
    }
    function fOpenScreenshotSavedPopup(filename) {
        pScreenshotFilename = filename
        var screenshotWin = iScreenshotPopupComponent.createObject(iAppwin)
        screenshotWin.screen = iAppwin.screen
        screenshotWin.x = iSidebar.mapToGlobal(0, 0).x - screenshotWin.width + screenshotWin.shadowThickness
        screenshotWin.y = fGetPopupTopPoint(pScreenshot) - screenshotWin.shadowThickness
        screenshotWin.show()
    }

    function fOpenEcoModePopup() {
        if (pEcoModeWin != null)
        {
            if (pEcoModeWin.visible)
                pEcoModeWin.closePopup()
            return
        }
        pEcoModeWin = iEcoModePopupComponent.createObject(iAppwin)
        pEcoModeWin.screen = iAppwin.screen
        pEcoModeWin.x = iSidebar.mapToGlobal(0, 0).x - pEcoModeWin.width + pEcoModeWin.shadowThickness
        pEcoModeWin.y = fGetPopupTopPoint(pEcoMode) - pEcoModeWin.shadowThickness
        pEcoModeWin.show()
    }

    function fUpdateVolumeState(isMuted) {
        if (pIsEcoModeEnabled) {
            pIsEcoModeSoundEnabled = !isMuted
        } else {
            pIsEcoModeSoundEnabled = false
        }
    }

    function fOpenGameControl(mouse) {
        if(mouse.button === Qt.RightButton)
            fOpenControlsEditorWindow()
        else
            fOpenGameControlsPopup()
    }
    function fOpenGameControlsPopup() {
        kmmBackend.kmmPopupStart()
        if (pGameControlsWin != null)
        {
            if (pGameControlsWin.visible)
                pGameControlsWin.closePopup()
            return
        }
        pGameControlsWin = iGameControlsPopupComponent.createObject(iAppwin)
        pGameControlsWin.screen = iAppwin.screen

        //This is a variant list with index of the selected scheme
        //stored at 0th location and scheme list at 1st.
        var schemeInfo = kmmBackend.getPopupSchemes()
        pGameControlsWin.schemeModel = schemeInfo[1]
        pGameControlsWin.schemeIdx = schemeInfo[0]
        pGameControlsSensitivityEnabled = kmmBackend.hasPanControl()
        pGameControlsWin.updateSenstivity()

        pGameControlsWin.x = iSidebar.mapToGlobal(0, 0).x - pGameControlsWin.width + pGameControlsWin.shadowThickness
        pGameControlsWin.y = fGetPopupTopPoint(pGameControl) - pGameControlsWin.shadowThickness
        pGameControlsPopupLoaded = true
        pGameControlsWin.show()
    }
    function fOpenControlsEditorWindow() {
        if (pKmmEditorWindow != null) return

        var component = Qt.createComponent("KmmEditorWindow.qml")
        if (component.status === Component.Ready) {
            pKmmEditorWindow = component.createObject(iAppwin)
            if (pKmmEditorWindow != null) {
                kmmBackend.kmmEditorStart()
                var schemeInfo = kmmBackend.getEditorSchemes()
                pKmmEditorWindow.schemeModel = schemeInfo[1]
                pKmmEditorWindow.schemeIdx = schemeInfo[0]
                pKmmEditorWindow.pBuiltinIndex = schemeInfo[2]
                pKmmEditorWindow.width = iAppwin.width - iSidebar.width + pKmmEditorWindow.pKmmEditorPanelWidth
                pKmmEditorWindow.height = iAppwin.height
                pKmmEditorWindow.x = iAppwin.x
                pKmmEditorWindow.y = iAppwin.y
                pKmmEditorWindow.show()
            }
        }
    }
    function fToggleGameControlsState(isEnabled) {
        pGameControlsEnabled = isEnabled
        kmmBackend.toggleOverlayVisibility(isEnabled ? pIsGameControlsOverlayEnabled : isEnabled, false)
    }
    function fToggleGameControlsVisibility(isVisible) {
        pIsGameControlsOverlayEnabled = isVisible
    }

    function fGetPopupTopPoint(elementId) {
        var applicableIndex = -1
        for (var i = 0; i < iAllSidebarItems.length; i++) {
            if(iAllSidebarItems[i].pShowViaRepaterOnly && iAllSidebarItems[i].pIsFeatureEnable) {
                applicableIndex  += 1
                if(iAllSidebarItems[i].pElementId === elementId && applicableIndex <= pVisibleSidebarElementsCount-1) {
                    return iSidebar.mapToGlobal(0, 0).y + applicableIndex * pSidebarElementSize;
                }
            }
        }
        return iKebabMenuBtn.mapToGlobal(0, 0).y
    }
}
