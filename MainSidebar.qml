import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.15
import Qt.labs.platform 1.1
import UiToolTipControl 1.0
import QtQuick.Shapes 1.12

Rectangle {
    id: iSidebar
    objectName: "sidebar"
    property int pSidebarElementSize: 32
    property int pVisibleSidebarElementsCount: 0

    property bool pIsBootComplete: false
    property bool pIsMacoFeatureEnabled: true
    
    property bool pGameControlsEnabled: true
    property bool pIsGameControlsOverlayEnabled: true
    property bool pGameControlsSensitivityEnabled: false
    property bool pGameControlsPopupLoaded: false


    property bool pIsMacroEnabled: true
    property bool pMouseCursorLocked: false
    property bool pIsEcoModeEnabled: true
    property bool pIsEcoModeSoundEnabled: false
    property bool pRunTrimAnimation: false
    property var pMediaPrompt

    property var pScreenshotBtn
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

    property list<QtObject> iAllSidebarItems: [
        MainSidebarElement {
            pElementId: pCollapse
            pAsset: "TitlebarCollapse"
            pTooltipText: "Close sidebar"
            onClicked: console.log(button.enabled)
            onRightClicked: console.log("right")
            pAcceptedMouseButtons: Qt.LeftButton | Qt.RightButton
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
            onClicked: fOpenGameControl(button)
            onRightClicked: fOpenControlsEditorWindow(button)
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
            onClicked: iFileDialog.open()
        },
        MainSidebarElement {
            pElementId: pScreenshot
            pAsset: "SidebarScreenshot"
            pTooltipText: "Take screenshot"
            pConfShortcutProperty: "take_screenshot"
            pIsEnable: pIsBootComplete
            onClicked: fHandleScreenshotBtnClicked(button)
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
            onClicked: fOpenEcoModePopup(button)
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
        pIsMacoFeatureEnabled = true; //uiBackend.confGetBool("bst.feature.macros", true)
        pIsGameControlsOverlayEnabled = true; //uiBackend.confGetBool("bst.key_controls_overlay_enabled")
        //fResetSidebar()
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
                plrBackend.onInstallApkClicked(path)
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
                                plrBackend.openMediaFolder(pScreenshotFilename)
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
                                plrBackend.openMediaManager()
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
                            asset: model.ModelData.pAsset
                            enabled: model.ModelData.pIsEnable
                            pImageHeight: pSidebarElementSize
                            pImageWidth: pSidebarElementSize
                            visible: model.ModelData.pIsFeatureEnable && model.ModelData.pShowOnKebabMenu && (index > pVisibleSidebarElementsCount-1)
                            Component.onCompleted: if(visible) pKebabMenuElementsCount++
                            UiToolTip.text: qsTranslate("QObject", model.modelData.pTooltipText)
                            pImageAnimationRunning: model.modelData.pRunImageAnimation
                            pAcceptedMouseButtons: model.modelData.pAcceptedMouseButtons
                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: model.modelData.pAcceptedMouseButtons
                                onClicked:
                                {
                                    if(mouse.button === Qt.LeftButton)
                                        model.modelData.clicked(iBtn)
                                    else
                                        model.modelData.rightClicked(iBtn)
                                }
                            }
                        }
                    }
                }
            }

            onClosePopup: {
                iKebabMenuPopup.close()
                iKebabMenuPopup.destroy()
                iKebabMenuBtn.asset = "SidebarKebabClosed"
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
                    visible: (index <= pVisibleSidebarElementsCount-1) && model.modelData.pIsFeatureEnable && model.modelData.pShowViaRepaterOnly
                    UiToolTip.text: qsTranslate("QObject", model.modelData.pTooltipText)
                    pImageAnimationRunning: model.modelData.pRunImageAnimation
                    pAcceptedMouseButtons: model.modelData.pAcceptedMouseButtons
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: model.modelData.pAcceptedMouseButtons
                        onClicked:
                        {
                            if(mouse.button === Qt.LeftButton)
                                model.modelData.clicked(iBtn)
                            else
                                model.modelData.rightClicked(iBtn)
                        }
                    }
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
                var kebabMenuWin = iKebabMenuPopupComponent.createObject(iAppwin)
                kebabMenuWin.screen = iAppwin.screen
                kebabMenuWin.x = iSidebar.mapToGlobal(0, 0).x - kebabMenuWin.width + kebabMenuWin.shadowThickness
                kebabMenuWin.y = iKebabMenuBtn.mapToGlobal(0, 0).y - kebabMenuWin.shadowThickness
                kebabMenuWin.show()
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
            onClicked: sidebarSettingClicked()
        }
        UiImageButton {
            id: iBackBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            asset: "SidebarBack"
            enabled: pIsBootComplete
            onClicked: plrBackend.onBackClicked()
        }
        UiImageButton {
            id: iHomeBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            enabled: pIsBootComplete

            asset: "SidebarHome"
            onClicked: plrBackend.onHomeClicked()
        }
        UiImageButton {
            id: iRecentBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            asset: "SidebarRecents"
            enabled: pIsBootComplete
            onClicked: plrBackend.onRecentAppsClicked()
        }
    }

    function fUpdateMouseCursorImage(mouseStateLocked) {
        pMouseCursorLocked = mouseStateLocked ? "SidebarLockCursorActive" : "SidebarLockCursor"
    }

    function fUpdateMacroBtnEnabled(enable) {
        pIsMacroEnabled = enable
    }

    function fTrimMemoryClick() {
        pRunTrimAnimation = true
        plrBackend.onTrimMemoryClicked()
    }
    function fHideTrimMemoryLoader() {
        pRunTrimAnimation = false
    }

    function fHandleScreenshotBtnClicked(button) {
        var mediaFolder = uiBackend.confGetString("bst.media_folder")
        pScreenshotBtn = button
        if (mediaFolder === "") {
            mediaFolder = plrBackend.getMediaFolder()
            pScreenShotNoticeText = mediaFolder
            pMediaPrompt = iSelectMediaPrompt.createObject(iAppwin)
            pMediaPrompt.show()
        } else { plrBackend.takeScreenshot(mediaFolder) }
    }
    function fOpenScreenshotSavedPopup(filename) {
        pScreenshotFilename = filename
        var screenshotWin = iScreenshotPopupComponent.createObject(iAppwin)
        screenshotWin.screen = iAppwin.screen
        screenshotWin.x = iSidebar.mapToGlobal(0, 0).x - screenshotWin.width + screenshotWin.shadowThickness
        screenshotWin.y = pScreenshotBtn.mapToGlobal(0, 0).y - screenshotWin.shadowThickness
        screenshotWin.show()
    }

    function fOpenEcoModePopup(button) {
        var ecoModeWin = iEcoModePopupComponent.createObject(iAppwin)
        ecoModeWin.screen = iAppwin.screen
        ecoModeWin.x = iSidebar.mapToGlobal(0, 0).x - ecoModeWin.width + ecoModeWin.shadowThickness
        ecoModeWin.y = button.mapToGlobal(0, 0).y - ecoModeWin.shadowThickness
        ecoModeWin.show()
    }

    function fUpdateVolumeState(isMuted) {
        if (pIsEcoModeEnabled) {
            pIsEcoModeSoundEnabled = !isMuted
        } else {
            pIsEcoModeSoundEnabled = false
        }
    }

    function fOpenGameControl(button, mouse) {
        if(mouse.button === Qt.RightButton)
            fOpenControlsEditorWindow()
        else
            fOpenGameControlsPopup(button)
    }
    function fOpenGameControlsPopup(button) {
        kmmBackend.kmmPopupStart()
        var gameControlsWin = iGameControlsPopupComponent.createObject(iAppwin)
        gameControlsWin.screen = iAppwin.screen

        //This is a variant list with index of the selected scheme
        //stored at 0th location and scheme list at 1st.
        var schemeInfo = kmmBackend.getPopupSchemes()
        gameControlsWin.schemeModel = schemeInfo[1]
        gameControlsWin.schemeIdx = schemeInfo[0]
        pGameControlsSensitivityEnabled = kmmBackend.hasPanControl()
        gameControlsWin.updateSenstivity()

        gameControlsWin.x = iSidebar.mapToGlobal(0, 0).x - gameControlsWin.width + gameControlsWin.shadowThickness
        gameControlsWin.y = button.mapToGlobal(0, 0).y - gameControlsWin.shadowThickness
        pGameControlsPopupLoaded = true
        gameControlsWin.show()
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
}
