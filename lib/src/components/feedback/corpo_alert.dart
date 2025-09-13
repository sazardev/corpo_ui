/// A comprehensive alert component for the Corpo UI design system.
///
/// CorpoAlert provides consistent alert messaging across corporate
/// applications, with support for different severity levels, actions,
/// and dismissal functionality.
///
/// Example usage:
/// ```dart
/// CorpoAlert(
///   type: CorpoAlertType.success,
///   title: 'Success',
///   message: 'Your changes have been saved.',
/// )
///
/// CorpoAlert.error(
///   title: 'Error',
///   message: 'Something went wrong.',
///   onDismiss: () => hideAlert(),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Alert types for different semantic meanings.
enum CorpoAlertType {
  /// Informational alert
  info,

  /// Success alert
  success,

  /// Warning alert
  warning,

  /// Error alert
  error,
}

/// A comprehensive alert widget following Corpo UI design principles.
///
/// This component provides consistent alert messaging with support for
/// different severity levels, icons, and dismissal functionality.
class CorpoAlert extends StatelessWidget {
  /// Creates a Corpo UI alert.
  const CorpoAlert({
    required this.type,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.isDismissible = true,
    super.key,
  });

  /// Creates an info alert.
  const CorpoAlert.info({
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.isDismissible = true,
    super.key,
  }) : type = CorpoAlertType.info;

  /// Creates a success alert.
  const CorpoAlert.success({
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.isDismissible = true,
    super.key,
  }) : type = CorpoAlertType.success;

  /// Creates a warning alert.
  const CorpoAlert.warning({
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.isDismissible = true,
    super.key,
  }) : type = CorpoAlertType.warning;

  /// Creates an error alert.
  const CorpoAlert.error({
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.isDismissible = true,
    super.key,
  }) : type = CorpoAlertType.error;

  /// The type of alert determining the color scheme.
  final CorpoAlertType type;

  /// Optional title for the alert.
  final String? title;

  /// The message content of the alert.
  final String? message;

  /// Custom icon to display. If null, a default icon will be used.
  final IconData? icon;

  /// Optional action widgets to display.
  final List<Widget>? actions;

  /// Called when the alert is dismissed.
  final VoidCallback? onDismiss;

  /// Whether the alert can be dismissed.
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = _getBackgroundColor(type);
    final Color borderColor = _getBorderColor(type);
    final Color iconColor = _getIconColor(type);
    final Color textColor = _getTextColor(type);
    final IconData effectiveIcon = icon ?? _getDefaultIcon(type);

    return Container(
      padding: const EdgeInsets.all(CorpoSpacing.medium),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(effectiveIcon, color: iconColor, size: 20),
          const SizedBox(width: CorpoSpacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null)
                  Text(
                    title!,
                    style: CorpoTypography.labelMedium.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (title != null && message != null)
                  const SizedBox(height: CorpoSpacing.extraSmall),
                if (message != null)
                  Text(
                    message!,
                    style: CorpoTypography.bodySmall.copyWith(color: textColor),
                  ),
                if (actions != null) ...<Widget>[
                  const SizedBox(height: CorpoSpacing.small),
                  Row(children: actions!),
                ],
              ],
            ),
          ),
          if (isDismissible && onDismiss != null) ...<Widget>[
            const SizedBox(width: CorpoSpacing.small),
            IconButton(
              onPressed: onDismiss,
              icon: const Icon(Icons.close),
              iconSize: 16,
              color: textColor.withOpacity(0.7),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Gets the background color for the alert type.
  Color _getBackgroundColor(CorpoAlertType type) {
    switch (type) {
      case CorpoAlertType.info:
        return CorpoColors.infoBackground;
      case CorpoAlertType.success:
        return CorpoColors.successBackground;
      case CorpoAlertType.warning:
        return CorpoColors.warningBackground;
      case CorpoAlertType.error:
        return CorpoColors.errorBackground;
    }
  }

  /// Gets the border color for the alert type.
  Color _getBorderColor(CorpoAlertType type) {
    switch (type) {
      case CorpoAlertType.info:
        return CorpoColors.infoBorder;
      case CorpoAlertType.success:
        return CorpoColors.successBorder;
      case CorpoAlertType.warning:
        return CorpoColors.warningBorder;
      case CorpoAlertType.error:
        return CorpoColors.errorBorder;
    }
  }

  /// Gets the icon color for the alert type.
  Color _getIconColor(CorpoAlertType type) {
    switch (type) {
      case CorpoAlertType.info:
        return CorpoColors.info;
      case CorpoAlertType.success:
        return CorpoColors.success;
      case CorpoAlertType.warning:
        return CorpoColors.warning;
      case CorpoAlertType.error:
        return CorpoColors.error;
    }
  }

  /// Gets the text color for the alert type.
  Color _getTextColor(CorpoAlertType type) {
    // All alert backgrounds are light, so we use dark text
    return CorpoColors.neutral800;
  }

  /// Gets the default icon for the alert type.
  IconData _getDefaultIcon(CorpoAlertType type) {
    switch (type) {
      case CorpoAlertType.info:
        return Icons.info_outline;
      case CorpoAlertType.success:
        return Icons.check_circle_outline;
      case CorpoAlertType.warning:
        return Icons.warning_outlined;
      case CorpoAlertType.error:
        return Icons.error_outline;
    }
  }
}
