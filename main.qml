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
    color: "transparent"
    //flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint
    title: qsTranslate("QObject", "Test Application")

    width: 800 + 2* iShadow.shadowThickness
    height: 300 + 2* iShadow.shadowThickness
    visible: true

    UiShadowContainer{
        id:iShadow
        Rectangle { anchors.fill: parent; color:UiTheme.colors.primary80 }

        UiColumnLayout {
            anchors.fill: parent
            MainTopbar {
                Layout.alignment: Qt.AlignTop
                id: iTopbar
                color: UiTheme.colors.primary60
                Layout.fillWidth: true
                Layout.preferredHeight: 32
            }
        }
    }
}
