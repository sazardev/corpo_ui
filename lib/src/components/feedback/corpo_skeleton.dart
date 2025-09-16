/// A comprehensive skeleton loader component for the Corpo UI design system.
///
/// CorpoSkeleton provides consistent loading state placeholders across
/// corporate applications, with support for shimmer animation, various
/// shapes, and customizable dimensions.
///
/// Example usage:
/// ```dart
/// CorpoSkeleton()
///
/// CorpoSkeleton.circular(
///   diameter: 40.0,
/// )
///
/// CorpoSkeleton.text(
///   lines: 3,
/// )
///
/// CorpoSkeleton.card()
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Skeleton animation types.
enum CorpoSkeletonAnimation {
  /// No animation
  none,

  /// Shimmer animation
  shimmer,

  /// Pulse animation
  pulse,
}

/// Skeleton shape variants.
enum CorpoSkeletonShape {
  /// Rectangular shape
  rectangle,

  /// Circular shape
  circle,

  /// Rounded rectangle
  rounded,
}

/// A comprehensive skeleton loader widget following Corpo UI design principles.
///
/// This component provides consistent loading state placeholders with
/// shimmer animation and various shape configurations.
class CorpoSkeleton extends StatefulWidget {
  /// Creates a basic skeleton loader.
  const CorpoSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16.0,
    this.shape = CorpoSkeletonShape.rounded,
    this.animation = CorpoSkeletonAnimation.shimmer,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
  }) : lines = null,
       lineHeight = null,
       spacing = null;

  /// Creates a circular skeleton loader.
  const CorpoSkeleton.circular({
    required double diameter,
    super.key,
    this.animation = CorpoSkeletonAnimation.shimmer,
    this.baseColor,
    this.highlightColor,
  }) : width = diameter,
       height = diameter,
       shape = CorpoSkeletonShape.circle,
       borderRadius = null,
       lines = null,
       lineHeight = null,
       spacing = null;

  /// Creates a text skeleton loader with multiple lines.
  const CorpoSkeleton.text({
    super.key,
    this.lines = 1,
    this.lineHeight = 16.0,
    this.spacing = 8.0, // CorpoSpacing.small equivalent
    this.animation = CorpoSkeletonAnimation.shimmer,
    this.baseColor,
    this.highlightColor,
  }) : width = double.infinity,
       height = null,
       shape = CorpoSkeletonShape.rounded,
       borderRadius = null;

  /// Creates a card skeleton loader.
  const CorpoSkeleton.card({
    super.key,
    this.width = double.infinity,
    this.height = 200.0,
    this.animation = CorpoSkeletonAnimation.shimmer,
    this.baseColor,
    this.highlightColor,
  }) : shape = CorpoSkeletonShape.rounded,
       borderRadius = null,
       lines = null,
       lineHeight = null,
       spacing = null;

  /// Width of the skeleton.
  final double width;

  /// Height of the skeleton.
  final double? height;

  /// Shape of the skeleton.
  final CorpoSkeletonShape shape;

  /// Animation type for the skeleton.
  final CorpoSkeletonAnimation animation;

  /// Base color of the skeleton.
  final Color? baseColor;

  /// Highlight color for shimmer animation.
  final Color? highlightColor;

  /// Custom border radius for rounded shapes.
  final BorderRadius? borderRadius;

  /// Number of lines for text skeleton.
  final int? lines;

  /// Height of each line for text skeleton.
  final double? lineHeight;

  /// Spacing between lines for text skeleton.
  final double? spacing;

  @override
  State<CorpoSkeleton> createState() => _CorpoSkeletonState();
}

class _CorpoSkeletonState extends State<CorpoSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    if (widget.animation != CorpoSkeletonAnimation.none) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    if (widget.lines != null) {
      return _buildTextSkeleton(isDark, tokens);
    }

    return _buildSkeleton(isDark, tokens);
  }

  Widget _buildTextSkeleton(bool isDark, CorpoDesignTokens tokens) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List<Widget>.generate(widget.lines!, (int index) {
      final bool isLastLine = index == widget.lines! - 1;
      final double lineWidth = isLastLine ? widget.width * 0.7 : widget.width;

      return Column(
        children: <Widget>[
          _buildSkeleton(
            isDark,
            tokens,
            width: lineWidth,
            height: widget.lineHeight ?? 16.0,
          ),
          if (!isLastLine && widget.spacing != null)
            SizedBox(height: widget.spacing),
        ],
      );
    }),
  );

  Widget _buildSkeleton(
    bool isDark,
    CorpoDesignTokens tokens, {
    double? width,
    double? height,
  }) {
    final Color baseColor =
        widget.baseColor ??
        (isDark
            ? tokens.textPrimary.withOpacity(0.3)
            : tokens.textSecondary.withOpacity(0.2));
    final Color highlightColor =
        widget.highlightColor ??
        (isDark
            ? tokens.textPrimary.withOpacity(0.4)
            : tokens.textSecondary.withOpacity(0.1));

    Widget skeleton = Container(
      width: width ?? widget.width,
      height: height ?? widget.height,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: _getBorderRadius(tokens),
      ),
    );

    if (widget.animation == CorpoSkeletonAnimation.shimmer) {
      skeleton = AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) => Container(
            width: width ?? widget.width,
            height: height ?? widget.height,
            decoration: BoxDecoration(
              borderRadius: _getBorderRadius(tokens),
              gradient: LinearGradient(
                colors: <Color>[baseColor, highlightColor, baseColor],
                stops: const <double>[0, 0.5, 1],
                transform: _SlideGradientTransform(_animation.value),
              ),
            ),
          ),
      );
    } else if (widget.animation == CorpoSkeletonAnimation.pulse) {
      skeleton = AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) => Opacity(
          opacity: 0.5 + (_animationController.value * 0.5),
          child: Container(
            width: width ?? widget.width,
            height: height ?? widget.height,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: _getBorderRadius(tokens),
            ),
          ),
        ),
      );
    }

    return skeleton;
  }

  BorderRadius? _getBorderRadius(CorpoDesignTokens tokens) {
    if (widget.borderRadius != null) {
      return widget.borderRadius;
    }

    switch (widget.shape) {
      case CorpoSkeletonShape.rectangle:
        return null;
      case CorpoSkeletonShape.circle:
        return BorderRadius.circular(widget.width / 2);
      case CorpoSkeletonShape.rounded:
        return BorderRadius.circular(tokens.borderRadius);
    }
  }
}

/// Custom gradient transform for shimmer animation.
class _SlideGradientTransform extends GradientTransform {
  const _SlideGradientTransform(this.slidePercent);

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
}
