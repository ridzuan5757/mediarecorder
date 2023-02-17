import QtQuick
import QtQuick.Controls
import QtMultimedia

Row {
    id: root
    property bool available: false
    property AudioInput selected: available ? audioInput : null

    MediaDevices {
        id: mediaDevices
    }

    AudioInput {
        id: audioInput
        muted: !audioSwitch.checked
    }

    Switch {
        id: audioSwitch
        height: Style.height
        checked: true
    }

    ComboBox {
        id: comboBox
        width: Style.widthLong
        height: Style.height
        textRole: "description"
        font.pointSize: Style.fontSize
        model: mediaDevices.audioInputs
        background: StyleRectangle {
            anchors.fill: parent
        }
        displayText: typeof currentValue === "undefined" ? "unavailable" : currentValue.description
        onCurrentValueChanged: {
            if (typeof comboBox.currentValue !== "undefined") {
                audioInput.device = currentValue
            }
        }
    }
}
