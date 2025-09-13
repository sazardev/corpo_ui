/// A comprehensive tabs component for the Corpo UI design system.
///
/// CorpoTabs provides consistent tab navigation styling and behavior
/// across corporate applications, with support for various styles,
/// scrolling, and responsive design.
///
/// Example usage:
/// ```dart
/// CorpoTabs(
///   tabs: [
///     CorpoTab(text: 'Overview'),
///     CorpoTab(text: 'Details'),
///     CorpoTab(text: 'Settings'),
///   ],
///   children: [
///     OverviewPage(),
///     DetailsPage(),
///     SettingsPage(),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Tab styles for different use cases.
enum CorpoTabStyle {
  /// Standard underlined tabs
  underlined,

  /// Filled background tabs
  filled,

  /// Outlined tabs
  outlined,
}

/// Individual tab configuration.
class CorpoTab {
  /// Creates a tab configuration.
  const CorpoTab({this.text, this.icon, this.child});

  /// Text label for the tab.
  final String? text;

  /// Icon for the tab.
  final IconData? icon;

  /// Custom child widget for the tab.
  final Widget? child;
}

/// A comprehensive tabs widget following Corpo UI design principles.
///
/// This component provides consistent tab navigation styling with support
/// for various styles, scrolling, and accessibility features.
class CorpoTabs extends StatefulWidget {
  /// Creates a Corpo UI tabs component.
  const CorpoTabs({
    required this.tabs, required this.children, super.key,
    this.initialIndex = 0,
    this.onTap,
    this.style = CorpoTabStyle.underlined,
    this.isScrollable = false,
    this.indicatorColor,
    this.backgroundColor,
    this.labelColor,
    this.unselectedLabelColor,
  });

  /// List of tab configurations.
  final List<CorpoTab> tabs;

  /// List of child widgets corresponding to each tab.
  final List<Widget> children;

  /// Initial selected tab index.
  final int initialIndex;

  /// Called when a tab is selected.
  final ValueChanged<int>? onTap;

  /// Style of the tabs.
  final CorpoTabStyle style;

  /// Whether tabs should be scrollable.
  final bool isScrollable;

  /// Color of the tab indicator.
  final Color? indicatorColor;

  /// Background color of the tab bar.
  final Color? backgroundColor;

  /// Color of the selected tab label.
  final Color? labelColor;

  /// Color of unselected tab labels.
  final Color? unselectedLabelColor;

  @override
  State<CorpoTabs> createState() => _CorpoTabsState();
}

class _CorpoTabsState extends State<CorpoTabs> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      widget.onTap?.call(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Column(
      children: <Widget>[
        _buildTabBar(isDark),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.children,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(bool isDark) {
    switch (widget.style) {
      case CorpoTabStyle.underlined:
        return _buildUnderlinedTabBar(isDark);
      case CorpoTabStyle.filled:
        return _buildFilledTabBar(isDark);
      case CorpoTabStyle.outlined:
        return _buildOutlinedTabBar(isDark);
    }
  }

  Widget _buildUnderlinedTabBar(bool isDark) => Container(
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ??
            (isDark ? CorpoColors.neutral900 : CorpoColors.neutralWhite),
        border: Border(
          bottom: BorderSide(
            color: isDark ? CorpoColors.neutral700 : CorpoColors.neutral200,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: widget.tabs.map(_buildTab).toList(),
        isScrollable: widget.isScrollable,
        indicatorColor:
            widget.indicatorColor ??
            (isDark ? CorpoColors.primary400 : CorpoColors.primary500),
        labelColor:
            widget.labelColor ??
            (isDark ? CorpoColors.primary400 : CorpoColors.primary500),
        unselectedLabelColor:
            widget.unselectedLabelColor ??
            (isDark ? CorpoColors.neutral400 : CorpoColors.neutral600),
        labelStyle: CorpoTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: CorpoTypography.labelMedium,
        splashFactory: NoSplash.splashFactory,
      ),
    );

  Widget _buildFilledTabBar(bool isDark) => Container(
      padding: const EdgeInsets.all(CorpoSpacing.extraSmall),
      decoration: BoxDecoration(
        color: isDark ? CorpoColors.neutral800 : CorpoColors.neutral100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: widget.tabs.map(_buildTab).toList(),
        isScrollable: widget.isScrollable,
        indicator: BoxDecoration(
          color: isDark ? CorpoColors.primary600 : CorpoColors.primary500,
          borderRadius: BorderRadius.circular(6),
        ),
        labelColor: CorpoColors.neutralWhite,
        unselectedLabelColor: isDark
            ? CorpoColors.neutral400
            : CorpoColors.neutral600,
        labelStyle: CorpoTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: CorpoTypography.labelMedium,
        splashFactory: NoSplash.splashFactory,
      ),
    );

  Widget _buildOutlinedTabBar(bool isDark) => Container(
      padding: const EdgeInsets.all(CorpoSpacing.extraSmall),
      child: TabBar(
        controller: _tabController,
        tabs: widget.tabs.map(_buildTab).toList(),
        isScrollable: widget.isScrollable,
        indicator: BoxDecoration(
          border: Border.all(
            color: isDark ? CorpoColors.primary400 : CorpoColors.primary500,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        labelColor: isDark ? CorpoColors.primary400 : CorpoColors.primary500,
        unselectedLabelColor: isDark
            ? CorpoColors.neutral400
            : CorpoColors.neutral600,
        labelStyle: CorpoTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: CorpoTypography.labelMedium,
        splashFactory: NoSplash.splashFactory,
      ),
    );

  Widget _buildTab(CorpoTab tab) {
    if (tab.child != null) {
      return Tab(child: tab.child);
    }

    if (tab.icon != null && tab.text != null) {
      return Tab(icon: Icon(tab.icon, size: 20), text: tab.text);
    }

    if (tab.icon != null) {
      return Tab(icon: Icon(tab.icon, size: 20));
    }

    return Tab(text: tab.text ?? '');
  }
}
