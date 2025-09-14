/// Micro-interaction animations for the Corpo UI design system.
///
/// This file provides comprehensive micro-interaction utilities with
/// corporate-appropriate timing and subtle effects. The animations
/// follow professional design principles with purposeful motion
/// suitable for business applications.
///
/// Example usage:
/// ```dart
/// CorpoMicroInteraction.hover(
///   child: MyButton(),
/// )
///
/// CorpoMicroInteraction.press(
///   child: MyWidget(),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'fade_transition.dart';

/// Defines the micro-interaction type.
enum CorpoMicroInteractionType {
  /// Hover effect (desktop)
  hover,

  /// Press/tap effect
  press,

  /// Focus effect (keyboard navigation)
  focus,

  /// Selection effect
  select,

  /// Loading pulse effect
  loading,

  /// Success feedback
  success,

  /// Error feedback
  error,

  /// Warning feedback
  warning,

  /// Attention grabber
  attention,

  /// Breathe animation (subtle pulse)
  breathe,

  /// Ripple effect
  ripple,
}

/// Corporate-specific micro-interaction effects.
abstract final class CorpoMicroEffects {
  /// Subtle elevation for hover states
  static const double hoverElevation = 2;

  /// Scale factor for press interactions
  static const double pressScale = 0.98;

  /// Scale factor for hover interactions
  static const double hoverScale = 1.02;

  /// Focus border width
  static const double focusBorderWidth = 2;

  /// Ripple effect radius
  static const double rippleRadius = 20;

  /// Loading pulse scale range
  static const double pulseScaleMin = 0.95;
  static const double pulseScaleMax = 1.05;
}

/// A comprehensive micro-interaction widget following Corpo UI design principles.
///
/// This component provides smooth micro-interactions with professional timing
/// and subtle effects suitable for corporate applications. It supports
/// various interaction types and can be customized for different contexts.
class CorpoMicroInteraction extends StatefulWidget {
  /// Creates a micro-interaction widget.
  const CorpoMicroInteraction({
    required this.child,
    this.type = CorpoMicroInteractionType.hover,
    this.duration = CorpoAnimationDurations.quick,
    this.curve = CorpoAnimationCurves.gentle,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.customColor,
    super.key,
  });

  /// Creates a hover micro-interaction.
  const CorpoMicroInteraction.hover({
    required this.child,
    this.duration = CorpoAnimationDurations.quick,
    this.enabled = true,
    this.onTap,
    this.onHover,
    this.customColor,
    super.key,
  }) : type = CorpoMicroInteractionType.hover,
       curve = CorpoAnimationCurves.gentle,
       onLongPress = null;

  /// Creates a press micro-interaction.
  const CorpoMicroInteraction.press({
    required this.child,
    this.duration = CorpoAnimationDurations.quick,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.customColor,
    super.key,
  }) : type = CorpoMicroInteractionType.press,
       curve = CorpoAnimationCurves.sharp,
       onHover = null;

  /// Creates a focus micro-interaction.
  const CorpoMicroInteraction.focus({
    required this.child,
    this.duration = CorpoAnimationDurations.quick,
    this.enabled = true,
    this.customColor,
    super.key,
  }) : type = CorpoMicroInteractionType.focus,
       curve = CorpoAnimationCurves.gentle,
       onTap = null,
       onLongPress = null,
       onHover = null;

  /// Creates a loading pulse micro-interaction.
  const CorpoMicroInteraction.loading({
    required this.child,
    this.duration = CorpoAnimationDurations.slow,
    this.enabled = true,
    super.key,
  }) : type = CorpoMicroInteractionType.loading,
       curve = CorpoAnimationCurves.gentle,
       onTap = null,
       onLongPress = null,
       onHover = null,
       customColor = null;

  /// Creates a success feedback micro-interaction.
  const CorpoMicroInteraction.success({
    required this.child,
    this.duration = CorpoAnimationDurations.standard,
    this.enabled = true,
    super.key,
  }) : type = CorpoMicroInteractionType.success,
       curve = CorpoAnimationCurves.gentle,
       onTap = null,
       onLongPress = null,
       onHover = null,
       customColor = null;

  /// The widget to apply micro-interactions to.
  final Widget child;

  /// The type of micro-interaction.
  final CorpoMicroInteractionType type;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;

