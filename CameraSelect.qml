import QtQuick
import QtQuick.Controls
import QtMultimedia

Row {
    id: root
    height: Style.height
    property bool available: (typeof comboBox.currentValue !== "undefined")
                             && cameraSwitch.checked
    property Camera selected: available ? camera : null

    Camera {
        id: camera
        active: available && selected != null
    }

    MediaDevices {
        id: mediaDevices
    }

    Switch {
        id: cameraSwitch
        anchors.verticalCenter: parent.verticalCenter
        checked: true
    }

    ComboBox {
        id: comboBox
        width: Style.widthLong
        height: Style.height
        model: mediaDevices.videoInputs
        background: StyleRectangle {
            anchors.fill: parent
        }
        displayText: typeof currentValue === "undefined" ? "Unavailable" : currentValue.description
        font.pointSize: Style.fontSize
        textRole: "description"
        onCurrentValueChanged: {
            if (typeof comboBox.currentValue !== "undefined") {
                camera.cameraDevice = currentValue
            }
        }
    }
}
