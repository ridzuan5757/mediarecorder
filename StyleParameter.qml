import QtQuick
import QtQuick.Controls

Row {
    id: root
    spacing: Style.intraSpacing
    property bool enabled: true
    property alias label: label.text
    property alias model: comboBox.model
    property alias currentIndex: comboBox.currentIndex
    property alias currentValue: comboBox.currentValue

    signal activated(var currentValue)

    Text {
        id: label
        height: Style.height
        width: Style.widthShort
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        color: root.enabled ? "black" : "gray"
        font.pointSize: Style.fontSize
    }

    ComboBox {
        id: comboBox
        height: Style.height
        width: Style.widthLong
        enabled: root.enabled
        displayText: currentText
        textRole: qsTr("Text")
        valueRole: qsTr("Value")
        font.pointSize: Style.fontSize
        background: StyleRectangle {
            anchors.fill: parent
        }
        onActivated: root.activated(currentValue)
    }
}
