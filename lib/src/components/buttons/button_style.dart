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

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Button styling configurations for the Corpo UI design system.
///
/// Provides static methods to generate ButtonStyle objects for different
/// button variants, ensuring consistency and maintainability across
/// the component library.
abstract final class CorpoButtonStyle {
  /// Creates the primary button style.
  ///
  /// Primary buttons are used for the main call-to-action in a interface.
  /// They have high visual prominence with solid background colors.
  static ButtonStyle primary({required bool isDark, bool isEnabled = true}) {
    final Color backgroundColor = isEnabled
        ? CorpoColors.primary500
        : (isDark ? CorpoColors.neutral700 : CorpoColors.neutral300);

    final Color foregroundColor = isEnabled
        ? CorpoColors.neutralWhite
        : (isDark ? CorpoColors.neutral500 : CorpoColors.neutral400);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled ? CorpoColors.primary700 : backgroundColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled ? CorpoColors.primary600 : backgroundColor;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled ? CorpoColors.primary600 : backgroundColor;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return CorpoColors.neutralWhite.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return CorpoColors.neutralWhite.withOpacity(0.05);
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
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(CorpoPadding.medium),
      minimumSize: WidgetStateProperty.all<Size>(const Size(88, 40)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        CorpoTypography.labelMedium.copyWith(
          fontWeight: CorpoFontWeight.semiBold,
        ),
      ),
    );
  }

  /// Creates the secondary button style.
  ///
  /// Secondary buttons are used for secondary actions and have
  /// a subtle background with border emphasis.
  static ButtonStyle secondary({required bool isDark, bool isEnabled = true}) {
    final Color backgroundColor = isDark
        ? CorpoColors.neutral800
        : CorpoColors.neutralWhite;
    final Color borderColor = isEnabled
        ? CorpoColors.primary500
        : (isDark ? CorpoColors.neutral600 : CorpoColors.neutral300);

    final Color foregroundColor = isEnabled
        ? CorpoColors.primary500
        : (isDark ? CorpoColors.neutral500 : CorpoColors.neutral400);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled ? CorpoColors.primary50 : backgroundColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled ? CorpoColors.primary50 : backgroundColor;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled ? CorpoColors.primary50 : backgroundColor;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return CorpoColors.primary500.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return CorpoColors.primary500.withOpacity(0.05);
        }
        return null;
      }),
      elevation: WidgetStateProperty.all<double>(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(CorpoPadding.medium),
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
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        CorpoTypography.labelMedium.copyWith(
          fontWeight: CorpoFontWeight.semiBold,
        ),
      ),
    );
  }

  /// Creates the tertiary button style.
  ///
  /// Tertiary buttons are used for minimal actions and have
  /// no background or border in their default state.
  static ButtonStyle tertiary({required bool isDark, bool isEnabled = true}) {
    final Color foregroundColor = isEnabled
        ? CorpoColors.primary500
        : (isDark ? CorpoColors.neutral500 : CorpoColors.neutral400);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled ? CorpoColors.primary100 : Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled ? CorpoColors.primary50 : Colors.transparent;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled ? CorpoColors.primary50 : Colors.transparent;
        }
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return CorpoColors.primary500.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return CorpoColors.primary500.withOpacity(0.05);
        }
        return null;
      }),
      elevation: WidgetStateProperty.all<double>(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(CorpoPadding.medium),
      minimumSize: WidgetStateProperty.all<Size>(const Size(88, 40)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        CorpoTypography.labelMedium.copyWith(
          fontWeight: CorpoFontWeight.semiBold,
        ),
      ),
    );
  }

  /// Creates the danger button style.
  ///
  /// Danger buttons are used for destructive actions and have
  /// prominent red/error coloring to warn users.
  static ButtonStyle danger({required bool isDark, bool isEnabled = true}) {
    final Color backgroundColor = isEnabled
        ? CorpoColors.error
        : (isDark ? CorpoColors.neutral700 : CorpoColors.neutral300);

    final Color foregroundColor = isEnabled
        ? CorpoColors.neutralWhite
        : (isDark ? CorpoColors.neutral500 : CorpoColors.neutral400);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled ? CorpoColors.error : backgroundColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled ? CorpoColors.error : backgroundColor;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled ? CorpoColors.error : backgroundColor;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (!isEnabled) return null;
        if (states.contains(WidgetState.pressed)) {
          return CorpoColors.neutralWhite.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return CorpoColors.neutralWhite.withOpacity(0.05);
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
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(CorpoPadding.medium),
      minimumSize: WidgetStateProperty.all<Size>(const Size(88, 40)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        CorpoTypography.labelMedium.copyWith(
          fontWeight: CorpoFontWeight.semiBold,
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
    final Color foregroundColor = isEnabled
        ? (isDark ? CorpoColors.neutral200 : CorpoColors.neutral700)
        : (isDark ? CorpoColors.neutral600 : CorpoColors.neutral400);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isEnabled
              ? (isDark ? CorpoColors.neutral700 : CorpoColors.neutral200)
              : Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return isEnabled
              ? (isDark ? CorpoColors.neutral800 : CorpoColors.neutral100)
              : Colors.transparent;
        }
        if (states.contains(WidgetState.focused)) {
          return isEnabled
              ? (isDark ? CorpoColors.neutral800 : CorpoColors.neutral100)
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
          return isDark
              ? CorpoColors.neutralWhite.withOpacity(0.1)
              : CorpoColors.neutralBlack.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return isDark
              ? CorpoColors.neutralWhite.withOpacity(0.05)
              : CorpoColors.neutralBlack.withOpacity(0.05);
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
