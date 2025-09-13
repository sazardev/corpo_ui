/// A comprehensive icon component for the Corpo UI design system.
///
/// CorpoIcon provides consistent icon styling and behavior across
/// corporate applications, with support for semantic variants, sizing,
/// and theme integration. It extends Flutter's Icon widget with
/// corporate design principles and accessibility features.
///
/// The component includes a curated set of corporate-appropriate icons
/// with semantic naming and consistent sizing standards. It automatically
/// adapts to theme colors and provides accessibility features.
///
/// Example usage:
/// ```dart
/// CorpoIcon(
///   Icons.person,
///   size: CorpoIconSize.medium,
///   color: CorpoColors.primary500,
/// )
///
/// CorpoIcon.semantic(
///   CorpoSemanticIcon.success,
///   size: CorpoIconSize.large,
/// )
///
/// CorpoIcon.action(
///   CorpoActionIcon.add,
///   onTap: () => print('Add action'),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';

/// Icon size variants for different use cases.
///
/// Provides consistent sizing options optimized for
/// different contexts and touch targets.
enum CorpoIconSize {
  /// Extra small icon (12px) for dense layouts
  extraSmall,

  /// Small icon (16px) for compact elements
  small,

  /// Medium icon (20px) for standard use (default)
  medium,

  /// Large icon (24px) for prominent elements
  large,

  /// Extra large icon (32px) for hero elements
  extraLarge,

  /// XXL icon (48px) for major visual elements
  xxLarge,
}

/// Semantic icon types for common corporate use cases.
///
/// Provides standardized icons for common business scenarios
/// with consistent meaning across the application.
enum CorpoSemanticIcon {
  /// Success state indicator
  success,

  /// Warning state indicator
  warning,

  /// Error state indicator
  error,

  /// Information state indicator
  info,

  /// Help or question indicator
  help,

  /// Settings or configuration
  settings,

  /// Search functionality
  search,

  /// User or profile
  user,

  /// Document or file
  document,

  /// Email or message
  email,

  /// Phone or contact
  phone,

  /// Location or address
  location,

  /// Calendar or date
  calendar,

  /// Clock or time
  time,

  /// Dashboard or home
  dashboard,

  /// Reports or analytics
  reports,

  /// Security or lock
  security,
}

/// Action icon types for interactive elements.
///
/// Provides standardized icons for common actions
/// with consistent visual language.
enum CorpoActionIcon {
  /// Add or create action
  add,

  /// Edit or modify action
  edit,

  /// Delete or remove action
  delete,

  /// Save action
  save,

  /// Cancel action
  cancel,

  /// Confirm or check action
  confirm,

  /// Download action
  download,

  /// Upload action
  upload,

  /// Share action
  share,

  /// Copy action
  copy,

  /// Print action
  print,

  /// Refresh or reload action
  refresh,

  /// More options action
  more,

  /// Back navigation
  back,

  /// Forward navigation
  forward,

  /// Close or dismiss action
  close,

  /// Expand action
  expand,

  /// Collapse action
  collapse,
}

/// A comprehensive icon widget following Corpo UI design principles.
///
/// This component provides consistent icon styling, sizing, and behavior
/// across the application. It supports custom icons, semantic icons,
/// and action icons with proper accessibility features.
class CorpoIcon extends StatelessWidget {
  /// Creates a Corpo UI icon.
  ///
  /// The [iconData] parameter specifies the icon to display.
  /// The [size] determines the icon dimensions.
  const CorpoIcon(
    this.iconData, {
    super.key,
    this.size = CorpoIconSize.medium,
    this.color,
    this.semanticLabel,
    this.onTap,
  }) : semanticIcon = null,
       actionIcon = null;

  /// Convenience constructor for semantic icons.
  ///
  /// Uses predefined icons for common semantic meanings
  /// with appropriate colors and accessibility labels.
  const CorpoIcon.semantic(
    this.semanticIcon, {
    super.key,
    this.size = CorpoIconSize.medium,
    this.color,
    this.semanticLabel,
    this.onTap,
  }) : iconData = null,
       actionIcon = null;

  /// Convenience constructor for action icons.
  ///
  /// Uses predefined icons for common actions with
  /// interactive behavior and accessibility features.
  const CorpoIcon.action(
    this.actionIcon, {
    super.key,
    this.size = CorpoIconSize.medium,
    this.color,
    this.semanticLabel,
    this.onTap,
  }) : iconData = null,
       semanticIcon = null;

