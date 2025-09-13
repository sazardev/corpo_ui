/// Typography constants for the Corpo UI design system.
///
/// This file defines the typography scale, font weights, and text styles
/// used throughout Corpo UI. The typography system is designed for
/// corporate applications with focus on readability, hierarchy, and
/// professional appearance across all platforms.
///
/// The typography system includes:
/// - Font sizes following a modular scale
/// - Font weights for different emphasis levels
/// - Line heights optimized for readability
/// - Letter spacing for improved legibility
/// - Predefined text styles for common use cases
///
/// Example usage:
/// ```dart
/// Text(
///   'Heading',
///   style: CorpoTypography.heading1,
/// )
///
/// Text(
///   'Body text',
///   style: CorpoTypography.bodyMedium,
/// )
/// ```
library;

import 'package:flutter/painting.dart';

/// Font weight constants for consistent typography.
///
/// Provides semantic font weight values that work well
/// across different platforms and font families.
abstract final class CorpoFontWeight {
  /// Light font weight (300)
  static const FontWeight light = FontWeight.w300;

  /// Regular font weight (400) - Default text weight
  static const FontWeight regular = FontWeight.w400;

  /// Medium font weight (500) - Slightly emphasized text
  static const FontWeight medium = FontWeight.w500;

  /// Semi-bold font weight (600) - Moderately emphasized text
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold font weight (700) - Strongly emphasized text
  static const FontWeight bold = FontWeight.w700;
}

/// Font size constants based on a modular scale.
///
/// Font sizes progress logically to create visual hierarchy
/// while maintaining readability across different screen sizes.
abstract final class CorpoFontSize {
  /// Extra small text (12px)
  static const double extraSmall = 12;

  /// Small text (14px)
  static const double small = 14;

  /// Medium text (16px) - Base font size
  static const double medium = 16;

  /// Large text (18px)
  static const double large = 18;

  /// Extra large text (20px)
  static const double extraLarge = 20;

  /// XXL text (24px)
  static const double xxLarge = 24;

  /// XXXL text (28px)
  static const double xxxLarge = 28;

  /// 4XL text (32px)
  static const double xxxxLarge = 32;

  /// 5XL text (36px)
  static const double xxxxxLarge = 36;

  /// 6XL text (48px)
  static const double xxxxxxLarge = 48;
}

/// Line height constants for optimal readability.
///
/// Line heights are calculated as multipliers of font size
/// to ensure proper text spacing and readability.
abstract final class CorpoLineHeight {
  /// Tight line height (1.25) - For headings and display text
  static const double tight = 1.25;

  /// Normal line height (1.5) - For body text and most content
  static const double normal = 1.5;

  /// Relaxed line height (1.75) - For increased readability
  static const double relaxed = 1.75;
}

/// Letter spacing constants for improved legibility.
///
/// Letter spacing values are optimized for different text sizes
/// and use cases to improve readability and visual appeal.
abstract final class CorpoLetterSpacing {
  /// Tight letter spacing (-0.025em)
  static const double tight = -0.025;

  /// Normal letter spacing (0em) - Default spacing
  static const double normal = 0;

  /// Wide letter spacing (0.025em)
  static const double wide = 0.025;

  /// Extra wide letter spacing (0.05em)
  static const double extraWide = 0.05;
}

/// Predefined text styles for consistent typography throughout the application.
///
/// These styles combine font size, weight, line height, and letter spacing
/// to create a cohesive typography system suitable for corporate applications.
abstract final class CorpoTypography {
  // Display Styles - For large headings and hero text
  /// Display large - Largest text style for hero sections
  static const TextStyle displayLarge = TextStyle(
    fontSize: CorpoFontSize.xxxxxxLarge,
    fontWeight: CorpoFontWeight.bold,
    height: CorpoLineHeight.tight,
    letterSpacing: CorpoLetterSpacing.tight,
  );

  /// Display medium - Large display text
  static const TextStyle displayMedium = TextStyle(
    fontSize: CorpoFontSize.xxxxxLarge,
    fontWeight: CorpoFontWeight.bold,
    height: CorpoLineHeight.tight,
    letterSpacing: CorpoLetterSpacing.tight,
  );

  /// Display small - Smaller display text
  static const TextStyle displaySmall = TextStyle(
    fontSize: CorpoFontSize.xxxxLarge,
    fontWeight: CorpoFontWeight.semiBold,
    height: CorpoLineHeight.tight,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  // Heading Styles - For section headings and page titles
  /// Heading 1 - Main page headings
  static const TextStyle heading1 = TextStyle(
    fontSize: CorpoFontSize.xxxLarge,
    fontWeight: CorpoFontWeight.semiBold,
    height: CorpoLineHeight.tight,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  /// Heading 2 - Section headings
  static const TextStyle heading2 = TextStyle(
    fontSize: CorpoFontSize.xxLarge,
    fontWeight: CorpoFontWeight.semiBold,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  /// Heading 3 - Subsection headings
  static const TextStyle heading3 = TextStyle(
    fontSize: CorpoFontSize.extraLarge,
    fontWeight: CorpoFontWeight.medium,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  /// Heading 4 - Small headings
  static const TextStyle heading4 = TextStyle(
    fontSize: CorpoFontSize.large,
    fontWeight: CorpoFontWeight.medium,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  // Body Styles - For main content text
  /// Body large - Large body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: CorpoFontSize.large,
    fontWeight: CorpoFontWeight.regular,
    height: CorpoLineHeight.relaxed,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  /// Body medium - Standard body text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: CorpoFontSize.medium,
    fontWeight: CorpoFontWeight.regular,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  /// Body small - Small body text
  static const TextStyle bodySmall = TextStyle(
    fontSize: CorpoFontSize.small,
    fontWeight: CorpoFontWeight.regular,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  // Label Styles - For form labels and UI labels
  /// Label large - Large labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: CorpoFontSize.medium,
    fontWeight: CorpoFontWeight.medium,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.wide,
  );

  /// Label medium - Standard labels
  static const TextStyle labelMedium = TextStyle(
    fontSize: CorpoFontSize.small,
    fontWeight: CorpoFontWeight.medium,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.wide,
  );

  /// Label small - Small labels
  static const TextStyle labelSmall = TextStyle(
    fontSize: CorpoFontSize.extraSmall,
    fontWeight: CorpoFontWeight.medium,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.extraWide,
  );

  // Button Styles - For button text
  /// Button large - Large button text
  static const TextStyle buttonLarge = TextStyle(
    fontSize: CorpoFontSize.medium,
    fontWeight: CorpoFontWeight.semiBold,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.wide,
  );

  /// Button medium - Standard button text
  static const TextStyle buttonMedium = TextStyle(
    fontSize: CorpoFontSize.small,
    fontWeight: CorpoFontWeight.semiBold,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.wide,
  );

  /// Button small - Small button text
  static const TextStyle buttonSmall = TextStyle(
    fontSize: CorpoFontSize.extraSmall,
    fontWeight: CorpoFontWeight.semiBold,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.extraWide,
  );

  // Caption and Overline Styles - For metadata and secondary text
  /// Caption - Small secondary text
  static const TextStyle caption = TextStyle(
    fontSize: CorpoFontSize.extraSmall,
    fontWeight: CorpoFontWeight.regular,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.normal,
  );

  /// Overline - All caps small text for categories
  static const TextStyle overline = TextStyle(
    fontSize: CorpoFontSize.extraSmall,
    fontWeight: CorpoFontWeight.medium,
    height: CorpoLineHeight.normal,
    letterSpacing: CorpoLetterSpacing.extraWide,
  );
}
