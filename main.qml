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
    width: 258 + 2* iShadow.shadowThickness
    height: 360 + 2* iShadow.shadowThickness
    visible: true

    ListModel { id: iModel }

    Component.onCompleted: {
        iModel.append( { text: "Default 1" })
        iModel.append( { text: "Default 2" })
    }

    UiShadowContainer{
        id:iShadow
        Rectangle { anchors.fill: parent; color: UiTheme.colors.primary80 }


        UiColumnLayout{
            width: 280 - 24
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                height: iTestCombobox.height
                UiRowLayout {
                    anchors.fill:parent
                    color: UiTheme.colors.primary90
                    z: 1000
                    leftPadding: 8
                    rightPadding: 8
                    topPadding: 5
                    bottomPadding: 5
                    spacing: 8
                    UiImageButton {
                        asset: "AddSmall"
                        Layout.preferredHeight: 12
                        Layout.preferredWidth: 12
                        Layout.alignment: Qt.AlignVCenter
                        onClicked: {
                            iModel.append( { text: "Default" })
                        }
                    }

                    Text {
                        text: qsTranslate("QObject", "Create new profile")
                        font: UiTheme.fonts.bodySmall
                        color: UiTheme.colors.primary10
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                    }

                }
            }








            UiComboBox {
                id: iTestCombobox
                pSize: UiTheme.comboBoxes.sizes.small
                Layout.fillWidth: true
                Layout.preferredHeight: 24
                Layout.alignment: Qt.AlignCenter
                model:iModel
                delegate:  ItemDelegate {
                    width: ListView.view.width
                    height: iTestCombobox.height
                    palette.highlightedText: iTestCombobox.contentItem.pColor.active.textColor
                    highlighted: iTestCombobox.highlightedIndex === index
                    hoverEnabled: iTestCombobox.hoverEnabled

                    contentItem:  UiRowLayout {
                        id: iModelDelegate
                        anchors.fill: parent
                        spacing: 8
                        leftPadding: 8
                        rightPadding: 8
                        Text {
                            id: iText
                            text: modelData
                            elide: Text.ElideRight
                            font: UiTheme.fonts.bodySmall
                            color: UiTheme.colors.primary10
                            UiToolTip.text: text
                            Layout.maximumWidth: iTestCombobox.width -80
                            Layout.alignment: Qt.AlignVCenter
                        }
                        Item {
                            Layout.fillWidth: true
                        }

                        UiImageButton {
                            asset: "EditIcon"
                            UiToolTip.text: qsTranslate("QObject", "Edit")
                            Layout.preferredHeight: 12
                            Layout.preferredWidth: 12
                            Layout.alignment: Qt.AlignVCenter
                        }

                        UiImageButton {
                            asset: "DuplicateSmall"
                            UiToolTip.text: qsTranslate("QObject", "Copy")
                            Layout.preferredHeight: 12
                            Layout.preferredWidth: 12
                            Layout.alignment: Qt.AlignVCenter
                        }

                        UiImageButton {
                            asset: "DeleteSmall"
                            UiToolTip.text: qsTranslate("QObject", "Delete")
                            Layout.preferredHeight: 12
                            Layout.preferredWidth: 12
                            Layout.alignment: Qt.AlignVCenter
                        }
                    }

                    background: Rectangle {
                        color: highlighted ? iTestCombobox.pColor.dropDownHighlight :
                                             iTestCombobox.currentIndex === index ? iTestCombobox.pColor.dropDownSelection : "transparent"
                    }
                }

                popup: Popup {
                    y: iTestCombobox.height
                    width: iTestCombobox.width
                    height: Math.min(contentItem.implicitHeight, iTestCombobox.pSize.maxDropDownHeight, iTestCombobox.Window.height)
                    padding: 0

                    contentItem: UiColumnLayout {
                        ListView {
                            id: iListView
                            implicitHeight: contentHeight
                            implicitWidth: iTestCombobox.width
                            model: iTestCombobox.delegateModel
                            currentIndex: iTestCombobox.highlightedIndex
                            highlightMoveDuration: 0
                            Layout.maximumHeight: 130

                            ScrollIndicator.vertical: ScrollIndicator { }
                            Rectangle {
                                z: 10
                                width: parent.width
                                height: parent.height
                                color: "transparent"
                                border.width: 1
                                border.color: iTestCombobox.pColor.normal.border
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: iTestCombobox.height
                            UiRowLayout {
                                anchors.fill:parent
                                id: iFooter
                                color: UiTheme.colors.primary90
                                z: 1000
                                leftPadding: 8
                                rightPadding: 8
                                topPadding: 5
                                bottomPadding: 5
                                spacing: 8
                                UiImageButton {
                                    asset: "AddSmall"
                                    Layout.preferredHeight: 12
                                    Layout.preferredWidth: 12
                                    Layout.alignment: Qt.AlignVCenter
                                    onClicked: {
                                        iModel.append( { text: "Default" })
                                    }
                                }

                                Text {
                                    text: qsTranslate("QObject", "Create new profile")
                                    font: UiTheme.fonts.bodySmall
                                    color: UiTheme.colors.primary10
                                    Layout.alignment: Qt.AlignVCenter
                                }

                            }
                            MouseArea {
                                anchors.fill: parent
                            }
                        }
                    }
                    background: Rectangle {
                        color:  iTestCombobox.pColor.normal.background
                    }
                }
            }
        }
    }
}
