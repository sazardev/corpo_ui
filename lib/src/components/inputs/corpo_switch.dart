/// A comprehensive switch component for the Corpo UI design system.
///
/// CorpoSwitch provides consistent toggle input styling and behavior
/// across corporate applications, with support for labels, descriptions,
/// and various states including disabled and loading.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including semantic labels and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoSwitch(
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
///   label: 'Enable notifications',
/// )
///
/// CorpoSwitch(
///   value: isLoading,
///   onChanged: null, // Disabled
///   label: 'Feature flag',
///   description: 'Enable experimental features',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Size variants for different layout contexts.
enum CorpoSwitchSize {
  /// Small switch for compact layouts
  small,

  /// Medium switch for standard use (default)
  medium,

  /// Large switch for prominent toggles
  large,
}

/// A comprehensive switch widget following Corpo UI design principles.
///
/// This component provides consistent styling, accessibility features,
/// and visual feedback for toggle inputs. It supports labels, descriptions,
/// and various size configurations.
class CorpoSwitch extends StatelessWidget {
  /// Creates a Corpo UI switch.
  ///
  /// The [value] parameter determines the current state of the switch.
  /// The [onChanged] callback is called when the switch is toggled.
  /// If [onChanged] is null, the switch will be disabled.
  const CorpoSwitch({
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.size = CorpoSwitchSize.medium,
    this.autofocus = false,
    super.key,
  });

  /// The current value of the switch.
  final bool value;

  /// Called when the switch is toggled.
  ///
  /// If null, the switch will be disabled and will not respond to input.
  final ValueChanged<bool>? onChanged;

  /// Optional label text displayed next to the switch.
  final String? label;

  /// Optional description text displayed below the label.
  final String? description;

  /// Size of the switch.
  final CorpoSwitchSize size;

  /// Whether this switch should be focused initially.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final bool isEnabled = onChanged != null;

    if (label == null && description == null) {
      return _buildSwitch(context, isDark, isEnabled);
    }

    return _buildSwitchWithLabels(context, isDark, isEnabled);
  }

  /// Builds a standalone switch without labels.
  Widget _buildSwitch(BuildContext context, bool isDark, bool isEnabled) =>
      Transform.scale(
        scale: _getSwitchScale(),
        child: Switch(
          value: value,
          onChanged: onChanged,
          autofocus: autofocus,
          activeThumbColor: _getActiveColor(isDark, isEnabled),
          activeTrackColor: _getActiveTrackColor(isDark, isEnabled),
          inactiveThumbColor: _getInactiveThumbColor(isDark, isEnabled),
          inactiveTrackColor: _getInactiveTrackColor(isDark, isEnabled),
          trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) => _getTrackOutlineColor(isDark, states),
          ),
        ),
      );

  /// Builds a switch with labels and descriptions.
  Widget _buildSwitchWithLabels(
    BuildContext context,
    bool isDark,
    bool isEnabled,
  ) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (label != null) _buildLabel(isDark, isEnabled),
            if (description != null) _buildDescription(isDark, isEnabled),
          ],
        ),
      ),
      const SizedBox(width: CorpoSpacing.medium),
      _buildSwitch(context, isDark, isEnabled),
    ],
  );

  /// Builds the switch label.
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

  /// Builds the switch description.
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

  /// Gets the active thumb color.
  Color _getActiveColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral300;
    }
    return CorpoColors.neutralWhite;
  }

  /// Gets the active track color.
  Color _getActiveTrackColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral700 : CorpoColors.neutral200;
    }
    return CorpoColors.primary500;
  }

  /// Gets the inactive thumb color.
  Color _getInactiveThumbColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral300;
    }
    return CorpoColors.neutralWhite;
  }

  /// Gets the inactive track color.
  Color _getInactiveTrackColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral700 : CorpoColors.neutral200;
    }
    return isDark ? CorpoColors.neutral600 : CorpoColors.neutral300;
  }

  /// Gets the track outline color based on state.
  Color? _getTrackOutlineColor(bool isDark, Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return isDark ? CorpoColors.neutral700 : CorpoColors.neutral200;
    }

    if (states.contains(WidgetState.focused)) {
      return CorpoColors.primary500;
    }

    if (states.contains(WidgetState.selected)) {
      return CorpoColors.primary600;
    }

    return isDark ? CorpoColors.neutral500 : CorpoColors.neutral400;
  }

  /// Gets the switch scale based on size.
  double _getSwitchScale() {
    switch (size) {
      case CorpoSwitchSize.small:
        return 0.8;
      case CorpoSwitchSize.medium:
        return 1;
      case CorpoSwitchSize.large:
        return 1.2;
    }
  }

  /// Gets the label font size based on switch size.
  double _getLabelFontSize() {
    switch (size) {
      case CorpoSwitchSize.small:
        return CorpoFontSize.small;
      case CorpoSwitchSize.medium:
        return CorpoFontSize.medium;
      case CorpoSwitchSize.large:
        return CorpoFontSize.large;
    }
  }

  /// Gets the description font size based on switch size.
  double _getDescriptionFontSize() {
    switch (size) {
      case CorpoSwitchSize.small:
        return CorpoFontSize.extraSmall;
      case CorpoSwitchSize.medium:
        return CorpoFontSize.small;
      case CorpoSwitchSize.large:
        return CorpoFontSize.medium;
    }
  }
}
