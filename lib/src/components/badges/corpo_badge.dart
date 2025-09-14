/// A comprehensive badge component for the Corpo UI design system.
///
/// CorpoBadge provides consistent badge styling and behavior across
/// corporate applications, with support for status indicators, counts,
/// notifications, and various visual variants.
///
/// The component follows corporate design principles with clear visual
/// hierarchy, accessibility features, and professional styling suitable
/// for status communication and data visualization.
///
/// Example usage:
/// ```dart
/// CorpoBadge(
///   'Active',
///   variant: CorpoBadgeVariant.success,
/// )
///
/// CorpoBadge.count(
///   12,
///   variant: CorpoBadgeVariant.info,
/// )
///
/// CorpoBadge.dot(
///   variant: CorpoBadgeVariant.warning,
/// )
///
/// CorpoBadge.notification(
///   99,
///   child: Icon(Icons.notifications),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Badge variant types for different semantic meanings.
///
/// Determines the color scheme and visual treatment of the badge.
enum CorpoBadgeVariant {
  /// Default badge for general purpose
  neutral,

  /// Primary badge for main brand elements
  primary,

  /// Secondary badge for supporting elements
  secondary,

  /// Success badge for positive states
  success,

  /// Warning badge for caution states
  warning,

  /// Error badge for negative states
  error,

  /// Info badge for informational content
  info,
}

/// Badge size variants for different contexts.
///
/// Provides consistent sizing options for various use cases.
enum CorpoBadgeSize {
  /// Small badge for compact layouts
  small,

  /// Medium badge for standard use (default)
  medium,

  /// Large badge for prominent display
  large,
}

/// Badge style types for different visual presentations.
///
/// Determines the visual treatment and emphasis level.
enum CorpoBadgeStyle {
  /// Filled badge with solid background
  filled,

  /// Outlined badge with border and transparent background
  outlined,

  /// Subtle badge with light background tint
  subtle,

  /// Dot badge for minimal indication
  dot,
}

/// A comprehensive badge widget following Corpo UI design principles.
///
/// This component provides consistent visual indicators for status,
/// counts, notifications, and other semantic information. It supports
/// various styles, sizes, and colors while maintaining accessibility.
class CorpoBadge extends StatelessWidget {
  /// Creates a Corpo UI badge.
  ///
  /// The [text] parameter contains the badge content.
  /// Use null for dot-style badges without text.
  const CorpoBadge(
    this.text, {
    super.key,
    this.variant = CorpoBadgeVariant.neutral,
    this.size = CorpoBadgeSize.medium,
    this.style = CorpoBadgeStyle.filled,
    this.icon,
    this.child,
  }) : count = null;

  /// Convenience constructor for count badges.
  ///
  /// Displays a numeric count with appropriate formatting
  /// and overflow handling for large numbers.
  const CorpoBadge.count(
    this.count, {
    super.key,
    this.variant = CorpoBadgeVariant.primary,
    this.size = CorpoBadgeSize.medium,
    this.style = CorpoBadgeStyle.filled,
    this.icon,
    this.child,
  }) : text = null;

  /// Convenience constructor for dot badges.
  ///
  /// Creates a small dot indicator without text,
  /// useful for status indicators and notifications.
  const CorpoBadge.dot({
    super.key,
    this.variant = CorpoBadgeVariant.primary,
    this.size = CorpoBadgeSize.small,
    this.child,
  }) : text = null,
       count = null,
       style = CorpoBadgeStyle.dot,
       icon = null;

  /// Convenience constructor for notification badges.
  ///
  /// Positions a count badge on top of a child widget,
  /// commonly used for notification indicators on icons.
  const CorpoBadge.notification(
    this.count, {
    required this.child,
    super.key,
    this.variant = CorpoBadgeVariant.error,
    this.size = CorpoBadgeSize.small,
    this.style = CorpoBadgeStyle.filled,
  }) : text = null,
       icon = null;

  /// The text content of the badge.
  final String? text;

  /// The numeric count for count badges.
  final int? count;

  /// The visual variant determining color scheme.
  final CorpoBadgeVariant variant;

  /// The size variant of the badge.
  final CorpoBadgeSize size;

  /// The style variant determining visual treatment.
  final CorpoBadgeStyle style;

  /// Optional icon to display alongside text.
  final IconData? icon;

  /// Optional child widget for notification badges.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // Build notification badge if child is provided
    if (child != null) {
      return _buildNotificationBadge(isDark);
    }

