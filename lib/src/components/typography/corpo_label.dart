/// A comprehensive label component for the Corpo UI design system.
///
/// CorpoLabel provides consistent labeling for form fields, captions,
/// and descriptive text. It integrates with the design system's typography
/// and supports various semantic variants for different use cases.
///
/// The component follows corporate design principles with clear visual
/// hierarchy and professional styling suitable for business applications.
/// It automatically handles theme integration and provides accessibility
/// features for screen readers.
///
/// Example usage:
/// ```dart
/// CorpoLabel(
///   'Email Address',
///   variant: CorpoLabelVariant.fieldLabel,
/// )
///
/// CorpoLabel.required('Password')
///
/// CorpoLabel.caption('Optional field')
///
/// CorpoLabel.helper('Must be at least 8 characters')
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/typography.dart';

/// Label variants for different use cases.
///
/// Determines the visual style and semantic meaning of the label.
enum CorpoLabelVariant {
  /// Standard field label
  fieldLabel,

  /// Required field label (with asterisk)
  required,

  /// Caption text for additional information
  caption,

  /// Helper text for guidance
  helper,

  /// Error text for validation messages
  error,

  /// Success text for positive feedback
  success,

  /// Warning text for cautionary information
  warning,
}

/// Size variants for different contexts.
enum CorpoLabelSize {
  /// Small label for compact layouts
  small,

  /// Medium label for standard use (default)
  medium,

  /// Large label for prominent display
  large,
}

/// A label widget that follows Corpo UI design principles.
///
/// This component provides consistent labeling across the application
/// with support for different variants, colors, and accessibility features.
/// It automatically handles theme integration and provides semantic meaning
/// for form fields and descriptive content.
class CorpoLabel extends StatelessWidget {
  /// Creates a Corpo UI label.
  ///
  /// The [text] parameter is required and contains the label content.
  const CorpoLabel(
    this.text, {
    this.variant = CorpoLabelVariant.fieldLabel,
    this.size = CorpoLabelSize.medium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  });

  /// Creates a required field label with asterisk.
  const CorpoLabel.required(
    this.text, {
    this.size = CorpoLabelSize.medium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : variant = CorpoLabelVariant.required;

  /// Creates a caption label for additional information.
  const CorpoLabel.caption(
    this.text, {
    this.size = CorpoLabelSize.small,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : variant = CorpoLabelVariant.caption;

  /// Creates a helper text label for guidance.
  const CorpoLabel.helper(
    this.text, {
    this.size = CorpoLabelSize.small,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : variant = CorpoLabelVariant.helper;

  /// Creates an error label for validation messages.
  const CorpoLabel.error(
    this.text, {
    this.size = CorpoLabelSize.small,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : variant = CorpoLabelVariant.error;

  /// Creates a success label for positive feedback.
  const CorpoLabel.success(
    this.text, {
    this.size = CorpoLabelSize.small,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : variant = CorpoLabelVariant.success;

  /// Creates a warning label for cautionary information.
  const CorpoLabel.warning(
    this.text, {
    this.size = CorpoLabelSize.small,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : variant = CorpoLabelVariant.warning;

  /// The text content of the label.
  final String text;

  /// The variant that determines the visual style and semantic meaning.
  final CorpoLabelVariant variant;

  /// The size variant for the label.
  final CorpoLabelSize size;

  /// The color to use for the text.
  ///
  /// If null, the appropriate color for the variant will be used.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// A semantic description of the text.
  ///
  /// Used by screen readers and other assistive technologies.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = _getTextStyle(size);
    final Color effectiveColor = color ?? _getColor(context, variant);

    String displayText = text;
    if (variant == CorpoLabelVariant.required) {
      displayText = '$text *';
    }

    return Text(
      displayText,
      style: baseStyle.copyWith(color: effectiveColor),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
    );
  }

  /// Gets the appropriate text style for the label size.
  TextStyle _getTextStyle(CorpoLabelSize size) {
    switch (size) {
      case CorpoLabelSize.small:
        return CorpoTypography.labelSmall;
      case CorpoLabelSize.medium:
        return CorpoTypography.labelMedium;
      case CorpoLabelSize.large:
        return CorpoTypography.labelLarge;
    }
  }

  /// Gets the appropriate color for the label variant.
  Color _getColor(BuildContext context, CorpoLabelVariant variant) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    switch (variant) {
      case CorpoLabelVariant.fieldLabel:
      case CorpoLabelVariant.required:
        return isDark ? CorpoColors.neutral200 : CorpoColors.neutral700;
      case CorpoLabelVariant.caption:
      case CorpoLabelVariant.helper:
        return isDark ? CorpoColors.neutral300 : CorpoColors.neutral600;
      case CorpoLabelVariant.error:
        return CorpoColors.error;
      case CorpoLabelVariant.success:
        return CorpoColors.success;
      case CorpoLabelVariant.warning:
        return CorpoColors.warning;
    }
  }
}
