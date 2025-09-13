/// Color constants for the Corpo UI design system.
///
/// This file defines the semantic color system used throughout Corpo UI,
/// focusing on corporate application design principles with professional,
/// accessible, and consistent color choices.
///
/// The color system is organized into semantic categories:
/// - Primary: Main brand colors for primary actions and emphasis
/// - Secondary: Supporting colors for secondary actions
/// - Neutral: Grayscale colors for text, borders, and backgrounds
/// - Semantic: Colors that convey meaning (success, warning, error, info)
///
/// Example usage:
/// ```dart
/// Container(
///   color: CorpoColors.primary500,
///   child: Text(
///     'Primary Button',
///     style: TextStyle(color: CorpoColors.neutralWhite),
///   ),
/// )
/// ```
library;

import 'package:flutter/painting.dart';

/// Primary color palette for the corporate design system.
///
/// Based on a professional blue tone that conveys trust, stability,
/// and professionalism while maintaining good accessibility.
abstract final class CorpoColors {
  // Primary Color Scale (Corporate Blue)
  /// Primary 50 - Lightest primary color
  static const Color primary50 = Color(0xFFEBF8FF);

  /// Primary 100 - Very light primary color
  static const Color primary100 = Color(0xFFBEE3F8);

  /// Primary 200 - Light primary color
  static const Color primary200 = Color(0xFF90CDF4);

  /// Primary 300 - Medium light primary color
  static const Color primary300 = Color(0xFF63B3ED);

  /// Primary 400 - Medium primary color
  static const Color primary400 = Color(0xFF4299E1);

  /// Primary 500 - Main primary color (brand color)
  static const Color primary500 = Color(0xFF3182CE);

  /// Primary 600 - Medium dark primary color
  static const Color primary600 = Color(0xFF2B77CB);

  /// Primary 700 - Dark primary color
  static const Color primary700 = Color(0xFF2C5AA0);

  /// Primary 800 - Very dark primary color
  static const Color primary800 = Color(0xFF2A4A7C);

  /// Primary 900 - Darkest primary color
  static const Color primary900 = Color(0xFF1A365D);

  // Secondary Color Scale (Professional Gray-Blue)
  /// Secondary 50 - Lightest secondary color
  static const Color secondary50 = Color(0xFFF7FAFC);

  /// Secondary 100 - Very light secondary color
  static const Color secondary100 = Color(0xFFEDF2F7);

  /// Secondary 200 - Light secondary color
  static const Color secondary200 = Color(0xFFE2E8F0);

  /// Secondary 300 - Medium light secondary color
  static const Color secondary300 = Color(0xFFCBD5E0);

  /// Secondary 400 - Medium secondary color
  static const Color secondary400 = Color(0xFFA0AEC0);

  /// Secondary 500 - Main secondary color
  static const Color secondary500 = Color(0xFF718096);

  /// Secondary 600 - Medium dark secondary color
  static const Color secondary600 = Color(0xFF4A5568);

  /// Secondary 700 - Dark secondary color
  static const Color secondary700 = Color(0xFF2D3748);

  /// Secondary 800 - Very dark secondary color
  static const Color secondary800 = Color(0xFF1A202C);

  /// Secondary 900 - Darkest secondary color
  static const Color secondary900 = Color(0xFF171923);

  // Neutral Color Scale (True Grays)
  /// Pure white
  static const Color neutralWhite = Color(0xFFFFFFFF);

  /// Neutral 50 - Off white
  static const Color neutral50 = Color(0xFFFAFAFA);

  /// Neutral 100 - Very light gray
  static const Color neutral100 = Color(0xFFF4F4F5);

  /// Neutral 200 - Light gray
  static const Color neutral200 = Color(0xFFE4E4E7);

  /// Neutral 300 - Medium light gray
  static const Color neutral300 = Color(0xFFD4D4D8);

  /// Neutral 400 - Medium gray
  static const Color neutral400 = Color(0xFFA1A1AA);

  /// Neutral 500 - Main neutral color
  static const Color neutral500 = Color(0xFF71717A);

  /// Neutral 600 - Medium dark gray
  static const Color neutral600 = Color(0xFF52525B);

  /// Neutral 700 - Dark gray
  static const Color neutral700 = Color(0xFF3F3F46);

  /// Neutral 800 - Very dark gray
  static const Color neutral800 = Color(0xFF27272A);

  /// Neutral 900 - Near black
  static const Color neutral900 = Color(0xFF18181B);

  /// Pure black
  static const Color neutralBlack = Color(0xFF000000);

  // Semantic Colors
  /// Success color (Green) - Indicates positive actions or status
  static const Color success = Color(0xFF10B981);

  /// Success background - Light green for success backgrounds
  static const Color successBackground = Color(0xFFECFDF5);

  /// Success border - Medium green for success borders
  static const Color successBorder = Color(0xFFBBF7D0);

  /// Warning color (Amber) - Indicates caution or important information
  static const Color warning = Color(0xFFF59E0B);

  /// Warning background - Light amber for warning backgrounds
  static const Color warningBackground = Color(0xFFFEF3C7);

  /// Warning border - Medium amber for warning borders
  static const Color warningBorder = Color(0xFFFDE68A);

  /// Error color (Red) - Indicates errors or destructive actions
  static const Color error = Color(0xFFEF4444);

  /// Error background - Light red for error backgrounds
  static const Color errorBackground = Color(0xFFFEF2F2);

  /// Error border - Medium red for error borders
  static const Color errorBorder = Color(0xFFFECACA);

  /// Info color (Blue) - Indicates informational content
  static const Color info = Color(0xFF3B82F6);

  /// Info background - Light blue for info backgrounds
  static const Color infoBackground = Color(0xFFEFF6FF);

  /// Info border - Medium blue for info borders
  static const Color infoBorder = Color(0xFFBFDBFE);

  // Surface Colors
  /// Background surface - Primary app background
  static const Color surfaceBackground = neutralWhite;

  /// Card surface - Elevated content background
  static const Color surfaceCard = neutralWhite;

  /// Dialog surface - Modal and dialog background
  static const Color surfaceDialog = neutralWhite;

  /// Disabled surface - Disabled component background
  static const Color surfaceDisabled = neutral100;

  // Border Colors
  /// Primary border color
  static const Color borderPrimary = neutral200;

  /// Secondary border color
  static const Color borderSecondary = neutral100;

  /// Focus border color
  static const Color borderFocus = primary500;

  /// Disabled border color
  static const Color borderDisabled = neutral200;

  // Text Colors
  /// Primary text color - Main content text
  static const Color textPrimary = neutral900;

  /// Secondary text color - Supporting text
  static const Color textSecondary = neutral600;

  /// Muted text color - Least prominent text
  static const Color textMuted = neutral400;

  /// Disabled text color
  static const Color textDisabled = neutral300;

  /// Text on primary color
  static const Color textOnPrimary = neutralWhite;

  /// Text on dark backgrounds
  static const Color textOnDark = neutralWhite;
}
