/// Corpo UI theme system for consistent design across Flutter applications.
///
/// This file provides the main theme implementation for Corpo UI, extending
/// Flutter's ThemeData with corporate design principles and customizations.
/// The theme system now uses CorpoDesignTokens for complete ShadCN-style theming.
///
/// Example usage:
/// ```dart
/// MaterialApp(
///   theme: CorpoTheme.light(),
///   darkTheme: CorpoTheme.dark(),
///   themeMode: ThemeMode.system,
///   home: MyApp(),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../design_tokens.dart';

/// Main theme class for Corpo UI design system.
///
/// Provides static methods to generate light and dark themes
/// with consistent corporate styling using design tokens.
abstract final class CorpoTheme {
  /// Creates a light theme with corporate design principles.
  static ThemeData light() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    
    final ColorScheme colorScheme = ColorScheme.light(
      primary: tokens.primaryColor,
      secondary: tokens.secondaryColor,
      error: tokens.errorColor,
      surface: tokens.surfaceColor,
      onSurface: tokens.textPrimary,
      onSurfaceVariant: tokens.textSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,
      fontFamily: tokens.fontFamily,
    );
  }

  /// Creates a dark theme with corporate design principles.
  static ThemeData dark() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    
    final ColorScheme colorScheme = ColorScheme.dark(
      primary: tokens.primaryColor,
      secondary: tokens.secondaryColor,
      error: tokens.errorColor,
      surface: const Color(0xFF1A202C),
      onSurface: tokens.surfaceColor,
      onSurfaceVariant: tokens.textSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      fontFamily: tokens.fontFamily,
    );
  }
}