/// Corporate button styling definitions and configurations.
///
/// This file provides the ButtonStyle configurations for all Corpo UI
/// button variants, ensuring consistent styling across the design system.
///
/// The styles follow corporate design principles with clear visual hierarchy,
/// accessibility standards, and professional appearance suitable for
/// business applications.
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Button styling configurations for the Corpo UI design system.
///
/// Provides static methods to generate ButtonStyle objects for different
/// button variants, ensuring consistency and maintainability across
/// the component library.
abstract final class CorpoButtonStyle {
  /// Helper method to darken a color by a given factor.
  static Color _darkenColor(Color color, double factor) => Color.fromARGB(
    color.alpha,
    (color.red * (1 - factor)).round(),
    (color.green * (1 - factor)).round(),
    (color.blue * (1 - factor)).round(),
  );

  /// Helper method to lighten a color by a given factor.
  static Color _lightenColor(Color color, double factor) => Color.fromARGB(
    color.alpha,
    (color.red + ((255 - color.red) * factor)).round(),
    (color.green + ((255 - color.green) * factor)).round(),
    (color.blue + ((255 - color.blue) * factor)).round(),
  );

  /// Creates the primary button style.
  ///
  /// Primary buttons are used for the main call-to-action in a interface.
  /// They have high visual prominence with solid background colors.
  static ButtonStyle primary({required bool isDark, bool isEnabled = true}) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color backgroundColor = isEnabled
        ? tokens.primaryColor
        : (isDark
              ? tokens.surfaceColor.withValues(alpha: 0.3)
              : tokens.surfaceColor.withValues(alpha: 0.6));

    final Color foregroundColor = isEnabled
        ? tokens.getTextColorFor(tokens.primaryColor)
        : (isDark
              ? tokens.textSecondary
              : tokens.textSecondary.withValues(alpha: 0.7));

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled
              ? _darkenColor(tokens.primaryColor, 0.2)
              : backgroundColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled
              ? _darkenColor(tokens.primaryColor, 0.1)
              : backgroundColor;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled
              ? _darkenColor(tokens.primaryColor, 0.1)
              : backgroundColor;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return tokens
              .getTextColorFor(tokens.primaryColor)
              .withValues(alpha: 0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return tokens
              .getTextColorFor(tokens.primaryColor)
              .withValues(alpha: 0.05);
        }
        return null;
      }),
      elevation: WidgetStateProperty.resolveWith<double>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return 0;
        if (states.contains(WidgetState.pressed)) return 2;
        if (states.contains(WidgetState.hovered)) return 4;
        return 1;
      }),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.all(tokens.spacing4x),
      ),
      minimumSize: WidgetStateProperty.all<Size>(const Size(88, 40)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Creates the secondary button style.
  ///
  /// Secondary buttons are used for secondary actions and have
  /// a subtle background with border emphasis.
  static ButtonStyle secondary({required bool isDark, bool isEnabled = true}) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color backgroundColor = tokens.surfaceColor;
    final Color borderColor = isEnabled
        ? tokens.primaryColor
        : tokens.textSecondary.withValues(alpha: 0.5);

    final Color foregroundColor = isEnabled
        ? tokens.primaryColor
        : tokens.textSecondary;

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled
              ? _lightenColor(tokens.primaryColor, 0.9)
              : backgroundColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled
              ? _lightenColor(tokens.primaryColor, 0.9)
              : backgroundColor;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled
              ? _lightenColor(tokens.primaryColor, 0.9)
              : backgroundColor;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return tokens.primaryColor.withValues(alpha: 0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return tokens.primaryColor.withValues(alpha: 0.05);
        }
        return null;
      }),
      elevation: WidgetStateProperty.all<double>(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.all(tokens.spacing4x),
      ),
      minimumSize: WidgetStateProperty.all<Size>(const Size(88, 40)),
      side: WidgetStateProperty.resolveWith<BorderSide>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: borderColor, width: 2);
        }
        return BorderSide(color: borderColor);
      }),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Creates the tertiary button style.
  ///
  /// Tertiary buttons are used for minimal actions and have
  /// no background or border in their default state.
  static ButtonStyle tertiary({required bool isDark, bool isEnabled = true}) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color foregroundColor = isEnabled
        ? tokens.primaryColor
        : tokens.textSecondary;

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled
              ? _lightenColor(tokens.primaryColor, 0.8)
              : Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled
              ? _lightenColor(tokens.primaryColor, 0.9)
              : Colors.transparent;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled
              ? _lightenColor(tokens.primaryColor, 0.9)
              : Colors.transparent;
        }
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return tokens.primaryColor.withValues(alpha: 0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return tokens.primaryColor.withValues(alpha: 0.05);
        }
        return null;
      }),
      elevation: WidgetStateProperty.all<double>(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.all(tokens.spacing4x),
      ),
      minimumSize: WidgetStateProperty.all<Size>(const Size(88, 40)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Creates the danger button style.
  ///
  /// Danger buttons are used for destructive actions and have
  /// prominent red/error coloring to warn users.
  static ButtonStyle danger({required bool isDark, bool isEnabled = true}) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color backgroundColor = isEnabled
        ? tokens.errorColor
        : (isDark
              ? tokens.surfaceColor.withValues(alpha: 0.3)
              : tokens.surfaceColor.withValues(alpha: 0.6));

    final Color foregroundColor = isEnabled
        ? tokens.getTextColorFor(tokens.errorColor)
        : tokens.textSecondary;

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled
              ? _darkenColor(tokens.errorColor, 0.2)
              : backgroundColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled
              ? _darkenColor(tokens.errorColor, 0.1)
              : backgroundColor;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled
              ? _darkenColor(tokens.errorColor, 0.1)
              : backgroundColor;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return tokens
              .getTextColorFor(tokens.errorColor)
              .withValues(alpha: 0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return tokens
              .getTextColorFor(tokens.errorColor)
              .withValues(alpha: 0.05);
        }
        return null;
      }),
      elevation: WidgetStateProperty.resolveWith<double>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return 0;
        if (states.contains(WidgetState.pressed)) return 2;
        if (states.contains(WidgetState.hovered)) return 4;
        return 1;
      }),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.all(tokens.spacing4x),
      ),
      minimumSize: WidgetStateProperty.all<Size>(const Size(88, 40)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Creates an icon button style.
  ///
  /// Icon buttons are square buttons designed specifically for icons,
  /// with consistent sizing and padding optimized for touch targets.
  static ButtonStyle icon({
    required bool isDark,
    bool isEnabled = true,
    double size = 40.0,
  }) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color foregroundColor = isEnabled
        ? tokens.textPrimary
        : tokens.textSecondary;

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled
              ? tokens.surfaceColor.withValues(alpha: 0.8)
              : Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled
              ? tokens.surfaceColor.withValues(alpha: 0.9)
              : Colors.transparent;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled
              ? tokens.surfaceColor.withValues(alpha: 0.9)
              : Colors.transparent;
        }
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return tokens.textPrimary.withValues(alpha: 0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return tokens.textPrimary.withValues(alpha: 0.05);
        }
        return null;
      }),
      elevation: WidgetStateProperty.all<double>(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      minimumSize: WidgetStateProperty.all<Size>(Size(size, size)),
      maximumSize: WidgetStateProperty.all<Size>(Size(size, size)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(size / 2)),
      ),
    );
  }
}
