/// A comprehensive breadcrumb navigation component for the Corpo UI design system.
///
/// CorpoBreadcrumb provides consistent hierarchical navigation styling
/// and behavior across corporate applications, with support for custom
/// separators, interactive items, and responsive design.
///
/// Example usage:
/// ```dart
/// CorpoBreadcrumb(
///   items: [
///     CorpoBreadcrumbItem(
///       text: 'Home',
///       onTap: () => navigateTo('/'),
///     ),
///     CorpoBreadcrumbItem(
///       text: 'Products',
///       onTap: () => navigateTo('/products'),
///     ),
///     CorpoBreadcrumbItem(
///       text: 'Electronics',
///       isCurrentPage: true,
///     ),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Individual breadcrumb item configuration.
class CorpoBreadcrumbItem {
  /// Creates a breadcrumb item.
  const CorpoBreadcrumbItem({
    required this.text,
    this.onTap,
    this.icon,
    this.isCurrentPage = false,
    this.enabled = true,
  });

  /// Text label for the breadcrumb item.
  final String text;

  /// Called when the breadcrumb item is tapped.
  final VoidCallback? onTap;

  /// Optional icon for the breadcrumb item.
  final IconData? icon;

  /// Whether this item represents the current page.
  final bool isCurrentPage;

  /// Whether the item is enabled.
  final bool enabled;
}

/// A comprehensive breadcrumb navigation widget following Corpo UI design principles.
///
/// This component provides consistent hierarchical navigation styling with
/// support for custom separators, interactive items, and accessibility features.
class CorpoBreadcrumb extends StatelessWidget {
  /// Creates a Corpo UI breadcrumb navigation.
  const CorpoBreadcrumb({
    required this.items,
    super.key,
    this.separator = '/',
    this.maxItems,
    this.overflowText = '...',
    this.separatorColor,
    this.itemColor,
    this.currentPageColor,
    this.disabledColor,
  });

  /// List of breadcrumb items.
  final List<CorpoBreadcrumbItem> items;

  /// Separator between breadcrumb items.
  final String separator;

  /// Maximum number of items to show before overflow.
  final int? maxItems;

  /// Text to show when items are collapsed due to overflow.
  final String overflowText;

  /// Color of the separator.
  final Color? separatorColor;

  /// Color of clickable items.
  final Color? itemColor;

  /// Color of the current page item.
  final Color? currentPageColor;

  /// Color of disabled items.
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final List<CorpoBreadcrumbItem> displayItems = _getDisplayItems();

    return Wrap(children: _buildBreadcrumbItems(displayItems, tokens, isDark));
  }

  List<CorpoBreadcrumbItem> _getDisplayItems() {
    if (maxItems == null || items.length <= maxItems!) {
      return items;
    }

    // Show first item, overflow indicator, and last few items
    final List<CorpoBreadcrumbItem> result = <CorpoBreadcrumbItem>[];

    // Always show first item
    if (items.isNotEmpty) {
      result.add(items.first);
    }

    // Add overflow indicator if needed
    if (items.length > maxItems!) {
      result.add(CorpoBreadcrumbItem(text: overflowText, enabled: false));
    }

    // Add last few items
    final int startIndex = items.length - (maxItems! - 2);
    if (startIndex > 1) {
      result.addAll(items.sublist(startIndex));
    }

    return result;
  }

  List<Widget> _buildBreadcrumbItems(
    List<CorpoBreadcrumbItem> displayItems,
    CorpoDesignTokens tokens,
    bool isDark,
  ) {
    final List<Widget> widgets = <Widget>[];

    for (int i = 0; i < displayItems.length; i++) {
      final CorpoBreadcrumbItem item = displayItems[i];

      // Add the breadcrumb item
      widgets.add(_buildBreadcrumbItem(item, tokens, isDark));

      // Add separator if not the last item
      if (i < displayItems.length - 1) {
        widgets.add(_buildSeparator(tokens, isDark));
      }
    }

    return widgets;
  }

  Widget _buildBreadcrumbItem(
    CorpoBreadcrumbItem item,
    CorpoDesignTokens tokens,
    bool isDark,
  ) {
    Color textColor;

    if (!item.enabled) {
      textColor = disabledColor ?? tokens.textSecondary.withOpacity(0.5);
    } else if (item.isCurrentPage) {
      textColor = currentPageColor ?? tokens.textPrimary;
    } else {
      textColor = itemColor ?? tokens.primaryColor;
    }

    final Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (item.icon != null) ...<Widget>[
          Icon(item.icon, size: 16, color: textColor),
          SizedBox(width: tokens.spacing1x),
        ],
        Text(
          item.text,
          style: TextStyle(
            fontSize: tokens.fontSizeSmall,
            fontFamily: tokens.fontFamily,
            color: textColor,
            fontWeight: item.isCurrentPage ? FontWeight.w600 : FontWeight.w400,
            decoration: item.enabled && !item.isCurrentPage
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: textColor,
          ),
        ),
      ],
    );

    if (item.enabled && !item.isCurrentPage && item.onTap != null) {
      return InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing1x,
            vertical: 2,
          ),
          child: child,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing1x, vertical: 2),
      child: child,
    );
  }

  Widget _buildSeparator(CorpoDesignTokens tokens, bool isDark) => Padding(
    padding: EdgeInsets.symmetric(horizontal: tokens.spacing1x),
    child: Text(
      separator,
      style: TextStyle(
        fontSize: tokens.fontSizeSmall,
        fontFamily: tokens.fontFamily,
        color: separatorColor ?? tokens.textSecondary,
      ),
    ),
  );
}
