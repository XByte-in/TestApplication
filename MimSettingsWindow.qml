/*
 * Copyright (C) 2020-2021 BlueStack Systems, Inc.
 * All Rights Reserved
 *
 * THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF BLUESTACK SYSTEMS, INC.
 * The copyright notice above does not evidence any actual or intended
 * publication of such source code.
 */

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
//import DialogButtonModel 1.0
//import DialogButtonModelList 1.0

Window {
    id: iSettingsWindow
    objectName: "settingsWindow"
    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint
    modality: Qt.ApplicationModal
    title: qsTranslate("QObject", "Settings")

    screen: transientParent.screen

    signal showRestartLoader()

    readonly property alias pShadowThickness: iSettingsWindowShadowContainer.shadowThickness
    property int pSettingsBtnCount: 11
    property UiSettingsButton pSelectedSetting: iPerformanceSettingsBtn
    property UiSettingsButton pCurrentSelectedSetting: iPerformanceSettingsBtn
    //TODO: Rename prefix of common settings qml from Plr to Ui
    property string pParentWindow: "mim"
    property string pVmName: ""
    property bool pCurrentTabDirty: false


    function fChangeSelectedSetting(newSelectedSetting) {
     console.info("pSettingBtnText: ",newSelectedSetting.pSettingBtnText)
        pCurrentSelectedSetting = newSelectedSetting
        fSwitchSettingPanel()
    }

    function fSwitchSettingPanel() {
        if (pSelectedSetting !== pCurrentSelectedSetting) {
            pSelectedSetting.pSelected = false
            pCurrentSelectedSetting.pSelected = true
            pSelectedSetting = pCurrentSelectedSetting
            iSelectedSettingControl.currentIndex = pCurrentSelectedSetting.pSettingIdx
        }
    }


    function fSaveSettingsForMim(){       
        close()
    }

//    Component {
//        id: iDiscardChangesAndClosePrompt
//        UiMessageDialog {
//            title: qsTranslate("QObject", "Discard Changes")
//            pDescription: qsTranslate("QObject", "Are you sure you want to discard changes and leave this tab?")
//            pDialogType: UiDialog.DialogTypes.SimpleNarrow
//            pButtonsList: DialogButtonModelList {
//                pButtons: [
//                    DialogButtonModel {
//                        pColor: UiTheme.buttons.colors.danger
//                        pText: qsTranslate("QObject",  "Discard Changes")
//                        onClicked: {
//                            close()
//                            iSettingsWindow.close()
//                        }
//                    },
//                    DialogButtonModel {
//                        pColor: UiTheme.buttons.colors.secondary
//                        pText: qsTranslate("QObject", "No")
//                        onClicked: {
//                            close()
//                        }
//                    }
//                ]
//            }
//        }
//    }

//    Component {
//        id: iDiscardChangesPrompt
//        UiMessageDialog {
//            title: qsTranslate("QObject", "Discard Changes")
//            pDescription: qsTranslate("QObject", "Are you sure you want to discard changes and leave this tab?")
//            pDialogType: UiDialog.DialogTypes.SimpleNarrow
//            pButtonsList: DialogButtonModelList {
//                pButtons: [
//                    DialogButtonModel {
//                        pColor: UiTheme.buttons.colors.danger
//                        pText: qsTranslate("QObject",  "Discard Changes")
//                        onClicked: {
//                            iSelectedSettingControl.children[iSelectedSettingControl.currentIndex].fDiscardChanges()
//                            close()
//                        }
//                    },
//                    DialogButtonModel {
//                        pColor: UiTheme.buttons.colors.secondary
//                        pText: qsTranslate("QObject", "No")
//                        onClicked: {
//                            close()
//                        }
//                    }
//                ]
//            }
//        }
//    }

    //@disable-check M16
    onClosing: {
        destroy()
    }

    UiShadowContainer {
        id: iSettingsWindowShadowContainer
        Rectangle {
            anchors.fill: parent
            color: UiTheme.colors.primary80
            UiColumnLayout {
                id:iContentLayout
                anchors.centerIn: parent
                spacing: 20

                UiColumnLayout {
                    id: iSettingsWindowsHeader
                    Layout.preferredHeight: 40
                    Layout.fillWidth: true

                    Text {
                        text: qsTranslate("QObject", "Settings")
                        font: UiTheme.fonts.titleExtraLarge
                        color: UiTheme.colors.primary10
                    }
                }

                UiRowLayout {
                    Layout.fillWidth: true
                    spacing: 32
                    UiRowLayout{
                        Layout.alignment: Qt.AlignTop
                        spacing: 4
                        UiColumnLayout {
                            UiSettingsButton { id: iPerformanceSettingsBtn; pSettingIdx: 0; pSettingBtnText: qsTranslate("QObject", "Performance"); pSelected: true; onSettingClicked: fChangeSelectedSetting(this) }
                            UiSettingsButton { id: iDisplaySettingsBtn; pSettingIdx: 1; pSettingBtnText: qsTranslate("QObject", "Display"); onSettingClicked: fChangeSelectedSetting(this) }
                            UiSettingsButton { id: iGraphicsSettingsBtn; pSettingIdx: 2; pSettingBtnText: qsTranslate("QObject", "Graphics"); onSettingClicked: fChangeSelectedSetting(this) }
                        }

                        Rectangle {
                            width: 1
                            Layout.fillHeight: true
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.rgba(UiTheme.colors.primary60.r, UiTheme.colors.primary60.g, UiTheme.colors.primary60.b, 1) }
                                GradientStop { position: 1.0; color: Qt.rgba(UiTheme.colors.primary60.r, UiTheme.colors.primary60.g, UiTheme.colors.primary60.b, 0) }
                            }
                        }
                    }

                    Rectangle {
                        Layout.preferredHeight: iSettingsWindow.height * 0.85 - iSettingsWindowsHeader.height - iContentLayout.spacing
                        Layout.minimumHeight: 360
                        Layout.maximumHeight: 570
                        Layout.preferredWidth: 548
                        color: "transparent"
                        StackLayout {
                            id: iSelectedSettingControl
                            anchors.fill: parent
                            currentIndex: 0
                            PlrPerformanceSetting {
                                id: iPerformanceSetting
                                pParentWindow: iSettingsWindow.pParentWindow
                                pVmName: iSettingsWindow.pVmName
                            }

                            PlrDisplaySetting {
                                id: iDisplaySetting
                                pParentWindow: iSettingsWindow.pParentWindow
                            }

                            PlrGraphicsSetting {
                                pParentWindow: iSettingsWindow.pParentWindow
                            }
                        }
                    }
                }
            }

            UiImageButton {
                asset: "CloseIcon"
                pImageWidth: 16
                pImageHeight: 16
                anchors.top: parent.top
                anchors.topMargin: Math.min(iSettingsWindow.height * 0.06, 56)
                anchors.right: parent.right
                anchors.rightMargin: Math.min(iSettingsWindow.height * 0.06, 56)
                onClicked:  iSettingsWindow.close()
            }
        }
    }
}
