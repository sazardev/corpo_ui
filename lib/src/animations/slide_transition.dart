/// Slide transition animations for the Corpo UI design system.
///
/// This file provides comprehensive slide transition utilities with
/// corporate-appropriate timing and directional movement. The animations
/// follow professional design principles with smooth, purposeful motion
/// suitable for business applications.
///
/// Example usage:
/// ```dart
/// CorpoSlideTransition(
///   direction: CorpoSlideDirection.fromRight,
///   child: MyWidget(),
/// )
///
/// CorpoSlideTransition.fromBottom(
///   child: MyWidget(),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'fade_transition.dart';

/// Defines the slide direction.
enum CorpoSlideDirection {
  /// Slide from left to right
  fromLeft,

  /// Slide from right to left
  fromRight,

  /// Slide from top to bottom
  fromTop,

  /// Slide from bottom to top
  fromBottom,

  /// Slide horizontally (auto-detect direction)
  horizontal,

  /// Slide vertically (auto-detect direction)
  vertical,
}

/// Defines the slide animation behavior.
enum CorpoSlideType {
  /// Standard slide transition
  slide,

  /// Slide with fade effect
  slideWithFade,

  /// Push transition (slides in while pushing out)
  push,

  /// Cover transition (slides over existing content)
  cover,
}

/// A comprehensive slide transition widget following Corpo UI design principles.
///
/// This component provides smooth slide animations with professional timing
/// and directional movement suitable for corporate applications. It supports
/// various slide types and can be combined with fade effects.
class CorpoSlideTransition extends StatefulWidget {
  /// Creates a slide transition widget.
  const CorpoSlideTransition({
    required this.child,
    this.direction = CorpoSlideDirection.fromRight,
    this.type = CorpoSlideType.slide,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
    this.delay = Duration.zero,
    this.distance = 1.0,
    this.autoStart = true,
    this.onComplete,
    super.key,
  });

  /// Creates a slide from left transition.
  const CorpoSlideTransition.fromLeft({
    required this.child,
    this.type = CorpoSlideType.slide,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
    this.delay = Duration.zero,
    this.distance = 1.0,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : direction = CorpoSlideDirection.fromLeft;

  /// Creates a slide from right transition.
  const CorpoSlideTransition.fromRight({
    required this.child,
    this.type = CorpoSlideType.slide,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
    this.delay = Duration.zero,
    this.distance = 1.0,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : direction = CorpoSlideDirection.fromRight;

  /// Creates a slide from bottom transition.
  const CorpoSlideTransition.fromBottom({
    required this.child,
    this.type = CorpoSlideType.slideWithFade,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.emphasized,
    this.delay = Duration.zero,
    this.distance = 1.0,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : direction = CorpoSlideDirection.fromBottom;

  /// Creates a slide from top transition.
  const CorpoSlideTransition.fromTop({
    required this.child,
    this.type = CorpoSlideType.slideWithFade,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.emphasized,
    this.delay = Duration.zero,
    this.distance = 1.0,
    this.autoStart = true,
    this.onComplete,
    super.key,
  }) : direction = CorpoSlideDirection.fromTop;

  /// The widget to animate.
  final Widget child;

  /// The direction of the slide animation.
  final CorpoSlideDirection direction;

  /// The type of slide animation.
  final CorpoSlideType type;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;

  /// Delay before starting the animation.
  final Duration delay;

  /// The distance of the slide (1.0 = full widget size).
  final double distance;

  /// Whether to start the animation automatically.
  final bool autoStart;

  /// Callback when animation completes.
  final VoidCallback? onComplete;

  @override
  State<CorpoSlideTransition> createState() => _CorpoSlideTransitionState();
}

class _CorpoSlideTransitionState extends State<CorpoSlideTransition>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
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

    // Calculate slide offset based on direction
    Offset slideBegin;
    switch (widget.direction) {
      case CorpoSlideDirection.fromLeft:
        slideBegin = Offset(-widget.distance, 0);
        break;
      case CorpoSlideDirection.fromRight:
        slideBegin = Offset(widget.distance, 0);
        break;
      case CorpoSlideDirection.fromTop:
        slideBegin = Offset(0, -widget.distance);
        break;
      case CorpoSlideDirection.fromBottom:
        slideBegin = Offset(0, widget.distance);
        break;
      case CorpoSlideDirection.horizontal:
        // Auto-detect based on text direction
        slideBegin = Offset(widget.distance, 0);
        break;
      case CorpoSlideDirection.vertical:
        slideBegin = Offset(0, widget.distance);
        break;
    }

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    // Fade animation for slideWithFade type
    _fadeAnimation = Tween<double>(
      begin: widget.type == CorpoSlideType.slideWithFade ? 0.0 : 1.0,
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
    Widget animatedChild = SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );

    // Apply fade if needed
    if (widget.type == CorpoSlideType.slideWithFade) {
      animatedChild = FadeTransition(
        opacity: _fadeAnimation,
        child: animatedChild,
      );
    }

    return animatedChild;
  }
}

/// A slide page route for navigation transitions.
class CorpoSlidePageRoute<T> extends PageRouteBuilder<T> {
  /// Creates a slide page route.
  CorpoSlidePageRoute({
    required this.child,
    this.direction = CorpoSlideDirection.fromRight,
    this.duration = CorpoAnimationDurations.standard,
    this.curve = CorpoAnimationCurves.standard,
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
             ) => CorpoSlidePageTransition(
               animation: animation,
               secondaryAnimation: secondaryAnimation,
               direction: direction,
               curve: curve,
               child: child,
             ),
       );

  /// The page widget to display.
  final Widget child;

  /// The direction of the slide animation.
  final CorpoSlideDirection direction;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;
}

/// Internal slide page transition widget.
class CorpoSlidePageTransition extends StatelessWidget {
  /// Creates a slide page transition.
  const CorpoSlidePageTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.direction,
    required this.curve,
    required this.child,
    super.key,
  });

  /// Primary animation for the incoming page.
  final Animation<double> animation;

  /// Secondary animation for the outgoing page.
  final Animation<double> secondaryAnimation;

  /// The direction of the slide animation.
  final CorpoSlideDirection direction;

  /// The animation curve.
  final Curve curve;

  /// The page widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Calculate slide offset based on direction
    Offset slideBegin;
    Offset slideEnd;

    switch (direction) {
      case CorpoSlideDirection.fromLeft:
        slideBegin = const Offset(-1, 0);
        slideEnd = const Offset(1, 0);
        break;
      case CorpoSlideDirection.fromRight:
        slideBegin = const Offset(1, 0);
        slideEnd = const Offset(-1, 0);
        break;
      case CorpoSlideDirection.fromTop:
        slideBegin = const Offset(0, -1);
        slideEnd = const Offset(0, 1);
        break;
      case CorpoSlideDirection.fromBottom:
        slideBegin = const Offset(0, 1);
        slideEnd = const Offset(0, -1);
        break;
      case CorpoSlideDirection.horizontal:
        slideBegin = const Offset(1, 0);
        slideEnd = const Offset(-1, 0);
        break;
      case CorpoSlideDirection.vertical:
        slideBegin = const Offset(0, 1);
        slideEnd = const Offset(0, -1);
        break;
    }

    final Animation<Offset> primaryAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    final Animation<Offset> secondarySlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: slideEnd,
    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve));

