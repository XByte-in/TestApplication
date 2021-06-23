import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.15
import Qt.labs.platform 1.1
import UiToolTipControl 1.0
import QtQuick.Shapes 1.12

Rectangle {
    id: iRoot
    property int pSidebarElementSize: 32

    property bool pIsBootComplete: false
    property bool pIsMacoFeatureEnabled: false
    property int pVisibleSidebarElementsCount: 0
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

    property list<QtObject> iAllSidebarItems: [
        MainSidebarElement { pElementId: pFullscreen;   pAsset: "SidebarFullScreen";        pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pVolumeUp;     pAsset: "SidebarVolumeUp";          pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pVolumeDown;   pAsset: "SidebarVolumeDown";        pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pLockCursor;   pAsset: "SidebarLockCursor";        pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pGameControl;  pAsset: "SidebarControls";          pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pSync;         pAsset: "SidebarSync";              pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pMacro;        pAsset: "SidebarMacro";             pIsFeatureEnable: pIsMacoFeatureEnabled;    onClicked: fCall(); },
        MainSidebarElement { pElementId: pMemoryTrim;   pAsset: "SidebarMemoryTrim";        pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pInstallApk;   pAsset: "SidebarInstallApk";        pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pScreenshot;   pAsset: "SidebarScreenshot";        pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pMediaFolder;  pAsset: "SidebarMediaFolder";       onClicked: fCall(); },
        MainSidebarElement { pElementId: pRotate;       pAsset: "SidebarRotate";            pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pShake;        pAsset: "SidebarShake";             pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pMim;          pAsset: "SidebarInstanceManager";   onClicked: fCall(); },
        MainSidebarElement { pElementId: pEcoMode;      pAsset: "SidebarEcoMode";           pIsEnable: pIsBootComplete; onClicked: fCall(); },
        MainSidebarElement { pElementId: pSettings;     pAsset: "SidebarSettings";          pShowViaRepaterOnly: false; pShowOnKebabMenu: !iSettingsBtn.visible;    onClicked: fCall(); },
        MainSidebarElement { pElementId: pBack;         pAsset: "SidebarBack";              pIsEnable: pIsBootComplete; pShowViaRepaterOnly: false; pShowOnKebabMenu: !iBackBtn.visible;    onClicked: fCall(); },
        MainSidebarElement { pElementId: pHome;         pAsset: "SidebarHome";              pIsEnable: pIsBootComplete; pShowViaRepaterOnly: false; pShowOnKebabMenu: !iHomeBtn.visible;    onClicked: fCall(); },
        MainSidebarElement { pElementId: pRecent;       pAsset: "SidebarRecents";           pIsEnable: pIsBootComplete; pShowViaRepaterOnly: false; pShowOnKebabMenu: !iRecentBtn.visible;  onClicked: fCall(); }
    ]
    onHeightChanged: {
        fResetSidebar()
    }
    function fResetSidebar() {
        var availableHeight = iRoot.height
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
                            onClicked: model.ModelData.clicked()
                            Component.onCompleted: if(visible) pKebabMenuElementsCount++
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
                    asset: model.modelData.pAsset
                    pImageHeight: pSidebarElementSize
                    pImageWidth: pSidebarElementSize
                    enabled: model.modelData.pIsEnable
                    visible: (index <= pVisibleSidebarElementsCount-1) && model.modelData.pIsFeatureEnable && model.modelData.pShowViaRepaterOnly
                    onClicked: model.modelData.clicked()
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
        }
        UiImageButton {
            id: iBackBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            asset: "SidebarBack"
            enabled: pIsBootComplete
        }
        UiImageButton {
            id: iHomeBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            enabled: pIsBootComplete

            asset: "SidebarHome"
        }
        UiImageButton {
            id: iRecentBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            asset: "SidebarRecents"
            enabled: pIsBootComplete
        }
    }

    function fCall() {
        console.log("Test");
    }
}
