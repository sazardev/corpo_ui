/// Scale transition animations for the Corpo UI design system.
///
/// This file provides comprehensive scale transition utilities with
/// corporate-appropriate timing and scaling effects. The animations
/// follow professional design principles with smooth, elegant motion
/// suitable for business applications.
///
/// Example usage:
/// ```dart
/// CorpoScaleTransition(
///   type: CorpoScaleType.scaleIn,
///   child: MyWidget(),
/// )
///
/// CorpoScaleTransition.bounceIn(
///   child: MyWidget(),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'fade_transition.dart';

/// Defines the scale animation type.
enum CorpoScaleType {
  /// Standard scale in animation
  scaleIn,

  /// Standard scale out animation
  scaleOut,

  /// Scale in with bounce effect
  bounceIn,

  /// Scale out with bounce effect
  bounceOut,

  /// Elastic scale in
  elasticIn,

  /// Elastic scale out
  elasticOut,

  /// Scale with fade effect
  scaleWithFade,

  /// Pulse animation (scale up and down)
  pulse,

  /// Zoom in from center
  zoomIn,

  /// Zoom out from center
  zoomOut,
}

/// Defines the scale origin point.
enum CorpoScaleOrigin {
  /// Scale from center (default)
  center,

  /// Scale from top-left corner
  topLeft,

  /// Scale from top-right corner
  topRight,

  /// Scale from bottom-left corner
  bottomLeft,

  /// Scale from bottom-right corner
  bottomRight,

  /// Scale from top edge
  topCenter,

  /// Scale from bottom edge
  bottomCenter,

  /// Scale from left edge
  centerLeft,

  /// Scale from right edge
  centerRight,
}

/// Corporate-specific animation curves for scale transitions.
abstract final class CorpoScaleCurves {
  /// Smooth scale curve for professional applications
  static const Cubic smoothScale = Curves.easeOutCubic;

  /// Bounce curve for playful scale animations
  static const Curve bounce = Curves.bounceOut;

  /// Elastic curve for engaging scale animations
  static const ElasticOutCurve elastic = Curves.elasticOut;

  /// Quick scale for micro-interactions
  static const Cubic quick = Curves.easeOutQuart;

  /// Gentle scale for subtle animations
  static const Cubic gentle = Curves.easeInOutSine;
}

/// A comprehensive scale transition widget following Corpo UI design principles.
///
/// This component provides smooth scale animations with professional timing
/// and scaling effects suitable for corporate applications. It supports
/// various scale types and origin points.
class CorpoScaleTransition extends StatefulWidget {
  /// Creates a scale transition widget.
  const CorpoScaleTransition({
    required this.child,
    this.type = CorpoScaleType.scaleIn,
    this.origin = CorpoScaleOrigin.center,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoScaleCurves.smoothScale,
    this.delay = Duration.zero,
    this.scaleBegin = 0.0,
    this.scaleEnd = 1.0,
    this.autoStart = true,
    this.repeat = false,
    this.onComplete,
    super.key,
  });

