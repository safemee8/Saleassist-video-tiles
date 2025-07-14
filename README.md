# saleassist_video_tiles

A Flutter package to display and manage short-form video tiles — just like Instagram Reels or YouTube Shorts — with product integration, video caching, and smooth full-screen transitions. Created by **SaleAssist**.

---

## ✨ Features

- Vertical video tiles (Reels-like)
- Fullscreen playback with controls
- Built-in product info display
- Smart video caching
- Customizable layout and autoplay
- Bloc-based controller management

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  saleassist_video_tiles: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 🧩 Usage

Import the widget:

```dart
import 'package:saleassist_video_tiles/saleassist_video_tiles.dart';
```

### Basic Example

```dart
SaleassistVideoTiles(
  autoPlay: true,
  borderRadius: 10,
  type: VideoTileType.tileView,
  seperatorWidth: 8,
  tileSize: Size(200, 300),
  playListId: "f8ebec27-0164-4a6b-83a6-3d6689b988e2",
),
```

### Parameter Overview

| Parameter        | Type            | Description                                                  |
| ---------------- | --------------- | ------------------------------------------------------------ |
| `autoPlay`       | `bool`          | Autoplay videos on visibility                                |
| `borderRadius`   | `double`        | Border radius for tile corners                               |
| `type`           | `VideoTileType` | Display type: `tileView` ,`coverFlow` , `story` , `gridview` |
| `seperatorWidth` | `double`        | Spacing between tiles                                        |
| `tileSize`       | `Size`          | Size of each video tile                                      |
| `playListId`     | `String`        | Playlist ID to load videos dynamically                       |

---

## 📦 Package Structure

- `SaleassistVideoTiles` – main widget for embedding videos
- `SaleAssistFullScreenPage` – full-screen view with player controls
- Bloc state handling for optimized controller management and caching

---

## 📄 License

Licensed under the MIT License. See [LICENSE](LICENSE) for more info.

---

## 👤 Author

Maintained by [Saleassist.ai](https://github.com/yash-g-dev)

---

## 💡 Contribution

Have suggestions or found a bug? Feel free to open an [issue](https://github.com/yash-g-dev/Saleassist-video-tiles/issues) or submit a PR!
