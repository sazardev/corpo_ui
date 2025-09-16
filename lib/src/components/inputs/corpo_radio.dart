/// A comprehensive radio button component for the Corpo UI design system.
///
/// CorpoRadio provides consistent radio button styling and behavior
/// across corporate applications, with support for labels, descriptions,
/// grouping, and various visual states.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including semantic labels and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoRadio<String>(
///   value: 'option1',
///   groupValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   label: 'Option 1',
/// )
///
/// CorpoRadio<String>(
///   value: 'option2',
///   groupValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   label: 'Option 2',
///   description: 'Additional information about this option',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Size variants for different layout contexts.
enum CorpoRadioSize {
  /// Small radio for compact layouts
  small,

  /// Medium radio for standard use (default)
  medium,

  /// Large radio for prominent selections
  large,
}

/// A comprehensive radio button widget following Corpo UI design principles.
///
/// This component provides consistent styling, accessibility features,
/// and visual feedback for single selection inputs. It supports labels,
/// descriptions, and various size configurations.
class CorpoRadio<T> extends StatelessWidget {
  /// Creates a Corpo UI radio button.
  ///
  /// The [value] and [groupValue] parameters are required to determine
  /// the selection state. [onChanged] is called when the radio is selected.
  const CorpoRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.description,
    this.size = CorpoRadioSize.medium,
    this.semanticLabel,
    super.key,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for the radio group.
  final T? groupValue;

  /// Called when the radio button is selected.
  ///
  /// If null, the radio button will be disabled.
  final ValueChanged<T?>? onChanged;

  /// Optional label text for the radio button.
  final String? label;

  /// Optional description text providing additional context.
  final String? description;

  /// The size variant for the radio button.
  final CorpoRadioSize size;

  /// A semantic description of the radio button.
  ///
  /// Used by screen readers and other assistive technologies.
  final String? semanticLabel;

  /// Whether this radio button is currently selected.
  bool get isSelected => value == groupValue;

  /// Whether this radio button is enabled.
  bool get isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final double radioSize = _getRadioSize(size);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Widget radioWidget = SizedBox(
      width: radioSize,
      height: radioSize,
      child: Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        activeColor: isEnabled
            ? tokens.primaryColor
            : _getDisabledColor(isDark, tokens),
        focusColor: tokens.primaryColor.withOpacity(0.1),
        hoverColor: tokens.primaryColor.withOpacity(0.05),
      ),
    );

    // If there's no label, return just the radio
    if (label == null && description == null) {
      return semanticLabel != null
          ? Semantics(label: semanticLabel, child: radioWidget)
          : radioWidget;
    }

    // Build the complete radio with label and optional description
    return GestureDetector(
      onTap: isEnabled ? () => onChanged?.call(value) : null,
      child: Semantics(
        label: semanticLabel ?? label,
        selected: isSelected,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            radioWidget,
            SizedBox(width: tokens.spacing2x),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (label != null)
                    Text(
                      label!,
                      style: _getLabelStyle(size, tokens).copyWith(
                        color: _getLabelColor(isDark, isEnabled, tokens),
                      ),
                    ),
                  if (description != null) ...<Widget>[
                    SizedBox(height: tokens.spacing1x),
                    Text(
                      description!,
                      style: _getDescriptionStyle(size, tokens).copyWith(
                        color: _getDescriptionColor(isDark, isEnabled, tokens),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gets the radio button size for the given size variant.
  double _getRadioSize(CorpoRadioSize size) {
    switch (size) {
      case CorpoRadioSize.small:
        return 16;
      case CorpoRadioSize.medium:
        return 20;
      case CorpoRadioSize.large:
        return 24;
    }
  }

  /// Gets the label text style for the given size variant.
  TextStyle _getLabelStyle(CorpoRadioSize size, CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoRadioSize.small:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontWeight: FontWeight.w500,
        );
      case CorpoRadioSize.medium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontWeight: FontWeight.w500,
        );
      case CorpoRadioSize.large:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontWeight: FontWeight.w500,
        );
    }
  }

  /// Gets the description text style for the given size variant.
  TextStyle _getDescriptionStyle(
    CorpoRadioSize size,
    CorpoDesignTokens tokens,
  ) {
    switch (size) {
      case CorpoRadioSize.small:
        return TextStyle(fontSize: tokens.fontSizeSmall * 0.85);
      case CorpoRadioSize.medium:
      case CorpoRadioSize.large:
        return TextStyle(fontSize: tokens.fontSizeSmall);
    }
  }

  /// Gets the label color based on theme and enabled state.
  Color _getLabelColor(bool isDark, bool isEnabled, CorpoDesignTokens tokens) {
    if (!isEnabled) {
      return tokens.textSecondary.withOpacity(0.6);
    }
    return tokens.textPrimary;
  }

  /// Gets the description color based on theme and enabled state.
  Color _getDescriptionColor(
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.textSecondary.withOpacity(0.5);
    }
    return tokens.textSecondary;
  }

  /// Gets the disabled color for the radio button.
  Color _getDisabledColor(bool isDark, CorpoDesignTokens tokens) =>
      tokens.textSecondary.withOpacity(0.4);
}
