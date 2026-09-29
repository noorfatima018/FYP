import 'dart:async';
import 'package:video_player/video_player.dart';
import '../constants/app_assets.dart';

/// Pre-warms the logo video controller at app launch to minimize startup latency
class VideoPreloadService {
  VideoPreloadService._();

  static VideoPlayerController? _controller;
  static Completer<VideoPlayerController>? _initCompleter;

  /// Starts initializing the video controller in the background immediately
  static Future<VideoPlayerController> preload() {
    if (_initCompleter != null) {
      return _initCompleter!.future;
    }

    _initCompleter = Completer<VideoPlayerController>();

    final controller = VideoPlayerController.asset(AppAssets.animatedLogo);
    _controller = controller;

    controller.initialize().then((_) {
      controller.setLooping(false);
      if (!_initCompleter!.isCompleted) {
        _initCompleter!.complete(controller);
      }
    }).catchError((error) {
      if (!_initCompleter!.isCompleted) {
        _initCompleter!.completeError(error);
      }
    });

    return _initCompleter!.future;
  }

  /// Returns the preloaded controller if ready
  static VideoPlayerController? get preloadedController => _controller;

  /// Cleans up the preloaded controller
  static void dispose() {
    _controller?.dispose();
    _controller = null;
    _initCompleter = null;
  }
}
