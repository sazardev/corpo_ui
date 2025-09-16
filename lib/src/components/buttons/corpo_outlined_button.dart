/// A specialized outlined button component for the Corpo UI design system.
///
/// CorpoOutlinedButton provides consistent outlined button styling and behavior
/// across corporate applications, with support for different variants,
/// sizes, and accessibility features.
///
/// The component follows corporate design principles with clear border
/// emphasis and minimal background styling, making it ideal for secondary
/// actions that need more prominence than text buttons but less than
/// filled buttons.
///
/// Example usage:
/// ```dart
/// CorpoOutlinedButton(
///   onPressed: () => print('Outlined action'),
///   child: Text('Secondary Action'),
/// )
///
/// CorpoOutlinedButton.primary(
///   onPressed: () => print('Primary outlined action'),
///   child: Text('Continue'),
/// )
///
/// CorpoOutlinedButton.danger(
///   onPressed: () => print('Delete action'),
///   child: Text('Delete'),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Outlined button variants for different use cases.
enum CorpoOutlinedButtonVariant {
  /// Default outlined button
  standard,

  /// Primary outlined button with brand color
  primary,

  /// Danger outlined button for destructive actions
  danger,
}

/// Outlined button sizes for different contexts.
enum CorpoOutlinedButtonSize {
  /// Small outlined button
  small,

  /// Medium outlined button (default)
  medium,

  /// Large outlined button
  large,
}

/// A specialized outlined button widget following Corpo UI design principles.
///
/// This component provides consistent styling for outlined buttons with
/// clear border emphasis and transparent backgrounds. It's designed for
/// secondary actions that need more visual weight than text buttons.
class CorpoOutlinedButton extends StatelessWidget {
  /// Creates a Corpo UI outlined button.
  const CorpoOutlinedButton({
    required this.onPressed,
    required this.child,
    this.variant = CorpoOutlinedButtonVariant.standard,
    this.size = CorpoOutlinedButtonSize.medium,
    this.semanticLabel,
    super.key,
  });

  /// Creates a primary outlined button.
  const CorpoOutlinedButton.primary({
    required this.onPressed,
    required this.child,
    this.size = CorpoOutlinedButtonSize.medium,
    this.semanticLabel,
    super.key,
  }) : variant = CorpoOutlinedButtonVariant.primary;

  /// Creates a danger outlined button.
  const CorpoOutlinedButton.danger({
    required this.onPressed,
    required this.child,
    this.size = CorpoOutlinedButtonSize.medium,
    this.semanticLabel,
    super.key,
  }) : variant = CorpoOutlinedButtonVariant.danger;

  /// Creates a small outlined button.
  const CorpoOutlinedButton.small({
    required this.onPressed,
    required this.child,
    this.variant = CorpoOutlinedButtonVariant.standard,
    this.semanticLabel,
    super.key,
  }) : size = CorpoOutlinedButtonSize.small;

  /// Creates a large outlined button.
  const CorpoOutlinedButton.large({
    required this.onPressed,
    required this.child,
    this.variant = CorpoOutlinedButtonVariant.standard,
    this.semanticLabel,
    super.key,
  }) : size = CorpoOutlinedButtonSize.large;

  /// Called when the button is pressed.
  ///
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The widget to display inside the button.
  final Widget child;

  /// The visual variant of the button.
  final CorpoOutlinedButtonVariant variant;

  /// The size of the button.
  final CorpoOutlinedButtonSize size;

  /// A semantic description of the button's action.
  ///
  /// Used by screen readers and other assistive technologies.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final bool isEnabled = onPressed != null;

    Widget button = OutlinedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context, variant, size, isEnabled, tokens),
      child: child,
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

  /// Gets the button style for the variant, size, and state.
  ButtonStyle _getButtonStyle(
    BuildContext context,
    CorpoOutlinedButtonVariant variant,
    CorpoOutlinedButtonSize size,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final EdgeInsets padding = _getPadding(size, tokens);
    final TextStyle textStyle = _getTextStyle(size, tokens);
    final BorderSide borderSide = _getBorderSide(
      variant,
      isEnabled,
      isDark,
      tokens,
    );

    return OutlinedButton.styleFrom(
      foregroundColor: _getForegroundColor(variant, isEnabled, isDark, tokens),
      disabledForegroundColor: tokens.textSecondary,
      backgroundColor: Colors.transparent,
      disabledBackgroundColor: Colors.transparent,
      side: borderSide,
      padding: padding,
      textStyle: textStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      minimumSize: _getMinimumSize(size, tokens),
    );
  }

  /// Gets the foreground color for the variant and state.
  Color _getForegroundColor(
    CorpoOutlinedButtonVariant variant,
    bool isEnabled,
    bool isDark,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.textSecondary;
    }

    switch (variant) {
      case CorpoOutlinedButtonVariant.standard:
        return tokens.textPrimary;
      case CorpoOutlinedButtonVariant.primary:
        return tokens.primaryColor;
      case CorpoOutlinedButtonVariant.danger:
        return tokens.errorColor;
    }
  }

  /// Gets the border side for the variant and state.
  BorderSide _getBorderSide(
    CorpoOutlinedButtonVariant variant,
    bool isEnabled,
    bool isDark,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return BorderSide(color: tokens.textSecondary.withValues(alpha: 0.5));
    }

    Color borderColor;
    switch (variant) {
      case CorpoOutlinedButtonVariant.standard:
        borderColor = tokens.textSecondary;
        break;
      case CorpoOutlinedButtonVariant.primary:
        borderColor = tokens.primaryColor;
        break;
      case CorpoOutlinedButtonVariant.danger:
        borderColor = tokens.errorColor;
        break;
    }

    return BorderSide(color: borderColor);
  }

  /// Gets the padding for the size variant.
  EdgeInsets _getPadding(
    CorpoOutlinedButtonSize size,
    CorpoDesignTokens tokens,
  ) {
    switch (size) {
      case CorpoOutlinedButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing4x,
          vertical: tokens.spacing2x,
        );
      case CorpoOutlinedButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing6x,
          vertical: tokens.spacing4x,
        );
      case CorpoOutlinedButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing8x,
          vertical: tokens.spacing6x,
        );
    }
  }

  /// Gets the text style for the size variant.
  TextStyle _getTextStyle(
    CorpoOutlinedButtonSize size,
    CorpoDesignTokens tokens,
  ) {
    switch (size) {
      case CorpoOutlinedButtonSize.small:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoOutlinedButtonSize.medium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoOutlinedButtonSize.large:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
    }
  }

  /// Gets the minimum size for the size variant.
  Size _getMinimumSize(CorpoOutlinedButtonSize size, CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoOutlinedButtonSize.small:
        return Size(
          tokens.spacing16x + tokens.spacing4x,
          tokens.spacing8x,
        ); // 80px x 32px
      case CorpoOutlinedButtonSize.medium:
        return Size(
          tokens.spacing16x + tokens.spacing8x + tokens.spacing1x,
          tokens.spacing8x + tokens.spacing2x,
        ); // ~100px x 40px
      case CorpoOutlinedButtonSize.large:
        return Size(
          tokens.spacing16x + tokens.spacing16x + tokens.spacing2x,
          tokens.spacing12x,
        ); // 120px x 48px
    }
  }
}
