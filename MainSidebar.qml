import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.15
import Qt.labs.platform 1.1
import UiToolTipControl 1.0
import DialogButtonModel 1.0
import DialogButtonModelList 1.0
//import UiFolderDialog 1.0
import QtQuick.Shapes 1.12

Rectangle {
    id: iSidebar

    property bool pIsBootComplete: false
    property bool pIsMacoFeatureEnabled: false

    property int pSidebarElementSize: 32
    property int pVisibleSidebarElementsCount: 0

    readonly property string pFullscreen : "fullscreen"
//    property list<QtObject> paramModel: [
//        MainSidebarElements{ pElementId:    pAsset: "SidebarFullScreen"     ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarVolumeUp"       ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarVolumeDown"     ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarLockCursor"     ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarControls"       ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarSync"           ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarMacro"          ;  pIsEnable: true           ;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarMemoryTrim"     ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarInstallApk"     ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarScreenshot"     ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarMediaFolder"    ;  pIsEnable: true           ;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarRotate"         ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarShake"          ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarInstanceManager";  pIsEnable: true           ;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarEcoMode"        ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: true ;  pShowOnKebabMenu: true                 ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarSettings"       ;  pIsEnable: true           ;  pShowViaRepaterOnly: false;  pShowOnKebabMenu: !iSettingsBtn.visible;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarBack"           ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: false;  pShowOnKebabMenu: !iBackBtn.visible    ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarHome"           ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: false;  pShowOnKebabMenu: !iHomeBtn.visible    ;  },
//        MainSidebarElements{ pElementId:    pAsset: "SidebarRecents"        ;  pIsEnable: pIsBootComplete;  pShowViaRepaterOnly: false;  pShowOnKebabMenu: !iRecentBtn.visible  ;  }]

    ListModel {
        id: iAllSidebarItems
        property var actions : {
            "SidebarFullScreen":        function(index) { console.log("clicked! "+ index); },
            "SidebarVolumeUp":          function(index) { console.log("clicked! "+ index); },
            "SidebarVolumeDown":        function(index) { console.log("clicked! "+ index); },
            "SidebarLockCursor":        function(index) { console.log("clicked! "+ index); },
            "SidebarControls":          function(index) { console.log("clicked! "+ index); },
            "SidebarSync":              function(index) { console.log("clicked! "+ index); },
            "SidebarMacro":             function(index) { console.log("clicked! "+ index); },
            "SidebarMemoryTrim":        function(index) { console.log("clicked! "+ index); },
            "SidebarInstallApk":        function(index) { console.log("clicked! "+ index); },
            "SidebarScreenshot":        function(index) { console.log("clicked! "+ index); },
            "SidebarMediaFolder":       function(index) { console.log("clicked! "+ index); },
            "SidebarRotate":            function(index) { console.log("clicked! "+ index); },
            "SidebarShake":             function(index) { console.log("clicked! "+ index); },
            "SidebarInstanceManager":   function(index) { console.log("clicked! "+ index); },
            "SidebarEcoMode":           function(index) { console.log("clicked! "+ index); },
            "SidebarSettings":          function(index) { console.log("clicked! "+ index); },
            "SidebarBack":              function(index) { console.log("clicked! "+ index); },
            "SidebarHome":              function(index) { console.log("clicked! "+ index); },
            "SidebarRecents":           function(index) { console.log("clicked! "+ index); }
        }
    }
    function fRefresh(){
        console.log("refresh call")
        paramModel[0].refresh()
        console.log("refresh called")
        //iAllSidebarItems.setProperty(index, string, value)
    }

    function fResetSidebar(){var availableHeight = height
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

        fResetSidebarElements();
        if(availableHeight > 0) {
            var repeaterElements = 0
            for( var i = 0; i < iAllSidebarItems.count; i++ ) {
                if(iAllSidebarItems.get(i).showViaRepater) repeaterElements++ ;
            }
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
    function fResetSidebarElements(){
        //iSidebarRepeater.model = []
        iAllSidebarItems.clear()
        iAllSidebarItems.append(iQObj);
        //        iAllSidebarItems.append({elementName: "SidebarFullScreen",      isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarVolumeUp",        isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarVolumeDown",      isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarLockCursor",      isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarControls",        isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarSync",            isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        if(pIsMacoFeatureEnabled)
        //            iAllSidebarItems.append({elementName: "SidebarMacro",       isEnable: true           , showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarMemoryTrim",      isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarInstallApk",      isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarScreenshot",      isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarMediaFolder",     isEnable: true           , showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarRotate",          isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarShake",           isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarInstanceManager", isEnable: true           , showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarEcoMode",         isEnable: pIsBootComplete, showViaRepater: true , showOnKebab: true  })
        //        iAllSidebarItems.append({elementName: "SidebarSettings",        isEnable: true           , showViaRepater: false, showOnKebab: !iSettingsBtn.visible  })
        //        iAllSidebarItems.append({elementName: "SidebarBack",            isEnable: pIsBootComplete, showViaRepater: false, showOnKebab: !iBackBtn.visible  })
        //        iAllSidebarItems.append({elementName: "SidebarHome",            isEnable: pIsBootComplete, showViaRepater: false, showOnKebab: !iHomeBtn.visible  })
        //        iAllSidebarItems.append({elementName: "SidebarRecents",         isEnable: pIsBootComplete, showViaRepater: false, showOnKebab: !iRecentBtn.visible  })
        //iSidebarRepeater.model = iAllSidebarItems
    }
    onHeightChanged: {
        fResetSidebar()
    }
    Component {
        id: iKebabMenuPopupComponent
        UiWindowedPopup {
            id: iKebabMenuPopup
            property int kebabMenuElementsCount: 0
            contentWidth: pSidebarElementSize * Math.ceil(kebabMenuElementsCount / 4)
            contentHeight: Math.min(pSidebarElementSize * 4, pSidebarElementSize * kebabMenuElementsCount)
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
                            asset: elementName
                            enabled: isEnable
                            pImageHeight: pSidebarElementSize
                            pImageWidth: pSidebarElementSize
                            visible: showOnKebab && (index > pVisibleSidebarElementsCount-1)
                            onClicked: iAllSidebarItems.actions[elementName](index)
                            Component.onCompleted: {
                                if(visible) kebabMenuElementsCount++
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
            id: iSidebarRepeater
            model: paramModel
            delegate: Component {
                UiImageButton {
                    asset: model.modelData.elementName
                    pImageHeight: pSidebarElementSize
                    pImageWidth: pSidebarElementSize
                    enabled: model.modelData.isEnable
                    //visible: (index <= pVisibleSidebarElementsCount-1) && model.modelData.showViaRepater
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
}
