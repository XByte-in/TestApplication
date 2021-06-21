import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.12
import QtQuick.Controls 1.4
import DirValidator 1.0
import DialogButtonModel 1.0
import DialogButtonModelList 1.0
import UiToolTipControl 1.0
ApplicationWindow {
    id: iAppwin
    width: 600
    height: 400
    x: Screen.width / 2 - width / 2
    y : Screen.height / 2 - height / 2
    //flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint
    color: UiTheme.colors.primary80
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border { color: UiTheme.colors.primary60; width: 1 }
        UiColumnLayout {
            anchors.fill: parent
            anchors.margins: 1
            UiRowLayout {
                id: iTopbarRow
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                spacing: 0
                color: UiTheme.colors.primary60
                Text {
                    id: iBstTxt
                    text: "Test App"
                    Layout.fillHeight: true
                    color: UiTheme.colors.primary10
                    font: UiTheme.fonts.bodyMedium
                    Layout.leftMargin: 12
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                MouseArea {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onPositionChanged: iAppwin.startSystemMove()
                }
                UiImageButton {
                    id:iCloseBtn
                    asset: "TitlebarClose"
                    pImageWidth: 32
                    pImageHeight: 32
                    Layout.alignment: Qt.AlignRight
                    UiToolTip.text: qsTranslate("QObject", "Close")
                    onClicked: iAppwin.close()
                }
            }

            UiRowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                UiColumnLayout {
                    id: iTestArea
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"

                    UiButton {
                        text: "Boot Complete Toggle"
                        pSize: UiTheme.buttons.sizes.medium
                        pColor: UiTheme.buttons.colors.accent
                        onClicked: {
                            iSidebar.pIsBootComplete = !iSidebar.pIsBootComplete
                            iSidebar.fResetSidebarElements()
                        }
                    }
                    UiButton {
                        text: "Macro Feature toggle"
                        pSize: UiTheme.buttons.sizes.medium
                        pColor: UiTheme.buttons.colors.accent
                        onClicked: {
                            iSidebar.pIsMacoFeatureEnabled = !iSidebar.pIsMacoFeatureEnabled
                            iSidebar.fResetSidebarElements()
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                    }
                }

                MainSidebar {
                    id: iSidebar
                    color: UiTheme.colors.primary80
                    Layout.preferredWidth: 32
                    Layout.fillHeight: true
                    border { color: UiTheme.colors.primary60 ; width: 1 }
                }
            }
        }
    }
}
