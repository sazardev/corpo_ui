/// A specialized icon button component for the Corpo UI design system.
///
/// CorpoIconButton provides consistent icon-only button styling and behavior
/// across corporate applications, with support for different variants,
/// sizes, and accessibility features.
///
/// The component follows corporate design principles with clear visual
/// hierarchy, professional styling, and comprehensive interaction states
/// including hover, focus, pressed, and disabled.
///
/// Example usage:
/// ```dart
/// CorpoIconButton(
///   icon: Icons.edit,
///   onPressed: () => print('Edit action'),
/// )
///
/// CorpoIconButton.secondary(
///   icon: Icons.delete,
///   onPressed: () => print('Delete action'),
/// )
///
/// CorpoIconButton.small(
///   icon: Icons.close,
///   onPressed: () => Navigator.pop(context),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';

/// Icon button variants for different use cases.
enum CorpoIconButtonVariant {
  /// Primary icon button for main actions
  primary,

  /// Secondary icon button for secondary actions
  secondary,

  /// Tertiary icon button for minimal actions
  tertiary,

  /// Danger icon button for destructive actions
  danger,
}

/// Icon button sizes for different contexts.
enum CorpoIconButtonSize {
  /// Small icon button (32x32)
  small,

  /// Medium icon button (40x40)
  medium,

  /// Large icon button (48x48)
  large,
}

/// A specialized icon button widget following Corpo UI design principles.
///
/// This component provides consistent styling, behavior, and accessibility
/// features for icon-only buttons. It supports different variants, sizes,
/// and interaction states.
class CorpoIconButton extends StatelessWidget {
  /// Creates a Corpo UI icon button.
  const CorpoIconButton({
    required this.icon,
    required this.onPressed,
    this.variant = CorpoIconButtonVariant.primary,
    this.size = CorpoIconButtonSize.medium,
    this.color,
    this.tooltip,
    this.semanticLabel,
    super.key,
  });

  /// Creates a secondary icon button.
  const CorpoIconButton.secondary({
    required this.icon,
    required this.onPressed,
    this.size = CorpoIconButtonSize.medium,
    this.color,
    this.tooltip,
    this.semanticLabel,
    super.key,
  }) : variant = CorpoIconButtonVariant.secondary;

  /// Creates a tertiary icon button.
  const CorpoIconButton.tertiary({
    required this.icon,
    required this.onPressed,
    this.size = CorpoIconButtonSize.medium,
    this.color,
    this.tooltip,
    this.semanticLabel,
    super.key,
  }) : variant = CorpoIconButtonVariant.tertiary;

  /// Creates a danger icon button.
  const CorpoIconButton.danger({
    required this.icon,
    required this.onPressed,
    this.size = CorpoIconButtonSize.medium,
    this.color,
    this.tooltip,
    this.semanticLabel,
    super.key,
  }) : variant = CorpoIconButtonVariant.danger;

  /// Creates a small icon button.
  const CorpoIconButton.small({
    required this.icon,
    required this.onPressed,
    this.variant = CorpoIconButtonVariant.primary,
    this.color,
    this.tooltip,
    this.semanticLabel,
    super.key,
  }) : size = CorpoIconButtonSize.small;

  /// Creates a large icon button.
  const CorpoIconButton.large({
    required this.icon,
    required this.onPressed,
    this.variant = CorpoIconButtonVariant.primary,
    this.color,
    this.tooltip,
    this.semanticLabel,
    super.key,
  }) : size = CorpoIconButtonSize.large;

  /// The icon to display in the button.
  final IconData icon;

  /// Called when the button is pressed.
  ///
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The visual variant of the button.
  final CorpoIconButtonVariant variant;

  /// The size of the button.
  final CorpoIconButtonSize size;

  /// The color to use for the icon.
  ///
  /// If null, the appropriate color for the variant will be used.
  final Color? color;

  /// The tooltip message to show when the button is hovered.
  final String? tooltip;

