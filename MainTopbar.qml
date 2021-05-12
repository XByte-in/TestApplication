
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import UiToolTipControl 1.0
import QtQuick.Shapes 1.12
import DialogButtonModel 1.0
import DialogButtonModelList 1.0

Rectangle {
    id: iRoot

    UiRowLayout {
        id: iTopbarRow
        anchors.fill: parent
        spacing: 0
        UiImage {
            id: iProductLogo
            extn: ".png"
            asset: "BlueStacks5Beta"
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
        }

        Text {
            id: iBstTxt
            text: "Bluestacks"
            Layout.fillHeight: true
            color: UiTheme.colors.primary10
            font: UiTheme.fonts.bodyMedium
            Layout.leftMargin: 4
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: iVersionTxt
            text: "5.1.0.100"
            Layout.fillHeight: true
            color: UiTheme.colors.primary10
            font: UiTheme.fonts.bodyExtraSmall
            fontSizeMode: Text.Fit
            Layout.leftMargin: 4
            opacity: 0.7
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: iImageTxt
            text: ""
            Layout.fillHeight: true
            color: UiTheme.colors.primary10
            font: UiTheme.fonts.bodyExtraSmall
            fontSizeMode: Text.Fit
            Layout.leftMargin: 4
            opacity: 0.7
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        UiImageButton {
            id: iHomeBtn
            Layout.leftMargin: 8
            asset: "SidebarHome"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Home")
        }
        UiImageButton {
            id: iRecentBtn
            asset: "SidebarRecents"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Recent apps")
        }

        Item {
            Layout.fillWidth: true
        }


        Item {
            Layout.fillWidth: true
        }
        UiImageButton {
            id: iRawModeWarningBtn
            asset: "TitlebarError"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
        }

        UiImageButton {
            id: iHelpBtn
            asset: "TitlebarHelp"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Help and support")
        }
        UiImageButton {
            id: iCfgBtn
            asset: "TitlebarMenu"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Menu")
        }
        UiImageButton {
            asset: "TitlebarMinimize"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Minimize")
        }
        UiImageButton {
            asset: "TitlebarMaximize"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Maximize")
        }
        UiImageButton {
            asset: "TitlebarRestore"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Restore")
        }
        UiImageButton {
            asset: "TitlebarClose"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Close")
            onClicked: iAppwin.close()
        }
        UiImageButton {
            id: iSidebarShowBtn
            asset: "TitlebarExpand"
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            pSourceHeight: 32
            pSourceWidth: 32
            UiToolTip.text: qsTranslate("QObject", "Open sidebar")
        }
    }
}
