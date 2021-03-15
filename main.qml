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
    property int propertyListViewHeight1:0
    property int propertyListViewHeight2:0

    ScrollView {
        id: scrollView
        anchors.fill: parent
        ColumnLayout {
            anchors.fill: parent
            ListView {
                id: lv1
                anchors.top: parent.top
                width: parent.width
                model: 5
                 Layout.minimumHeight: propertyListViewHeight1
                delegate: ItemDelegate {
                    text: "Item " + (index)
                    width: 500
                    Component.onCompleted: {
                        propertyListViewHeight1 += height
                    }
                }
            }
            ListView {
                id: lv2
                anchors.top: lv1.bottom
                width: parent.width
                model: 5
                Layout.minimumHeight: propertyListViewHeight2
                delegate: ItemDelegate {
                    width: 500
                    text: "XXX " + (index)
                    Component.onCompleted: {
                        propertyListViewHeight2 += height
                    }
                }
            }
        }
    }
}