  /// A semantic description of the button's action.
  ///
  /// Used by screen readers and other assistive technologies.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    final double buttonSize = _getButtonSize(size);
    final double iconSize = _getIconSize(size);

    Widget button = IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
        color: color ?? _getIconColor(context, variant, isEnabled),
      ),
      style: _getButtonStyle(context, variant, isEnabled, buttonSize),
      tooltip: tooltip,
    );

    if (semanticLabel != null) {
      button = Semantics(
        label: semanticLabel,
        button: true,
        enabled: isEnabled,
        child: button,
      );
    }

    return button;
  }

  /// Gets the button size for the given size variant.
  double _getButtonSize(CorpoIconButtonSize size) {
    switch (size) {
      case CorpoIconButtonSize.small:
        return 32.0;
      case CorpoIconButtonSize.medium:
        return 40.0;
      case CorpoIconButtonSize.large:
        return 48.0;
    }
  }

  /// Gets the icon size for the given size variant.
  double _getIconSize(CorpoIconButtonSize size) {
    switch (size) {
      case CorpoIconButtonSize.small:
        return 16.0;
      case CorpoIconButtonSize.medium:
        return 20.0;
      case CorpoIconButtonSize.large:
        return 24.0;
    }
  }

  /// Gets the appropriate icon color for the variant and state.
  Color _getIconColor(
    BuildContext context,
    CorpoIconButtonVariant variant,
    bool isEnabled,
  ) {
    if (!isEnabled) {
      return Theme.of(context).brightness == Brightness.dark
          ? CorpoColors.neutral600
          : CorpoColors.neutral400;
    }

    switch (variant) {
      case CorpoIconButtonVariant.primary:
        return CorpoColors.neutralWhite;
      case CorpoIconButtonVariant.secondary:
      case CorpoIconButtonVariant.tertiary:
        return Theme.of(context).brightness == Brightness.dark
            ? CorpoColors.neutral200
            : CorpoColors.neutral700;
      case CorpoIconButtonVariant.danger:
        return variant == CorpoIconButtonVariant.danger
            ? CorpoColors.neutralWhite
            : CorpoColors.error;
    }
  }

  /// Gets the button style for the variant and state.
  ButtonStyle _getButtonStyle(
    BuildContext context,
    CorpoIconButtonVariant variant,
    bool isEnabled,
    double buttonSize,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton.styleFrom(
      minimumSize: Size(buttonSize, buttonSize),
      maximumSize: Size(buttonSize, buttonSize),
      backgroundColor: _getBackgroundColor(variant, isEnabled, isDark),
      foregroundColor: _getIconColor(context, variant, isEnabled),
      disabledBackgroundColor: isDark
          ? CorpoColors.neutral800
          : CorpoColors.neutral100,
      padding: EdgeInsets.all(CorpoSpacing.extraSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
        side: _getBorderSide(variant, isEnabled, isDark),
      ),
    );
  }

  /// Gets the background color for the variant and state.
  Color? _getBackgroundColor(
    CorpoIconButtonVariant variant,
    bool isEnabled,
    bool isDark,
  ) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral800 : CorpoColors.neutral100;
    }

    switch (variant) {
      case CorpoIconButtonVariant.primary:
        return CorpoColors.primary500;
      case CorpoIconButtonVariant.secondary:
        return isDark ? CorpoColors.neutral700 : CorpoColors.neutral100;
      case CorpoIconButtonVariant.tertiary:
        return Colors.transparent;
      case CorpoIconButtonVariant.danger:
        return CorpoColors.error;
    }
  }

  /// Gets the border side for the variant and state.
  BorderSide _getBorderSide(
    CorpoIconButtonVariant variant,
    bool isEnabled,
    bool isDark,
  ) {
    if (variant == CorpoIconButtonVariant.secondary && isEnabled) {
      return BorderSide(
        color: isDark ? CorpoColors.neutral600 : CorpoColors.neutral300,
        width: 1.0,
      );
    }
    return BorderSide.none;
  }
}
