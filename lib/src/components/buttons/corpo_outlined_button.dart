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

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

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
    final bool isEnabled = onPressed != null;

    Widget button = OutlinedButton(
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
    CorpoOutlinedButtonVariant variant,
    CorpoOutlinedButtonSize size,
    bool isEnabled,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final EdgeInsets padding = _getPadding(size);
    final TextStyle textStyle = _getTextStyle(size);
    final BorderSide borderSide = _getBorderSide(variant, isEnabled, isDark);

    return OutlinedButton.styleFrom(
      foregroundColor: _getForegroundColor(variant, isEnabled, isDark),
      disabledForegroundColor: isDark
          ? CorpoColors.neutral600
          : CorpoColors.neutral400,
      backgroundColor: Colors.transparent,
      disabledBackgroundColor: Colors.transparent,
      side: borderSide,
      padding: padding,
      textStyle: textStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
      ),
      minimumSize: _getMinimumSize(size),
    );
  }

  /// Gets the foreground color for the variant and state.
  Color _getForegroundColor(
    CorpoOutlinedButtonVariant variant,
    bool isEnabled,
    bool isDark,
  ) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
    }

    switch (variant) {
      case CorpoOutlinedButtonVariant.standard:
        return isDark ? CorpoColors.neutral200 : CorpoColors.neutral700;
      case CorpoOutlinedButtonVariant.primary:
        return CorpoColors.primary500;
      case CorpoOutlinedButtonVariant.danger:
        return CorpoColors.error;
    }
  }

  /// Gets the border side for the variant and state.
  BorderSide _getBorderSide(
    CorpoOutlinedButtonVariant variant,
    bool isEnabled,
    bool isDark,
  ) {
    if (!isEnabled) {
      return BorderSide(
        color: isDark ? CorpoColors.neutral700 : CorpoColors.neutral300,
      );
    }

    Color borderColor;
    switch (variant) {
      case CorpoOutlinedButtonVariant.standard:
        borderColor = isDark ? CorpoColors.neutral400 : CorpoColors.neutral400;
        break;
      case CorpoOutlinedButtonVariant.primary:
        borderColor = CorpoColors.primary500;
        break;
      case CorpoOutlinedButtonVariant.danger:
        borderColor = CorpoColors.error;
        break;
    }

    return BorderSide(color: borderColor);
  }

  /// Gets the padding for the size variant.
  EdgeInsets _getPadding(CorpoOutlinedButtonSize size) {
    switch (size) {
      case CorpoOutlinedButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.medium,
          vertical: CorpoSpacing.small,
        );
      case CorpoOutlinedButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.large,
          vertical: CorpoSpacing.medium,
        );
      case CorpoOutlinedButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.extraLarge,
          vertical: CorpoSpacing.large,
        );
    }
  }

  /// Gets the text style for the size variant.
  TextStyle _getTextStyle(CorpoOutlinedButtonSize size) {
    switch (size) {
      case CorpoOutlinedButtonSize.small:
        return CorpoTypography.buttonSmall;
      case CorpoOutlinedButtonSize.medium:
        return CorpoTypography.buttonMedium;
      case CorpoOutlinedButtonSize.large:
        return CorpoTypography.buttonLarge;
    }
  }

  /// Gets the minimum size for the size variant.
  Size _getMinimumSize(CorpoOutlinedButtonSize size) {
    switch (size) {
      case CorpoOutlinedButtonSize.small:
        return const Size(80, 32);
      case CorpoOutlinedButtonSize.medium:
        return const Size(100, 40);
      case CorpoOutlinedButtonSize.large:
        return const Size(120, 48);
    }
  }
}
