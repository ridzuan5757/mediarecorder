import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Row {
    id: root
    required property MediaRecorder recorder
    property bool settingVisible: false
    property bool captureVisible: false
    property alias audioInput: audioInputSelect.selected
    property alias camera: cameraSelect.selected
    spacing: Style.interSpacing * Style.ratio

    Column {
        id: inputControls
        spacing: Style.intraSpacing

        CameraSelect {
            id: cameraSelect
        }

        AudioInputSelect {
            id: audioInputSelect
        }
    }

    Column {
        width: recordButton.width

        RecordButton {
            id: recordButton
            recording: recorder.recorderState === MediaRecorder.RecordingState
            onClicked: recording ? recorder.stop() : recorder.record()
        }

        Text {
            id: recordingTime
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: Style.fontSize
        }
    }

    Column {
        id: optionButtons
        spacing: Style.intraSpacing

        Button {
            height: Style.height
            width: Style.widthMedium
            background: StyleRectangle {
                anchors.fill: parent
            }
            onClicked: root.captureVisible = !root.captureVisible
            text: qsTr("Captures")
            font.pointSize: Style.fontSize
        }

        Button {
            height: Style.height
            width: Style.widthMedium
            background: StyleRectangle {
                anchors.fill: parent
            }
            onClicked: root.settingVisible = !root.settingVisible
            text: qsTr("Settings")
            font.pointSize: Style.fontSize
        }
    }

    Timer {
        running: true
        interval: 100
        repeat: true
        onTriggered: {
            var m = Math.floor(recorder.duration / 60000)
            var ms = (recorder.duration / 1000 - m * 60).toFixed(1)
            recordingTime.text = `${m}:${ms.padStart(4, 0)}`
        }
    }
}
