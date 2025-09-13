/// A comprehensive snackbar component for the Corpo UI design system.
///
/// CorpoSnackbar provides consistent toast notification styling and
/// behavior across corporate applications, with support for actions,
/// positioning, and various message types.
///
/// Example usage:
/// ```dart
/// CorpoSnackbar.show(
///   context,
///   message: 'Operation completed successfully',
///   type: CorpoSnackbarType.success,
///   action: CorpoSnackbarAction(
///     label: 'Undo',
///     onPressed: () => undoOperation(),
///   ),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Snackbar types for different message semantics.
enum CorpoSnackbarType {
  /// Default informational snackbar
  info,

  /// Success message snackbar
  success,

  /// Warning message snackbar
  warning,

  /// Error message snackbar
  error,
}

/// Snackbar positioning.
enum CorpoSnackbarPosition {
  /// Bottom of the screen
  bottom,

  /// Top of the screen
  top,
}

/// Action configuration for snackbars.
class CorpoSnackbarAction {
  /// Creates a snackbar action.
  const CorpoSnackbarAction({
    required this.label,
    required this.onPressed,
    this.textColor,
  });

  /// Label text for the action.
  final String label;

  /// Called when the action is pressed.
  final VoidCallback onPressed;

  /// Color of the action text.
  final Color? textColor;
}

/// A comprehensive snackbar widget following Corpo UI design principles.
///
/// This component provides consistent toast notification styling with
/// support for actions, different message types, and accessibility features.
class CorpoSnackbar {
  /// Shows a snackbar with the given configuration.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    CorpoSnackbarType type = CorpoSnackbarType.info,
    CorpoSnackbarAction? action,
    Duration duration = const Duration(seconds: 4),
    CorpoSnackbarPosition position = CorpoSnackbarPosition.bottom,
    bool showCloseIcon = false,
    EdgeInsets? margin,
    double? elevation,
  }) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final SnackBar snackBar = SnackBar(
      content: _buildContent(message, type, isDark),
      backgroundColor: _getBackgroundColor(type, isDark),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: margin ?? _getDefaultMargin(position),
      elevation: elevation ?? 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      action: action != null
          ? SnackBarAction(
              label: action.label,
              onPressed: action.onPressed,
              textColor: action.textColor ?? _getActionColor(type, isDark),
            )
          : null,
      showCloseIcon: showCloseIcon,
      closeIconColor: _getIconColor(type, isDark),
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Shows an info snackbar.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> info(
    BuildContext context, {
    required String message,
    CorpoSnackbarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) => show(
      context,
      message: message,
      action: action,
      duration: duration,
    );

  /// Shows a success snackbar.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context, {
    required String message,
    CorpoSnackbarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) => show(
      context,
      message: message,
      type: CorpoSnackbarType.success,
      action: action,
      duration: duration,
    );

  /// Shows a warning snackbar.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> warning(
    BuildContext context, {
    required String message,
    CorpoSnackbarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) => show(
      context,
      message: message,
      type: CorpoSnackbarType.warning,
      action: action,
      duration: duration,
    );

  /// Shows an error snackbar.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context, {
    required String message,
    CorpoSnackbarAction? action,
    Duration duration = const Duration(seconds: 6),
  }) => show(
      context,
      message: message,
      type: CorpoSnackbarType.error,
      action: action,
      duration: duration,
    );

  static Widget _buildContent(
    String message,
    CorpoSnackbarType type,
    bool isDark,
  ) => Row(
      children: <Widget>[
        Icon(_getIcon(type), color: _getIconColor(type, isDark), size: 20),
        const SizedBox(width: CorpoSpacing.small),
        Expanded(
          child: Text(
            message,
            style: CorpoTypography.bodyMedium.copyWith(
              color: _getTextColor(type, isDark),
            ),
          ),
        ),
      ],
    );

  static IconData _getIcon(CorpoSnackbarType type) {
    switch (type) {
      case CorpoSnackbarType.info:
        return Icons.info_outline;
      case CorpoSnackbarType.success:
        return Icons.check_circle_outline;
      case CorpoSnackbarType.warning:
        return Icons.warning_outlined;
      case CorpoSnackbarType.error:
        return Icons.error_outline;
    }
  }

  static Color _getBackgroundColor(CorpoSnackbarType type, bool isDark) {
    switch (type) {
      case CorpoSnackbarType.info:
        return isDark ? CorpoColors.info : CorpoColors.infoBackground;
      case CorpoSnackbarType.success:
        return isDark ? CorpoColors.success : CorpoColors.successBackground;
      case CorpoSnackbarType.warning:
        return isDark ? CorpoColors.warning : CorpoColors.warningBackground;
      case CorpoSnackbarType.error:
        return isDark ? CorpoColors.error : CorpoColors.errorBackground;
    }
  }

  static Color _getTextColor(CorpoSnackbarType type, bool isDark) {
    switch (type) {
      case CorpoSnackbarType.info:
        return isDark ? CorpoColors.neutralWhite : CorpoColors.info;
      case CorpoSnackbarType.success:
        return isDark ? CorpoColors.neutralWhite : CorpoColors.success;
      case CorpoSnackbarType.warning:
        return isDark ? CorpoColors.neutralWhite : CorpoColors.warning;
      case CorpoSnackbarType.error:
        return isDark ? CorpoColors.neutralWhite : CorpoColors.error;
    }
  }

  static Color _getIconColor(CorpoSnackbarType type, bool isDark) => _getTextColor(type, isDark);

  static Color _getActionColor(CorpoSnackbarType type, bool isDark) {
    switch (type) {
      case CorpoSnackbarType.info:
        return isDark ? CorpoColors.primary300 : CorpoColors.primary600;
      case CorpoSnackbarType.success:
        return isDark ? CorpoColors.success : CorpoColors.success;
      case CorpoSnackbarType.warning:
        return isDark ? CorpoColors.warning : CorpoColors.warning;
      case CorpoSnackbarType.error:
        return isDark ? CorpoColors.error : CorpoColors.error;
    }
  }

  static EdgeInsets _getDefaultMargin(CorpoSnackbarPosition position) {
    switch (position) {
      case CorpoSnackbarPosition.bottom:
        return const EdgeInsets.all(CorpoSpacing.medium);
      case CorpoSnackbarPosition.top:
        return const EdgeInsets.only(
          left: CorpoSpacing.medium,
          right: CorpoSpacing.medium,
          top: CorpoSpacing.large,
        );
    }
  }
}
