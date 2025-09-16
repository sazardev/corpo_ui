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

import '../../design_tokens.dart';

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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final bool isEnabled = onChanged != null;

    if (label == null && description == null) {
      return _buildCheckbox(context, isDark, isEnabled, tokens);
    }

    return _buildCheckboxWithLabels(context, isDark, isEnabled, tokens);
  }

  /// Builds a standalone checkbox without labels.
  Widget _buildCheckbox(
    BuildContext context,
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) => Transform.scale(
    scale: _getCheckboxScale(),
    child: Checkbox(
      value: value,
      onChanged: onChanged,
      tristate: tristate,
      autofocus: autofocus,
      activeColor: _getActiveColor(isDark, isEnabled, tokens),
      checkColor: _getCheckColor(isDark, isEnabled, tokens),
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) => _getFillColor(isDark, states, tokens),
      ),
      side: BorderSide(
        color: _getBorderColor(isDark, isEnabled, tokens),
        width: _getBorderWidth(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
      ),
    ),
  );

  /// Builds a checkbox with labels and descriptions.
  Widget _buildCheckboxWithLabels(
    BuildContext context,
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
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
    borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
    child: Padding(
      padding: EdgeInsets.all(tokens.spacing2x),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCheckbox(context, isDark, isEnabled, tokens),
          SizedBox(width: tokens.spacing3x),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (label != null) _buildLabel(isDark, isEnabled, tokens),
                if (description != null)
                  _buildDescription(isDark, isEnabled, tokens),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  /// Builds the checkbox label.
  Widget _buildLabel(bool isDark, bool isEnabled, CorpoDesignTokens tokens) {
    final Color labelColor = isEnabled
        ? tokens.textPrimary
        : tokens.textSecondary;

    return Text(
      label!,
      style: TextStyle(
        color: labelColor,
        fontWeight: FontWeight.w500,
        fontSize: tokens.baseFontSize,
      ),
    );
  }

  /// Builds the checkbox description.
  Widget _buildDescription(
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    final Color descriptionColor = isEnabled
        ? tokens.textSecondary
        : tokens.textSecondary.withOpacity(0.6);

    return Padding(
      padding: EdgeInsets.only(top: tokens.spacing1x / 2),
      child: Text(
        description!,
        style: TextStyle(
          color: descriptionColor,
          fontSize: tokens.fontSizeSmall,
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
  Color _getActiveColor(bool isDark, bool isEnabled, CorpoDesignTokens tokens) {
    if (!isEnabled) {
      return isDark ? Colors.grey[600]! : Colors.grey[400]!;
    }
    return tokens.primaryColor;
  }

  /// Gets the check mark color.
  Color _getCheckColor(bool isDark, bool isEnabled, CorpoDesignTokens tokens) =>
      Colors.white;

  /// Gets the fill color based on state.
  Color _getFillColor(
    bool isDark,
    Set<WidgetState> states,
    CorpoDesignTokens tokens,
  ) {
    if (states.contains(WidgetState.disabled)) {
      return isDark ? Colors.grey[700]! : Colors.grey[300]!;
    }

    if (states.contains(WidgetState.selected)) {
      if (states.contains(WidgetState.pressed)) {
        return tokens.primaryColor.withOpacity(0.8);
      }
      if (states.contains(WidgetState.hovered)) {
        return tokens.primaryColor.withOpacity(0.9);
      }
      return tokens.primaryColor;
    }

    if (states.contains(WidgetState.pressed)) {
      return isDark ? Colors.grey[600]! : Colors.grey[300]!;
    }

    if (states.contains(WidgetState.hovered)) {
      return isDark ? Colors.grey[700]! : Colors.grey[200]!;
    }

    return Colors.transparent;
  }

  /// Gets the border color.
  Color _getBorderColor(bool isDark, bool isEnabled, CorpoDesignTokens tokens) {
    if (!isEnabled) {
      return isDark ? Colors.grey[600]! : Colors.grey[400]!;
    }

    if (value == true) {
      return tokens.primaryColor;
    }

    return isDark ? Colors.grey[500]! : Colors.grey[400]!;
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
}
