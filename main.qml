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
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint
    title: qsTranslate("QObject", "Test Application")

    width: 500 + 2* iShadow.shadowThickness
    height: 300 + 2* iShadow.shadowThickness
    visible: true

    UiShadowContainer{
        id:iShadow
        Rectangle { anchors.fill: parent; color:UiTheme.colors.primary80 }

        ListModel {
            id: myModel
            ListElement { text: "1" }
            ListElement { text: "2" }
            ListElement { text: "3" }
            ListElement { text: "4" }
            ListElement { text: "5" }
            ListElement { text: "6" }
            ListElement { text: "7" }
        }

        Item {
            id: mainContent
            anchors.fill: parent

            ScrollView {
                anchors.fill: parent
                ListView {
                    id: listView
                    model: myModel
                    delegate: DraggableItem {
                        Rectangle {
                            height: 40
                            width: 40
                            color: "white"

                            Text {
                                id: textLabel
                                anchors.centerIn: parent
                                text: model.text
                            }
                            Rectangle {
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                    bottom: parent.bottom
                                }
                                height: 1
                                color: "lightgrey"
                            }
                        }

                        draggedItemParent: mainContent
                        onMoveItemRequested: myModel.move(from, to, 1)
                    }
                }
            }
        }
    }
}
