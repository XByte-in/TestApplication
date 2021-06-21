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

    property int pSidebarElementSize: 32
    property bool pIsBootComplete: false
    ListModel {
        id: iVisibleSidebarItems
    }
    ListModel {
        id: iCollapsedSidebarItems
    }
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
        }
    }
    function reset(){
        iAllSidebarItems.clear()
        iAllSidebarItems.append({elementName: "SidebarFullScreen",     isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarVolumeUp",       isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarVolumeDown",     isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarLockCursor",     isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarControls",       isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarSync",           isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarMacro",          isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarMemoryTrim",     isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarInstallApk",     isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarScreenshot",     isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarMediaFolder",    isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarRotate",         isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarShake",          isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarInstanceManager",isEnable: pIsBootComplete})
        iAllSidebarItems.append({elementName: "SidebarEcoMode",        isEnable: pIsBootComplete})
    }
    Component.onCompleted: {
        reset()
    }
    onHeightChanged: {
        console.log(height)
    }
    UiColumnLayout {
        anchors.fill: parent
        Repeater {
            model: iAllSidebarItems
            UiImageButton {
                asset: elementName
                pImageHeight: pSidebarElementSize
                pImageWidth: pSidebarElementSize
                enabled: isEnable
            }
        }
        UiImageButton {
            id: iKebabMenuBtn
            Layout.alignment: Qt.AlignHCenter
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize

            asset: "SidebarKebabClosed"
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
        }
        UiImageButton {
            id: iHomeBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            asset: "SidebarHome"
        }
        UiImageButton {
            id: iRecentBtn
            pImageHeight: pSidebarElementSize
            pImageWidth: pSidebarElementSize
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            asset: "SidebarRecents"
        }
    }
}
