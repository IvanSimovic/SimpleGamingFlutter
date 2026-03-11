import 'package:flutter/material.dart';

abstract final class AppGradients {
  // Scrim overlays for full-screen media cards (Reels).
  // Top scrim covers the status bar area; bottom scrim covers the info column.
  static const reelScrimTop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x8C000000), Colors.transparent],
    stops: [0.0, 0.2],
  );

  static const reelScrimBottom = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xE1000000)],
    stops: [0.35, 1.0],
  );
}