  /// Creates a scale in transition.
  const CorpoScaleTransition.scaleIn({
    required this.child,
    this.origin = CorpoScaleOrigin.center,
    this.duration = CorpoAnimationDurations.standard,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : type = CorpoScaleType.scaleIn,
       curve = CorpoScaleCurves.smoothScale,
       scaleBegin = 0.0,
       scaleEnd = 1.0,
       repeat = false;

  /// Creates a bounce in transition.
  const CorpoScaleTransition.bounceIn({
    required this.child,
    this.origin = CorpoScaleOrigin.center,
    this.duration = CorpoAnimationDurations.slow,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : type = CorpoScaleType.bounceIn,
       curve = CorpoScaleCurves.bounce,
       scaleBegin = 0.0,
       scaleEnd = 1.0,
       repeat = false;

  /// Creates an elastic in transition.
  const CorpoScaleTransition.elasticIn({
    required this.child,
    this.origin = CorpoScaleOrigin.center,
    this.duration = CorpoAnimationDurations.slow,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : type = CorpoScaleType.elasticIn,
       curve = CorpoScaleCurves.elastic,
       scaleBegin = 0.0,
       scaleEnd = 1.0,
       repeat = false;

  /// Creates a pulse animation.
  const CorpoScaleTransition.pulse({
    required this.child,
    this.origin = CorpoScaleOrigin.center,
    this.duration = CorpoAnimationDurations.standard,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : type = CorpoScaleType.pulse,
       curve = CorpoScaleCurves.gentle,
       scaleBegin = 1.0,
       scaleEnd = 1.1,
       repeat = true;

  /// Creates a zoom in transition.
  const CorpoScaleTransition.zoomIn({
    required this.child,
    this.origin = CorpoScaleOrigin.center,
    this.duration = CorpoAnimationDurations.quick,
    this.delay = Duration.zero,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : type = CorpoScaleType.zoomIn,
       curve = CorpoScaleCurves.quick,
       scaleBegin = 0.8,
       scaleEnd = 1.0,
       repeat = false;

  /// The widget to animate.
  final Widget child;

  /// The type of scale animation.
  final CorpoScaleType type;

  /// The origin point for scaling.
  final CorpoScaleOrigin origin;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;

  /// Delay before starting the animation.
  final Duration delay;

  /// The starting scale value.
  final double scaleBegin;

  /// The ending scale value.
  final double scaleEnd;

  /// Whether to start the animation automatically.
  final bool autoStart;

  /// Whether to repeat the animation.
  final bool repeat;

  /// Callback when animation completes.
  final VoidCallback? onComplete;

  @override
  State<CorpoScaleTransition> createState() => _CorpoScaleTransitionState();
}

class _CorpoScaleTransitionState extends State<CorpoScaleTransition>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

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

    // Configure scale animation based on type
    double begin = widget.scaleBegin;
    double end = widget.scaleEnd;

    switch (widget.type) {
      case CorpoScaleType.scaleOut:
        begin = 1.0;
        end = 0.0;
        break;
      case CorpoScaleType.bounceOut:
        begin = 1.0;
        end = 0.0;
        break;
      case CorpoScaleType.elasticOut:
        begin = 1.0;
        end = 0.0;
        break;
      case CorpoScaleType.zoomOut:
        begin = 1.0;
        end = 1.2;
        break;
      default:
        // Use provided values
        break;
    }

    _scaleAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    // Fade animation for scaleWithFade type
    _fadeAnimation = Tween<double>(
      begin: widget.type == CorpoScaleType.scaleWithFade ? 0.0 : 1.0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (widget.repeat) {
          if (widget.type == CorpoScaleType.pulse) {
            _controller.reverse();
          } else {
            _controller.repeat(reverse: true);
          }
        } else {
          widget.onComplete?.call();
        }
      } else if (status == AnimationStatus.dismissed && widget.repeat) {
        if (widget.type == CorpoScaleType.pulse) {
          _controller.forward();
        }
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

  /// Stops repeating animation.
  void stop() => _controller.stop();

  Alignment _getAlignment() {
    switch (widget.origin) {
      case CorpoScaleOrigin.center:
        return Alignment.center;
      case CorpoScaleOrigin.topLeft:
        return Alignment.topLeft;
      case CorpoScaleOrigin.topRight:
        return Alignment.topRight;
      case CorpoScaleOrigin.bottomLeft:
        return Alignment.bottomLeft;
      case CorpoScaleOrigin.bottomRight:
        return Alignment.bottomRight;
      case CorpoScaleOrigin.topCenter:
        return Alignment.topCenter;
      case CorpoScaleOrigin.bottomCenter:
        return Alignment.bottomCenter;
      case CorpoScaleOrigin.centerLeft:
        return Alignment.centerLeft;
      case CorpoScaleOrigin.centerRight:
        return Alignment.centerRight;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = ScaleTransition(
      scale: _scaleAnimation,
      alignment: _getAlignment(),
      child: widget.child,
    );

    // Apply fade if needed
    if (widget.type == CorpoScaleType.scaleWithFade) {
      animatedChild = FadeTransition(
        opacity: _fadeAnimation,
        child: animatedChild,
      );
    }

    return animatedChild;
  }
}

/// A scale page route for navigation transitions.
class CorpoScalePageRoute<T> extends PageRouteBuilder<T> {
  /// Creates a scale page route.
  CorpoScalePageRoute({
    required this.child,
    this.type = CorpoScaleType.scaleIn,
    this.origin = CorpoScaleOrigin.center,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoScaleCurves.smoothScale,
    super.settings,
  }) : super(
         pageBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
             ) => child,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
               Widget child,
             ) => CorpoScalePageTransition(
               animation: animation,
               type: type,
               origin: origin,
               curve: curve,
               child: child,
             ),
       );

  /// The page widget to display.
  final Widget child;

  /// The type of scale animation.
  final CorpoScaleType type;

  /// The origin point for scaling.
  final CorpoScaleOrigin origin;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;
}

/// Internal scale page transition widget.
class CorpoScalePageTransition extends StatelessWidget {
  /// Creates a scale page transition.
  const CorpoScalePageTransition({
    required this.animation,
    required this.type,
    required this.origin,
    required this.curve,
    required this.child,
    super.key,
  });

  /// The animation for the page transition.
  final Animation<double> animation;

  /// The type of scale animation.
  final CorpoScaleType type;

  /// The origin point for scaling.
  final CorpoScaleOrigin origin;

  /// The animation curve.
  final Curve curve;

  /// The page widget.
  final Widget child;

  Alignment _getAlignment() {
    switch (origin) {
      case CorpoScaleOrigin.center:
        return Alignment.center;
      case CorpoScaleOrigin.topLeft:
        return Alignment.topLeft;
      case CorpoScaleOrigin.topRight:
        return Alignment.topRight;
      case CorpoScaleOrigin.bottomLeft:
        return Alignment.bottomLeft;
      case CorpoScaleOrigin.bottomRight:
        return Alignment.bottomRight;
      case CorpoScaleOrigin.topCenter:
        return Alignment.topCenter;
      case CorpoScaleOrigin.bottomCenter:
        return Alignment.bottomCenter;
      case CorpoScaleOrigin.centerLeft:
        return Alignment.centerLeft;
      case CorpoScaleOrigin.centerRight:
        return Alignment.centerRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    double begin = 0.8;
    double end = 1;

    if (type == CorpoScaleType.zoomOut) {
      begin = 1.0;
      end = 0.8;
    }

    final Animation<double> scaleAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    Widget scaledChild = ScaleTransition(
      scale: scaleAnimation,
      alignment: _getAlignment(),
      child: child,
    );

    // Add fade for certain types
    if (type == CorpoScaleType.scaleWithFade) {
      scaledChild = FadeTransition(opacity: animation, child: scaledChild);
    }

    return scaledChild;
  }
}

/// Utility class for creating scale animations.
abstract final class CorpoScaleAnimations {
  /// Creates a staggered scale animation for multiple widgets.
  static Widget staggeredScale({
    required List<Widget> children,
    CorpoScaleType type = CorpoScaleType.scaleIn,
    CorpoScaleOrigin origin = CorpoScaleOrigin.center,
    Duration interval = const Duration(milliseconds: 100),
    Duration duration = CorpoAnimationDurations.standard,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(
      children.length,
      (int index) => CorpoScaleTransition(
        type: type,
        origin: origin,
        duration: duration,
        delay: Duration(milliseconds: interval.inMilliseconds * index),
        child: children[index],
      ),
    ),
  );

  /// Creates a scale animation controller for manual control.
  static AnimationController createController({
    required TickerProvider vsync,
    Duration duration = CorpoAnimationDurations.standard,
  }) => AnimationController(duration: duration, vsync: vsync);

  /// Creates a scale animation from an existing controller.
  static Animation<double> createAnimation({
    required AnimationController controller,
    required CorpoScaleType type,
    Curve curve = CorpoScaleCurves.smoothScale,
    double scaleBegin = 0.0,
    double scaleEnd = 1.0,
  }) {
    double begin = scaleBegin;
    double end = scaleEnd;

    switch (type) {
      case CorpoScaleType.scaleOut:
      case CorpoScaleType.bounceOut:
      case CorpoScaleType.elasticOut:
        begin = 1.0;
        end = 0.0;
        break;
      case CorpoScaleType.pulse:
        begin = 1.0;
        end = 1.1;
        break;
      case CorpoScaleType.zoomOut:
        begin = 1.0;
        end = 1.2;
        break;
      default:
        // Use provided values
        break;
    }

    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }

  /// Creates a breathing animation (continuous pulse).
  static Widget breathing({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
    double scaleMin = 0.95,
    double scaleMax = 1.05,
  }) => CorpoScaleTransition(
    type: CorpoScaleType.pulse,
    duration: duration,
    scaleBegin: scaleMin,
    scaleEnd: scaleMax,
    repeat: true,
    child: child,
  );
}
