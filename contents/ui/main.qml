
import QtQuick.Controls as QQC2
import Qt.labs.folderlistmodel
import QtQuick
import QtMultimedia
import QtQuick.Effects
import org.kde.plasma.plasmoid
import org.kde.plasma.core 2.0 as PlasmaCore

PlasmoidItem {
    id: root

    implicitWidth: 400
    implicitHeight: 300

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    Rectangle {
    id: frame

    anchors.fill: parent
    color: "transparent"

    Item {
        id: videoSource

        anchors.centerIn: parent

        width: (plasmoid.configuration.rotation % 2 === 0)
               ? parent.width
               : parent.height

        height: (plasmoid.configuration.rotation % 2 === 0)
                ? parent.height
                : parent.width

        rotation: plasmoid.configuration.rotation * 90

        // Keep opacity working
        opacity: plasmoid.configuration.opacity / 100.0

        // Render this item into a texture for MultiEffect
        layer.enabled: true

        VideoOutput {
            id: videoOutput

            anchors.fill: parent

            fillMode: VideoOutput.PreserveAspectCrop
        }
    }
}

    MouseArea {
        id: videoMouseArea

        anchors.fill: parent
        hoverEnabled: true

        acceptedButtons: Qt.NoButton

        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            width: 42
            height: 70

            radius: 12

            color: "black"
            opacity: videoMouseArea.containsMouse &&
                    plasmoid.configuration.folderPath !== ""
                    ? 0.55
                    : 0.0

            Behavior on opacity {
                NumberAnimation {
                    duration: 180
                }
            }

            QQC2.Button {
                anchors.fill: parent

                text: "‹"

                enabled: folderModel.count > 0

                background: Rectangle {
                    color: "transparent"
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 34
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if (folderIndex > 0) {
                        folderIndex--
                    } else if (plasmoid.configuration.loopVideo &&
                            folderModel.count > 0) {
                        folderIndex = folderModel.count - 1
                    }
                }
            }
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            width: 42
            height: 70

            radius: 12

            color: "black"
            opacity: videoMouseArea.containsMouse &&
                    plasmoid.configuration.folderPath !== ""
                    ? 0.55
                    : 0.0

            Behavior on opacity {
                NumberAnimation {
                    duration: 180
                }
            }

            QQC2.Button {
                anchors.fill: parent

                text: "›"

                enabled: folderModel.count > 0

                background: Rectangle {
                    color: "transparent"
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 34
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if (folderIndex + 1 < folderModel.count) {
                        folderIndex++
                    } else if (plasmoid.configuration.loopVideo &&
                            folderModel.count > 0) {
                        folderIndex = 0
                    }
                }
            }
        }
    }


    property int folderIndex: 0

    FolderListModel {
        id: folderModel

        folder: plasmoid.configuration.folderPath

        nameFilters: [
            "*.mp4",
            "*.webm",
            "*.mkv",
            "*.avi",
            "*.mov",
            "*.m4v"
    ]

        showDirs: false
        showFiles: true
    }

    MediaDevices {
        id: mediaDevices

        onDefaultAudioOutputChanged: {
            audioOutput.device = mediaDevices.defaultAudioOutput
            console.log(
                "Audio device changed to:",
                mediaDevices.defaultAudioOutput.description
            )
        }
    }

    MediaPlayer {
        id: player

        videoOutput: videoOutput
        source: plasmoid.configuration.folderPath !== ""
            ? (folderModel.count > 0
                ? folderModel.get(folderIndex, "fileUrl")
                : "")
            : plasmoid.configuration.videoPath

        audioOutput: AudioOutput {
            id: audioOutput

            device: mediaDevices.defaultAudioOutput

            volume: plasmoid.configuration.audioEnabled
                    ? plasmoid.configuration.volume / 100
                    : 0.0
        }


        loops: plasmoid.configuration.folderPath !== ""
                ? 1
                : (plasmoid.configuration.loopVideo
                   ? MediaPlayer.Infinite
                   : 1)

        onSourceChanged: {
            if (source.toString() !== "") {
                play()
            }
        }

        onMediaStatusChanged: {
            if (mediaStatus === MediaPlayer.EndOfMedia &&
                plasmoid.configuration.folderPath !== "") {

                if (folderModel.count === 0)
                    return

                if (folderIndex + 1 < folderModel.count) {
                    folderIndex++
                } else if (plasmoid.configuration.loopVideo) {
                    folderIndex = 0
                } else {
                    return
                }
            }
        }

        onErrorOccurred: function(error, errorString) {
            console.log("Video Frame ERROR:", errorString)
        }
    }
}