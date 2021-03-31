import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.12

import DirValidator 1.0
import DialogButtonModel 1.0
import DialogButtonModelList 1.0
import UiToolTipControl 1.0

ApplicationWindow {
    id: appwin
    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint
    title: qsTranslate("QObject", "%1 macro manager")
    width: 540 + 2* iShadow.shadowThickness
    height: 360 + 2* iShadow.shadowThickness
    visible: true

    property bool pMacroRecordingControlVisible: false
    property bool pMacroRecordingControlTimerRunning: false
    property bool pMacroRecordingInProcess: false
    property var pMacroRecordingStartTime: -1
    property var pMacroRecordingPausedTime: -1
    property string pMacroRecordingControlText: "00:00:00"
    property string pMacroRecordingControlIterationText: "{} Time"
    UiShadowContainer{
        id:iShadow

        Rectangle {
            anchors.fill: parent
            color: UiTheme.colors.primary80
        }
        UiRowLayout {
            id: iRow

            color: UiTheme.colors.overLayBlack

            x: parent.x + parent.width/2 - width/2
            y: parent.y + 10

            leftPadding: 10
            rightPadding: 10
            topPadding: 5
            bottomPadding: 5

            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            Text {
                id: iMessage
                color: UiTheme.colors.secondaryHover
                font: UiTheme.fonts.bodySmall
                wrapMode: Text.Wrap
                text: "I macro imported successfully"
            }
            UiImageButton{
                asset: "CloseIcon"
                width: 16
                height: 16
            }
        }
    }
}