  /// The icon data to display (for custom icons).
  final IconData? iconData;

  /// The semantic icon type to display.
  final CorpoSemanticIcon? semanticIcon;

  /// The action icon type to display.
  final CorpoActionIcon? actionIcon;

  /// The size variant of the icon.
  final CorpoIconSize size;

  /// The color of the icon.
  ///
  /// If null, uses the default icon color from the theme.
  final Color? color;

  /// The semantic label for accessibility.
  ///
  /// Used by screen readers to describe the icon's purpose.
  final String? semanticLabel;

  /// Optional tap handler for interactive icons.
  ///
  /// If provided, the icon becomes interactive with proper
  /// touch targets and visual feedback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // Determine the actual icon data to use
    final IconData effectiveIconData = _getEffectiveIconData();

    // Calculate icon size in pixels
    final double iconSize = _getIconSizeInPixels();

    // Determine effective color
    final Color effectiveColor = _getEffectiveColor(theme, isDark);

    // Build the icon widget
    final Widget iconWidget = Icon(
      effectiveIconData,
      size: iconSize,
      color: effectiveColor,
      semanticLabel: semanticLabel ?? _getDefaultSemanticLabel(),
    );

    // Wrap with interactive behavior if onTap is provided
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
        child: Padding(
          padding: const EdgeInsets.all(CorpoSpacing.extraSmall),
          child: iconWidget,
        ),
      );
    }

    return iconWidget;
  }

  /// Gets the effective icon data based on the constructor used.
  IconData _getEffectiveIconData() {
    if (iconData != null) {
      return iconData!;
    }

    if (semanticIcon != null) {
      return _getSemanticIconData(semanticIcon!);
    }

    if (actionIcon != null) {
      return _getActionIconData(actionIcon!);
    }

    // Fallback to a default icon
    return Icons.help_outline;
  }

  /// Maps semantic icons to Material Design icons.
  IconData _getSemanticIconData(CorpoSemanticIcon semantic) {
    switch (semantic) {
      case CorpoSemanticIcon.success:
        return Icons.check_circle_outline;
      case CorpoSemanticIcon.warning:
        return Icons.warning_amber_outlined;
      case CorpoSemanticIcon.error:
        return Icons.error_outline;
      case CorpoSemanticIcon.info:
        return Icons.info_outline;
      case CorpoSemanticIcon.help:
        return Icons.help_outline;
      case CorpoSemanticIcon.settings:
        return Icons.settings_outlined;
      case CorpoSemanticIcon.search:
        return Icons.search;
      case CorpoSemanticIcon.user:
        return Icons.person_outline;
      case CorpoSemanticIcon.document:
        return Icons.description_outlined;
      case CorpoSemanticIcon.email:
        return Icons.email_outlined;
      case CorpoSemanticIcon.phone:
        return Icons.phone_outlined;
      case CorpoSemanticIcon.location:
        return Icons.location_on_outlined;
      case CorpoSemanticIcon.calendar:
        return Icons.calendar_today_outlined;
      case CorpoSemanticIcon.time:
        return Icons.access_time_outlined;
      case CorpoSemanticIcon.dashboard:
        return Icons.dashboard_outlined;
      case CorpoSemanticIcon.reports:
        return Icons.analytics_outlined;
      case CorpoSemanticIcon.security:
        return Icons.lock_outline;
    }
  }

  /// Maps action icons to Material Design icons.
  IconData _getActionIconData(CorpoActionIcon action) {
    switch (action) {
      case CorpoActionIcon.add:
        return Icons.add;
      case CorpoActionIcon.edit:
        return Icons.edit_outlined;
      case CorpoActionIcon.delete:
        return Icons.delete_outline;
      case CorpoActionIcon.save:
        return Icons.save_outlined;
      case CorpoActionIcon.cancel:
        return Icons.cancel_outlined;
      case CorpoActionIcon.confirm:
        return Icons.check;
      case CorpoActionIcon.download:
        return Icons.download_outlined;
      case CorpoActionIcon.upload:
        return Icons.upload_outlined;
      case CorpoActionIcon.share:
        return Icons.share_outlined;
      case CorpoActionIcon.copy:
        return Icons.copy_outlined;
      case CorpoActionIcon.print:
        return Icons.print_outlined;
      case CorpoActionIcon.refresh:
        return Icons.refresh;
      case CorpoActionIcon.more:
        return Icons.more_vert;
      case CorpoActionIcon.back:
        return Icons.arrow_back;
      case CorpoActionIcon.forward:
        return Icons.arrow_forward;
      case CorpoActionIcon.close:
        return Icons.close;
      case CorpoActionIcon.expand:
        return Icons.expand_more;
      case CorpoActionIcon.collapse:
        return Icons.expand_less;
    }
  }

  /// Converts size enum to pixel value.
  double _getIconSizeInPixels() {
    switch (size) {
      case CorpoIconSize.extraSmall:
        return 12;
      case CorpoIconSize.small:
        return 16;
      case CorpoIconSize.medium:
        return 20;
      case CorpoIconSize.large:
        return 24;
      case CorpoIconSize.extraLarge:
        return 32;
      case CorpoIconSize.xxLarge:
        return 48;
    }
  }

  /// Determines the effective color based on context.
  Color _getEffectiveColor(ThemeData theme, bool isDark) {
    if (color != null) {
      return color!;
    }

    // Use semantic colors for semantic icons
    if (semanticIcon != null) {
      switch (semanticIcon!) {
        case CorpoSemanticIcon.success:
          return CorpoColors.success;
        case CorpoSemanticIcon.warning:
          return CorpoColors.warning;
        case CorpoSemanticIcon.error:
          return CorpoColors.error;
        case CorpoSemanticIcon.info:
          return CorpoColors.info;
        default:
          break;
      }
    }

    // Use primary color for action icons
    if (actionIcon != null) {
      return CorpoColors.primary500;
    }

    // Default to theme icon color
    return theme.iconTheme.color ??
        (isDark ? CorpoColors.neutral200 : CorpoColors.neutral700);
  }

  /// Gets default semantic label for accessibility.
  String? _getDefaultSemanticLabel() {
    if (semanticIcon != null) {
      return _getSemanticLabel(semanticIcon!);
    }

    if (actionIcon != null) {
      return _getActionLabel(actionIcon!);
    }

    return null;
  }

  /// Gets semantic label for semantic icons.
  String _getSemanticLabel(CorpoSemanticIcon semantic) {
    switch (semantic) {
      case CorpoSemanticIcon.success:
        return 'Success';
      case CorpoSemanticIcon.warning:
        return 'Warning';
      case CorpoSemanticIcon.error:
        return 'Error';
      case CorpoSemanticIcon.info:
        return 'Information';
      case CorpoSemanticIcon.help:
        return 'Help';
      case CorpoSemanticIcon.settings:
        return 'Settings';
      case CorpoSemanticIcon.search:
        return 'Search';
      case CorpoSemanticIcon.user:
        return 'User';
      case CorpoSemanticIcon.document:
        return 'Document';
      case CorpoSemanticIcon.email:
        return 'Email';
      case CorpoSemanticIcon.phone:
        return 'Phone';
      case CorpoSemanticIcon.location:
        return 'Location';
      case CorpoSemanticIcon.calendar:
        return 'Calendar';
      case CorpoSemanticIcon.time:
        return 'Time';
      case CorpoSemanticIcon.dashboard:
        return 'Dashboard';
      case CorpoSemanticIcon.reports:
        return 'Reports';
      case CorpoSemanticIcon.security:
        return 'Security';
    }
  }

  /// Gets semantic label for action icons.
  String _getActionLabel(CorpoActionIcon action) {
    switch (action) {
      case CorpoActionIcon.add:
        return 'Add';
      case CorpoActionIcon.edit:
        return 'Edit';
      case CorpoActionIcon.delete:
        return 'Delete';
      case CorpoActionIcon.save:
        return 'Save';
      case CorpoActionIcon.cancel:
        return 'Cancel';
      case CorpoActionIcon.confirm:
        return 'Confirm';
      case CorpoActionIcon.download:
        return 'Download';
      case CorpoActionIcon.upload:
        return 'Upload';
      case CorpoActionIcon.share:
        return 'Share';
      case CorpoActionIcon.copy:
        return 'Copy';
      case CorpoActionIcon.print:
        return 'Print';
      case CorpoActionIcon.refresh:
        return 'Refresh';
      case CorpoActionIcon.more:
        return 'More options';
      case CorpoActionIcon.back:
        return 'Back';
      case CorpoActionIcon.forward:
        return 'Forward';
      case CorpoActionIcon.close:
        return 'Close';
      case CorpoActionIcon.expand:
        return 'Expand';
      case CorpoActionIcon.collapse:
        return 'Collapse';
    }
  }
}
