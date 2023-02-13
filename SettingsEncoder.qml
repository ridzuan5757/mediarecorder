import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Column {
    id: root
    spacing: Style.intraSpacing
    Component.onCompleted: root.populateModels()

    required property MediaRecorder recorder

    function populateModels() {
        audioCodecModel.populate()
        videoCodecModel.populate()
        fileFormatModel.populate()
    }

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
            ListElement {
                text: qsTr("Low")
                value: MediaRecorder.LowQuality
            }
            ListElement {
                text: qsTr("Normal")
                value: MediaRecorder.NormalQuality
            }
            ListElement {
                text: qsTr("High")
                value: MediaRecorder.HighQuality
            }
            ListElement {
                text: qsTr("Very High")
                value: MediaRecorder.VeryHighQuality
            }
        }
        onActivated: v => recorder.quality = v
    }

    StyleParameter {
        id: audioCodecSelect
        label: qsTr("Audio Codec")
        model: audioCodecModel
        onActivated: v => recorder.mediaFormat.audioCodec = v

        ListModel {
            id: audioCodecModel
            function populate() {
                audioCodecModel.clear()
                audioCodecModel.append({
                                           "text": "Unspecified",
                                           "value": MediaFormat.AudioCodec.Unspecified
                                       })
                var cs = recorder.mediaFormat.supportedAudioCodecs(
                            MediaFormat.Encode)
                for (var c in cs) {
                    audioCodecModel.append({
                                               "text": recorder.mediaFormat.audioCodecName(
                                                           c),
                                               "value": c
                                           })
                }
                audioCodecSelect.currentIndex = cs.indexOf(
                            recorder.mediaFormat.audioCodec) + 1
            }
        }
    }

    function buildModel() {}

    StyleParameter {
        id: videoCodecSelect
        label: qsTr("Video Codec")
        model: videoCodecModel
        onActivated: v => recorder.mediaFormat.videoCodec = v

        ListModel {
            id: videoCodecModel
            function populate() {
                videoCodecModel.clear()
                videoCodecModel.append({
                                           "text": "Unspecified",
                                           "value": MediaFormat.VideoCodec.Unspecified
                                       })
                var cs = recorder.mediaFormat.supportedVideoCodecs(
                            MediaFormat.Encode)
                for (var c in cs) {
                    videoCodecModel.append({
                                               "text": recorder.mediaFormat.videoCodecName(
                                                           c),
                                               "value": c
                                           })
                }
                videoCodecSelect.currentIndex = cs.indexOf(
                            recorder.mediaFormat.videoCodec) + 1
            }
        }
    }

    StyleParameter {
        id: fileFormatSelect
        label: qsTr("File Format")
        model: fileFormatModel
        onActivated: v => recorder.mediaFormat.fileFormat = v

        ListModel {
            id: fileFormatModel
            function populate() {
                fileFormatModel.clear()
                fileFormatModel.append({
                                           "text": "Unspecified",
                                           "value": MediaFormat.AudioCodec.Unspecified
                                       })
                var cs = recorder.mediaFormat.supportedFileFormats(
                            MediaFormat.Encode)
                for (var c in cs) {
                    fileFormatModel.append({
                                               "text": recorder.mediaFormat.fileFormatName(
                                                           c),
                                               "value": c
                                           })
                }
                fileFormatSelect.currentIndex = cs.indexOf(
                            recorder.mediaFormat.fileFormat) + 1
            }
        }
    }
}
