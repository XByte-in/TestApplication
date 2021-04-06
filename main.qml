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
    title: qsTranslate("QObject", "Test Application")
    width: 540 + 2* iShadow.shadowThickness
    height: 360 + 2* iShadow.shadowThickness
    visible: true



    //Component.onCompleted: {iToast.fShow("Testng my toast", 1000000)}

    UiShadowContainer{
        id:iShadow
        Rectangle { anchors.fill: parent; color:UiTheme.colors.primary80 }

        UiToast{
            id: iToast
            visible: true
            pShowCross: true
        }

        Rectangle {
            height: 300
            width: 1
            anchors.centerIn: parent
        }
    }
}
