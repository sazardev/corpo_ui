/// A comprehensive progress bar component for the Corpo UI design system.
///
/// CorpoProgressBar provides consistent progress indication across
/// corporate applications, with support for determinate and indeterminate
/// states, different styles, and accessibility features.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive progress indication
/// for long-running operations and loading states.
///
/// Example usage:
/// ```dart
/// CorpoProgressBar(
///   value: 0.7,
///   label: 'Loading...',
/// )
///
/// CorpoProgressBar.linear(
///   value: 0.45,
///   showLabel: true,
///   height: CorpoProgressBarHeight.thick,
/// )
///
/// CorpoProgressBar.indeterminate(
///   label: 'Processing...',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Progress bar height variants for different visual emphasis.
///
/// Determines the thickness of the progress bar indicator.
enum CorpoProgressBarHeight {
  /// Thin progress bar for subtle indication
  thin,

  /// Medium progress bar for standard use (default)
  medium,

  /// Thick progress bar for prominent display
  thick,
}

/// Progress bar style variants for different use cases.
enum CorpoProgressBarStyle {
  /// Linear progress bar with rounded corners
  linear,

  /// Stepped progress bar with discrete segments
  stepped,
}

/// A comprehensive progress bar widget following Corpo UI design principles.
///
/// This component provides consistent progress indication with support
/// for different styles, colors, and accessibility features. It handles
/// both determinate and indeterminate progress states.
class CorpoProgressBar extends StatelessWidget {
  /// Creates a Corpo UI progress bar.
  ///
  /// The [value] parameter determines the progress (0.0 to 1.0).
  /// If null, the progress bar will be indeterminate.
  const CorpoProgressBar({
    super.key,
    this.value,
    this.height = CorpoProgressBarHeight.medium,
    this.style = CorpoProgressBarStyle.linear,
    this.color,
    this.backgroundColor,
    this.label,
    this.showLabel = false,
    this.showPercentage = false,
  });

  /// Convenience constructor for linear progress bars.
  const CorpoProgressBar.linear({
    super.key,
    this.value,
    this.height = CorpoProgressBarHeight.medium,
    this.color,
    this.backgroundColor,
    this.label,
    this.showLabel = false,
    this.showPercentage = false,
  }) : style = CorpoProgressBarStyle.linear;

  /// Convenience constructor for stepped progress bars.
  const CorpoProgressBar.stepped({
    super.key,
    this.value,
    this.height = CorpoProgressBarHeight.medium,
    this.color,
    this.backgroundColor,
    this.label,
    this.showLabel = false,
    this.showPercentage = false,
  }) : style = CorpoProgressBarStyle.stepped;

  /// Convenience constructor for indeterminate progress bars.
  const CorpoProgressBar.indeterminate({
    super.key,
    this.height = CorpoProgressBarHeight.medium,
    this.style = CorpoProgressBarStyle.linear,
    this.color,
    this.backgroundColor,
    this.label,
    this.showLabel = true,
  }) : value = null,
       showPercentage = false;

  /// The progress value between 0.0 and 1.0.
  ///
  /// If null, the progress bar will display an indeterminate animation.
  final double? value;

  /// The height variant of the progress bar.
  final CorpoProgressBarHeight height;

  /// The style variant of the progress bar.
  final CorpoProgressBarStyle style;

  /// The color of the progress indicator.
  ///
  /// If null, uses the primary color from the theme.
  final Color? color;

  /// The background color of the progress track.
  ///
  /// If null, uses a neutral color based on the theme.
  final Color? backgroundColor;

  /// Optional label text to display above the progress bar.
  final String? label;

  /// Whether to show the label text.
  final bool showLabel;

  /// Whether to show the percentage next to the progress bar.
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color effectiveColor = color ?? tokens.primaryColor;
    final Color effectiveBackgroundColor =
        backgroundColor ?? tokens.textSecondary.withOpacity(0.2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showLabel && label != null) ...<Widget>[
          _buildLabel(tokens),
          SizedBox(height: tokens.spacing1x),
        ],
        Row(
          children: <Widget>[
            Expanded(
              child: _buildProgressIndicator(
                effectiveColor,
                effectiveBackgroundColor,
                tokens,
              ),
            ),
            if (showPercentage && value != null) ...<Widget>[
              SizedBox(width: tokens.spacing2x),
              _buildPercentageText(tokens),
            ],
          ],
        ),
      ],
    );
  }

  /// Builds the label widget.
  Widget _buildLabel(CorpoDesignTokens tokens) => Text(
    label!,
    style: TextStyle(
      fontSize: tokens.baseFontSize,
      fontFamily: tokens.fontFamily,
      color: tokens.textPrimary,
      fontWeight: FontWeight.w500,
    ),
  );

  /// Builds the percentage text widget.
  Widget _buildPercentageText(CorpoDesignTokens tokens) {
    final int percentage = ((value ?? 0) * 100).round();
    return Text(
      '$percentage%',
      style: TextStyle(
        fontSize: tokens.fontSizeSmall,
        fontFamily: tokens.fontFamily,
        color: tokens.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Builds the main progress indicator based on style.
  Widget _buildProgressIndicator(
    Color progressColor,
    Color trackColor,
    CorpoDesignTokens tokens,
  ) {
    switch (style) {
      case CorpoProgressBarStyle.linear:
        return _buildLinearProgress(progressColor, trackColor, tokens);
      case CorpoProgressBarStyle.stepped:
        return _buildSteppedProgress(progressColor, trackColor, tokens);
    }
  }

  /// Builds a linear progress indicator.
  Widget _buildLinearProgress(
    Color progressColor,
    Color trackColor,
    CorpoDesignTokens tokens,
  ) {
    final double barHeight = _getBarHeight(tokens);
    final BorderRadius borderRadius = BorderRadius.circular(barHeight / 2);

    return Container(
      height: barHeight,
      decoration: BoxDecoration(color: trackColor, borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          minHeight: barHeight,
        ),
      ),
    );
  }

  /// Builds a stepped progress indicator.
  Widget _buildSteppedProgress(
    Color progressColor,
    Color trackColor,
    CorpoDesignTokens tokens,
  ) {
    const int totalSteps = 10;
    final int completedSteps = value != null
        ? (value! * totalSteps).round()
        : 0;

    return Row(
      children: List<Widget>.generate(totalSteps, (int index) {
        final bool isCompleted = index < completedSteps;
        return Expanded(
          child: Container(
            height: _getBarHeight(tokens),
            margin: index < totalSteps - 1
                ? EdgeInsets.only(right: tokens.spacing1x / 2)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: isCompleted ? progressColor : trackColor,
              borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
            ),
          ),
        );
      }),
    );
  }

  /// Gets the height of the progress bar in pixels.
  double _getBarHeight(CorpoDesignTokens tokens) {
    switch (height) {
      case CorpoProgressBarHeight.thin:
        return tokens.spacing1x; // 4px
      case CorpoProgressBarHeight.medium:
        return tokens.spacing2x; // 8px
      case CorpoProgressBarHeight.thick:
        return tokens.spacing3x; // 12px
    }
  }
}
