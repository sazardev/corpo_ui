/// A comprehensive bottom navigation component for the Corpo UI design system.
///
/// CorpoBottomNavigation provides consistent bottom tab navigation styling
/// and behavior across corporate applications, with support for badges,
/// icons, labels, and various visual states.
///
/// The component follows corporate design principles with professional
/// styling, accessibility features, and comprehensive navigation
/// management for mobile and desktop applications.
///
/// Example usage:
/// ```dart
/// CorpoBottomNavigation(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [
///     CorpoBottomNavigationItem(
///       icon: Icons.home,
///       label: 'Home',
///     ),
///     CorpoBottomNavigationItem(
///       icon: Icons.search,
///       label: 'Search',
///       badge: '3',
///     ),
///     CorpoBottomNavigationItem(
///       icon: Icons.person,
///       label: 'Profile',
///     ),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Bottom navigation bar types.
enum CorpoBottomNavigationType {
  /// Fixed type with equal spacing
  fixed,

  /// Shifting type with animation
  shifting,
}

/// Bottom navigation item with badge support.
class CorpoBottomNavigationItem {
  /// Creates a bottom navigation item.
  const CorpoBottomNavigationItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badge,
    this.tooltip,
    this.enabled = true,
  });

  /// Icon for the item.
  final IconData icon;

  /// Icon shown when the item is active.
  final IconData? activeIcon;

  /// Label text for the item.
  final String label;

  /// Badge text or count for the item.
  final String? badge;

  /// Tooltip text for the item.
  final String? tooltip;

  /// Whether the item is enabled.
  final bool enabled;
}

/// A comprehensive bottom navigation widget following Corpo UI design principles.
///
/// This component provides consistent bottom tab navigation styling with support
/// for badges, icons, labels, and accessibility features.
class CorpoBottomNavigation extends StatelessWidget {
  /// Creates a Corpo UI bottom navigation.
  const CorpoBottomNavigation({
    required this.items,
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.type = CorpoBottomNavigationType.fixed,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
    this.height = 60.0,
    this.showLabels = true,
    this.showBadges = true,
  });

  /// List of navigation items.
  final List<CorpoBottomNavigationItem> items;

  /// Currently selected item index.
  final int currentIndex;

  /// Called when an item is tapped.
  final ValueChanged<int>? onTap;

  /// Type of bottom navigation.
  final CorpoBottomNavigationType type;

  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// Color of the selected item.
  final Color? selectedItemColor;

  /// Color of unselected items.
  final Color? unselectedItemColor;

  /// Elevation of the navigation bar.
  final double elevation;

  /// Height of the navigation bar.
  final double height;

  /// Whether to show item labels.
  final bool showLabels;

  /// Whether to show item badges.
  final bool showBadges;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? tokens.surfaceColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tokens.textSecondary.withOpacity(0.1),
            offset: const Offset(0, -1),
            blurRadius: elevation,
          ),
        ],
        border: Border(
          top: BorderSide(color: tokens.textSecondary.withOpacity(0.2)),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.asMap().entries.map((
            MapEntry<int, CorpoBottomNavigationItem> entry,
          ) {
            final int index = entry.key;
            final CorpoBottomNavigationItem item = entry.value;
            return _buildNavigationItem(context, index, item, tokens, isDark);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(
    BuildContext context,
    int index,
    CorpoBottomNavigationItem item,
    CorpoDesignTokens tokens,
    bool isDark,
  ) {
    final bool isSelected = index == currentIndex;
    final Color itemColor = isSelected
        ? (selectedItemColor ?? tokens.primaryColor)
        : (unselectedItemColor ?? tokens.textSecondary);

    Widget child = InkWell(
      onTap: item.enabled ? () => onTap?.call(index) : null,
      borderRadius: BorderRadius.circular(tokens.borderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing2x,
          vertical: tokens.spacing1x,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Icon(
                  isSelected && item.activeIcon != null
                      ? item.activeIcon!
                      : item.icon,
                  color: item.enabled
                      ? itemColor
                      : tokens.textSecondary.withOpacity(0.5),
                  size: 24,
                ),
                if (showBadges && item.badge != null)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: _buildBadge(item.badge!, tokens, isDark),
                  ),
              ],
            ),
            if (showLabels) ...<Widget>[
              SizedBox(height: tokens.spacing1x),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: tokens.fontSizeSmall,
                  fontFamily: tokens.fontFamily,
                  color: item.enabled
                      ? itemColor
                      : tokens.textSecondary.withOpacity(0.5),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );

    if (item.tooltip != null) {
      child = Tooltip(message: item.tooltip, child: child);
    }

    return Expanded(child: child);
  }

  Widget _buildBadge(String badge, CorpoDesignTokens tokens, bool isDark) {
    // Parse badge to check if it's numeric
    final int? count = int.tryParse(badge);
    final bool isNumeric = count != null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing1x, vertical: 2),
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      decoration: BoxDecoration(
        color: tokens.errorColor,
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      child: Text(
        isNumeric && count > 99 ? '99+' : badge,
        style: TextStyle(
          fontSize: 10,
          fontFamily: tokens.fontFamily,
          color: tokens.getTextColorFor(tokens.errorColor),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
