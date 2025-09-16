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

import '../../design_tokens.dart';

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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final bool isEnabled = onPressed != null;
    final double buttonSize = _getButtonSize(size, tokens);
    final double iconSize = _getIconSize(size, tokens);

    Widget button = IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
        color: color ?? _getIconColor(context, variant, isEnabled, tokens),
      ),
      style: _getButtonStyle(context, variant, isEnabled, buttonSize, tokens),
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
  double _getButtonSize(CorpoIconButtonSize size, CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoIconButtonSize.small:
        return tokens.spacing8x; // 32px
      case CorpoIconButtonSize.medium:
        return tokens.spacing8x + tokens.spacing2x; // 40px (32 + 8)
      case CorpoIconButtonSize.large:
        return tokens.spacing12x; // 48px
    }
  }

  /// Gets the icon size for the given size variant.
  double _getIconSize(CorpoIconButtonSize size, CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoIconButtonSize.small:
        return tokens.spacing4x; // 16px
      case CorpoIconButtonSize.medium:
        return tokens.spacing4x + tokens.spacing1x; // 20px (16 + 4)
      case CorpoIconButtonSize.large:
        return tokens.spacing6x; // 24px
    }
  }

  /// Gets the appropriate icon color for the variant and state.
  Color _getIconColor(
    BuildContext context,
    CorpoIconButtonVariant variant,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.textSecondary;
    }

    switch (variant) {
      case CorpoIconButtonVariant.primary:
        return tokens.getTextColorFor(tokens.primaryColor);
      case CorpoIconButtonVariant.secondary:
      case CorpoIconButtonVariant.tertiary:
        return tokens.textPrimary;
      case CorpoIconButtonVariant.danger:
        return variant == CorpoIconButtonVariant.danger
            ? tokens.getTextColorFor(tokens.errorColor)
            : tokens.errorColor;
    }
  }

  /// Gets the button style for the variant and state.
  ButtonStyle _getButtonStyle(
    BuildContext context,
    CorpoIconButtonVariant variant,
    bool isEnabled,
    double buttonSize,
    CorpoDesignTokens tokens,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton.styleFrom(
      minimumSize: Size(buttonSize, buttonSize),
      maximumSize: Size(buttonSize, buttonSize),
      backgroundColor: _getBackgroundColor(variant, isEnabled, isDark, tokens),
      foregroundColor: _getIconColor(context, variant, isEnabled, tokens),
      disabledBackgroundColor: tokens.surfaceColor.withValues(alpha: 0.5),
      padding: EdgeInsets.all(tokens.spacing1x),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.spacing1x),
        side: _getBorderSide(variant, isEnabled, isDark, tokens),
      ),
    );
  }

  /// Gets the background color for the variant and state.
  Color? _getBackgroundColor(
    CorpoIconButtonVariant variant,
    bool isEnabled,
    bool isDark,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.surfaceColor.withValues(alpha: 0.5);
    }

    switch (variant) {
      case CorpoIconButtonVariant.primary:
        return tokens.primaryColor;
      case CorpoIconButtonVariant.secondary:
        return tokens.surfaceColor.withValues(alpha: 0.8);
      case CorpoIconButtonVariant.tertiary:
        return Colors.transparent;
      case CorpoIconButtonVariant.danger:
        return tokens.errorColor;
    }
  }

  /// Gets the border side for the variant and state.
  BorderSide _getBorderSide(
    CorpoIconButtonVariant variant,
    bool isEnabled,
    bool isDark,
    CorpoDesignTokens tokens,
  ) {
    if (variant == CorpoIconButtonVariant.secondary && isEnabled) {
      return BorderSide(color: tokens.textSecondary.withValues(alpha: 0.5));
    }
    return BorderSide.none;
  }
}
