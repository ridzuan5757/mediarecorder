import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Window {
    id: root
    visible: true
    title: qsTr("Video Recorder")
    width: Style.screenWidth
    height: Style.screenHeight

    onWidthChanged: {
        Style.calculateRatio(root.width, root.height)
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        visible: !playback.playing
    }

    Popup {
        id: recorderError
        anchors.centerIn: Overlay.overlay
        Text {
            id: recorderErrorText
        }
    }

    CaptureSession {
        id: captureSession
        recorder: recorder
        audioInput: controls.audioInput
        camera: controls.camera
        videoOutput: videoOutput
    }

    MediaRecorder {
        id: recorder
        onRecorderStateChanged: state => {
                                    if (state === MediaRecorder.StoppedState) {
                                        root.contentOrientation = Qt.PrimaryOrientation
                                        mediaList.append()
                                    } else if (state === MediaRecorder.RecordingState
                                               && captureSession.camera) {
                                        root.contentOrientation = root.screen.orientation
                                        videoOutput.grabToImage(function (res) {
                                            mediaList.mediaThumbnail = res.url
                                        })
                                    }
                                }
        onActualLocationChanged: url => {
                                     mediaList.mediaUrl = url
                                 }
        onErrorOccurred: {
            recorderErrorText.text = recorder.errorString
            recorderError.open()
        }
    }

    Playback {
        id: playback
        anchors.fill: parent
        anchors.margins: 50
        active: {
            controls.captureVisible
        }
    }

    Frame {
        id: mediaListFrame
        height: 150
        width: parent.width
        anchors.bottom: controlsFrame.top
        x: controls.capturesVisible ? 0 : parent.width
        background: Rectangle {
            anchors.fill: parent
            color: "white"
            opacity: 0.8
        }

        Behavior on x {
            NumberAnimation {
                duration: 200
            }
        }

        MediaList {
            id: mediaList
            anchors.fill: parent
            playback: playback
        }
    }

    Frame {
        id: controlsFrame
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: controls.height + Style.interSpacing * 2
                + (settingEncoder.visible ? settingEncoder.height : 0)
                + (settingsMetaData.visible ? settingsMetaData.height : 0)
        background: Rectangle {
            anchors.fill: parent
            color: "white"
            opacity: 0.8
        }

        Behavior on height {
            NumberAnimation {
                duration: 100
            }
        }

        ColumnLayout {
            anchors.fill: parent

            Controls {
                id: controls
                Layout.alignment: Qt.AlignHCenter
                recorder: recorder
            }

            StyleRectangle {
                Layout.alignment: Qt.AlignHCenter
                visible: controls.settingsVisible
                width: controls.width
                height: 1
            }

            SettingsEncoder {
                id: settingEncoder
                Layout.alignment: Qt.AlignHCenter
                visible: controls.settingsVisible
                padding: Style.interSpacing
                recorder: recorder
            }

            SettingsMetaData {
                id: settingsMetaData
                Layout.alignment: Qt.AlignCenter
                visible: !Style.isMobile() && controls.settingsVisible
                recorder: recorder
            }
        }
    }
}
