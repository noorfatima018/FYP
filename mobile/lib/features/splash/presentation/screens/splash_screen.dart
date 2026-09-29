import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/video_preload_service.dart';
import '../../../../routes/app_routes.dart';

/// Splash Screen that plays the RentWise animated logo once and transitions to AuthScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _hasNavigated = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  Timer? _fallbackTimer;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _setupVideo();
  }

  Future<void> _setupVideo() async {
    try {
      final preloaded = VideoPreloadService.preloadedController;

      if (preloaded != null && preloaded.value.isInitialized) {
        _attachController(preloaded);
      } else {
        final controller = await VideoPreloadService.preload();
        if (mounted) {
          _attachController(controller);
        }
      }
    } catch (e) {
      // Fallback if video fails to initialize
      if (mounted) {
        _fallbackTimer = Timer(const Duration(milliseconds: 1500), () {
          _navigateToAuth();
        });
      }
    }
  }

  void _attachController(VideoPlayerController controller) {
    _videoController = controller;
    setState(() {
      _isVideoInitialized = true;
    });
    _fadeController.forward();
    _videoController!.seekTo(Duration.zero);
    _videoController!.play();
    _videoController!.addListener(_videoListener);
  }

  void _videoListener() {
    if (_videoController == null || _hasNavigated) return;

    final position = _videoController!.value.position;
    final duration = _videoController!.value.duration;

    // Transition immediately when the video animation finishes
    if (position >= duration && duration > Duration.zero) {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;
    _videoController?.removeListener(_videoListener);
    _fallbackTimer?.cancel();

    Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    _videoController?.removeListener(_videoListener);
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamCanvas,
      body: SafeArea(
        child: Stack(
          children: [
            // Center Animated Video with Multiply Blend Mode
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _isVideoInitialized && _videoController != null
                      ? ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            AppColors.creamCanvas,
                            BlendMode.multiply,
                          ),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.matrix([
                              1.5, 0,   0,   0, -20,
                              0,   1.5, 0,   0, -20,
                              0,   0,   1.5, 0, -20,
                              0,   0,   0,   1, 0,
                            ]),
                            child: AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio > 0
                                  ? _videoController!.value.aspectRatio
                                  : 1.0,
                              child: VideoPlayer(_videoController!),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),

            // Top-right Skip Button
            Positioned(
              top: 16,
              right: 16,
              child: TextButton(
                onPressed: _navigateToAuth,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.brownAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
