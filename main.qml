import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.12
import QtQml.Models 2.15
import DirValidator 1.0
import UiToolTipControl 1.0
import MaskedMouseArea 1.0

ApplicationWindow {
    id: iAppwin
    width: 500
    height: 350
    x: Screen.width / 2 - width / 2
    y : Screen.height / 2 - height / 2
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint
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
                    property var startingPosition
                    property bool isPressed: false
                    property bool skipFirstEvent: false

                    onPressed: {
                        isPressed = true
                        startingPosition  = Qt.point(mouse.x, mouse.y)
                    }
                    onReleased: isPressed = false

                    onDoubleClicked: {
                        iAppwin.visibility === ApplicationWindow.Windowed ? iAppwin.showMaximized() : iAppwin.showNormal()
                    }
                    onPositionChanged: {
                        if(isPressed) {
                            if (iAppwin.visibility === ApplicationWindow.Maximized) {
                                var actualX = iAppwin.x
                                var mx = (startingPosition.x-iAppwin.x) / iAppwin.width
                                var my = mouse.y - iAppwin.y

                                iAppwin.showNormal()
                                iAppwin.x = actualX + startingPosition.x - mx*iAppwin.width
                                iAppwin.y = startingPosition.y

                                skipFirstEvent = true
                            } else {
                                if(skipFirstEvent) {
                                    startingPosition  = Qt.point(mouse.x, mouse.y)
                                    skipFirstEvent = false
                                } else {
                                    var delta = Qt.point(mouse.x-startingPosition.x, mouse.y-startingPosition.y)
                                    iAppwin.x += delta.x;
                                    iAppwin.y += delta.y;
                                    skipFirstEvent = false
                                }
                            }
                        }
                    }
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
                id: iTest
                Layout.fillHeight: true
                Layout.fillWidth: true
                UiColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    UiButton {
                        pSize: UiTheme.buttons.sizes.medium
                        pColor: UiTheme.buttons.colors.accent
                        text: qsTranslate("QObject", "Click")
                        onClicked: fOpenSettingsWindow("Test")
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
    function fOpenSettingsWindow(vmName) {
        var component = Qt.createComponent("MimSettingsWindow.qml")
        if (component.status === Component.Ready) {
            var pSettingsWindow = component.createObject(iAppwin,{ pVmName: vmName})
            if (pSettingsWindow !== null) {
                var shadowWidthDiff = 2 * pSettingsWindow.pShadowThickness
                var settingsWidth = Math.max(iAppwin.width + shadowWidthDiff, (800  + shadowWidthDiff))
                var settingsHeight = Math.max(iAppwin.height + shadowWidthDiff, (550 + shadowWidthDiff))
                var settingsX = iAppwin.x - ((settingsWidth / 2) - (iAppwin.width / 2))
                var settingsY = iAppwin.y - ((settingsHeight / 2) - (iAppwin.height / 2))


                if (settingsX < pSettingsWindow.screen.virtualX) {
                    if (iAppwin.x < pSettingsWindow.screen.virtualX)
                        settingsX = pSettingsWindow.screen.virtualX
                    else
                        settingsX = iAppwin.x - (shadowWidthDiff / 2)
                }
                if (settingsY < pSettingsWindow.screen.virtualY) {
                    if (iAppwin.y < pSettingsWindow.screen.virtualY)
                        settingsY = pSettingsWindow.screen.virtualY
                    else
                        settingsY = iAppwin.y - (shadowWidthDiff / 2)
                }

                if (((settingsX + settingsWidth) > pSettingsWindow.screen.virtualX + pSettingsWindow.screen.width))
                {
                    settingsX = pSettingsWindow.screen.virtualX
                            + pSettingsWindow.screen.width - settingsWidth
                }
                if (((settingsY + settingsHeight) > pSettingsWindow.screen.virtualY + pSettingsWindow.screen.height)) {
                    settingsY = pSettingsWindow.screen.virtualY
                            + pSettingsWindow.screen.height - settingsHeight
                }

                pSettingsWindow.width = settingsWidth
                pSettingsWindow.height = settingsHeight
                pSettingsWindow.x = settingsX
                pSettingsWindow.y = settingsY
                pSettingsWindow.show()
            }
        }
    }
}
