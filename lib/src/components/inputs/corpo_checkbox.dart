/// A comprehensive checkbox component for the Corpo UI design system.
///
/// CorpoCheckbox provides consistent checkbox styling and behavior
/// across corporate applications, with support for labels, descriptions,
/// tristate support, and various visual states.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including semantic labels and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoCheckbox(
///   value: isChecked,
///   onChanged: (value) => setState(() => isChecked = value ?? false),
///   label: 'I agree to the terms',
/// )
///
/// CorpoCheckbox(
///   value: null, // Indeterminate state
///   tristate: true,
///   onChanged: (value) => handleTristate(value),
///   label: 'Select all items',
///   description: 'Choose all available options',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Size variants for different layout contexts.
enum CorpoCheckboxSize {
  /// Small checkbox for compact layouts
  small,

  /// Medium checkbox for standard use (default)
  medium,

  /// Large checkbox for prominent selections
  large,
}

/// A comprehensive checkbox widget following Corpo UI design principles.
///
/// This component provides consistent styling, accessibility features,
/// and visual feedback for selection inputs. It supports labels, descriptions,
/// tristate mode, and various size configurations.
class CorpoCheckbox extends StatelessWidget {
  /// Creates a Corpo UI checkbox.
  ///
  /// The [value] parameter determines the current state of the checkbox.
  /// The [onChanged] callback is called when the checkbox is toggled.
  /// If [onChanged] is null, the checkbox will be disabled.
  const CorpoCheckbox({
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.size = CorpoCheckboxSize.medium,
    this.tristate = false,
    this.autofocus = false,
    super.key,
  });

  /// The current value of the checkbox.
  ///
  /// When [tristate] is true, this can be true, false, or null (indeterminate).
  /// When [tristate] is false, this should be true or false.
  final bool? value;

  /// Called when the checkbox is toggled.
  ///
  /// If null, the checkbox will be disabled and will not respond to input.
  final ValueChanged<bool?>? onChanged;

  /// Optional label text displayed next to the checkbox.
  final String? label;

  /// Optional description text displayed below the label.
  final String? description;

  /// Size of the checkbox.
  final CorpoCheckboxSize size;

  /// Whether the checkbox supports three states (true, false, null).
  final bool tristate;

  /// Whether this checkbox should be focused initially.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final bool isEnabled = onChanged != null;

    if (label == null && description == null) {
      return _buildCheckbox(context, isDark, isEnabled);
    }

    return _buildCheckboxWithLabels(context, isDark, isEnabled);
  }

  /// Builds a standalone checkbox without labels.
  Widget _buildCheckbox(BuildContext context, bool isDark, bool isEnabled) =>
      Transform.scale(
        scale: _getCheckboxScale(),
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          tristate: tristate,
          autofocus: autofocus,
          activeColor: _getActiveColor(isDark, isEnabled),
          checkColor: _getCheckColor(isDark, isEnabled),
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) => _getFillColor(isDark, states),
          ),
          side: BorderSide(
            color: _getBorderColor(isDark, isEnabled),
            width: _getBorderWidth(),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      );

  /// Builds a checkbox with labels and descriptions.
  Widget _buildCheckboxWithLabels(
    BuildContext context,
    bool isDark,
    bool isEnabled,
  ) => InkWell(
    onTap: isEnabled
        ? () {
            if (tristate) {
              _handleTristateToggle();
            } else {
              onChanged?.call(!(value ?? false));
            }
          }
        : null,
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.all(CorpoSpacing.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCheckbox(context, isDark, isEnabled),
          const SizedBox(width: CorpoSpacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (label != null) _buildLabel(isDark, isEnabled),
                if (description != null) _buildDescription(isDark, isEnabled),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  /// Builds the checkbox label.
  Widget _buildLabel(bool isDark, bool isEnabled) {
    final Color labelColor = isEnabled
        ? isDark
              ? CorpoColors.neutral200
              : CorpoColors.neutral800
        : isDark
        ? CorpoColors.neutral600
        : CorpoColors.neutral400;

    return Text(
      label!,
      style: CorpoTypography.bodyMedium.copyWith(
        color: labelColor,
        fontWeight: CorpoFontWeight.medium,
        fontSize: _getLabelFontSize(),
      ),
    );
  }

  /// Builds the checkbox description.
  Widget _buildDescription(bool isDark, bool isEnabled) {
    final Color descriptionColor = isEnabled
        ? isDark
              ? CorpoColors.neutral400
              : CorpoColors.neutral600
        : isDark
        ? CorpoColors.neutral700
        : CorpoColors.neutral300;

    return Padding(
      padding: const EdgeInsets.only(top: CorpoSpacing.extraSmall / 2),
      child: Text(
        description!,
        style: CorpoTypography.bodySmall.copyWith(
          color: descriptionColor,
          fontSize: _getDescriptionFontSize(),
        ),
      ),
    );
  }

  /// Handles tristate toggle logic.
  void _handleTristateToggle() {
    if (value == null) {
      onChanged?.call(true);
    } else if (value == true) {
      onChanged?.call(false);
    } else {
      onChanged?.call(null);
    }
  }

  /// Gets the active color for the checkbox.
  Color _getActiveColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral300;
    }
    return CorpoColors.primary500;
  }

  /// Gets the check mark color.
  Color _getCheckColor(bool isDark, bool isEnabled) => CorpoColors.neutralWhite;

  /// Gets the fill color based on state.
  Color _getFillColor(bool isDark, Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return isDark ? CorpoColors.neutral700 : CorpoColors.neutral200;
    }

    if (states.contains(WidgetState.selected)) {
      if (states.contains(WidgetState.pressed)) {
        return CorpoColors.primary600;
      }
      if (states.contains(WidgetState.hovered)) {
        return CorpoColors.primary400;
      }
      return CorpoColors.primary500;
    }

    if (states.contains(WidgetState.pressed)) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral200;
    }

    if (states.contains(WidgetState.hovered)) {
      return isDark ? CorpoColors.neutral700 : CorpoColors.neutral100;
    }

    return Colors.transparent;
  }

  /// Gets the border color.
  Color _getBorderColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral300;
    }

    if (value == true) {
      return CorpoColors.primary500;
    }

    return isDark ? CorpoColors.neutral500 : CorpoColors.neutral400;
  }

  /// Gets the border width.
  double _getBorderWidth() {
    switch (size) {
      case CorpoCheckboxSize.small:
        return 1.5;
      case CorpoCheckboxSize.medium:
        return 2;
      case CorpoCheckboxSize.large:
        return 2.5;
    }
  }

  /// Gets the checkbox scale based on size.
  double _getCheckboxScale() {
    switch (size) {
      case CorpoCheckboxSize.small:
        return 0.8;
      case CorpoCheckboxSize.medium:
        return 1;
      case CorpoCheckboxSize.large:
        return 1.2;
    }
  }

  /// Gets the label font size based on checkbox size.
  double _getLabelFontSize() {
    switch (size) {
      case CorpoCheckboxSize.small:
        return CorpoFontSize.small;
      case CorpoCheckboxSize.medium:
        return CorpoFontSize.medium;
      case CorpoCheckboxSize.large:
        return CorpoFontSize.large;
    }
  }

  /// Gets the description font size based on checkbox size.
  double _getDescriptionFontSize() {
    switch (size) {
      case CorpoCheckboxSize.small:
        return CorpoFontSize.extraSmall;
      case CorpoCheckboxSize.medium:
        return CorpoFontSize.small;
      case CorpoCheckboxSize.large:
        return CorpoFontSize.medium;
    }
  }
}
