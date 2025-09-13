/// Corpo UI theme system for consistent design across Flutter applications.
///
/// This file provides the main theme implementation for Corpo UI, extending
/// Flutter's ThemeData with corporate design principles and customizations.
/// The theme system includes light and dark variants with full Material Design
/// integration while maintaining the professional aesthetic of corporate applications.
///
/// The theme includes:
/// - Color schemes based on Corpo UI design tokens
/// - Typography system integration
/// - Component theming for consistent appearance
/// - Responsive design support
/// - Accessibility optimizations
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

import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/typography.dart';

/// Main theme class for Corpo UI design system.
///
/// Provides static methods to generate light and dark themes
/// with consistent corporate styling and professional appearance.
abstract final class CorpoTheme {
  /// Creates a light theme with corporate design principles.
  ///
  /// This theme uses light backgrounds with dark text for optimal
  /// readability and professional appearance in corporate environments.
  static ThemeData light() {
    const ColorScheme colorScheme = ColorScheme.light(
      // Primary colors
      primary: CorpoColors.primary500,
      primaryContainer: CorpoColors.primary100,
      onPrimaryContainer: CorpoColors.primary700,

      // Secondary colors
      secondary: CorpoColors.secondary500,
      onSecondary: CorpoColors.neutralWhite,
      secondaryContainer: CorpoColors.secondary100,
      onSecondaryContainer: CorpoColors.secondary700,
      onSurface: CorpoColors.textPrimary,
      surfaceContainerHighest: CorpoColors.neutral50,
      onSurfaceVariant: CorpoColors.textSecondary,

      // Error colors
      error: CorpoColors.error,
      errorContainer: CorpoColors.errorBackground,
      onErrorContainer: CorpoColors.error,

      // Outline colors
      outline: CorpoColors.borderPrimary,
      outlineVariant: CorpoColors.borderSecondary,
    );

    return ThemeData(
      // Core theme properties
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,

      // Typography
      textTheme: _buildTextTheme(CorpoColors.textPrimary),

      // App bar theme
      appBarTheme: _buildAppBarTheme(colorScheme),

      // Card theme
      cardTheme: _buildCardTheme(colorScheme),

      // Elevated button theme
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),

      // Text button theme
      textButtonTheme: _buildTextButtonTheme(colorScheme),

      // Outlined button theme
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),

