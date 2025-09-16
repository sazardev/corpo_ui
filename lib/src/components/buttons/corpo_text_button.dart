/// A specialized text button component for the Corpo UI design system.
///
/// CorpoTextButton provides consistent text-only button styling and behavior
/// across corporate applications, with support for different variants,
/// sizes, and accessibility features.
///
/// The component follows corporate design principles with minimal visual
/// styling, focusing on typography and color to indicate interactivity.
/// It's ideal for secondary actions and links within interfaces.
///
/// Example usage:
/// ```dart
/// CorpoTextButton(
///   onPressed: () => print('Text action'),
///   child: Text('Learn More'),
/// )
///
/// CorpoTextButton.primary(
///   onPressed: () => print('Primary text action'),
///   child: Text('Continue'),
/// )
///
/// CorpoTextButton.danger(
///   onPressed: () => print('Delete action'),
///   child: Text('Delete'),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Text button variants for different use cases.
enum CorpoTextButtonVariant {
  /// Default text button
  standard,

  /// Primary text button with brand color
  primary,

  /// Danger text button for destructive actions
  danger,
}

/// Text button sizes for different contexts.
enum CorpoTextButtonSize {
  /// Small text button
  small,

  /// Medium text button (default)
  medium,

  /// Large text button
  large,
}

/// A specialized text button widget following Corpo UI design principles.
///
/// This component provides consistent styling for text-only buttons with
/// minimal visual emphasis. It's designed for secondary actions, navigation
/// links, and other cases where a full button would be too prominent.
class CorpoTextButton extends StatelessWidget {
  /// Creates a Corpo UI text button.
  const CorpoTextButton({
    required this.onPressed,
    required this.child,
    this.variant = CorpoTextButtonVariant.standard,
    this.size = CorpoTextButtonSize.medium,
    this.semanticLabel,
    super.key,
  });

  /// Creates a primary text button.
  const CorpoTextButton.primary({
    required this.onPressed,
    required this.child,
    this.size = CorpoTextButtonSize.medium,
    this.semanticLabel,
    super.key,
  }) : variant = CorpoTextButtonVariant.primary;

  /// Creates a danger text button.
  const CorpoTextButton.danger({
    required this.onPressed,
    required this.child,
    this.size = CorpoTextButtonSize.medium,
    this.semanticLabel,
    super.key,
  }) : variant = CorpoTextButtonVariant.danger;

  /// Creates a small text button.
  const CorpoTextButton.small({
    required this.onPressed,
    required this.child,
    this.variant = CorpoTextButtonVariant.standard,
    this.semanticLabel,
    super.key,
  }) : size = CorpoTextButtonSize.small;

  /// Creates a large text button.
  const CorpoTextButton.large({
    required this.onPressed,
    required this.child,
    this.variant = CorpoTextButtonVariant.standard,
    this.semanticLabel,
    super.key,
  }) : size = CorpoTextButtonSize.large;

  /// Called when the button is pressed.
  ///
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The widget to display inside the button.
  final Widget child;

  /// The visual variant of the button.
  final CorpoTextButtonVariant variant;

  /// The size of the button.
  final CorpoTextButtonSize size;

  /// A semantic description of the button's action.
  ///
  /// Used by screen readers and other assistive technologies.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final bool isEnabled = onPressed != null;

    Widget button = TextButton(
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
    CorpoTextButtonVariant variant,
    CorpoTextButtonSize size,
    bool isEnabled,
    CorpoDesignTokens tokens,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final EdgeInsets padding = _getPadding(size, tokens);
    final TextStyle textStyle = _getTextStyle(size, tokens);

    return TextButton.styleFrom(
      foregroundColor: _getForegroundColor(variant, isEnabled, isDark, tokens),
      disabledForegroundColor: tokens.textSecondary,
      padding: padding,
      textStyle: textStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      minimumSize: _getMinimumSize(size, tokens),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  /// Gets the foreground color for the variant and state.
  Color _getForegroundColor(
    CorpoTextButtonVariant variant,
    bool isEnabled,
    bool isDark,
    CorpoDesignTokens tokens,
  ) {
    if (!isEnabled) {
      return tokens.textSecondary;
    }

    switch (variant) {
      case CorpoTextButtonVariant.standard:
        return tokens.textPrimary;
      case CorpoTextButtonVariant.primary:
        return tokens.primaryColor;
      case CorpoTextButtonVariant.danger:
        return tokens.errorColor;
    }
  }

  /// Gets the padding for the size variant.
  EdgeInsets _getPadding(CorpoTextButtonSize size, CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoTextButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing2x,
          vertical: tokens.spacing1x,
        );
      case CorpoTextButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing4x,
          vertical: tokens.spacing2x,
        );
      case CorpoTextButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing6x,
          vertical: tokens.spacing4x,
        );
    }
  }

  /// Gets the text style for the size variant.
  TextStyle _getTextStyle(CorpoTextButtonSize size, CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoTextButtonSize.small:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoTextButtonSize.medium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoTextButtonSize.large:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
    }
  }

  /// Gets the minimum size for the size variant.
  Size _getMinimumSize(CorpoTextButtonSize size, CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoTextButtonSize.small:
        return Size(tokens.spacing16x, tokens.spacing8x); // 64px x 32px
      case CorpoTextButtonSize.medium:
        return Size(
          tokens.spacing16x + tokens.spacing4x,
          tokens.spacing8x + tokens.spacing2x,
        ); // 80px x 40px
      case CorpoTextButtonSize.large:
        return Size(
          tokens.spacing16x + tokens.spacing8x,
          tokens.spacing12x,
        ); // 96px x 48px
    }
  }
}
