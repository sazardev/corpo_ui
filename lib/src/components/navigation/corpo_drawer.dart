/// A comprehensive navigation drawer component for the Corpo UI design system.
///
/// CorpoDrawer provides consistent side navigation styling and behavior
/// across corporate applications, with support for hierarchical navigation,
/// sections, and responsive design.
///
/// The component follows corporate design principles with professional
/// styling, accessibility features, and comprehensive navigation
/// organization for business applications.
///
/// Example usage:
/// ```dart
/// Scaffold(
///   drawer: CorpoDrawer(
///     header: CorpoDrawerHeader(
///       title: 'Company App',
///       subtitle: 'v1.0.0',
///     ),
///     items: [
///       CorpoDrawerItem(
///         icon: Icons.dashboard,
///         title: 'Dashboard',
///         onTap: () => navigateTo('/dashboard'),
///       ),
///       CorpoDrawerSection(
///         title: 'Management',
///         items: [
///           CorpoDrawerItem(
///             icon: Icons.people,
///             title: 'Users',
///             onTap: () => navigateTo('/users'),
///           ),
///         ],
///       ),
///     ],
///   ),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Drawer width for different screen sizes.
enum CorpoDrawerWidth {
  /// Narrow drawer (240px)
  narrow,

  /// Standard drawer (280px)
  standard,

  /// Wide drawer (320px)
  wide,
}

/// Navigation drawer item types.
enum CorpoDrawerItemType {
  /// Regular navigation item
  item,

  /// Section header
  section,

  /// Divider
  divider,
}

/// A comprehensive navigation drawer widget following Corpo UI design principles.
///
/// This component provides consistent side navigation styling with support
/// for hierarchical navigation, sections, and responsive design.
class CorpoDrawer extends StatelessWidget {
  /// Creates a Corpo UI navigation drawer.
  const CorpoDrawer({
    super.key,
    this.header,
    this.items = const <CorpoDrawerItem>[],
    this.footer,
    this.width = CorpoDrawerWidth.standard,
    this.backgroundColor,
    this.elevation = 16.0,
  });

  /// Optional header widget at the top of the drawer.
  final Widget? header;

  /// List of navigation items.
  final List<CorpoDrawerItem> items;

  /// Optional footer widget at the bottom of the drawer.
  final Widget? footer;

  /// Width of the drawer.
  final CorpoDrawerWidth width;

  /// Background color of the drawer.
  final Color? backgroundColor;

  /// Elevation of the drawer.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Drawer(
      width: _getDrawerWidth(),
      elevation: elevation,
      backgroundColor:
          backgroundColor ??
          (isDark ? CorpoColors.neutral900 : CorpoColors.neutralWhite),
      child: Column(
        children: <Widget>[
          if (header != null) header!,
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: CorpoSpacing.small),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index];
              },
            ),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }

  double _getDrawerWidth() {
    switch (width) {
      case CorpoDrawerWidth.narrow:
        return 240.0;
      case CorpoDrawerWidth.standard:
        return 280.0;
      case CorpoDrawerWidth.wide:
        return 320.0;
    }
  }
}

/// A drawer header component for CorpoDrawer.
class CorpoDrawerHeader extends StatelessWidget {
  /// Creates a drawer header.
  const CorpoDrawerHeader({
    super.key,
    this.title,
    this.subtitle,
    this.avatar,
    this.backgroundColor,
    this.height = 120.0,
    this.onTap,
  });

  /// Title text for the header.
  final String? title;

  /// Subtitle text for the header.
  final String? subtitle;

  /// Optional avatar widget.
  final Widget? avatar;

  /// Background color of the header.
  final Color? backgroundColor;

  /// Height of the header.
  final double height;

