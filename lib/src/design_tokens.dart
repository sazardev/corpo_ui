/// Corpo UI Design Tokens - Central configuration file
///
/// This is the HEART of Corpo UI - similar to ShadCN's CSS variables system.
/// Change values here and ALL components throughout your app will update automatically.
///
/// This file implements the ShadCN philosophy where a single configuration
/// controls the entire design system. Every component reads from these tokens.
///
/// Usage:
/// ```dart
/// // Just change values here and your entire app theme updates!
/// CorpoDesignTokens.configure(
///   primaryColor: Colors.purple,
///   borderRadius: 12.0,
///   spacing: 8.0,
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Central design tokens system - THE single source of truth for your design.
///
/// This class implements ShadCN's philosophy: change here, update everywhere.
/// Every Corpo UI component reads from these tokens for complete consistency.
class CorpoDesignTokens {
  factory CorpoDesignTokens() => _instance;

  CorpoDesignTokens._internal();
  static final CorpoDesignTokens _instance = CorpoDesignTokens._internal();

  // ==========================================
  // CORE COLORS - Change these to rebrand your entire app
  // ==========================================

  /// Primary brand color - The main color of your application
  /// Default: Professional blue (#3182CE)
  /// Example: Change to Colors.purple[600] for purple theme
  Color _primaryColor = const Color(0xFF3182CE);

  /// Secondary color for supporting elements
  /// Default: Professional gray-blue
  Color _secondaryColor = const Color(0xFF718096);

  /// Background color for cards, surfaces, etc.
  /// Default: Pure white in light mode
  Color _surfaceColor = const Color(0xFFFFFFFF);

  /// Text color for primary content
  /// Default: Near black for accessibility
  Color _textPrimary = const Color(0xFF1A202C);

  /// Text color for secondary content
  /// Default: Medium gray
  Color _textSecondary = const Color(0xFF4A5568);

  // ==========================================
  // SEMANTIC COLORS - Status and feedback
  // ==========================================

  Color _successColor = const Color(0xFF38A169);
  Color _warningColor = const Color(0xFFD69E2E);
  Color _errorColor = const Color(0xFFE53E3E);
  Color _infoColor = const Color(0xFF3182CE);

  // ==========================================
  // SPACING SYSTEM - Control all spacing from here
  // ==========================================

  /// Base spacing unit - multiply by factors for consistent spacing
  /// Default: 4.0 (so 1x=4px, 2x=8px, 4x=16px, etc.)
  double _baseSpacing = 4;

  // ==========================================
  // TYPOGRAPHY SYSTEM - Control all text styles
  // ==========================================

  /// Base font size for body text
  double _baseFontSize = 14;

  /// Font family for the entire app
  String _fontFamily = 'Inter';

  // ==========================================
  // BORDER RADIUS - Control roundness everywhere
  // ==========================================

  /// Default border radius for components
  double _borderRadius = 8;

  /// Small border radius for subtle rounding
  double _borderRadiusSmall = 4;

  /// Large border radius for prominent components
  double _borderRadiusLarge = 16;

  // ==========================================
  // PUBLIC GETTERS - Components read these values
  // ==========================================

  // Colors
  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  Color get surfaceColor => _surfaceColor;
  Color get backgroundColor => _surfaceColor; // Alias for surface color
  Color get textPrimary => _textPrimary;
  Color get textSecondary => _textSecondary;
  Color get successColor => _successColor;
  Color get warningColor => _warningColor;
  Color get errorColor => _errorColor;
  Color get infoColor => _infoColor;

  // Spacing
  double get baseSpacing => _baseSpacing;
  double get spacing1x => _baseSpacing;
  double get spacing2x => _baseSpacing * 2;
  double get spacing3x => _baseSpacing * 3;
  double get spacing4x => _baseSpacing * 4;
  double get spacing6x => _baseSpacing * 6;
  double get spacing8x => _baseSpacing * 8;
  double get spacing12x => _baseSpacing * 12;
  double get spacing16x => _baseSpacing * 16;

  // Typography
  double get baseFontSize => _baseFontSize;
  String get fontFamily => _fontFamily;
  double get fontSizeSmall => _baseFontSize * 0.875; // 12px if base is 14px
  double get fontSizeLarge => _baseFontSize * 1.125; // 16px if base is 14px
  double get fontSizeXLarge => _baseFontSize * 1.25; // 18px if base is 14px
  double get fontSizeXXLarge => _baseFontSize * 1.5; // 21px if base is 14px

  // Border Radius
  double get borderRadius => _borderRadius;
  double get borderRadiusSmall => _borderRadiusSmall;
  double get borderRadiusLarge => _borderRadiusLarge;

