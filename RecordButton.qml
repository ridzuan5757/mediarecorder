import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: root
    required property bool recording
    property int outerRadius: Style.height
    property int innerRadius: mouse.pressedButtons
                              === Qt.LeftButton ? outerRadius - 6 : outerRadius - 5

    signal clicked

    Rectangle {
        anchors.fill: parent
        radius: outerRadius
        opacity: 0.5
        border.color: "black"
        border.width: 1
    }

    Rectangle {
        anchors.centerIn: parent
        color: "red"
        width: recording ? innerRadius * 2 - 15 : innerRadius * 2
        height: recording ? innerRadius * 2 - 15 : innerRaidus * 2
        radius: recording ? 2 : innerRadius

        Behavior on width {
            NumberAnimation {
                duration: 100
            }
        }

        Behavior on height {
            NumberAnimation {
                duration: 100
            }
        }

        Behavior on radius {
            NumberAnimation {
                duration: 100
            }
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
