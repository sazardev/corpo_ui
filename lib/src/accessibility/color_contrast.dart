/// Color contrast validation utilities for the Corpo UI design system.
///
/// This file provides comprehensive color contrast validation and
/// adjustment utilities to ensure WCAG compliance and excellent
/// accessibility for users with visual impairments.
///
/// The contrast system includes:
/// - WCAG 2.1 contrast ratio calculations
/// - Automatic color adjustments for compliance
/// - Color blindness simulation and testing
/// - High contrast mode support
///
/// Example usage:
/// ```dart
/// final isCompliant = CorpoContrastValidator.validateContrast(
///   foreground: Colors.black,
///   background: Colors.white,
///   level: WCAGLevel.aa,
/// );
/// ```
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// WCAG compliance levels for color contrast.
enum WCAGLevel {
  /// WCAG AA standard (4.5:1 for normal text, 3:1 for large text)
  aa,

  /// WCAG AAA standard (7:1 for normal text, 4.5:1 for large text)
  aaa,

  /// Custom contrast ratio
  custom,
}

/// Text size categories for contrast calculations.
enum TextSizeCategory {
  /// Normal text (less than 18pt or 14pt bold)
  normal,

  /// Large text (18pt+ or 14pt+ bold)
  large,
}

/// Types of color blindness for simulation.
enum ColorBlindnessType {
  /// No color blindness
  none,

  /// Protanopia (red-blind)
  protanopia,

  /// Deuteranopia (green-blind)
  deuteranopia,

  /// Tritanopia (blue-blind)
  tritanopia,

  /// Protanomaly (red-weak)
  protanomaly,

  /// Deuteranomaly (green-weak)
  deuteranomaly,

  /// Tritanomaly (blue-weak)
  tritanomaly,

  /// Monochromacy (complete color blindness)
  monochromacy,
}

/// Result of a color contrast validation.
class ContrastValidationResult {
  /// Creates a contrast validation result.
  const ContrastValidationResult({
    required this.ratio,
    required this.isCompliant,
    required this.level,
    required this.requiredRatio,
    this.adjustedForeground,
    this.adjustedBackground,
  });

  /// The calculated contrast ratio.
  final double ratio;

  /// Whether the contrast meets the required level.
  final bool isCompliant;

  /// The WCAG level that was tested.
  final WCAGLevel level;

  /// The minimum required contrast ratio.
  final double requiredRatio;

  /// Suggested adjusted foreground color for compliance.
  final Color? adjustedForeground;

  /// Suggested adjusted background color for compliance.
  final Color? adjustedBackground;

  @override
  String toString() => 'ContrastValidationResult('
        'ratio: ${ratio.toStringAsFixed(2)}, '
        'isCompliant: $isCompliant, '
        'level: $level, '
        'requiredRatio: ${requiredRatio.toStringAsFixed(2)}'
        ')';
}

/// Utility class for color contrast validation and adjustment.
abstract final class CorpoContrastValidator {
  /// Validates color contrast according to WCAG guidelines.
  static ContrastValidationResult validateContrast({
    required Color foreground,
    required Color background,
    WCAGLevel level = WCAGLevel.aa,
    TextSizeCategory textSize = TextSizeCategory.normal,
    double? customRatio,
  }) {
    final double ratio = calculateContrastRatio(foreground, background);
    final double requiredRatio = _getRequiredRatio(level, textSize, customRatio);
    final bool isCompliant = ratio >= requiredRatio;

    Color? adjustedForeground;
    Color? adjustedBackground;

    if (!isCompliant) {
      adjustedForeground = adjustColorForContrast(
        foreground,
        background,
        requiredRatio,
      );
      adjustedBackground = adjustColorForContrast(
        foreground,
        background,
        requiredRatio,
        adjustForeground: false,
      );
    }

    return ContrastValidationResult(
      ratio: ratio,
      isCompliant: isCompliant,
      level: level,
      requiredRatio: requiredRatio,
      adjustedForeground: adjustedForeground,
      adjustedBackground: adjustedBackground,
    );
  }