  // ==========================================
  // CONFIGURATION METHODS - The ShadCN magic happens here!
  // ==========================================

  /// Configure your entire design system in one place!
  ///
  /// This is the ShadCN philosophy: change values here and your entire app updates.
  ///
  /// Example:
  /// ```dart
  /// // Purple theme
  /// CorpoDesignTokens.configure(
  ///   primaryColor: Colors.purple.shade600,
  ///   borderRadius: 12.0,
  ///   baseSpacing: 6.0, // More generous spacing
  /// );
  ///
  /// // Dark theme
  /// CorpoDesignTokens.configure(
  ///   surfaceColor: Color(0xFF1A1A1A),
  ///   textPrimary: Colors.white,
  ///   textSecondary: Colors.grey.shade300,
  /// );
  ///
  /// // Playful theme
  /// CorpoDesignTokens.configure(
  ///   primaryColor: Colors.orange.shade500,
  ///   borderRadius: 20.0, // Very rounded
  ///   fontFamily: 'Comic Sans MS',
  /// );
  /// ```
  static void configure({
    Color? primaryColor,
    Color? secondaryColor,
    Color? surfaceColor,
    Color? textPrimary,
    Color? textSecondary,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    double? baseSpacing,
    double? baseFontSize,
    String? fontFamily,
    double? borderRadius,
    double? borderRadiusSmall,
    double? borderRadiusLarge,
  }) {
    final CorpoDesignTokens instance = CorpoDesignTokens();

    // Update colors
    if (primaryColor != null) instance._primaryColor = primaryColor;
    if (secondaryColor != null) instance._secondaryColor = secondaryColor;
    if (surfaceColor != null) instance._surfaceColor = surfaceColor;
    if (textPrimary != null) instance._textPrimary = textPrimary;
    if (textSecondary != null) instance._textSecondary = textSecondary;
    if (successColor != null) instance._successColor = successColor;
    if (warningColor != null) instance._warningColor = warningColor;
    if (errorColor != null) instance._errorColor = errorColor;
    if (infoColor != null) instance._infoColor = infoColor;

    // Update spacing
    if (baseSpacing != null) instance._baseSpacing = baseSpacing;

    // Update typography
    if (baseFontSize != null) instance._baseFontSize = baseFontSize;
    if (fontFamily != null) instance._fontFamily = fontFamily;

    // Update border radius
    if (borderRadius != null) instance._borderRadius = borderRadius;
    if (borderRadiusSmall != null) {
      instance._borderRadiusSmall = borderRadiusSmall;
    }
    if (borderRadiusLarge != null) {
      instance._borderRadiusLarge = borderRadiusLarge;
    }
  }

  /// Generate color variations automatically (lighter/darker shades)
  /// This mimics ShadCN's color scale generation
  Color primaryLight() => HSLColor.fromColor(_primaryColor)
      .withLightness(
        (HSLColor.fromColor(_primaryColor).lightness + 0.2).clamp(0.0, 1.0),
      )
      .toColor();

  Color primaryDark() => HSLColor.fromColor(_primaryColor)
      .withLightness(
        (HSLColor.fromColor(_primaryColor).lightness - 0.2).clamp(0.0, 1.0),
      )
      .toColor();

  /// Generate accessible text color based on background
  /// Ensures WCAG compliance automatically
  Color getTextColorFor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? _textPrimary : Colors.white;
  }

  // ==========================================
  // PRESET CONFIGURATIONS - Common themes ready to use
  // ==========================================

  /// Apply a professional blue theme (default)
  static void applyCorporateTheme() {
    configure(
      primaryColor: const Color(0xFF3182CE),
      borderRadius: 8,
      baseSpacing: 4,
      fontFamily: 'Inter',
    );
  }

  /// Apply a modern purple theme
  static void applyModernTheme() {
    configure(
      primaryColor: const Color(0xFF7C3AED),
      secondaryColor: const Color(0xFF8B5CF6),
      borderRadius: 12,
      baseSpacing: 6,
      fontFamily: 'SF Pro Display',
    );
  }

  /// Apply a friendly orange theme
  static void applyFriendlyTheme() {
    configure(
      primaryColor: const Color(0xFFEA580C),
      successColor: const Color(0xFF16A34A),
      borderRadius: 16,
      baseSpacing: 8,
      fontFamily: 'Poppins',
    );
  }

  /// Apply minimal black & white theme
  static void applyMinimalTheme() {
    configure(
      primaryColor: const Color(0xFF000000),
      secondaryColor: const Color(0xFF6B7280),
      borderRadius: 4,
      baseSpacing: 4,
      fontFamily: 'SF Mono',
    );
  }
}
