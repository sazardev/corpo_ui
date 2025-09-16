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

import '../../design_tokens.dart';

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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final bool isEnabled = onChanged != null;

    if (label == null && description == null) {
      return _buildSwitch(context, isDark, isEnabled, tokens);
    }

    return _buildSwitchWithLabels(context, isDark, isEnabled, tokens);
  }

  /// Builds a standalone switch without labels.
  Widget _buildSwitch(
    BuildContext context,
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) => Transform.scale(
    scale: _getSwitchScale(),
    child: Switch(
      value: value,
      onChanged: onChanged,
      autofocus: autofocus,
      activeThumbColor: _getActiveColor(isDark, isEnabled, tokens),
      activeTrackColor: _getActiveTrackColor(isDark, isEnabled, tokens),
      inactiveThumbColor: _getInactiveThumbColor(isDark, isEnabled, tokens),
      inactiveTrackColor: _getInactiveTrackColor(isDark, isEnabled, tokens),
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) =>
            _getTrackOutlineColor(isDark, states, tokens),
      ),
    ),
  );

  /// Builds a switch with labels and descriptions.
  Widget _buildSwitchWithLabels(
    BuildContext context,
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
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
      SizedBox(width: tokens.spacing3x),
      _buildSwitch(context, isDark, isEnabled, tokens),
    ],
  );

  /// Builds the switch label.
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

  /// Builds the switch description.
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

  /// Gets the active thumb color.
  Color _getActiveColor(bool isDark, bool isEnabled, CorpoDesignTokens tokens) {
    if (!isEnabled) {
      return tokens.textSecondary.withOpacity(0.4);
    }
    return Colors.white;
  }

  /// Gets the active track color.
  Color _getActiveTrackColor(
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.surfaceColor.withOpacity(0.3);
    }
    return tokens.primaryColor;
  }

  /// Gets the inactive thumb color.
  Color _getInactiveThumbColor(
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.textSecondary.withOpacity(0.4);
    }
    return Colors.white;
  }

  /// Gets the inactive track color.
  Color _getInactiveTrackColor(
    bool isDark,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.surfaceColor.withOpacity(0.3);
    }
    return tokens.textSecondary.withOpacity(0.3);
  }

  /// Gets the track outline color based on state.
  Color? _getTrackOutlineColor(
    bool isDark,
    Set<WidgetState> states,
    CorpoDesignTokens tokens,
  ) {
    if (states.contains(WidgetState.disabled)) {
      return tokens.surfaceColor.withOpacity(0.3);
    }

    if (states.contains(WidgetState.focused)) {
      return tokens.primaryColor;
    }

    if (states.contains(WidgetState.selected)) {
      return tokens.primaryColor.withOpacity(0.8);
    }

    return tokens.textSecondary.withOpacity(0.5);
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
}
