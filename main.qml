import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    width: 640
    height: 400
    visible: true
    title: qsTr("Scroll")
    property int pRenameMacroListViewHeight:0
    property int pValidMacrosListViewHeight:0
    property int pInvalidMacrosListViewHeight:0

    Rectangle {
        width:240
        height: 242
        color: "Aqua"
        ScrollView {
            spacing: 0
            id: scrollView
            anchors.fill: parent
            clip: true
            UiColumnLayout {
                anchors.fill: parent
                spacing:0
                topPadding: 8
                ListView {
                    id: iRenameImportMacrosListView
                    width: parent.width
                    model: ListModel {
                        ListElement { name: "A"; newName: "A(1)"; filePath:"test"; isChecked: true; isRename:false}
                        ListElement { name: "B"; newName: "B(1)"; filePath:"test"; isChecked: true; isRename:false}
                    }
                    Layout.minimumHeight: pRenameMacroListViewHeight
                    delegate: Rectangle {
                        property var pIsChecked: isChecked
                        property var pNewName: newName

                        width: 240
                        height: iRenameMacroRadioBtn.checked? 92: 67
                        color: "Transparent"
                        Layout.alignment: Qt.AlignVCenter
                        Component.onCompleted: {
                            pRenameMacroListViewHeight += height
                        }
                        UiColumnLayout {
                            id: iCol
                            anchors.fill: parent
                            padding: 0
                            leftPadding: 12
                            Layout.maximumHeight: iRenameMacroRadioBtn.checked? 84: 59
                            UiCheckBox {
                                text: name
                                pSize: UiTheme.checkBoxes.sizes.small
                                font: UiTheme.fonts.bodySmall
                                checked: pIsChecked
                                onCheckedChanged: {
                                    isChecked = checked
                                    resetSelectAll();
                                }
                            }
                            UiColumnLayout {
                                padding: 0
                                leftPadding: 20
                                Text {
                                    Layout.fillWidth: true
                                    text: qsTranslate("QObject", "Macro with the same name exists.")
                                    color: UiTheme.colors.warning
                                    wrapMode: Text.Wrap
                                    font: UiTheme.fonts.bodySmallest
                                    bottomPadding: 7
                                }
                                UiRowLayout {
                                    padding: 0
                                    UiRadioButton{
                                        text: qsTranslate("QObject", "Replace")
                                        checked: true
                                        ButtonGroup.group: iBtnGrp
                                        pSize: UiTheme.radioButtons.sizes.small
                                        Layout.maximumWidth: 95
                                        Layout.minimumWidth: 95

                                        onCheckedChanged: {
                                            if(checked)
                                            {
                                                pRenameMacroListViewHeight -= 25
                                                isRename = false
                                                newName = pNewName
                                            }
                                        }
                                    }
                                    UiRadioButton{
                                        id: iRenameMacroRadioBtn
                                        text: qsTranslate("QObject", "Rename")
                                        checked: false
                                        ButtonGroup.group: iBtnGrp
                                        leftPadding: 5
                                        pSize: UiTheme.radioButtons.sizes.small
                                        Layout.maximumWidth: 95
                                        Layout.minimumWidth: 95
                                        onCheckedChanged: {
                                            if(checked)
                                            {
                                                pRenameMacroListViewHeight += 25
                                                isRename = true
                                                newName = pNewName
                                            }
                                        }
                                    }
                                }
                                UiTextField {
                                    Layout.topMargin: 4
                                    visible: iRenameMacroRadioBtn.checked ? true : false
                                    font: UiTheme.fonts.bodyExtraSmall
                                    height: 21
                                    Layout.maximumWidth: 196
                                    Layout.minimumWidth: 196
                                    text: pNewName
                                    onTextChanged: {
                                        newName = text
                                        var result = mnsBackend.validateImportMacroName(text);
                                        if(result !== 0)
                                        {

                                        }
                                    }
                                }
                            }
                        }
                        ButtonGroup {
                            id: iBtnGrp
                        }
                    }
                }
                ListView {
                    id: iValidImportMacrosListView
                    width: parent.width
                    model: ListModel {
                        ListElement { name: "C"; newName: "C(1)"; filePath:"test"; isChecked: true; isRename:false}
                        ListElement { name: "D"; newName: "D(1)"; filePath:"test"; isChecked: true; isRename:false}
                    }
                    Layout.minimumHeight: pValidMacrosListViewHeight
                    delegate: Rectangle {
                        property var pIsChecked: isChecked

                        width: 240
                        height: 26
                        color: "Transparent"
                        Layout.alignment: Qt.AlignVCenter
                        Component.onCompleted: {
                            pValidMacrosListViewHeight += height
                        }
                        UiCheckBox {
                            leftPadding: 12
                            text: name
                            pSize: UiTheme.checkBoxes.sizes.small
                            font: UiTheme.fonts.bodySmall
                            checked: pIsChecked
                            onCheckedChanged: {
                                isChecked = checked
                                resetSelectAll();
                            }
                        }
                    }
                }

                UiRowLayout {
                    width: parent.width
                    Layout.topMargin: 4
                    Layout.bottomMargin: 4
                    spacing: 0
                    Text {
                        text: qsTranslate("QObject", "Incompatible macros");
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font: UiTheme.fonts.bodySmallest
                        color: UiTheme.colors.primary30
                        wrapMode: Text.Wrap

                        Layout.leftMargin: 12
                        Layout.rightMargin: 4
                    }
                    UiImage {
                        id: iIncompatibleMacroHelp
                        asset: "HelpSmall"
                        Layout.leftMargin: 12
                        width: 12
                        height: 12
                        Layout.alignment: Qt.AlignLeft
                    }
                }

                ListView {
                    width: parent.width
                    model: ListModel {
                        ListElement { name: "E"; newName: "E(1)"; filePath:"test"; isChecked: true; isRename:false}
                        ListElement { name: "F"; newName: "F(1)"; filePath:"test"; isChecked: true; isRename:false}
                    }
                    Layout.minimumHeight: pInvalidMacrosListViewHeight
                    delegate: Rectangle {
                        width: 240
                        height: 26
                        color: "Transparent"
                        Layout.alignment: Qt.AlignVCenter
                        Component.onCompleted: {
                            pInvalidMacrosListViewHeight += height
                        }
                        UiRowLayout {
                            spacing: 0
                            UiImage {
                                asset: "ErrorSmall"
                                Layout.leftMargin: 12
                                Layout.rightMargin: 8
                                Layout.preferredWidth: 12
                                Layout.preferredHeight: 12
                            }
                            Text {
                                text: name
                                Layout.maximumWidth: 196
                                font: UiTheme.fonts.bodySmall
                                color: UiTheme.colors.primary20
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                }
            }
        }
    }
}