  /// Calculates the contrast ratio between two colors.
  ///
  /// Returns a value between 1:1 (no contrast) and 21:1 (maximum contrast).
  static double calculateContrastRatio(Color color1, Color color2) {
    final double luminance1 = calculateLuminance(color1);
    final double luminance2 = calculateLuminance(color2);

    final double lighter = math.max(luminance1, luminance2);
    final double darker = math.min(luminance1, luminance2);

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Calculates the relative luminance of a color.
  ///
  /// Uses the WCAG formula for luminance calculation.
  static double calculateLuminance(Color color) {
    final double r = _linearizeColorComponent(color.red / 255.0);
    final double g = _linearizeColorComponent(color.green / 255.0);
    final double b = _linearizeColorComponent(color.blue / 255.0);

    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Adjusts a color to meet the required contrast ratio.
  static Color adjustColorForContrast(
    Color foreground,
    Color background,
    double requiredRatio, {
    bool adjustForeground = true,
  }) {
    final Color targetColor = adjustForeground ? foreground : background;
    final Color referenceColor = adjustForeground ? background : foreground;

    // Try making the color darker first
    Color adjusted = _adjustColorBrightness(targetColor, -0.1);
    double ratio = calculateContrastRatio(
      adjustForeground ? adjusted : referenceColor,
      adjustForeground ? referenceColor : adjusted,
    );

    // If darker doesn't work, try lighter
    if (ratio < requiredRatio) {
      adjusted = _adjustColorBrightness(targetColor, 0.1);
      ratio = calculateContrastRatio(
        adjustForeground ? adjusted : referenceColor,
        adjustForeground ? referenceColor : adjusted,
      );
    }

    // Binary search for the optimal brightness
    const double step = 0.05;
    int iterations = 0;
    const int maxIterations = 20;

    while (ratio < requiredRatio && iterations < maxIterations) {
      if (calculateLuminance(adjusted) < calculateLuminance(referenceColor)) {
        // Make darker
        adjusted = _adjustColorBrightness(adjusted, -step);
      } else {
        // Make lighter
        adjusted = _adjustColorBrightness(adjusted, step);
      }

      ratio = calculateContrastRatio(
        adjustForeground ? adjusted : referenceColor,
        adjustForeground ? referenceColor : adjusted,
      );

      iterations++;
    }

    return adjusted;
  }

  /// Simulates color blindness for testing purposes.
  static Color simulateColorBlindness(Color color, ColorBlindnessType type) {
    switch (type) {
      case ColorBlindnessType.none:
        return color;

      case ColorBlindnessType.protanopia:
        return _simulateProtanopia(color);

      case ColorBlindnessType.deuteranopia:
        return _simulateDeuteranopia(color);

      case ColorBlindnessType.tritanopia:
        return _simulateTritanopia(color);

      case ColorBlindnessType.protanomaly:
        return _simulateProtanomaly(color);

      case ColorBlindnessType.deuteranomaly:
        return _simulateDeuteranomaly(color);

      case ColorBlindnessType.tritanomaly:
        return _simulateTritanomaly(color);

      case ColorBlindnessType.monochromacy:
        return _simulateMonochromacy(color);
    }
  }

  /// Checks if two colors are distinguishable for color-blind users.
  static bool areColorsDistinguishable(
    Color color1,
    Color color2,
    List<ColorBlindnessType> types,
  ) {
    for (final ColorBlindnessType type in types) {
      final Color simulated1 = simulateColorBlindness(color1, type);
      final Color simulated2 = simulateColorBlindness(color2, type);

      final double contrast = calculateContrastRatio(simulated1, simulated2);
      if (contrast < 1.5) {
        return false;
      }
    }
    return true;
  }

  /// Generates a high contrast variant of a color.
  static Color getHighContrastVariant(Color color, Color background) {
    final double backgroundLuminance = calculateLuminance(background);

    // If background is dark, make foreground light
    if (backgroundLuminance < 0.5) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  /// Gets colors optimized for high contrast mode.
  static ColorScheme getHighContrastColorScheme(bool isDark) {
    if (isDark) {
      return const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white,
        surface: Colors.black,
        error: Color(0xFFFF6B6B),
      );
    } else {
      return const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Color(0xFFD32F2F),
      );
    }
  }

  // Private helper methods

  static double _getRequiredRatio(
    WCAGLevel level,
    TextSizeCategory textSize,
    double? customRatio,
  ) {
    if (level == WCAGLevel.custom && customRatio != null) {
      return customRatio;
    }

    switch (level) {
      case WCAGLevel.aa:
        return textSize == TextSizeCategory.large ? 3.0 : 4.5;
      case WCAGLevel.aaa:
        return textSize == TextSizeCategory.large ? 4.5 : 7.0;
      case WCAGLevel.custom:
        return customRatio ?? 4.5;
    }
  }

  static double _linearizeColorComponent(double component) {
    if (component <= 0.03928) {
      return component / 12.92;
    } else {
      return math.pow((component + 0.055) / 1.055, 2.4).toDouble();
    }
  }

  static Color _adjustColorBrightness(Color color, double factor) {
    final HSLColor hsl = HSLColor.fromColor(color);
    final double newLightness = (hsl.lightness + factor).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }

  // Color blindness simulation methods
  static Color _simulateProtanopia(Color color) {
    // Simplified protanopia simulation
    final double r = 0.567 * color.red + 0.433 * color.green;
    final double g = 0.558 * color.red + 0.442 * color.green;
    final double b = color.blue.toDouble();

    return Color.fromARGB(
      color.alpha,
      r.round().clamp(0, 255),
      g.round().clamp(0, 255),
      b.round().clamp(0, 255),
    );
  }

  static Color _simulateDeuteranopia(Color color) {
    // Simplified deuteranopia simulation
    final double r = 0.625 * color.red + 0.375 * color.green;
    final double g = 0.7 * color.red + 0.3 * color.green;
    final double b = color.blue.toDouble();

    return Color.fromARGB(
      color.alpha,
      r.round().clamp(0, 255),
      g.round().clamp(0, 255),
      b.round().clamp(0, 255),
    );
  }

  static Color _simulateTritanopia(Color color) {
    // Simplified tritanopia simulation
    final double r = color.red.toDouble();
    final double g = 0.95 * color.green + 0.05 * color.blue;
    final double b = 0.433 * color.green + 0.567 * color.blue;

    return Color.fromARGB(
      color.alpha,
      r.round().clamp(0, 255),
      g.round().clamp(0, 255),
      b.round().clamp(0, 255),
    );
  }

  static Color _simulateProtanomaly(Color color) {
    // Milder version of protanopia
    final Color normal = color;
    final Color protanopia = _simulateProtanopia(color);
    return Color.lerp(normal, protanopia, 0.6)!;
  }

  static Color _simulateDeuteranomaly(Color color) {
    // Milder version of deuteranopia
    final Color normal = color;
    final Color deuteranopia = _simulateDeuteranopia(color);
    return Color.lerp(normal, deuteranopia, 0.6)!;
  }

  static Color _simulateTritanomaly(Color color) {
    // Milder version of tritanopia
    final Color normal = color;
    final Color tritanopia = _simulateTritanopia(color);
    return Color.lerp(normal, tritanopia, 0.6)!;
  }

  static Color _simulateMonochromacy(Color color) {
    // Convert to grayscale using luminance formula
    final double luminance = calculateLuminance(color);
    final int gray = (luminance * 255).round();

    return Color.fromARGB(color.alpha, gray, gray, gray);
  }
}

/// Widget that provides color contrast validation in real-time.
class CorpoContrastTester extends StatelessWidget {
  /// Creates a contrast tester.
  const CorpoContrastTester({
    required this.child,
    required this.foregroundColor,
    required this.backgroundColor,
    this.level = WCAGLevel.aa,
    this.textSize = TextSizeCategory.normal,
    this.showWarning = true,
    this.onContrastIssue,
    super.key,
  });

  /// The child widget to test contrast for.
  final Widget child;

  /// The foreground color.
  final Color foregroundColor;

  /// The background color.
  final Color backgroundColor;

  /// The WCAG level to test against.
  final WCAGLevel level;

  /// The text size category.
  final TextSizeCategory textSize;

  /// Whether to show visual warnings for contrast issues.
  final bool showWarning;

  /// Callback for contrast issues.
  final void Function(ContrastValidationResult)? onContrastIssue;

  @override
  Widget build(BuildContext context) {
    final ContrastValidationResult result = CorpoContrastValidator.validateContrast(
      foreground: foregroundColor,
      background: backgroundColor,
      level: level,
      textSize: textSize,
    );

    if (!result.isCompliant) {
      onContrastIssue?.call(result);

      if (showWarning) {
        return Stack(
          children: <Widget>[
            child,
            if (showWarning)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        );
      }
    }

    return child;
  }
}
