/// A comprehensive slider component for the Corpo UI design system.
///
/// CorpoSlider provides consistent slider styling and behavior across
/// corporate applications, with support for ranges, labels, validation,
/// and various visual states.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including screen reader support and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoSlider(
///   value: currentValue,
///   onChanged: (value) => setState(() => currentValue = value),
///   min: 0,
///   max: 100,
///   label: 'Volume',
/// )
///
/// CorpoSlider.range(
///   values: RangeValues(20, 80),
///   onChanged: (values) => setState(() => rangeValues = values),
///   min: 0,
///   max: 100,
///   label: 'Price Range',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Slider size variants for different contexts.
enum CorpoSliderSize {
  /// Small slider for compact layouts
  small,

  /// Medium slider for standard use (default)
  medium,

  /// Large slider for prominent controls
  large,
}

/// A comprehensive slider widget following Corpo UI design principles.
///
/// This component provides consistent styling and accessibility features
/// for value selection inputs. It supports single values, ranges,
/// and various size configurations.
class CorpoSlider extends StatelessWidget {
  /// Creates a single-value Corpo UI slider.
  const CorpoSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.helperText,
    this.size = CorpoSliderSize.medium,
    this.showLabels = false,
    this.semanticLabel,
    super.key,
  }) : values = null,
       onRangeChanged = null;

  /// Creates a range slider.
  const CorpoSlider.range({
    required this.values,
    required this.onRangeChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.helperText,
    this.size = CorpoSliderSize.medium,
    this.showLabels = false,
    this.semanticLabel,
    super.key,
  }) : value = null,
       onChanged = null;

  /// The current value for single-value sliders.
  final double? value;

  /// Called when the single value changes.
  final ValueChanged<double>? onChanged;

  /// The current values for range sliders.
  final RangeValues? values;

  /// Called when the range values change.
  final ValueChanged<RangeValues>? onRangeChanged;

  /// The minimum value of the slider.
  final double min;

  /// The maximum value of the slider.
  final double max;

  /// The number of discrete divisions.
  final int? divisions;

  /// Optional label for the slider.
  final String? label;

  /// Helper text displayed below the slider.
  final String? helperText;

  /// The size variant for the slider.
  final CorpoSliderSize size;

  /// Whether to show min/max labels.
  final bool showLabels;

  /// A semantic description of the slider.
  final String? semanticLabel;

  /// Whether this is a range slider.
  bool get isRange => values != null && onRangeChanged != null;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = isRange ? onRangeChanged != null : onChanged != null;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(
            label!,
            style: _getLabelStyle().copyWith(
              color: _getLabelColor(isDark, isEnabled),
            ),
          ),
          const SizedBox(height: CorpoSpacing.small),
        ],
        _buildSlider(context, isDark, isEnabled),
        if (showLabels) ...<Widget>[
          const SizedBox(height: CorpoSpacing.extraSmall),
          _buildValueLabels(isDark),
        ],
        if (helperText != null) ...<Widget>[
          const SizedBox(height: CorpoSpacing.extraSmall),
          Text(
            helperText!,
            style: CorpoTypography.caption.copyWith(
              color: isDark ? CorpoColors.neutral400 : CorpoColors.neutral600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSlider(BuildContext context, bool isDark, bool isEnabled) {
    final SliderThemeData sliderTheme = SliderTheme.of(context).copyWith(
      activeTrackColor: isEnabled
          ? CorpoColors.primary500
          : _getDisabledColor(isDark),
      inactiveTrackColor: isDark
          ? CorpoColors.neutral700
          : CorpoColors.neutral300,
      thumbColor: isEnabled
          ? CorpoColors.primary500
          : _getDisabledColor(isDark),
      overlayColor: CorpoColors.primary100,
      trackHeight: _getTrackHeight(),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: _getThumbRadius()),
    );

    return SliderTheme(
      data: sliderTheme,
      child: isRange
          ? RangeSlider(
              values: values!,
              onChanged: isEnabled ? onRangeChanged : null,
              min: min,
              max: max,
              divisions: divisions,
              labels: showLabels
                  ? RangeLabels(
                      values!.start.round().toString(),
                      values!.end.round().toString(),
                    )
                  : null,
            )
          : Slider(
              value: value!,
              onChanged: isEnabled ? onChanged : null,
              min: min,
              max: max,
              divisions: divisions,
              label: showLabels ? value!.round().toString() : null,
            ),
    );
  }

  Widget _buildValueLabels(bool isDark) {
    final Color labelColor = isDark
        ? CorpoColors.neutral400
        : CorpoColors.neutral600;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          min.round().toString(),
          style: CorpoTypography.caption.copyWith(color: labelColor),
        ),
        Text(
          max.round().toString(),
          style: CorpoTypography.caption.copyWith(color: labelColor),
        ),
      ],
    );
  }

  /// Gets the track height based on size variant.
  double _getTrackHeight() {
    switch (size) {
      case CorpoSliderSize.small:
        return 2.0;
      case CorpoSliderSize.medium:
        return 4.0;
      case CorpoSliderSize.large:
        return 6.0;
    }
  }

  /// Gets the thumb radius based on size variant.
  double _getThumbRadius() {
    switch (size) {
      case CorpoSliderSize.small:
        return 8.0;
      case CorpoSliderSize.medium:
        return 10.0;
      case CorpoSliderSize.large:
        return 12.0;
    }
  }

  /// Gets the label text style.
  TextStyle _getLabelStyle() {
    return CorpoTypography.labelMedium;
  }

  /// Gets the label color based on state.
  Color _getLabelColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
    }
    return isDark ? CorpoColors.neutral200 : CorpoColors.neutral700;
  }

  /// Gets the disabled color.
  Color _getDisabledColor(bool isDark) {
    return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
  }
}
