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

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

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
    final bool isEnabled = onPressed != null;

    Widget button = TextButton(
      onPressed: onPressed,
      style: _getButtonStyle(context, variant, size, isEnabled),
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
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final EdgeInsets padding = _getPadding(size);
    final TextStyle textStyle = _getTextStyle(size);

    return TextButton.styleFrom(
      foregroundColor: _getForegroundColor(variant, isEnabled, isDark),
      disabledForegroundColor: isDark
          ? CorpoColors.neutral600
          : CorpoColors.neutral400,
      padding: padding,
      textStyle: textStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
      ),
      minimumSize: _getMinimumSize(size),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  /// Gets the foreground color for the variant and state.
  Color _getForegroundColor(
    CorpoTextButtonVariant variant,
    bool isEnabled,
    bool isDark,
  ) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
    }

    switch (variant) {
      case CorpoTextButtonVariant.standard:
        return isDark ? CorpoColors.neutral200 : CorpoColors.neutral700;
      case CorpoTextButtonVariant.primary:
        return CorpoColors.primary500;
      case CorpoTextButtonVariant.danger:
        return CorpoColors.error;
    }
  }

  /// Gets the padding for the size variant.
  EdgeInsets _getPadding(CorpoTextButtonSize size) {
    switch (size) {
      case CorpoTextButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.small,
          vertical: CorpoSpacing.extraSmall,
        );
      case CorpoTextButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.medium,
          vertical: CorpoSpacing.small,
        );
      case CorpoTextButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.large,
          vertical: CorpoSpacing.medium,
        );
    }
  }

  /// Gets the text style for the size variant.
  TextStyle _getTextStyle(CorpoTextButtonSize size) {
    switch (size) {
      case CorpoTextButtonSize.small:
        return CorpoTypography.buttonSmall;
      case CorpoTextButtonSize.medium:
        return CorpoTypography.buttonMedium;
      case CorpoTextButtonSize.large:
        return CorpoTypography.buttonLarge;
    }
  }

  /// Gets the minimum size for the size variant.
  Size _getMinimumSize(CorpoTextButtonSize size) {
    switch (size) {
      case CorpoTextButtonSize.small:
        return const Size(64, 32);
      case CorpoTextButtonSize.medium:
        return const Size(80, 40);
      case CorpoTextButtonSize.large:
        return const Size(96, 48);
    }
  }
}
