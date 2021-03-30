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
    width: 600
    height: 600
    visible: true

    property bool pMacroRecordingControlVisible: false
    property bool pMacroRecordingControlTimerRunning: false
    property bool pMacroRecordingInProcess: false
    property var pMacroRecordingStartTime: -1
    property var pMacroRecordingPausedTime: -1
    property string pMacroRecordingControlText: "00:00:00"
    property string pMacroRecordingControlIterationText: "{} Time"
    Rectangle {
        anchors.fill: parent
        color: "#232642"
        MouseArea {
            anchors.fill: parent
        }
    }
    UiComboBox {
        id: iCustomCpuCombobx
        model: [1,2,3,4,5,6,7,89,90]        
        pSize: UiTheme.comboBoxes.sizes.medium
        width: 200
    }
}
