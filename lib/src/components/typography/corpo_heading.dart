/// A comprehensive heading component for the Corpo UI design system.
///
/// CorpoHeading provides semantic heading variants (H1-H6 equivalents) that
/// integrate seamlessly with the design system's typography scale and theme.
/// It extends Flutter's Text widget with corporate design principles and
/// consistent styling for proper content hierarchy.
///
/// The component automatically applies appropriate typography styles based
/// on heading levels and integrates with the theme system for proper color
/// handling in light and dark modes.
///
/// Example usage:
/// ```dart
/// CorpoHeading(
///   'Page Title',
///   level: CorpoHeadingLevel.h1,
/// )
///
/// CorpoHeading.h2('Section Title')
///
/// CorpoHeading.h3(
///   'Subsection Title',
///   color: tokens.primaryColor,
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Heading level variants for semantic hierarchy.
///
/// These variants correspond to HTML heading elements and provide
/// proper semantic structure for content organization.
enum CorpoHeadingLevel {
  /// H1 - Page title or main heading
  h1,

  /// H2 - Section heading
  h2,

  /// H3 - Subsection heading
  h3,

  /// H4 - Sub-subsection heading
  h4,

  /// H5 - Minor heading
  h5,

  /// H6 - Smallest heading
  h6,
}

/// A heading widget that follows Corpo UI design principles.
///
/// This widget provides consistent heading typography across the application
/// by using predefined text styles from the design system. It automatically
/// handles theme integration and provides semantic variants for different
/// heading levels.
class CorpoHeading extends StatelessWidget {
  /// Creates a Corpo UI heading.
  ///
  /// The [text] parameter is required and contains the heading content.
  /// The [level] determines which heading style to apply.
  const CorpoHeading(
    this.text, {
    required this.level,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  });

  /// Creates an H1 heading.
  const CorpoHeading.h1(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : level = CorpoHeadingLevel.h1;

  /// Creates an H2 heading.
  const CorpoHeading.h2(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : level = CorpoHeadingLevel.h2;

  /// Creates an H3 heading.
  const CorpoHeading.h3(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : level = CorpoHeadingLevel.h3;

  /// Creates an H4 heading.
  const CorpoHeading.h4(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : level = CorpoHeadingLevel.h4;

  /// Creates an H5 heading.
  const CorpoHeading.h5(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : level = CorpoHeadingLevel.h5;

  /// Creates an H6 heading.
  const CorpoHeading.h6(
    this.text, {
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    super.key,
  }) : level = CorpoHeadingLevel.h6;

  /// The text content of the heading.
  final String text;

  /// The heading level that determines the typography style.
  final CorpoHeadingLevel level;

  /// The color to use for the text.
  ///
  /// If null, the default text color from the theme will be used.
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final TextStyle style = _getTextStyle(level, tokens);
    final Color effectiveColor =
        color ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : tokens.textPrimary);

    return Text(
      text,
      style: style.copyWith(color: effectiveColor),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
    );
  }

  /// Gets the appropriate text style for the heading level.
  TextStyle _getTextStyle(CorpoHeadingLevel level, CorpoDesignTokens tokens) {
    switch (level) {
      case CorpoHeadingLevel.h1:
        return TextStyle(
          fontSize: tokens.fontSizeXXLarge * 2,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.bold,
        );
      case CorpoHeadingLevel.h2:
        return TextStyle(
          fontSize: tokens.fontSizeXXLarge * 1.5,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.bold,
        );
      case CorpoHeadingLevel.h3:
        return TextStyle(
          fontSize: tokens.fontSizeXXLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoHeadingLevel.h4:
        return TextStyle(
          fontSize: tokens.fontSizeXLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoHeadingLevel.h5:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoHeadingLevel.h6:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
    }
  }
}