  /// Called when the header is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      height: height,
      padding: const EdgeInsets.all(CorpoSpacing.medium),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isDark ? CorpoColors.primary700 : CorpoColors.primary500),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (avatar != null) ...<Widget>[
              avatar!,
              const SizedBox(height: CorpoSpacing.small),
            ],
            if (title != null)
              Text(
                title!,
                style: CorpoTypography.heading3.copyWith(
                  color: CorpoColors.neutralWhite,
                ),
              ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: CorpoTypography.bodySmall.copyWith(
                  color: CorpoColors.primary100,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A navigation item for CorpoDrawer.
class CorpoDrawerItem extends StatelessWidget {
  /// Creates a drawer item.
  const CorpoDrawerItem({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.enabled = true,
    this.type = CorpoDrawerItemType.item,
    this.children = const <CorpoDrawerItem>[],
  });

  /// Creates a section header.
  const CorpoDrawerItem.section({
    super.key,
    required this.title,
    this.children = const <CorpoDrawerItem>[],
  }) : icon = null,
       subtitle = null,
       trailing = null,
       onTap = null,
       selected = false,
       enabled = true,
       type = CorpoDrawerItemType.section;

  /// Creates a divider.
  const CorpoDrawerItem.divider({super.key})
    : icon = null,
      title = null,
      subtitle = null,
      trailing = null,
      onTap = null,
      selected = false,
      enabled = true,
      type = CorpoDrawerItemType.divider,
      children = const <CorpoDrawerItem>[];

  /// Icon for the item.
  final IconData? icon;

  /// Title text for the item.
  final String? title;

  /// Subtitle text for the item.
  final String? subtitle;

  /// Trailing widget for the item.
  final Widget? trailing;

  /// Called when the item is tapped.
  final VoidCallback? onTap;

  /// Whether the item is selected.
  final bool selected;

  /// Whether the item is enabled.
  final bool enabled;

  /// Type of the drawer item.
  final CorpoDrawerItemType type;

  /// Child items for expandable sections.
  final List<CorpoDrawerItem> children;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CorpoDrawerItemType.item:
        return _buildItem(context);
      case CorpoDrawerItemType.section:
        return _buildSection(context);
      case CorpoDrawerItemType.divider:
        return _buildDivider(context);
    }
  }

  Widget _buildItem(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: CorpoSpacing.small,
        vertical: CorpoSpacing.extraSmall,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: selected
            ? (isDark ? CorpoColors.primary800 : CorpoColors.primary100)
            : null,
      ),
      child: ListTile(
        leading: icon != null
            ? Icon(
                icon,
                color: selected
                    ? (isDark ? CorpoColors.primary300 : CorpoColors.primary600)
                    : (isDark
                          ? CorpoColors.neutral400
                          : CorpoColors.neutral600),
                size: 20.0,
              )
            : null,
        title: title != null
            ? Text(
                title!,
                style: CorpoTypography.bodyMedium.copyWith(
                  color: selected
                      ? (isDark
                            ? CorpoColors.primary300
                            : CorpoColors.primary600)
                      : (isDark
                            ? CorpoColors.neutralWhite
                            : CorpoColors.neutral900),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              )
            : null,
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: CorpoTypography.bodySmall.copyWith(
                  color: isDark
                      ? CorpoColors.neutral400
                      : CorpoColors.neutral600,
                ),
              )
            : null,
        trailing: trailing,
        onTap: enabled ? onTap : null,
        enabled: enabled,
        dense: true,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget _buildSection(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CorpoSpacing.medium,
            vertical: CorpoSpacing.small,
          ),
          child: Text(
            title ?? '',
            style: CorpoTypography.labelSmall.copyWith(
              color: isDark ? CorpoColors.neutral400 : CorpoColors.neutral600,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: CorpoSpacing.small),
      child: Divider(
        color: isDark ? CorpoColors.neutral700 : CorpoColors.neutral200,
        thickness: 1.0,
        indent: CorpoSpacing.medium,
        endIndent: CorpoSpacing.medium,
      ),
    );
  }
}
