/// A comprehensive spinner component for the Corpo UI design system.
///
/// CorpoSpinner provides consistent loading indication across corporate
/// applications, with support for different sizes, styles, and overlay
/// configurations for various loading scenarios.
///
/// The component follows corporate design principles with smooth animations,
/// professional styling, and accessibility features for loading states
/// and asynchronous operations.
///
/// Example usage:
/// ```dart
/// CorpoSpinner()
///
/// CorpoSpinner.large(
///   color: CorpoColors.primary500,
/// )
///
/// CorpoSpinner.overlay(
///   child: MyWidget(),
///   isLoading: isLoadingData,
/// )
///
/// CorpoSpinner.withLabel(
///   'Loading...',
///   size: CorpoSpinnerSize.medium,
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Spinner size variants for different contexts.
///
/// Provides consistent sizing options for various loading scenarios.
enum CorpoSpinnerSize {
  /// Extra small spinner (16px) for inline loading
  extraSmall,

  /// Small spinner (20px) for compact elements
  small,

  /// Medium spinner (24px) for standard use (default)
  medium,

  /// Large spinner (32px) for prominent loading
  large,

  /// Extra large spinner (48px) for full-screen loading
  extraLarge,
}

/// Spinner style variants for different visual treatments.
enum CorpoSpinnerStyle {
  /// Circular spinner with stroke animation
  circular,

  /// Pulsing dot spinner
  dots,

  /// Linear progress spinner
  linear,
}

/// A comprehensive spinner widget following Corpo UI design principles.
///
/// This component provides consistent loading indication with smooth
/// animations, various size options, and accessibility features.
/// It supports overlay configurations for blocking user interaction.
class CorpoSpinner extends StatefulWidget {
  /// Creates a Corpo UI spinner.
  ///
  /// The spinner will continuously animate until the widget is disposed.
  const CorpoSpinner({
    super.key,
    this.size = CorpoSpinnerSize.medium,
    this.style = CorpoSpinnerStyle.circular,
    this.color,
    this.strokeWidth,
    this.label,
  });

  /// Convenience constructor for large spinners.
  const CorpoSpinner.large({
    super.key,
    this.style = CorpoSpinnerStyle.circular,
    this.color,
    this.strokeWidth,
    this.label,
  }) : size = CorpoSpinnerSize.large;

  /// Convenience constructor for small spinners.
  const CorpoSpinner.small({
    super.key,
    this.style = CorpoSpinnerStyle.circular,
    this.color,
    this.strokeWidth,
    this.label,
  }) : size = CorpoSpinnerSize.small;

  /// Convenience constructor for spinners with labels.
  const CorpoSpinner.withLabel(
    this.label, {
    super.key,
    this.size = CorpoSpinnerSize.medium,
    this.style = CorpoSpinnerStyle.circular,
    this.color,
    this.strokeWidth,
  });

  /// Convenience constructor for overlay spinners.
  ///
  /// Creates a spinner overlay that blocks user interaction
  /// while loading is in progress.
  static Widget overlay({
    required Widget child,
    required bool isLoading,
    CorpoSpinnerSize size = CorpoSpinnerSize.large,
    CorpoSpinnerStyle style = CorpoSpinnerStyle.circular,
    Color? color,
    String? label,
    Color? overlayColor,
  }) => Stack(
      children: <Widget>[
        child,
        if (isLoading)
          Container(
            color: overlayColor ?? Colors.black.withValues(alpha: 0.3),
            child: Center(
              child: CorpoSpinner.withLabel(
                label,
                size: size,
                style: style,
                color: color ?? CorpoColors.neutralWhite,
              ),
            ),
          ),
      ],
    );

  /// The size variant of the spinner.
  final CorpoSpinnerSize size;

  /// The style variant of the spinner.
  final CorpoSpinnerStyle style;

  /// The color of the spinner.
  ///
  /// If null, uses the primary color from the theme.
  final Color? color;

  /// The stroke width for circular spinners.
  ///
  /// If null, uses a default width based on size.
  final double? strokeWidth;

  /// Optional label text to display below the spinner.
  final String? label;

  @override
  State<CorpoSpinner> createState() => _CorpoSpinnerState();
}

