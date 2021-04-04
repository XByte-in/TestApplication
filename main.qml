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

    property int count: 0
    ListModel { id: iModel }

    Component.onCompleted: { }

    UiShadowContainer{
        id:iShadow
        Rectangle { anchors.fill: parent; color: UiTheme.colors.primary80 }

        UiColumnLayout{
            width: 280 - 24
            spacing: 10

            UiComboBox {
                id: iSchemeCombobox
                pSize: UiTheme.comboBoxes.sizes.small
                Layout.fillWidth: true
                Layout.preferredHeight: 24
                Layout.alignment: Qt.AlignCenter
                model:iModel

                contentItem: UiTextField {
                    pSize: iSchemeCombobox.pSize.textField
                    pColor: iSchemeCombobox.pColor.textField
                    pColorState: iSchemeCombobox.hovered ? pColor.hover : pColor.normal
                    rightPadding: 0
                    text: iModel.count === 0 ? "Custom": iSchemeCombobox.displayText
                    enabled: false
                    autoScroll: false
                    readOnly: true

                    background: Rectangle { color: "transparent" }
                }

                delegate:  ItemDelegate {
                    width: ListView.view.width
                    height: iSchemeCombobox.height
                    palette.highlightedText: iSchemeCombobox.contentItem.pColor.active.textColor
                    highlighted: iSchemeCombobox.highlightedIndex === index
                    hoverEnabled: iSchemeCombobox.hoverEnabled

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
                            Layout.maximumWidth: iSchemeCombobox.width -80
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
                        color: highlighted ? iSchemeCombobox.pColor.dropDownHighlight :
                                             iSchemeCombobox.currentIndex === index ? iSchemeCombobox.pColor.dropDownSelection : "transparent"
                    }
                }

                popup: Popup {
                    y: iSchemeCombobox.height
                    width: iSchemeCombobox.width
                    height: Math.min(contentItem.implicitHeight, iSchemeCombobox.pSize.maxDropDownHeight, iSchemeCombobox.Window.height)
                    padding: 0

                    contentItem: UiColumnLayout {
                        ListView {
                            id: iListView
                            implicitHeight: contentHeight
                            implicitWidth: iSchemeCombobox.width
                            model: iSchemeCombobox.delegateModel
                            currentIndex: iSchemeCombobox.highlightedIndex
                            highlightMoveDuration: 0
                            Layout.maximumHeight: 130

                            ScrollIndicator.vertical: ScrollIndicator { }
                            Rectangle {
                                z: 10
                                width: parent.width
                                height: parent.height
                                color: "transparent"
                                border.width: 1
                                border.color: iSchemeCombobox.pColor.normal.border
                            }

                            onCurrentIndexChanged: {
                                console.log(iSchemeCombobox.currentIndex)
                            }
                        }

                        Rectangle {
                            border.width: 1
                            border.color: iSchemeCombobox.pColor.normal.border
                            anchors.topMargin: -1
                            Layout.fillWidth: true
                            height: iSchemeCombobox.height
                            color: iFooterMouseArea.containsMouse? UiTheme.colors.primary80: UiTheme.colors.primary90

                            UiRowLayout {
                                anchors.fill:parent
                                z: 1000
                                leftPadding: 8
                                rightPadding: 8
                                topPadding: 5
                                bottomPadding: 5
                                spacing: 8
                                UiImage {
                                    asset: "AddSmall"
                                    Layout.preferredHeight: 12
                                    Layout.preferredWidth: 12
                                    Layout.alignment: Qt.AlignVCenter
                                }
                                Text {
                                    text: qsTranslate("QObject", "Create new profile")
                                    font: UiTheme.fonts.bodySmall
                                    color: UiTheme.colors.primary10
                                    Layout.alignment: Qt.AlignVCenter
                                }
                            }
                            MouseArea {
                                id: iFooterMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onPressed: {
                                    iModel.append( { text: "Default " + count})
                                    count++
                                }
                            }
                        }
                    }
                    background: Rectangle {
                        color:  iSchemeCombobox.pColor.normal.background
                    }
                }
            }
        }
    }
}
