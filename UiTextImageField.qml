import QtQuick 2.0
import UiToolTipControl 1.0
UiTextField {
    id: iControl

    property string pAsset
    property QtObject pTextFieldProperties: UiTheme.textImageField.normal
    property bool pReadOnly : true
    signal clicked

    readOnly: pReadOnly
    rightPadding: pTextFieldProperties.imageWidth + 2*pTextFieldProperties.rightPadding

    background: Rectangle {
        color: readOnly ? "transparent"  : iControl.pColorState.background
        border.width: readOnly ? 0 : pTextFieldProperties.borderWidth
        border.color: pTextFieldProperties.borderColor
    }

    UiImageButton {
        id: iImage
        UiToolTip.text: qsTranslate("QObject", "Save")
        anchors { verticalCenter: parent.verticalCenter ; right: parent.right;}
        anchors.rightMargin: pTextFieldProperties.rightPadding
        asset: iControl.pAsset
        height: pTextFieldProperties.imageWidth
        width: pTextFieldProperties.imageHeight
        visible: !iControl.readOnly
        onClicked: {
            pReadOnly = true
            iControl.clicked()
        }
    }
}
