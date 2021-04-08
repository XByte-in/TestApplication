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

    UiShadowContainer{
        id:iShadow
        Rectangle { anchors.fill: parent; color:UiTheme.colors.primary80 }

        UiComboBox {
            width: 200
            model: [1,2,3,4,5]
            pSize: UiTheme.comboBoxes.sizes.medium
        }
    }
}
