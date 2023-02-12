import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: root
    property bool active: false
    property bool playing: false
    visible: active && playing
    onActiveChanged: {
        if(!root.active){
            stop()
        }
    }

    function playUrl(url){
        playing = true
        mediaPlayer.source = url
        mediaPlayer.play()
    }

    function stop(){
        playing = false
        mediaPlayer.stop()
    }

    VideoOutput{
        id: videoOutput
        anchors.fill: parent
    }

    MediaPlayer{
        id: mediaPlayer
        videoOutput: videoOutput
        audioOutput: AudioOutput{}
    }

    HoverHandler{
        id: hover
    }

    RoundButton{
        width: 50
        height: 50
        opacity: hover.hovered && active ? 1.0 : 0.0
        anchors.centerIn: root
        text: qsTr("\u25A0")
        onClicked: root.stop()

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
    }
}