  /// Whether the micro-interaction is enabled.
  final bool enabled;

  /// Callback for tap interactions.
  final VoidCallback? onTap;

  /// Callback for long press interactions.
  final VoidCallback? onLongPress;

  /// Callback for hover interactions.
  final ValueChanged<bool>? onHover;

  /// Custom color for the interaction effect.
  final Color? customColor;

  @override
  State<CorpoMicroInteraction> createState() => _CorpoMicroInteractionState();
}

class _CorpoMicroInteractionState extends State<CorpoMicroInteraction>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _elevationAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<Color?> _colorAnimation;

  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    if (widget.type == CorpoMicroInteractionType.loading ||
        widget.type == CorpoMicroInteractionType.breathe) {
      _startContinuousAnimation();
    }
  }

  void _initializeAnimations() {
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: _getScaleEnd(),
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _elevationAnimation = Tween<double>(
      begin: 0,
      end: _getElevationEnd(),
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _opacityAnimation = Tween<double>(
      begin: 1,
      end: _getOpacityEnd(),
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: _getColorEnd(),
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  double _getScaleEnd() {
    switch (widget.type) {
      case CorpoMicroInteractionType.hover:
        return CorpoMicroEffects.hoverScale;
      case CorpoMicroInteractionType.press:
        return CorpoMicroEffects.pressScale;
      case CorpoMicroInteractionType.loading:
      case CorpoMicroInteractionType.breathe:
        return CorpoMicroEffects.pulseScaleMax;
      case CorpoMicroInteractionType.success:
        return 1.1;
      case CorpoMicroInteractionType.attention:
        return 1.05;
      default:
        return 1;
    }
  }

  double _getElevationEnd() {
    switch (widget.type) {
      case CorpoMicroInteractionType.hover:
        return CorpoMicroEffects.hoverElevation;
      case CorpoMicroInteractionType.focus:
        return 1;
      default:
        return 0;
    }
  }

  double _getOpacityEnd() {
    switch (widget.type) {
      case CorpoMicroInteractionType.press:
        return 0.8;
      case CorpoMicroInteractionType.loading:
        return 0.7;
      default:
        return 1;
    }
  }

  Color? _getColorEnd() {
    if (widget.customColor != null) {
      return Color.fromARGB(
        (0.1 * 255).round(),
        (widget.customColor!.r * 255.0).round() & 0xff,
        (widget.customColor!.g * 255.0).round() & 0xff,
        (widget.customColor!.b * 255.0).round() & 0xff,
      );
    }

    switch (widget.type) {
      case CorpoMicroInteractionType.hover:
        return Color.fromARGB(
          (0.05 * 255).round(),
          (Colors.blue.r * 255.0).round() & 0xff,
          (Colors.blue.g * 255.0).round() & 0xff,
          (Colors.blue.b * 255.0).round() & 0xff,
        );
      case CorpoMicroInteractionType.focus:
        return Color.fromARGB(
          (0.1 * 255).round(),
          (Colors.blue.r * 255.0).round() & 0xff,
          (Colors.blue.g * 255.0).round() & 0xff,
          (Colors.blue.b * 255.0).round() & 0xff,
        );
      case CorpoMicroInteractionType.success:
        return Color.fromARGB(
          (0.1 * 255).round(),
          (Colors.green.r * 255.0).round() & 0xff,
          (Colors.green.g * 255.0).round() & 0xff,
          (Colors.green.b * 255.0).round() & 0xff,
        );
      case CorpoMicroInteractionType.error:
        return Color.fromARGB(
          (0.1 * 255).round(),
          (Colors.red.r * 255.0).round() & 0xff,
          (Colors.red.g * 255.0).round() & 0xff,
          (Colors.red.b * 255.0).round() & 0xff,
        );
      case CorpoMicroInteractionType.warning:
        return Color.fromARGB(
          (0.1 * 255).round(),
          (Colors.orange.r * 255.0).round() & 0xff,
          (Colors.orange.g * 255.0).round() & 0xff,
          (Colors.orange.b * 255.0).round() & 0xff,
        );
      default:
        return Colors.transparent;
    }
  }

  void _startContinuousAnimation() {
    _controller.repeat(reverse: true);
  }

  void _handleInteractionStart() {
    if (!widget.enabled) return;

    switch (widget.type) {
      case CorpoMicroInteractionType.hover:
        if (_isHovered) {
          _controller.forward();
        }
        break;
      case CorpoMicroInteractionType.press:
        if (_isPressed) {
          _controller.forward();
        }
        break;
      case CorpoMicroInteractionType.focus:
        if (_isFocused) {
          _controller.forward();
        }
        break;
      case CorpoMicroInteractionType.success:
      case CorpoMicroInteractionType.error:
      case CorpoMicroInteractionType.warning:
      case CorpoMicroInteractionType.attention:
        _controller.forward().then((_) {
          _controller.reverse();
        });
        break;
      default:
        break;
    }
  }

  void _handleInteractionEnd() {
    if (!widget.enabled) return;

    switch (widget.type) {
      case CorpoMicroInteractionType.hover:
      case CorpoMicroInteractionType.press:
      case CorpoMicroInteractionType.focus:
        _controller.reverse();
        break;
      default:
        break;
    }
  }

  /// Triggers the micro-interaction manually.
  void trigger() {
    if (!widget.enabled) return;
    _controller.forward().then((_) {
      if (widget.type != CorpoMicroInteractionType.loading &&
          widget.type != CorpoMicroInteractionType.breathe) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) {
      if (widget.type == CorpoMicroInteractionType.hover) {
        setState(() => _isHovered = true);
        widget.onHover?.call(true);
        _handleInteractionStart();
      }
    },
    onExit: (_) {
      if (widget.type == CorpoMicroInteractionType.hover) {
        setState(() => _isHovered = false);
        widget.onHover?.call(false);
        _handleInteractionEnd();
      }
    },
    child: GestureDetector(
      onTapDown: (_) {
        if (widget.type == CorpoMicroInteractionType.press) {
          setState(() => _isPressed = true);
          _handleInteractionStart();
        }
      },
      onTapUp: (_) {
        if (widget.type == CorpoMicroInteractionType.press) {
          setState(() => _isPressed = false);
          _handleInteractionEnd();
        }
      },
      onTapCancel: () {
        if (widget.type == CorpoMicroInteractionType.press) {
          setState(() => _isPressed = false);
          _handleInteractionEnd();
        }
      },
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Focus(
        onFocusChange: (bool focused) {
          if (widget.type == CorpoMicroInteractionType.focus) {
            setState(() => _isFocused = focused);
            if (focused) {
              _handleInteractionStart();
            } else {
              _handleInteractionEnd();
            }
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Material(
              elevation: _elevationAnimation.value,
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                decoration: widget.type == CorpoMicroInteractionType.focus
                    ? BoxDecoration(
                        border: _isFocused
                            ? Border.all(
                                color: Theme.of(context).primaryColor,
                                width: CorpoMicroEffects.focusBorderWidth,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(4),
                      )
                    : null,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Utility class for creating micro-interaction effects.
abstract final class CorpoMicroInteractions {
  /// Creates a button with all appropriate micro-interactions.
  static Widget button({
    required Widget child,
    required VoidCallback onPressed,
    bool enabled = true,
    Color? color,
  }) => CorpoMicroInteraction.hover(
    enabled: enabled,
    customColor: color,
    child: CorpoMicroInteraction.press(
      enabled: enabled,
      onTap: onPressed,
      child: CorpoMicroInteraction.focus(
        enabled: enabled,
        customColor: color,
        child: child,
      ),
    ),
  );

  /// Creates a card with hover effect.
  static Widget card({
    required Widget child,
    VoidCallback? onTap,
    bool enabled = true,
  }) =>
      CorpoMicroInteraction.hover(enabled: enabled, onTap: onTap, child: child);

  /// Creates a loading indicator with pulse effect.
  static Widget loading({
    required Widget child,
    Duration duration = CorpoAnimationDurations.slow,
  }) => CorpoMicroInteraction.loading(duration: duration, child: child);

  /// Creates a success feedback animation.
  static Widget success({
    required Widget child,
    Duration duration = CorpoAnimationDurations.standard,
  }) => CorpoMicroInteraction.success(duration: duration, child: child);

  /// Creates a breathing animation for subtle attention.
  static Widget breathe({
    required Widget child,
    Duration duration = const Duration(seconds: 3),
  }) => CorpoMicroInteraction(
    type: CorpoMicroInteractionType.breathe,
    duration: duration,
    child: child,
  );
}
