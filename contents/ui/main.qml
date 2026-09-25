import QtQuick
import QtMultimedia
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

        color: "black"

        radius: plasmoid.configuration.showFrame ? 18 : 0

        border.width: plasmoid.configuration.showFrame ? 2 : 0

        clip: true

        Item {
            id: videoContainer

            anchors.centerIn: parent

            width: (plasmoid.configuration.rotation % 2 === 0)
                   ? parent.width
                   : parent.height

            height: (plasmoid.configuration.rotation % 2 === 0)
                    ? parent.height
                    : parent.width

            rotation: plasmoid.configuration.rotation * 90

            VideoOutput {
                id: videoOutput

                anchors.fill: parent

                fillMode: VideoOutput.PreserveAspectCrop
            }
        }
    }

    MediaPlayer {
        id: player

        videoOutput: videoOutput

        source: plasmoid.configuration.videoPath

        audioOutput: AudioOutput {
            id: audioOutput

            volume: plasmoid.configuration.audioEnabled
                    ? plasmoid.configuration.volume / 100
                    : 0.0
        }

        loops: plasmoid.configuration.loopVideo
               ? MediaPlayer.Infinite
               : 1

        // Keep playing even when the desktop widget
        // is covered by another application.
        onSourceChanged: {
            if (source.toString() !== "") {
                play()
            }
        }

        onErrorOccurred: function(error, errorString) {
            console.log("Video Frame ERROR:", errorString)
        }
    }
}