    return SlideTransition(
      position: animation.status == AnimationStatus.reverse
          ? secondarySlideAnimation
          : primaryAnimation,
      child: child,
    );
  }
}

/// Utility class for creating slide animations.
abstract final class CorpoSlideAnimations {
  /// Creates a staggered slide animation for multiple widgets.
  static Widget staggeredSlide({
    required List<Widget> children,
    CorpoSlideDirection direction = CorpoSlideDirection.fromBottom,
    Duration interval = const Duration(milliseconds: 100),
    Duration duration = CorpoAnimationDurations.standard,
    CorpoSlideType type = CorpoSlideType.slideWithFade,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(
      children.length,
      (int index) => CorpoSlideTransition(
        direction: direction,
        type: type,
        duration: duration,
        delay: Duration(milliseconds: interval.inMilliseconds * index),
        child: children[index],
      ),
    ),
  );

  /// Creates a slide animation controller for manual control.
  static AnimationController createController({
    required TickerProvider vsync,
    Duration duration = CorpoAnimationDurations.standard,
  }) => AnimationController(duration: duration, vsync: vsync);

  /// Creates a slide animation from an existing controller.
  static Animation<Offset> createAnimation({
    required AnimationController controller,
    required CorpoSlideDirection direction,
    Curve curve = CorpoAnimationCurves.standard,
    double distance = 1.0,
  }) {
    Offset begin;
    switch (direction) {
      case CorpoSlideDirection.fromLeft:
        begin = Offset(-distance, 0);
        break;
      case CorpoSlideDirection.fromRight:
        begin = Offset(distance, 0);
        break;
      case CorpoSlideDirection.fromTop:
        begin = Offset(0, -distance);
        break;
      case CorpoSlideDirection.fromBottom:
        begin = Offset(0, distance);
        break;
      case CorpoSlideDirection.horizontal:
        begin = Offset(distance, 0);
        break;
      case CorpoSlideDirection.vertical:
        begin = Offset(0, distance);
        break;
    }

    return Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }
}
