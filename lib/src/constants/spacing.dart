/// Spacing constants for consistent layout spacing throughout the design
/// system.
///
/// ⚠️ **DEPRECATED**: This file is deprecated as of v0.2.0
///
/// **Migration Guide:**
/// Replace `CorpoSpacing.*` with `CorpoDesignTokens().spacing*`
///
/// **Old way:**
/// ```dart
/// Container(
///   padding: EdgeInsets.all(CorpoSpacing.medium),
///   margin: EdgeInsets.only(bottom: CorpoSpacing.large),
/// )
/// ```
///
/// **New way (ShadCN style):**
/// ```dart
/// final tokens = CorpoDesignTokens();
/// Container(
///   padding: EdgeInsets.all(tokens.spacing4x),  // CorpoSpacing.medium = 16px = spacing4x
///   margin: EdgeInsets.only(bottom: tokens.spacing6x), // CorpoSpacing.large = 24px = spacing6x
/// )
/// ```
///
/// **Migration mappings:**
/// - `CorpoSpacing.extraSmall` (4px) → `tokens.spacing1x`
/// - `CorpoSpacing.small` (8px) → `tokens.spacing2x`
/// - `CorpoSpacing.medium` (16px) → `tokens.spacing4x`
/// - `CorpoSpacing.large` (24px) → `tokens.spacing6x`
/// - `CorpoSpacing.extraLarge` (32px) → `tokens.spacing8x`
///
/// This file will be removed in v0.3.0
library;

import 'package:flutter/widgets.dart';

/// Spacing constants based on a 4px grid system.
///
/// ⚠️ **DEPRECATED**: Use `CorpoDesignTokens().spacing*` instead
///
/// All spacing values are multiples of 4 to ensure consistent
/// alignment and visual rhythm throughout the application.
@Deprecated(
  'Use CorpoDesignTokens().spacing* instead. Will be removed in v0.3.0',
)
abstract final class CorpoSpacing {
  /// No spacing (0px)
  static const double none = 0;

  /// Extra small spacing (4px)
  /// Typically used for very tight spacing between related elements
  static const double extraSmall = 4;

  /// Small spacing (8px)
  /// Used for spacing between closely related elements
  static const double small = 8;

  /// Medium spacing (16px)
  /// The most commonly used spacing value for general layout
  static const double medium = 16;

  /// Large spacing (24px)
  /// Used for spacing between sections or groups of elements
  static const double large = 24;

  /// Extra large spacing (32px)
  /// Used for major layout separations
  static const double extraLarge = 32;

  /// XXL spacing (48px)
  /// Used for significant visual breaks and page-level spacing
  static const double xxLarge = 48;

  /// XXXLarge spacing (64px)
  /// Used for maximum visual separation
  static const double xxxLarge = 64;
}

/// Padding constants for consistent component padding.
///
/// Provides predefined EdgeInsets for common padding scenarios
/// to ensure consistency across components.
abstract final class CorpoPadding {
  /// No padding
  static const EdgeInsets none = EdgeInsets.zero;

  /// Extra small padding (4px all sides)
  static const EdgeInsets extraSmall = EdgeInsets.all(CorpoSpacing.extraSmall);

  /// Small padding (8px all sides)
  static const EdgeInsets small = EdgeInsets.all(CorpoSpacing.small);

  /// Medium padding (16px all sides)
  static const EdgeInsets medium = EdgeInsets.all(CorpoSpacing.medium);

  /// Large padding (24px all sides)
  static const EdgeInsets large = EdgeInsets.all(CorpoSpacing.large);

  /// Extra large padding (32px all sides)
  static const EdgeInsets extraLarge = EdgeInsets.all(CorpoSpacing.extraLarge);

  /// Horizontal small padding (8px left/right)
  static const EdgeInsets horizontalSmall = EdgeInsets.symmetric(
    horizontal: CorpoSpacing.small,
  );

  /// Horizontal medium padding (16px left/right)
  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(
    horizontal: CorpoSpacing.medium,
  );

  /// Vertical small padding (8px top/bottom)
  static const EdgeInsets verticalSmall = EdgeInsets.symmetric(
    vertical: CorpoSpacing.small,
  );

  /// Vertical medium padding (16px top/bottom)
  static const EdgeInsets verticalMedium = EdgeInsets.symmetric(
    vertical: CorpoSpacing.medium,
  );
}
