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
///   leading: Icon(Icons.delete, color: Colors.red),
///   destructive: true,
///   onTap: () => confirmDelete(),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final EdgeInsetsGeometry effectivePadding =
        contentPadding ?? _getDefaultPadding(tokens);
    final Color? backgroundColor = _getBackgroundColor(isDark, tokens);
    final Color titleColor = _getTitleColor(isDark, tokens);
    final Color subtitleColor = _getSubtitleColor(isDark, tokens);

    Widget tile = ListTile(
      title: DefaultTextStyle(
        style: _getTitleStyle(tokens).copyWith(color: titleColor),
        child: title,
      ),
      subtitle: subtitle != null
          ? DefaultTextStyle(
              style: _getSubtitleStyle(tokens).copyWith(color: subtitleColor),
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
      selectedTileColor: _getSelectedColor(isDark, tokens),
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
            color: isDark
                ? tokens.surfaceColor.withOpacity(0.15)
                : tokens.surfaceColor.withOpacity(0.5),
          ),
        ],
      );
    }

    return tile;
  }

  /// Gets the default padding based on density.
  EdgeInsetsGeometry _getDefaultPadding(CorpoDesignTokens tokens) {
    switch (density) {
      case CorpoListTileDensity.compact:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing4x,
          vertical: tokens.spacing1x,
        );
      case CorpoListTileDensity.comfortable:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing6x,
          vertical: tokens.spacing4x,
        );
      case CorpoListTileDensity.standard:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing4x,
          vertical: tokens.spacing2x,
        );
    }
  }

  /// Gets the background color based on variant and theme.
  Color? _getBackgroundColor(bool isDark, CorpoDesignTokens tokens) {
    if (!enabled) {
      return isDark
          ? tokens.surfaceColor.withOpacity(0.1)
          : tokens.surfaceColor;
    }

    switch (variant) {
      case CorpoListTileVariant.emphasized:
        return isDark
            ? tokens.surfaceColor.withOpacity(0.15)
            : tokens.surfaceColor.withOpacity(0.5);
      case CorpoListTileVariant.action:
        return null; // Use default
      case CorpoListTileVariant.compact:
      case CorpoListTileVariant.standard:
        return null; // Use default
    }
  }

  /// Gets the selected tile color.
  Color _getSelectedColor(bool isDark, CorpoDesignTokens tokens) => isDark
      ? tokens.primaryColor.withOpacity(0.3)
      : tokens.primaryColor.withOpacity(0.1);

  /// Gets the title color based on state and theme.
  Color _getTitleColor(bool isDark, CorpoDesignTokens tokens) {
    if (!enabled) {
      return isDark
          ? tokens.textSecondary.withOpacity(0.5)
          : tokens.textSecondary;
    }

    if (destructive) {
      return tokens.errorColor;
    }

    return isDark ? tokens.textPrimary : tokens.textPrimary;
  }

  /// Gets the subtitle color based on state and theme.
  Color _getSubtitleColor(bool isDark, CorpoDesignTokens tokens) {
    if (!enabled) {
      return isDark
          ? tokens.textSecondary.withOpacity(0.3)
          : tokens.textSecondary.withOpacity(0.7);
    }

    return tokens.textSecondary;
  }

  /// Gets the title text style based on variant.
  TextStyle _getTitleStyle(CorpoDesignTokens tokens) {
    switch (variant) {
      case CorpoListTileVariant.emphasized:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
          fontWeight: FontWeight.w600, // semiBold equivalent
        );
      case CorpoListTileVariant.compact:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
        );
      case CorpoListTileVariant.action:
      case CorpoListTileVariant.standard:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
        );
    }
  }

  /// Gets the subtitle text style.
  TextStyle _getSubtitleStyle(CorpoDesignTokens tokens) =>
      TextStyle(fontSize: tokens.fontSizeSmall, fontFamily: tokens.fontFamily);
}
