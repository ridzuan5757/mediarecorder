import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

ColumnLayout {
    required property MediaRecorder recorder

    Text {
        text: qsTr("Metadata Settings")
    }

    ListModel {
        id: metaDataModel
    }

    Connections {
        target: recorder
        function onMetaDataChanged() {

            metaDataModel.clear()
            for (var key in recorder.metaData.keys()) {
                if (recorder.metaData.stringValue((key))) {

                    console.log("meta data value check")
                    console.log(key)

                    metaDataModel.append({
                                             "text": recorder.metaData.metaDataKeyToString(
                                                         key),
                                             "value": key
                                         })
                }
            }
        }
    }

    Row {
        id: metaDataAdd
        spacing: Style.intraSpacing

        ComboBox {
            id: metaDataType
            width: Style.widthMedium
            height: Style.height
            font.pointSize: Style.fontSize
            model: ListModel {
                ListElement {
                    text: qsTr("Title")
                    value: MediaMetaData.Title
                }
                ListElement {
                    text: qsTr("Author")
                    value: MediaMetaData.Author
                }
                ListElement {
                    text: qsTr("Comment")
                    value: MediaMetaData.Comment
                }
                ListElement {
                    text: qsTr("Description")
                    value: MediaMetaData.Description
                }
                ListElement {
                    text: qsTr("Genre")
                    value: MediaMetaData.Genre
                }
                ListElement {
                    text: qsTr("Publisher")
                    value: MediaMetaData.Publisher
                }
                ListElement {
                    text: qsTr("Copyright")
                    value: MediaMetaData.Copyright
                }
                ListElement {
                    text: qsTr("Date")
                    value: MediaMetaData.Date
                }
                ListElement {
                    text: qsTr("Url")
                    value: MediaMetaData.Url
                }
                ListElement {
                    text: qsTr("MediaType")
                    value: MediaMetaData.MediaType
                }
                ListElement {
                    text: qsTr("AlbumTitle")
                    value: MediaMetaData.AlbumTitle
                }
                ListElement {
                    text: qsTr("AlbumArtist")
                    value: MediaMetaData.AlbumArtist
                }
                ListElement {
                    text: qsTr("ContributingArtist")
                    value: MediaMetaData.ContributingArtist
                }
                ListElement {
                    text: qsTr("Composer")
                    value: MediaMetaData.Composer
                }
                ListElement {
                    text: qsTr("LeadPerformer")
                    value: MediaMetaData.LeadPerformer
                }
            }
            textRole: "text"
            valueRole: "value"
            background: StyleRectangle {
                anchors.fill: parent
                width: MediaMetaData.width
            }
        }

        Item {
            width: Style.widthMedium
            height: Style.height
            StyleRectangle {
                anchors.fill: parent
            }
            TextInput {
                id: textInput
                anchors.fill: parent
                anchors.bottom: parent.bottom
                anchors.margins: 4
                font.pointSize: Style.fontSize
                clip: true
                onAccepted: {
                    recorder.metaData.insert(metaDataType.currentValue, text)
                    recorder.metaDataChanged()
                    text = qsTr("")
                    textInput.deselect()
                }
            }
        }

        Button {
            width: Style.widthShort
            height: Style.height
            text: qsTr("Add")
            font.pointSize: Style.fontSize
            background: StyleRectangle {
                anchors.fill: parent
            }
            onClicked: textInput.accepted()
        }
    }

    ListView {
        id: listView
        Layout.fillHeight: true
        Layout.minimumWidth: metaDataAdd.width
        spacing: Style.intraSpacing
        clip: true
        model: metaDataModel
        delegate: Row {
            id: r
            height: Style.height
            spacing: Style.intraSpacing
            required property string text
            required property string value

            Text {
                height: Style.height
                width: Style.widthShort
                text: r.text
                font.pointSize: Style.fontSize
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
            }

            Item {
                width: Style.widthMedium
                height: Style.height

                StyleRectangle {
                    anchors.fill: parent
                }

                TextInput {
                    anchors.fill: parent
                    anchors.margins: 4
                    anchors.bottom: parent.bottom
                    font.pointSize: Style.fontSize
                    clip: true
                    text: recorder.metaData.stringValue(r.value)
                    onAccepted: {
                        recorder.metaData.insert(r.value, text)
                    }
                }

                Button {
                    width: Style.widthShort
                    height: Style.height
                    text: qsTr("Del")
                    font.pointSize: Style.fontSize
                    background: StyleRectangle {
                        anchors.fill: parent
                    }
                    onClicked: {
                        recorder.metaData.remove(r.value)
                        recorder.metaDataChanged()
                    }
                }
            }
        }
    }
}