      // Input decoration theme
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),

      // Divider theme
      dividerTheme: _buildDividerTheme(colorScheme),

      // Dialog theme
      dialogTheme: _buildDialogTheme(colorScheme),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(colorScheme),

      // Tab bar theme
      tabBarTheme: _buildTabBarTheme(colorScheme),

      // Chip theme
      chipTheme: _buildChipTheme(colorScheme),
    );
  }

  /// Creates a dark theme with corporate design principles.
  ///
  /// This theme uses dark backgrounds with light text while maintaining
  /// the professional corporate aesthetic and proper contrast ratios.
  static ThemeData dark() {
    const ColorScheme colorScheme = ColorScheme.dark(
      // Primary colors
      primary: CorpoColors.primary400,
      primaryContainer: CorpoColors.primary700,
      onPrimaryContainer: CorpoColors.primary100,

      // Secondary colors
      secondary: CorpoColors.secondary400,
      secondaryContainer: CorpoColors.secondary700,
      onSecondaryContainer: CorpoColors.secondary100,

      // Surface colors
      surface: CorpoColors.neutral900,
      onSurface: CorpoColors.neutral100,
      surfaceContainerHighest: CorpoColors.neutral800,
      onSurfaceVariant: CorpoColors.neutral300,

      // Error colors
      error: CorpoColors.error,
      errorContainer: CorpoColors.neutral800,
      onErrorContainer: CorpoColors.error,

      // Outline colors
      outline: CorpoColors.neutral600,
      outlineVariant: CorpoColors.neutral700,
    );

    return ThemeData(
      // Core theme properties
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,

      // Typography
      textTheme: _buildTextTheme(CorpoColors.neutral100),

      // App bar theme
      appBarTheme: _buildAppBarTheme(colorScheme),

      // Card theme
      cardTheme: _buildCardTheme(colorScheme),

      // Elevated button theme
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),

      // Text button theme
      textButtonTheme: _buildTextButtonTheme(colorScheme),

      // Outlined button theme
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),

      // Input decoration theme
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),

      // Divider theme
      dividerTheme: _buildDividerTheme(colorScheme),

      // Dialog theme
      dialogTheme: _buildDialogTheme(colorScheme),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(colorScheme),

      // Tab bar theme
      tabBarTheme: _buildTabBarTheme(colorScheme),

      // Chip theme
      chipTheme: _buildChipTheme(colorScheme),
    );
  }

  /// Builds the text theme with Corpo UI typography.
  static TextTheme _buildTextTheme(Color defaultColor) => TextTheme(
      // Display styles
      displayLarge: CorpoTypography.displayLarge.copyWith(color: defaultColor),
      displayMedium: CorpoTypography.displayMedium.copyWith(
        color: defaultColor,
      ),
      displaySmall: CorpoTypography.displaySmall.copyWith(color: defaultColor),

      // Headline styles
      headlineLarge: CorpoTypography.heading1.copyWith(color: defaultColor),
      headlineMedium: CorpoTypography.heading2.copyWith(color: defaultColor),
      headlineSmall: CorpoTypography.heading3.copyWith(color: defaultColor),

      // Title styles
      titleLarge: CorpoTypography.heading4.copyWith(color: defaultColor),
      titleMedium: CorpoTypography.labelLarge.copyWith(color: defaultColor),
      titleSmall: CorpoTypography.labelMedium.copyWith(color: defaultColor),

      // Body styles
      bodyLarge: CorpoTypography.bodyLarge.copyWith(color: defaultColor),
      bodyMedium: CorpoTypography.bodyMedium.copyWith(color: defaultColor),
      bodySmall: CorpoTypography.bodySmall.copyWith(color: defaultColor),

      // Label styles
      labelLarge: CorpoTypography.buttonLarge.copyWith(color: defaultColor),
      labelMedium: CorpoTypography.buttonMedium.copyWith(color: defaultColor),
      labelSmall: CorpoTypography.buttonSmall.copyWith(color: defaultColor),
    );

  /// Builds the app bar theme.
  static AppBarTheme _buildAppBarTheme(ColorScheme colorScheme) => AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: CorpoTypography.heading4.copyWith(
        color: colorScheme.onSurface,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: colorScheme.brightness,
        statusBarIconBrightness: colorScheme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );

  /// Builds the card theme.
  static CardThemeData _buildCardTheme(ColorScheme colorScheme) => CardThemeData(
      color: colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.outline),
      ),
      margin: CorpoPadding.medium,
    );

  /// Builds the elevated button theme.
  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    ColorScheme colorScheme,
  ) => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        padding: CorpoPadding.medium,
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: CorpoTypography.buttonMedium,
      ),
    );

  /// Builds the text button theme.
  static TextButtonThemeData _buildTextButtonTheme(ColorScheme colorScheme) => TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        padding: CorpoPadding.medium,
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: CorpoTypography.buttonMedium,
      ),
    );

  /// Builds the outlined button theme.
  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    ColorScheme colorScheme,
  ) => OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        padding: CorpoPadding.medium,
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: colorScheme.outline, width: 1.5),
        textStyle: CorpoTypography.buttonMedium,
      ),
    );

  /// Builds the input decoration theme.
  static InputDecorationTheme _buildInputDecorationTheme(
    ColorScheme colorScheme,
  ) => InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: CorpoPadding.medium,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      labelStyle: CorpoTypography.labelMedium.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      hintStyle: CorpoTypography.bodyMedium.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );

  /// Builds the divider theme.
  static DividerThemeData _buildDividerTheme(ColorScheme colorScheme) => DividerThemeData(
      color: colorScheme.outline,
      thickness: 1,
      space: CorpoSpacing.medium,
    );

  /// Builds the dialog theme.
  static DialogThemeData _buildDialogTheme(ColorScheme colorScheme) => DialogThemeData(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      titleTextStyle: CorpoTypography.heading3.copyWith(
        color: colorScheme.onSurface,
      ),
      contentTextStyle: CorpoTypography.bodyMedium.copyWith(
        color: colorScheme.onSurface,
      ),
    );

  /// Builds the bottom navigation bar theme.
  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme(
    ColorScheme colorScheme,
  ) => BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );

  /// Builds the tab bar theme.
  static TabBarThemeData _buildTabBarTheme(ColorScheme colorScheme) => TabBarThemeData(
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      labelStyle: CorpoTypography.labelMedium,
      unselectedLabelStyle: CorpoTypography.labelMedium,
    );

  /// Builds the chip theme.
  static ChipThemeData _buildChipTheme(ColorScheme colorScheme) => ChipThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      selectedColor: colorScheme.primaryContainer,
      disabledColor: CorpoColors.surfaceDisabled,
      deleteIconColor: colorScheme.onSurfaceVariant,
      labelStyle: CorpoTypography.labelSmall.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      padding: CorpoPadding.small,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
}
