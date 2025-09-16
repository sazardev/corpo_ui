/// A comprehensive text component for the Corpo UI design system.
///
/// CorpoText provides semantic text variants that integrate seamlessly with
/// the design system's typography scale and theme. It extends Flutter's Text
/// widget with corporate design principles and consistent styling.
///
/// This component automatically applies the correct typography styles based
/// on semantic variants and integrates with the theme system for proper
/// color handling in light and dark modes.
///
/// Example usage:
/// ```dart
/// CorpoText(
///   'Hello World',
///   variant: CorpoTextVariant.headingLarge,
///   color: CorpoColors.primary500,
/// )
///
/// CorpoText.bodyMedium('Standard body text')
///
/// CorpoText.caption('Small caption text')
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Semantic variants for text styling.
///
/// These variants correspond to the typography system and provide
/// semantic meaning to different text elements in the UI.
enum CorpoTextVariant {
  /// Display text - largest text for hero sections
  displayLarge,

  /// Display text - large display text
  displayMedium,

  /// Display text - smaller display text
  displaySmall,

  /// Heading 1 - main page headings
  headingLarge,

  /// Heading 2 - section headings
  headingMedium,

  /// Heading 3 - subsection headings
  headingSmall,

  /// Large body text
  bodyLarge,

  /// Standard body text - most common text variant
  bodyMedium,

  /// Small body text
  bodySmall,

  /// Large labels for form elements
  labelLarge,

  /// Standard labels
  labelMedium,

  /// Small labels
  labelSmall,

  /// Button text styling
  button,

  /// Caption text for metadata
  caption,

  /// Overline text for categories
  overline,
}

/// A text widget that follows Corpo UI design principles.
///
/// This widget provides consistent typography across the application
/// by using predefined text styles from the design system. It automatically
/// handles theme integration and provides semantic variants for different
/// text use cases.
class CorpoText extends StatelessWidget {
  /// Creates a Corpo UI text widget.
  ///
  /// The [data] parameter is required and contains the text to display.
  /// The [variant] determines which typography style to apply.
  /// Other parameters follow Flutter's Text widget conventions.
  const CorpoText(
    this.data, {
    required this.variant,
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  });

  /// Convenience constructor for display large text.
  const CorpoText.displayLarge(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.displayLarge;

  /// Convenience constructor for display medium text.
  const CorpoText.displayMedium(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.displayMedium;

  /// Convenience constructor for heading large text.
  const CorpoText.headingLarge(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.headingLarge;

  /// Convenience constructor for heading medium text.
  const CorpoText.headingMedium(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.headingMedium;

  /// Convenience constructor for body large text.
  const CorpoText.bodyLarge(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.bodyLarge;

  /// Convenience constructor for body medium text (most common).
  const CorpoText.bodyMedium(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.bodyMedium;

  /// Convenience constructor for body small text.
  const CorpoText.bodySmall(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.bodySmall;

  /// Convenience constructor for label text.
  const CorpoText.label(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.labelMedium;

  /// Convenience constructor for caption text.
  const CorpoText.caption(
    this.data, {
    this.style,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.softWrap,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : variant = CorpoTextVariant.caption;

  /// The text to display.
  final String data;

  /// The semantic variant that determines the text style.
  final CorpoTextVariant variant;

  /// Optional style override. Merged with the variant style.
  final TextStyle? style;

  /// The color to use for the text. If null, uses theme default.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Optional maximum number of lines for the text to span.
  final int? maxLines;

  /// Alternative semantics description for accessibility.
  final String? semanticsLabel;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Used to select a font when multiple fonts have the same Unicode.
  final Locale? locale;

  /// The number of font pixels for each logical pixel.
  final double? textScaleFactor;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis? textWidthBasis;

  /// Defines how the paragraph will apply TextStyle.height to the ascent.
  final TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final TextStyle baseStyle = _getTextStyleForVariant(variant, tokens);
    final Color textColor =
        color ?? _getDefaultColorForVariant(context, variant, tokens);

    final TextStyle effectiveStyle = baseStyle
        .copyWith(color: textColor)
        .merge(style);

    return Text(
      data,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      textDirection: textDirection,
      locale: locale,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }

  /// Gets the base text style for the given variant.
  TextStyle _getTextStyleForVariant(
    CorpoTextVariant variant,
    CorpoDesignTokens tokens,
  ) {
    switch (variant) {
      case CorpoTextVariant.displayLarge:
        return TextStyle(
          fontSize: tokens.fontSizeXXLarge * 2, // Extra large for display text
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.bold,
        );
      case CorpoTextVariant.displayMedium:
        return TextStyle(
          fontSize: tokens.fontSizeXXLarge * 1.5,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.bold,
        );
      case CorpoTextVariant.displaySmall:
        return TextStyle(
          fontSize: tokens.fontSizeXXLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoTextVariant.headingLarge:
        return TextStyle(
          fontSize: tokens.fontSizeXLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoTextVariant.headingMedium:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoTextVariant.headingSmall:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        );
      case CorpoTextVariant.bodyLarge:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.normal,
        );
      case CorpoTextVariant.bodyMedium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.normal,
        );
      case CorpoTextVariant.bodySmall:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.normal,
        );
      case CorpoTextVariant.labelLarge:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w500,
        );
      case CorpoTextVariant.labelMedium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w500,
        );
      case CorpoTextVariant.labelSmall:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w500,
        );
      case CorpoTextVariant.button:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w500,
        );
      case CorpoTextVariant.caption:
        return TextStyle(
          fontSize: tokens.fontSizeSmall * 0.9,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.normal,
        );
      case CorpoTextVariant.overline:
        return TextStyle(
          fontSize: tokens.fontSizeSmall * 0.8,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        );
    }
  }

  /// Gets the default color for the variant based on the current theme.
  Color _getDefaultColorForVariant(
    BuildContext context,
    CorpoTextVariant variant,
    CorpoDesignTokens tokens,
  ) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // For display and heading variants, use stronger text color
    if (_isDisplayOrHeading(variant)) {
      return isDark ? Colors.white : tokens.textPrimary;
    }

    // For body text, use primary text color
    if (_isBodyText(variant)) {
      return isDark ? Colors.white.withOpacity(0.9) : tokens.textPrimary;
    }

    // For labels and captions, use secondary text color
    return isDark ? Colors.white.withOpacity(0.7) : tokens.textSecondary;
  }

  /// Checks if the variant is a display or heading variant.
  bool _isDisplayOrHeading(CorpoTextVariant variant) =>
      variant == CorpoTextVariant.displayLarge ||
      variant == CorpoTextVariant.displayMedium ||
      variant == CorpoTextVariant.displaySmall ||
      variant == CorpoTextVariant.headingLarge ||
      variant == CorpoTextVariant.headingMedium ||
      variant == CorpoTextVariant.headingSmall;

  /// Checks if the variant is a body text variant.
  bool _isBodyText(CorpoTextVariant variant) =>
      variant == CorpoTextVariant.bodyLarge ||
      variant == CorpoTextVariant.bodyMedium ||
      variant == CorpoTextVariant.bodySmall;
}
