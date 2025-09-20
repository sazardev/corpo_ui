/// A comprehensive list tile component for the Corpo UI design system.
///
/// CorpoListTile provides consistent list item styling and behavior
/// across corporate applications, with support for leading/trailing widgets,
/// subtitles, and various interactive states.
///
/// The component follows corporate design principles with clear visual
/// hierarchy, professional styling, and comprehensive accessibility features
/// including semantic labels and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoListTile(
///   title: 'John Doe',
///   subtitle: 'Software Engineer',
///   leading: CorpoAvatar.initials('John Doe'),
///   trailing: Icon(Icons.chevron_right),
///   onTap: () => navigateToProfile('john-doe'),
/// )
///
/// CorpoListTile.action(
///   title: 'Delete Account',
///   subtitle: 'This action cannot be undone',
///   leading: Icon(Icons.delete, color: CorpoColors.error),
///   destructive: true,
///   onTap: () => confirmDelete(),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// List tile variants for different use cases.
enum CorpoListTileVariant {
  /// Standard list tile for general content.
  standard,

  /// Compact list tile with reduced padding.
  compact,

  /// Emphasized list tile with enhanced visual prominence.
  emphasized,

  /// Action list tile for interactive items.
  action,
}

/// List tile density for different spacing needs.
enum CorpoListTileDensity {
  /// Standard density with normal spacing.
  standard,

  /// Compact density with reduced spacing.
  compact,

  /// Comfortable density with increased spacing.
  comfortable,
}

/// A comprehensive list tile widget following Corpo UI design principles.
///
/// This component provides consistent styling for list items with support
/// for various configurations, accessibility features, and theme integration.
class CorpoListTile extends StatelessWidget {
  /// Creates a Corpo UI list tile.
  const CorpoListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.dense = false,
    this.variant = CorpoListTileVariant.standard,
    this.density = CorpoListTileDensity.standard,
    this.contentPadding,
    this.destructive = false,
    this.divider = false,
    super.key,
  });

  /// Convenience constructor for action list tiles.
  const CorpoListTile.action({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.contentPadding,
    this.destructive = false,
    this.divider = false,
    super.key,
  }) : variant = CorpoListTileVariant.action,
       density = CorpoListTileDensity.standard,
       dense = false;

  /// Convenience constructor for compact list tiles.
  const CorpoListTile.compact({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.contentPadding,
    this.destructive = false,
    this.divider = false,
    super.key,
  }) : variant = CorpoListTileVariant.compact,
       density = CorpoListTileDensity.compact,
       dense = true;

  /// The primary content of the list tile.
  final Widget title;

  /// Optional secondary content displayed below the title.
  final Widget? subtitle;

  /// A widget to display before the title.
  final Widget? leading;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Called when the user taps this list tile.
  final VoidCallback? onTap;

  /// Called when the user long-presses on this list tile.
  final VoidCallback? onLongPress;

  /// Whether this list tile is part of a selection.
  final bool selected;

  /// Whether this list tile is interactive.
  final bool enabled;

  /// Whether this list tile is displayed with reduced height.
  final bool dense;

  /// The visual variant of the list tile.
  final CorpoListTileVariant variant;

  /// The density configuration for spacing.
  final CorpoListTileDensity density;

  /// The tile's internal padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether this list tile represents a destructive action.
  final bool destructive;

  /// Whether to show a divider below this tile.
  final bool divider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final EdgeInsetsGeometry effectivePadding =
        contentPadding ?? _getDefaultPadding();
    final Color? backgroundColor = _getBackgroundColor(isDark);
    final Color titleColor = _getTitleColor(isDark);
    final Color subtitleColor = _getSubtitleColor(isDark);

    Widget tile = ListTile(
      title: DefaultTextStyle(
        style: _getTitleStyle().copyWith(color: titleColor),
        child: title,
      ),
      subtitle: subtitle != null
          ? DefaultTextStyle(
              style: _getSubtitleStyle().copyWith(color: subtitleColor),
              child: subtitle!,
            )
          : null,
      leading: leading,
      trailing: trailing,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      selected: selected,
      enabled: enabled,
      dense: dense,
      contentPadding: effectivePadding,
      tileColor: backgroundColor,
      selectedTileColor: _getSelectedColor(isDark),
      mouseCursor: enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
    );

    if (divider) {
      tile = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          tile,
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? CorpoColors.neutral700 : CorpoColors.neutral200,
          ),
        ],
      );
    }

    return tile;
  }

  /// Gets the default padding based on density.
  EdgeInsetsGeometry _getDefaultPadding() {
    switch (density) {
      case CorpoListTileDensity.compact:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.medium,
          vertical: CorpoSpacing.extraSmall,
        );
      case CorpoListTileDensity.comfortable:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.large,
          vertical: CorpoSpacing.medium,
        );
      case CorpoListTileDensity.standard:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.medium,
          vertical: CorpoSpacing.small,
        );
    }
  }

  /// Gets the background color based on variant and theme.
  Color? _getBackgroundColor(bool isDark) {
    if (!enabled) {
      return isDark ? CorpoColors.neutral800 : CorpoColors.neutral100;
    }

    switch (variant) {
      case CorpoListTileVariant.emphasized:
        return isDark ? CorpoColors.neutral700 : CorpoColors.neutral50;
      case CorpoListTileVariant.action:
        return null; // Use default
      case CorpoListTileVariant.compact:
      case CorpoListTileVariant.standard:
        return null; // Use default
    }
  }

  /// Gets the selected tile color.
  Color _getSelectedColor(bool isDark) =>
      isDark ? CorpoColors.primary800 : CorpoColors.primary100;

  /// Gets the title color based on state and theme.
  Color _getTitleColor(bool isDark) {
    if (!enabled) {
      return isDark ? CorpoColors.neutral500 : CorpoColors.neutral400;
    }

    if (destructive) {
      return CorpoColors.error;
    }

    return isDark ? CorpoColors.neutral100 : CorpoColors.neutral900;
  }

  /// Gets the subtitle color based on state and theme.
  Color _getSubtitleColor(bool isDark) {
    if (!enabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral300;
    }

    return isDark ? CorpoColors.neutral300 : CorpoColors.neutral600;
  }

  /// Gets the title text style based on variant.
  TextStyle _getTitleStyle() {
    switch (variant) {
      case CorpoListTileVariant.emphasized:
        return CorpoTypography.bodyLarge.copyWith(
          fontWeight: CorpoFontWeight.semiBold,
        );
      case CorpoListTileVariant.compact:
        return CorpoTypography.bodyMedium;
      case CorpoListTileVariant.action:
      case CorpoListTileVariant.standard:
        return CorpoTypography.bodyLarge;
    }
  }

  /// Gets the subtitle text style.
  TextStyle _getSubtitleStyle() => CorpoTypography.bodySmall;
}
