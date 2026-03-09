import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_notifier.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_state.dart';

final reelsNotifierProvider =
    NotifierProvider.autoDispose<ReelsNotifier, ReelsState>(ReelsNotifier.new);
