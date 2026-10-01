# KDE Video Frame

A lightweight **KDE Plasma 6 plasmoid for playing videos directly on the desktop**.

Built with **QML, Qt Multimedia, and FFmpeg**, KDE Video Frame lets you place a video directly on your Plasma desktop with controls for playback, audio, opacity, rotation, and more.

## ✨ Features

- 🎬 Play individual video files directly on the desktop
- 📁 Play videos sequentially from a selected folder
- 🔁 Loop a single video
- 🔄 Loop an entire video folder
- 🔊 Enable or disable audio
- 🔉 Adjustable volume
- 🔄 Rotate video by 0°, 90°, 180°, or 270°
- 🌫️ Adjustable video opacity
- 🪟 Transparent widget background
- 🎞️ Qt Multimedia / FFmpeg based playback
- 🔌 Automatically follows the system's default audio output

## 🛠️ Requirements

- **KDE Plasma 6**
- **Qt 6**
- **Qt Multimedia**
- **FFmpeg**

## 📦 Installation

Clone the repository:

```bash
git clone https://github.com/arcoiesc/kde-video-frame.git
cd kde-video-frame
```

Install the plasmoid:

```bash
mkdir -p ~/.local/share/plasma/plasmoids/com.ash.videoframe
cp -r ./* ~/.local/share/plasma/plasmoids/com.ash.videoframe/
```

You can then add **KDE Video Frame** to your Plasma desktop.

## 🎥 Usage

After adding the plasmoid to your desktop, open its configuration.

### Single Video

Choose **Select Video** and select a video file.

With **Loop** enabled, the selected video repeats continuously.

### Folder Playback

Choose **Select Folder** and select a directory containing videos.

Videos are played sequentially:

```text
Video 1 → Video 2 → Video 3 → ...
```

When folder looping is enabled:

```text
Video 1 → Video 2 → Video 3
    ↑                 ↓
    └─────────────────┘
```

When folder looping is disabled, playback stops after the final video.

Selecting a video switches back to single-video mode, while selecting a folder switches to folder mode.

## ⚙️ Configuration

| Setting | Description |
|---|---|
| Video | Select an individual video |
| Folder | Select a folder for sequential playback |
| Loop | Loop the selected video or entire folder |
| Audio | Enable/disable audio |
| Volume | Adjust playback volume |
| Rotation | Rotate the video |
| Opacity | Adjust video opacity |
| Frame | Toggle the video frame |

## 🎞️ Supported Formats

The folder browser currently recognizes:

- `.mp4`
- `.webm`
- `.mkv`
- `.avi`
- `.mov`
- `.m4v`

Actual playback support depends on the codecs supported by the installed Qt Multimedia / FFmpeg stack.

## 🧑‍💻 Development

Clone the repository and run the plasmoid directly with:

```bash
plasmoidviewer -a .
```

This is useful for testing changes without installing the plasmoid system-wide.

The main project is structured around:

```text
kde-video-frame/
├── contents/
│   ├── config/
│   │   └── main.xml
│   └── ui/
│       ├── main.qml
│       └── configVideo.qml
├── metadata.json
├── README.md
└── .gitignore
```

### Tech Stack

- **QML** — user interface and Plasma integration
- **Qt Multimedia** — video and audio playback
- **FFmpeg** — multimedia backend
- **KDE Plasma 6** — desktop integration

## 🚧 Roadmap

Planned improvements and experiments may include:

- Rounded video corners
- Additional visual effects
- Improved desktop/window integration
- More playback controls
- Additional customization options
- Better handling of playlists and folders

## 📄 License

This project is currently under development.

See the repository for the latest source and project status.

---

Made for **KDE Plasma 6** with QML + Qt Multimedia. 🐧
