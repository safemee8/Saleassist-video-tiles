# Saleassist Video Tiles

[![pub package](https://img.shields.io/pub/v/saleassist_video_tiles.svg)](https://pub.dev/packages/saleassist_video_tiles)
[![Flutter Platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Saleassist Video Tiles brings SaleAssist's shoppable short-form videos to your Flutter app in just a few lines of code. It ships with a ready-made, Reels-style horizontal carousel, full-screen playback, product overlays, caching, and BLoC-based state management so that you can focus on your app experience instead of wiring video players.

---

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Example](#example)
- [Widget Parameters](#widget-parameters)
- [Handling Product Clicks](#handling-product-clicks)
- [Full-Screen Experience](#full-screen-experience)
- [Data Flow & Caching](#data-flow--caching)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Maintainers](#maintainers)

---

## Features
- Reels/Shorts inspired horizontal video tiles with autoplay and mute controls.
- One-tap full-screen playback with vertical paging and product call-to-action.
- Built-in SaleAssist playlist API integration using a single playlist identifier.
- Seven-day smart caching via `flutter_cache_manager` to reduce repeated downloads.
- BLoC architecture keeps network, cache, and UI in sync out of the box.
- Works on every Flutter platform (Android, iOS, Web, macOS, Windows, Linux).

---

## Requirements
- Dart SDK `>=3.5.3 <4.0.0`
- Flutter SDK `>=3.22.0`
- A valid SaleAssist playlist identifier (reach out to your SaleAssist contact or dashboard to obtain one).

---

## Installation

Add the package with Flutter's package manager:

```bash
flutter pub add saleassist_video_tiles
```

Or update your `pubspec.yaml` manually:

```yaml
dependencies:
  saleassist_video_tiles: ^0.0.3
```

Then fetch the dependency:

```bash
flutter pub get
```

---

## Getting Started
1. **Secure a playlist** – collect the `playlistId` for the shoppable videos you want to surface. Playlists are resolved against `https://vtiles.saleassist.ai/`.
2. **Import the package** – `import 'package:saleassist_video_tiles/saleassist_video_tiles.dart';`
3. **Drop the widget** – place `SaleassistVideoTiles` anywhere in your widget tree.

---

## Example

```dart
import 'package:flutter/material.dart';
import 'package:saleassist_video_tiles/saleassist_video_tiles.dart';

class VideoTilesSection extends StatelessWidget {
  const VideoTilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SaleassistVideoTiles(
      playListId: 'YOUR_PLAYLIST_ID',
      autoPlay: true,
      borderRadius: 16,
      seperatorWidth: 12,
      tileSize: const Size(220, 360),
      onProductClick: ({String mediaId = '', String productId = ''}) {
        // Handle the product selection (e.g., open PDP or log an analytics event)
        debugPrint('Clicked product $productId from media $mediaId');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product $productId tapped')),
        );
      },
    );
  }
}
```

Place `VideoTilesSection` inside any scrollable view or screen. The widget fetches the playlist, caches media locally, and renders the carousel automatically.

---

## Widget Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `playListId` | `String` | — | SaleAssist playlist identifier used to fetch videos. Required. |
| `onProductClick` | `Function({String mediaId, String productId})` | — | Callback fired whenever a product CTA is tapped in either tile or full-screen mode. Required. |
| `autoPlay` | `bool` | `false` | Autoplays the first tile when it becomes visible. Remaining tiles play once opened. |
| `borderRadius` | `double?` | `null` | Applies rounded corners to video tiles. |
| `seperatorWidth` | `double?` | `null` | Horizontal spacing between tiles in the list. Provide a value (e.g. `8.0`) to insert gaps between tiles. |
| `tileSize` | `Size` | `Size(100, 200)` | Size of each individual tile displayed in the carousel. |
| `type` | `VideoTileType` | `VideoTileType.tileView` | Layout mode selector. `tileView` is currently implemented; `coverFlow` and `story` are placeholders while in development. |

---

## Handling Product Clicks
Each video can surface multiple products. Use the `onProductClick` callback to connect the experience with your shopping flow:

```dart
SaleassistVideoTiles(
  playListId: 'demo-playlist',
  onProductClick: ({mediaId = '', productId = ''}) {
    Navigator.pushNamed(
      context,
      '/product/$productId',
      arguments: {'media': mediaId},
    );
  },
)
```

The callback fires both from the inline product pill and from the full-screen viewer.

---

## Full-Screen Experience
Users can enter full-screen playback from any tile via the floating controls or product pill. The package pushes a fade-transition page that:
- Plays videos vertically with swipe navigation.
- Keeps the current progress in sync using `SaleAssistFullScreenBloc`.
- Re-triggers `onProductClick` from full-screen overlays so your handlers stay consistent.
- Shares cached files between tile and full-screen modes for smooth transitions.

No additional setup is required—the navigator push is handled for you inside the widget.

---

## Data Flow & Caching
- **Networking**: `TilesApiRepository` talks to the SaleAssist API (`/shorts/{playListId}`) using Dio.
- **State management**: `SaleassistTileBloc` coordinates loading, failures, and success states across tiles and full-screen views.
- **Caching**: `SaleAssisstChacheManger` keeps media locally for seven days (max 100 objects) via `flutter_cache_manager`, reducing cold-start latency.
- **Video playback**: Powered by `video_player` and `chewie`, with loop + mute controls and animated overlay buttons.

---

## Roadmap
- `VideoTileType.coverFlow` layout.
- `VideoTileType.story` layout for Snapchat/Stories style navigation.
- Public API for overriding the networking layer (custom endpoints, auth headers).
- Additional hooks for analytics and playback lifecycle events.

---

## Contributing
Contributions are welcome! If you spot a bug or have an idea:
- Open an [issue](https://github.com/yash-g-dev/Saleassist-video-tiles/issues).
- Fork the repo, create a feature branch, and submit a pull request.
- Please include tests where practical (`flutter test`) and document new APIs in the README.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Maintainers
Built and maintained by [SaleAssist.ai](https://github.com/yash-g-dev). Feel free to reach out via issues for platform support or partnership requests.
