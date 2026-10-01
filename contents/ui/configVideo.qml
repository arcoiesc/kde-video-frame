import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Dialogs
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page

    property alias cfg_videoPath: videoPath.text
    property alias cfg_folderPath: folderPath.text
    property alias cfg_loopVideo: loopVideo.checked
    property alias cfg_audioEnabled: audioEnabled.checked
//    property alias cfg_showFrame: showFrame.checked
    property alias cfg_rotation: rotation.currentIndex
    property alias cfg_volume: volume.value
    property alias cfg_opacity: opacity.value
//    property alias cfg_cornerRadius: cornerRadius.value

    RowLayout {
    Kirigami.FormData.label: i18n("Video:")

    QQC2.TextField {
        id: videoPath
        Layout.fillWidth: true
        readOnly: true
        placeholderText: i18n("No video selected")
    }

    QQC2.Button {
        text: i18n("Select Video")
        icon.name: "video-x-generic"
        onClicked: fileDialog.open()
    }

    QQC2.Button {
        text: i18n("Select Folder")
        icon.name: "folder-open"
        onClicked: folderDialog.open()
    }
}



    RowLayout {
        Kirigami.FormData.label: i18n("Folder:")

        QQC2.TextField {
            id: folderPath
            Layout.fillWidth: true
            readOnly: true
            placeholderText: i18n("No folder selected")
        }
    }




    QQC2.CheckBox {
        id: loopVideo
        text: i18n("Loop video")
    }

    QQC2.CheckBox {
        id: audioEnabled
        text: i18n("Audio")
    }

    RowLayout {
        Kirigami.FormData.label: i18n("Volume:")

        QQC2.Slider {
            id: volume

            from: 0
            to: 100
            stepSize: 1

            Layout.fillWidth: true
            enabled: audioEnabled.checked
        }

        QQC2.Label {
            text: Math.round(volume.value) + "%"
            Layout.preferredWidth: 45
        }
    }

RowLayout {
    Kirigami.FormData.label: i18n("Opacity:")

    QQC2.Slider {
        id: opacity
        from: 0
        to: 100
        stepSize: 1
        value: 100
        Layout.fillWidth: true
    }

    QQC2.Label {
        text: Math.round(opacity.value) + "%"
        Layout.preferredWidth: 45
    }
}
/*
RowLayout {
    Kirigami.FormData.label: i18n("Corners:")

    QQC2.Slider {
        id: cornerRadius
        from: 0
        to: 50
        stepSize: 1
        value: 18
        Layout.fillWidth: true
    }

    QQC2.Label {
        text: Math.round(cornerRadius.value) + " px"
        Layout.preferredWidth: 45
    }
}
*/





/*
    QQC2.CheckBox {
        id: showFrame
        text: i18n("Show frame")
    }
*/

    QQC2.ComboBox {
        id: rotation

        Kirigami.FormData.label: i18n("Rotation:")

        model: [
            "0°",
            "90°",
            "180°",
            "270°"
        ]
    }

    FileDialog {
        id: fileDialog

        title: i18n("Select a video")

        nameFilters: [
            i18n("Video files (*.mp4 *.webm *.mkv *.avi *.mov *.m4v)"),
            i18n("All files (*)")
        ]

        onAccepted: {
            videoPath.text = selectedFile.toString()
            folderPath.text = ""
        }

    FolderDialog {
        id: folderDialog

        title: i18n("Select a video folder")

        onAccepted: {
            folderPath.text = selectedFolder.toString()
            videoPath.text = ""
        }
    }

    }

}