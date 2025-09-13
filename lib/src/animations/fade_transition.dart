/// Fade transition animations for the Corpo UI design system.
///
/// This file provides comprehensive fade in/out transition utilities
/// with corporate-appropriate timing and easing functions. The animations
/// follow professional design principles with smooth, subtle effects
/// suitable for business applications.
///
/// Example usage:
/// ```dart
/// CorpoFadeTransition(
///   duration: const Duration(milliseconds: 300),
///   child: MyWidget(),
/// )
///
/// CorpoFadeTransition.delayed(
///   delay: const Duration(milliseconds: 100),
///   child: MyWidget(),
/// )
/// ```
library;

import 'package:flutter/material.dart';

/// Defines the fade animation type.
enum CorpoFadeType {
  /// Simple fade in/out
  fadeIn,
  fadeOut,

  /// Fade with slight movement
  fadeInUp,
  fadeInDown,
  fadeInLeft,
  fadeInRight,

  /// Fade with scale
  fadeInScale,
  fadeOutScale,
}

/// Defines the easing curves for corporate animations.
abstract final class CorpoAnimationCurves {
  /// Standard easing for most corporate animations
  static const Curve standard = Curves.easeInOut;

  /// Subtle easing for background elements
  static const Curve subtle = Curves.easeOut;

  /// Emphasized easing for important elements
  static const Curve emphasized = Curves.easeInOutCubic;

  /// Sharp easing for quick interactions
  static const Curve sharp = Curves.easeInQuart;

  /// Gentle easing for delicate transitions
  static const Curve gentle = Curves.easeOutSine;
}

/// Animation durations following corporate design principles.
abstract final class CorpoAnimationDurations {
  /// Quick animations for micro-interactions
  static const Duration quick = Duration(milliseconds: 150);

  /// Standard duration for most animations
  static const Duration standard = Duration(milliseconds: 300);

  /// Slow animations for complex transitions
  static const Duration slow = Duration(milliseconds: 500);

  /// Extended animations for page transitions
  static const Duration extended = Duration(milliseconds: 700);
}

/// A comprehensive fade transition widget following Corpo UI design principles.
///
/// This component provides smooth fade animations with professional timing
/// and easing suitable for corporate applications. It supports various
/// fade types and can be combined with other transformations.
class CorpoFadeTransition extends StatefulWidget {
  /// Creates a fade transition widget.
  const CorpoFadeTransition({
    required this.child,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
    this.fadeType = CorpoFadeType.fadeIn,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  });

  /// Creates a delayed fade in transition.
  const CorpoFadeTransition.delayed({
    required this.child,
    required this.delay,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
    this.fadeType = CorpoFadeType.fadeIn,
    this.autoStart = true,
    this.onComplete,
    super.key,
  });

  /// Creates a fade in with upward movement.
  const CorpoFadeTransition.fadeInUp({
    required this.child,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : fadeType = CorpoFadeType.fadeInUp;

  /// Creates a fade in with downward movement.
  const CorpoFadeTransition.fadeInDown({
    required this.child,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : fadeType = CorpoFadeType.fadeInDown;

  /// Creates a fade in with scale effect.
  const CorpoFadeTransition.fadeInScale({
    required this.child,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.emphasized,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : fadeType = CorpoFadeType.fadeInScale;

  /// The widget to animate.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;

  /// The type of fade animation.
  final CorpoFadeType fadeType;

  /// Delay before starting the animation.
  final Duration delay;

  /// Whether to start the animation automatically.
  final bool autoStart;

  /// Callback when animation completes.
  final VoidCallback? onComplete;

  @override
  State<CorpoFadeTransition> createState() => _CorpoFadeTransitionState();
}

class _CorpoFadeTransitionState extends State<CorpoFadeTransition>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  void _initializeAnimations() {
    _controller = AnimationController(duration: widget.duration, vsync: this);

    // Opacity animation
    _opacityAnimation = Tween<double>(
      begin: widget.fadeType == CorpoFadeType.fadeOut ? 1.0 : 0.0,
      end: widget.fadeType == CorpoFadeType.fadeOut ? 0.0 : 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    // Slide animation for movement-based fades
    Offset slideBegin;
    switch (widget.fadeType) {
      case CorpoFadeType.fadeInUp:
        slideBegin = const Offset(0, 0.3);
        break;
      case CorpoFadeType.fadeInDown:
        slideBegin = const Offset(0, -0.3);
        break;
      case CorpoFadeType.fadeInLeft:
        slideBegin = const Offset(0.3, 0);
        break;
      case CorpoFadeType.fadeInRight:
        slideBegin = const Offset(-0.3, 0);
        break;
      default:
        slideBegin = Offset.zero;
    }

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    // Scale animation for scale-based fades
    final bool hasScale =
        widget.fadeType == CorpoFadeType.fadeInScale ||
        widget.fadeType == CorpoFadeType.fadeOutScale;

    _scaleAnimation = Tween<double>(
      begin: hasScale ? 0.8 : 1.0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  Future<void> _startAnimation() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }

    if (mounted) {
      await _controller.forward();
    }
  }

  /// Starts the animation manually.
  Future<void> start() => _startAnimation();

  /// Reverses the animation.
  Future<void> reverse() => _controller.reverse();

  /// Resets the animation to beginning.
  void reset() => _controller.reset();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = widget.child;

    // Apply scale animation if needed
    if (widget.fadeType == CorpoFadeType.fadeInScale ||
        widget.fadeType == CorpoFadeType.fadeOutScale) {
      animatedChild = ScaleTransition(
        scale: _scaleAnimation,
        child: animatedChild,
      );
    }

    // Apply slide animation if needed
    if (widget.fadeType == CorpoFadeType.fadeInUp ||
        widget.fadeType == CorpoFadeType.fadeInDown ||
        widget.fadeType == CorpoFadeType.fadeInLeft ||
        widget.fadeType == CorpoFadeType.fadeInRight) {
      animatedChild = SlideTransition(
        position: _slideAnimation,
        child: animatedChild,
      );
    }

    // Apply fade animation
    return FadeTransition(opacity: _opacityAnimation, child: animatedChild);
  }
}

/// Utility class for creating common fade animations.
abstract final class CorpoFadeAnimations {
  /// Creates a staggered list animation where children fade in sequentially.
  static Widget staggeredList({
    required List<Widget> children,
    Duration interval = const Duration(milliseconds: 100),
    Duration duration = CorpoAnimationDurations.standard,
    CorpoFadeType fadeType = CorpoFadeType.fadeInUp,
  }) => Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(children.length, (int index) => CorpoFadeTransition(
          duration: duration,
          fadeType: fadeType,
          delay: Duration(milliseconds: interval.inMilliseconds * index),
          child: children[index],
        )),
    );

  /// Creates a fade animation controller for manual control.
  static AnimationController createController({
    required TickerProvider vsync,
    Duration duration = CorpoAnimationDurations.standard,
  }) => AnimationController(duration: duration, vsync: vsync);

  /// Creates a fade animation from an existing controller.
  static Animation<double> createAnimation({
    required AnimationController controller,
    Curve curve = CorpoAnimationCurves.standard,
    double begin = 0.0,
    double end = 1.0,
  }) => Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
}