class _CorpoSpinnerState extends State<CorpoSpinner>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color effectiveColor =
        widget.color ??
        (isDark ? CorpoColors.primary400 : CorpoColors.primary500);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildSpinner(effectiveColor),
        if (widget.label != null) ...<Widget>[
          const SizedBox(height: CorpoSpacing.small),
          Text(
            widget.label!,
            style: CorpoTypography.labelMedium.copyWith(color: effectiveColor),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  /// Builds the spinner widget based on style.
  Widget _buildSpinner(Color color) {
    switch (widget.style) {
      case CorpoSpinnerStyle.circular:
        return _buildCircularSpinner(color);
      case CorpoSpinnerStyle.dots:
        return _buildDotsSpinner(color);
      case CorpoSpinnerStyle.linear:
        return _buildLinearSpinner(color);
    }
  }

  /// Builds a circular spinner.
  Widget _buildCircularSpinner(Color color) {
    final double size = _getSpinnerSize();
    final double strokeWidth = widget.strokeWidth ?? _getDefaultStrokeWidth();

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) => SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
    );
  }

  /// Builds a dots spinner.
  Widget _buildDotsSpinner(Color color) {
    final double dotSize = _getDotSize();

    return AnimatedBuilder(
      animation: _dotsController,
      builder: (BuildContext context, Widget? child) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(3, (int index) {
            final double delay = index * 0.3;
            final double animationValue = (_dotsController.value + delay) % 1.0;
            final double scale = _getDotScale(animationValue);

            return Container(
              margin: index < 2
                  ? const EdgeInsets.only(right: CorpoSpacing.extraSmall)
                  : EdgeInsets.zero,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
    );
  }

  /// Builds a linear spinner.
  Widget _buildLinearSpinner(Color color) {
    final double width = _getLinearWidth();
    final double height = _getLinearHeight();

    return SizedBox(
      width: width,
      height: height,
      child: LinearProgressIndicator(
        backgroundColor: color.withValues(alpha: 0.2),
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  /// Gets the spinner size in pixels.
  double _getSpinnerSize() {
    switch (widget.size) {
      case CorpoSpinnerSize.extraSmall:
        return 16;
      case CorpoSpinnerSize.small:
        return 20;
      case CorpoSpinnerSize.medium:
        return 24;
      case CorpoSpinnerSize.large:
        return 32;
      case CorpoSpinnerSize.extraLarge:
        return 48;
    }
  }

  /// Gets the default stroke width for circular spinners.
  double _getDefaultStrokeWidth() {
    switch (widget.size) {
      case CorpoSpinnerSize.extraSmall:
        return 2;
      case CorpoSpinnerSize.small:
        return 2.5;
      case CorpoSpinnerSize.medium:
        return 3;
      case CorpoSpinnerSize.large:
        return 3.5;
      case CorpoSpinnerSize.extraLarge:
        return 4;
    }
  }

  /// Gets the dot size for dots spinner.
  double _getDotSize() {
    switch (widget.size) {
      case CorpoSpinnerSize.extraSmall:
        return 4;
      case CorpoSpinnerSize.small:
        return 5;
      case CorpoSpinnerSize.medium:
        return 6;
      case CorpoSpinnerSize.large:
        return 8;
      case CorpoSpinnerSize.extraLarge:
        return 12;
    }
  }

  /// Gets the linear spinner width.
  double _getLinearWidth() {
    switch (widget.size) {
      case CorpoSpinnerSize.extraSmall:
        return 60;
      case CorpoSpinnerSize.small:
        return 80;
      case CorpoSpinnerSize.medium:
        return 100;
      case CorpoSpinnerSize.large:
        return 120;
      case CorpoSpinnerSize.extraLarge:
        return 160;
    }
  }

  /// Gets the linear spinner height.
  double _getLinearHeight() {
    switch (widget.size) {
      case CorpoSpinnerSize.extraSmall:
        return 2;
      case CorpoSpinnerSize.small:
        return 3;
      case CorpoSpinnerSize.medium:
        return 4;
      case CorpoSpinnerSize.large:
        return 5;
      case CorpoSpinnerSize.extraLarge:
        return 6;
    }
  }

  /// Calculates the scale for dots animation.
  double _getDotScale(double animationValue) {
    if (animationValue < 0.5) {
      return 0.5 + (animationValue * 1.0);
    } else {
      return 1.5 - (animationValue * 1.0);
    }
  }
}