    // Build regular badge
    return _buildBadge(isDark);
  }

  /// Builds a notification badge positioned over a child widget.
  Widget _buildNotificationBadge(bool isDark) => Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      child!,
      Positioned(top: -8, right: -8, child: _buildBadge(isDark)),
    ],
  );

  /// Builds the main badge widget.
  Widget _buildBadge(bool isDark) {
    final String displayText = _getDisplayText();
    final bool isEmpty = displayText.isEmpty && style != CorpoBadgeStyle.dot;

    if (isEmpty) {
      return const SizedBox.shrink();
    }

    final EdgeInsets padding = _getPadding();
    final BorderRadius borderRadius = _getBorderRadius();
    final Color backgroundColor = _getBackgroundColor(isDark);
    final Color textColor = _getTextColor(isDark);
    final Color borderColor = _getBorderColor(isDark);
    final TextStyle textStyle = _getTextStyle();
    final double minSize = _getMinSize();

    Widget badgeContent;

    if (style == CorpoBadgeStyle.dot) {
      // Dot badge without text
      badgeContent = Container(
        width: minSize,
        height: minSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(minSize / 2),
          border: style == CorpoBadgeStyle.outlined
              ? Border.all(color: borderColor)
              : null,
        ),
      );
    } else {
      // Text or count badge
      final List<Widget> children = <Widget>[];

      if (icon != null) {
        children.add(Icon(icon, size: _getIconSize(), color: textColor));
        if (displayText.isNotEmpty) {
          children.add(const SizedBox(width: CorpoSpacing.extraSmall));
        }
      }

      if (displayText.isNotEmpty) {
        children.add(
          Text(displayText, style: textStyle.copyWith(color: textColor)),
        );
      }

      badgeContent = Container(
        constraints: BoxConstraints(minHeight: minSize),
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: style == CorpoBadgeStyle.outlined
              ? Border.all(color: borderColor)
              : null,
        ),
        child: children.length == 1
            ? children.first
            : Row(mainAxisSize: MainAxisSize.min, children: children),
      );
    }

    return badgeContent;
  }

  /// Gets the display text for the badge.
  String _getDisplayText() {
    if (text != null) {
      return text!;
    }

    if (count != null) {
      // Format count with overflow handling
      if (count! > 99) {
        return '99+';
      }
      return count!.toString();
    }

    return '';
  }

  /// Gets the padding based on size and style.
  EdgeInsets _getPadding() {
    if (style == CorpoBadgeStyle.dot) {
      return EdgeInsets.zero;
    }

    switch (size) {
      case CorpoBadgeSize.small:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.extraSmall,
          vertical: 2,
        );
      case CorpoBadgeSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.small,
          vertical: CorpoSpacing.extraSmall,
        );
      case CorpoBadgeSize.large:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.small,
          vertical: CorpoSpacing.extraSmall + 2,
        );
    }
  }

  /// Gets the border radius based on size.
  BorderRadius _getBorderRadius() {
    switch (size) {
      case CorpoBadgeSize.small:
        return BorderRadius.circular(CorpoSpacing.extraSmall);
      case CorpoBadgeSize.medium:
        return BorderRadius.circular(CorpoSpacing.extraSmall + 2);
      case CorpoBadgeSize.large:
        return BorderRadius.circular(CorpoSpacing.small);
    }
  }

  /// Gets the minimum size for the badge.
  double _getMinSize() {
    switch (size) {
      case CorpoBadgeSize.small:
        return 16;
      case CorpoBadgeSize.medium:
        return 20;
      case CorpoBadgeSize.large:
        return 24;
    }
  }

  /// Gets the icon size based on badge size.
  double _getIconSize() {
    switch (size) {
      case CorpoBadgeSize.small:
        return 12;
      case CorpoBadgeSize.medium:
        return 14;
      case CorpoBadgeSize.large:
        return 16;
    }
  }

  /// Gets the text style based on size.
  TextStyle _getTextStyle() {
    switch (size) {
      case CorpoBadgeSize.small:
        return CorpoTypography.labelSmall;
      case CorpoBadgeSize.medium:
        return CorpoTypography.labelMedium;
      case CorpoBadgeSize.large:
        return CorpoTypography.labelLarge;
    }
  }

  /// Gets the background color based on variant and style.
  Color _getBackgroundColor(bool isDark) {
    switch (style) {
      case CorpoBadgeStyle.filled:
      case CorpoBadgeStyle.dot:
        return _getVariantColor(variant, isDark);
      case CorpoBadgeStyle.outlined:
        return Colors.transparent;
      case CorpoBadgeStyle.subtle:
        final Color baseColor = _getVariantColor(variant, isDark);
        return Color.fromARGB(
          (0.1 * 255).round(),
          (baseColor.r * 255.0).round() & 0xff,
          (baseColor.g * 255.0).round() & 0xff,
          (baseColor.b * 255.0).round() & 0xff,
        );
    }
  }

  /// Gets the text color based on variant and style.
  Color _getTextColor(bool isDark) {
    switch (style) {
      case CorpoBadgeStyle.filled:
      case CorpoBadgeStyle.dot:
        return _isLightVariant(variant)
            ? CorpoColors.neutral800
            : CorpoColors.neutralWhite;
      case CorpoBadgeStyle.outlined:
      case CorpoBadgeStyle.subtle:
        return _getVariantColor(variant, isDark);
    }
  }

  /// Gets the border color for outlined badges.
  Color _getBorderColor(bool isDark) => _getVariantColor(variant, isDark);

  /// Gets the color for a specific variant.
  Color _getVariantColor(CorpoBadgeVariant variant, bool isDark) {
    switch (variant) {
      case CorpoBadgeVariant.neutral:
        return isDark ? CorpoColors.neutral600 : CorpoColors.neutral500;
      case CorpoBadgeVariant.primary:
        return CorpoColors.primary500;
      case CorpoBadgeVariant.secondary:
        return isDark ? CorpoColors.neutral500 : CorpoColors.neutral600;
      case CorpoBadgeVariant.success:
        return CorpoColors.success;
      case CorpoBadgeVariant.warning:
        return CorpoColors.warning;
      case CorpoBadgeVariant.error:
        return CorpoColors.error;
      case CorpoBadgeVariant.info:
        return CorpoColors.info;
    }
  }

  /// Determines if a variant uses light colors that need dark text.
  bool _isLightVariant(CorpoBadgeVariant variant) =>
      variant == CorpoBadgeVariant.warning;
}
