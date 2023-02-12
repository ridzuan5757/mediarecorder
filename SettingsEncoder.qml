import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Column {
    id: root
    spacing: Style.intraSpacing
    Component.onCompleted: root.populateModels()

    required property MediaRecorder recorder

    function populateModels() {}

    Connections {
        target: recorder
        function onMediaFormatChanged() {
            root.populateModels()
        }
    }

    Text {
        text: qsTr("Encoder Settings")
    }

    StyleParameter {
        label: qsTr("Quality")
        model: ListModel {
            ListElement {
                text: qsTr("Very Low")
                value: MediaRecorder.VeryLowQuality
            }
        }
    }
}
