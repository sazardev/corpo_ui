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

import '../../design_tokens.dart';

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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Drawer(
      width: _getDrawerWidth(),
      elevation: elevation,
      backgroundColor: backgroundColor ?? tokens.surfaceColor,
      child: Column(
        children: <Widget>[
          if (header != null) header!,
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: tokens.spacing2x),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) => items[index],
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
        return 240;
      case CorpoDrawerWidth.standard:
        return 280;
      case CorpoDrawerWidth.wide:
        return 320;
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Container(
      height: height,
      padding: EdgeInsets.all(tokens.spacing4x),
      decoration: BoxDecoration(
        color: backgroundColor ?? tokens.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(tokens.borderRadius),
          bottomRight: Radius.circular(tokens.borderRadius),
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
              SizedBox(height: tokens.spacing2x),
            ],
            if (title != null)
              Text(
                title!,
                style: TextStyle(
                  fontSize: tokens.fontSizeLarge,
                  fontFamily: tokens.fontFamily,
                  color: tokens.getTextColorFor(tokens.primaryColor),
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: tokens.fontSizeSmall,
                  fontFamily: tokens.fontFamily,
                  color: tokens
                      .getTextColorFor(tokens.primaryColor)
                      .withOpacity(0.8),
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
    required this.title,
    super.key,
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: tokens.spacing2x,
        vertical: tokens.spacing1x,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tokens.borderRadius),
        color: selected ? tokens.primaryColor.withOpacity(0.1) : null,
      ),
      child: ListTile(
        leading: icon != null
            ? Icon(
                icon,
                color: selected ? tokens.primaryColor : tokens.textSecondary,
                size: 20,
              )
            : null,
        title: title != null
            ? Text(
                title!,
                style: TextStyle(
                  fontSize: tokens.baseFontSize,
                  fontFamily: tokens.fontFamily,
                  color: selected ? tokens.primaryColor : tokens.textPrimary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              )
            : null,
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(
                  fontSize: tokens.fontSizeSmall,
                  fontFamily: tokens.fontFamily,
                  color: tokens.textSecondary,
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing4x,
            vertical: tokens.spacing2x,
          ),
          child: Text(
            title ?? '',
            style: TextStyle(
              fontSize: tokens.fontSizeSmall,
              fontFamily: tokens.fontFamily,
              color: tokens.textSecondary,
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Container(
      margin: EdgeInsets.symmetric(vertical: tokens.spacing2x),
      child: Divider(
        color: tokens.textSecondary.withOpacity(0.2),
        thickness: 1,
        indent: tokens.spacing4x,
        endIndent: tokens.spacing4x,
      ),
    );
  }
}
