import QtQuick 2.12
import QtQuick.Controls 2.12
import DirValidator 1.0

SpinBox {
    id: iControl

    property QtObject pSize: UiTheme.spinBoxes.sizes.normal
    property QtObject pColor: UiTheme.spinBoxes.colors.accent
    property int pInputValidationState: UiTextField.InputValidation.Valid

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: pSize.indicatorWidth - 1

    contentItem: UiTextField {
        pSize: iControl.pSize.textFieldSize
        pColor: iControl.pColor.textFieldColor
        text: iControl.displayText
        readOnly: !iControl.editable
        horizontalAlignment: TextInput.AlignHCenter
        pInputValidationState: iControl.pInputValidationState
        validator: iControl.validator
        pColorState: pInputValidationState === UiTextField.InputValidation.Error ?
                         pColor.error : pInputValidationState === UiTextField.InputValidation.Warning ?
                             pColor.warning : iControl.activeFocus ?
                                 pColor.active : iControl.hovered ?
                                     pColor.hover : pColor.normal
    }

    up.indicator: Rectangle {
        height: parent.height / 2 + 1
        implicitWidth: iControl.pSize.indicatorWidth
        implicitHeight: iControl.pSize.indicatorWidth
        border.color: iControl.contentItem.background.border.color
        border.width: iControl.contentItem.background.border.width
        color: iControl.contentItem.background.color
        anchors.right: parent.right
        anchors.top: parent.top

        Image {
            source: "Assets/downArrow.png"
            height: iControl.pSize.indicatorImageHeight
            width: iControl.pSize.indicatorImageWidth
            anchors.centerIn: parent
        }
    }

    down.indicator: Rectangle {
        height: parent.height / 2
        implicitWidth: iControl.pSize.indicatorWidth
        implicitHeight: iControl.pSize.indicatorWidth
        border.color: iControl.contentItem.background.border.color
        border.width: iControl.contentItem.background.border.width
        color: iControl.contentItem.background.color
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Image {
            source: "Assets/upArrow.png"
            height: iControl.pSize.indicatorImageHeight
            width: iControl.pSize.indicatorImageWidth
            anchors.centerIn: parent
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}
