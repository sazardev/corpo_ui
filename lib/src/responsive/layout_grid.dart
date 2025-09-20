/// CSS Grid-like layout system for the Corpo UI design system.
///
/// This file provides comprehensive grid layout utilities inspired by
/// CSS Grid, enabling powerful and flexible layout arrangements with
/// corporate design principles and responsive behavior.
///
/// The grid system supports responsive configurations, gap management,
/// and flexible grid item placement.
///
/// Example usage:
/// ```dart
/// CorpoLayoutGrid(
///   crossAxisCount: 3,
///   gap: 16,
///   children: [
///     CorpoGridItem(child: Widget1()),
///     CorpoGridItem(child: Widget2()),
///     CorpoGridItem(child: Widget3()),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';

import 'responsive_builder.dart';
import 'screen_size.dart';

/// Represents an item in the grid layout.
class CorpoGridItem extends StatelessWidget {
  /// Creates a grid item.
  const CorpoGridItem({
    required this.child,
    this.crossAxisCellCount,
    this.mainAxisCellCount,
    this.alignment,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Number of cells to span across the cross axis.
  final int? crossAxisCellCount;

  /// Number of cells to span across the main axis.
  final int? mainAxisCellCount;

  /// Alignment within the grid cell.
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    if (alignment != null) {
      content = Align(alignment: alignment!, child: content);
    }

    return content;
  }
}

/// A responsive grid layout widget inspired by CSS Grid.
///
/// This component provides flexible grid layout capabilities with
/// responsive behavior and corporate design principles.
class CorpoLayoutGrid extends StatelessWidget {
  /// Creates a layout grid.
  const CorpoLayoutGrid({
    required this.children,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.gap,
    this.childAspectRatio = 1.0,
    this.responsiveCrossAxisCount,
    this.responsiveGap,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    super.key,
  });

  /// The grid items.
  final List<Widget> children;

  /// Number of items in the cross axis.
  final int crossAxisCount;

  /// Spacing between items on the main axis.
  final double mainAxisSpacing;

  /// Spacing between items on the cross axis.
  final double crossAxisSpacing;

  /// Gap between both axes (overrides mainAxisSpacing and crossAxisSpacing).
  final double? gap;

  /// The ratio of cross-axis to main-axis extent of each child.
  final double childAspectRatio;

  /// Responsive cross axis count by breakpoint.
  final Map<CorpoBreakpoint, int>? responsiveCrossAxisCount;

  /// Responsive gap by breakpoint.
  final Map<CorpoBreakpoint, double>? responsiveGap;

  /// The scroll direction.
  final Axis scrollDirection;

  /// Whether the grid should shrink wrap.
  final bool shrinkWrap;

  /// The scroll physics.
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);

    // Get responsive values
    final int effectiveCrossAxisCount = _getResponsiveCrossAxisCount(
      screenSize,
    );
    final double effectiveGap = _getResponsiveGap(screenSize);

    return GridView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: effectiveCrossAxisCount,
        mainAxisSpacing: effectiveGap,
        crossAxisSpacing: effectiveGap,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) => children[index],
    );
  }

  int _getResponsiveCrossAxisCount(CorpoScreenSize screenSize) {
    if (responsiveCrossAxisCount != null) {
      for (final CorpoBreakpoint breakpoint
          in CorpoBreakpoint.values.reversed) {
        if (screenSize.isAtLeast(breakpoint) &&
            responsiveCrossAxisCount!.containsKey(breakpoint)) {
          return responsiveCrossAxisCount![breakpoint]!;
        }
      }
    }
    return crossAxisCount;
  }

  double _getResponsiveGap(CorpoScreenSize screenSize) {
    if (responsiveGap != null) {
      for (final CorpoBreakpoint breakpoint
          in CorpoBreakpoint.values.reversed) {
        if (screenSize.isAtLeast(breakpoint) &&
            responsiveGap!.containsKey(breakpoint)) {
          return responsiveGap![breakpoint]!;
        }
      }
    }
    return gap ?? mainAxisSpacing;
  }
}

/// A staggered grid layout for variable-sized items.
///
/// This component provides a Pinterest-style grid layout with
/// responsive behavior.
class CorpoStaggeredGrid extends StatelessWidget {
  /// Creates a staggered grid.
  const CorpoStaggeredGrid({
    required this.children,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.responsiveCrossAxisCount,
    super.key,
  });

  /// The grid items.
  final List<Widget> children;

  /// Number of columns.
  final int crossAxisCount;

  /// Spacing between items on the main axis.
  final double mainAxisSpacing;

  /// Spacing between items on the cross axis.
  final double crossAxisSpacing;

  /// Responsive cross axis count by breakpoint.
  final Map<CorpoBreakpoint, int>? responsiveCrossAxisCount;

  @override
  Widget build(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);
    final int effectiveCrossAxisCount = _getResponsiveCrossAxisCount(
      screenSize,
    );

    // Create columns
    final List<List<Widget>> columns = List.generate(
      effectiveCrossAxisCount,
      (_) => <Widget>[],
    );

    // Distribute children across columns
    for (int i = 0; i < children.length; i++) {
      final int columnIndex = i % effectiveCrossAxisCount;
      columns[columnIndex].add(children[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columns.asMap().entries.map((
        MapEntry<int, List<Widget>> entry,
      ) {
        final int columnIndex = entry.key;
        final List<Widget> columnChildren = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: columnIndex < effectiveCrossAxisCount - 1
                  ? crossAxisSpacing
                  : 0,
            ),
            child: Column(
              children: columnChildren.asMap().entries.map((
                MapEntry<int, Widget> childEntry,
              ) {
                final int childIndex = childEntry.key;
                final Widget child = childEntry.value;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: childIndex < columnChildren.length - 1
                        ? mainAxisSpacing
                        : 0,
                  ),
                  child: child,
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }

  int _getResponsiveCrossAxisCount(CorpoScreenSize screenSize) {
    if (responsiveCrossAxisCount != null) {
      for (final CorpoBreakpoint breakpoint
          in CorpoBreakpoint.values.reversed) {
        if (screenSize.isAtLeast(breakpoint) &&
            responsiveCrossAxisCount!.containsKey(breakpoint)) {
          return responsiveCrossAxisCount![breakpoint]!;
        }
      }
    }
    return crossAxisCount;
  }
}

/// A masonry-style grid layout.
///
/// This component provides a brick-like layout where items
/// are placed to minimize gaps.
class CorpoMasonryGrid extends StatelessWidget {
  /// Creates a masonry grid.
  const CorpoMasonryGrid({
    required this.children,
    this.crossAxisCount = 2,
    this.spacing = 8,
    this.responsiveCrossAxisCount,
    super.key,
  });

  /// The grid items.
  final List<Widget> children;

  /// Number of columns.
  final int crossAxisCount;

  /// Spacing between items.
  final double spacing;

  /// Responsive cross axis count by breakpoint.
  final Map<CorpoBreakpoint, int>? responsiveCrossAxisCount;

  @override
  Widget build(BuildContext context) => CorpoStaggeredGrid(
    crossAxisCount: _getEffectiveCrossAxisCount(context),
    mainAxisSpacing: spacing,
    crossAxisSpacing: spacing,
    responsiveCrossAxisCount: responsiveCrossAxisCount,
    children: children,
  );

  int _getEffectiveCrossAxisCount(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);

    if (responsiveCrossAxisCount != null) {
      for (final CorpoBreakpoint breakpoint
          in CorpoBreakpoint.values.reversed) {
        if (screenSize.isAtLeast(breakpoint) &&
            responsiveCrossAxisCount!.containsKey(breakpoint)) {
          return responsiveCrossAxisCount![breakpoint]!;
        }
      }
    }
    return crossAxisCount;
  }
}

/// Utility class for creating grid layouts.
abstract final class CorpoGridUtils {
  /// Creates a simple responsive grid.
  static Widget simpleGrid({
    required List<Widget> children,
    int mobileColumns = 1,
    int tabletColumns = 2,
    int desktopColumns = 3,
    double gap = 16,
    double childAspectRatio = 1.0,
  }) => CorpoLayoutGrid(
    crossAxisCount: mobileColumns,
    responsiveCrossAxisCount: <CorpoBreakpoint, int>{
      CorpoBreakpoint.xs: mobileColumns,
      CorpoBreakpoint.md: tabletColumns,
      CorpoBreakpoint.lg: desktopColumns,
    },
    gap: gap,
    childAspectRatio: childAspectRatio,
    children: children,
  );

  /// Creates a card grid layout.
  static Widget cardGrid({
    required List<Widget> cards,
    double minCardWidth = 300,
    double gap = 16,
    double cardAspectRatio = 1.2,
  }) => CorpoResponsiveBuilder(
    builder: (BuildContext context, CorpoScreenSize screenSize) {
      final double availableWidth = screenSize.width - gap;
      final int columns = (availableWidth / (minCardWidth + gap)).floor().clamp(
        1,
        cards.length,
      );

      return CorpoLayoutGrid(
        crossAxisCount: columns,
        gap: gap,
        childAspectRatio: cardAspectRatio,
        children: cards,
      );
    },
  );

  /// Creates a dashboard-style layout.
  static Widget dashboardLayout({
    required Widget content,
    Widget? header,
    Widget? sidebar,
    Widget? footer,
    double gap = 16,
  }) => CorpoResponsiveBuilder(
    builder: (BuildContext context, CorpoScreenSize screenSize) {
      if (screenSize.isMobile) {
        // Mobile: stack vertically
        return Column(
          children: <Widget>[
            if (header != null) ...<Widget>[header, SizedBox(height: gap)],
            if (sidebar != null) ...<Widget>[sidebar, SizedBox(height: gap)],
            Expanded(child: content),
            if (footer != null) ...<Widget>[SizedBox(height: gap), footer],
          ],
        );
      } else {
        // Desktop: sidebar layout
        return Column(
          children: <Widget>[
            if (header != null) ...<Widget>[header, SizedBox(height: gap)],
            Expanded(
              child: Row(
                children: <Widget>[
                  if (sidebar != null) ...<Widget>[
                    SizedBox(width: 250, child: sidebar),
                    SizedBox(width: gap),
                  ],
                  Expanded(child: content),
                ],
              ),
            ),
            if (footer != null) ...<Widget>[SizedBox(height: gap), footer],
          ],
        );
      }
    },
  );

  /// Creates a responsive masonry layout.
  static Widget masonryLayout({
    required List<Widget> children,
    int mobileColumns = 1,
    int tabletColumns = 2,
    int desktopColumns = 3,
    double spacing = 16,
  }) => CorpoMasonryGrid(
    crossAxisCount: mobileColumns,
    responsiveCrossAxisCount: <CorpoBreakpoint, int>{
      CorpoBreakpoint.xs: mobileColumns,
      CorpoBreakpoint.md: tabletColumns,
      CorpoBreakpoint.lg: desktopColumns,
    },
    spacing: spacing,
    children: children,
  );

  /// Creates a hero section layout.
  static Widget heroSection({
    required Widget hero,
    List<Widget> features = const <Widget>[],
    double gap = 32,
  }) => CorpoResponsiveBuilder(
    builder: (BuildContext context, CorpoScreenSize screenSize) {
      if (screenSize.isMobile) {
        return Column(
          children: <Widget>[
            hero,
            if (features.isNotEmpty) ...<Widget>[
              SizedBox(height: gap),
              ...features.map(
                (Widget feature) => Padding(
                  padding: EdgeInsets.only(bottom: gap),
                  child: feature,
                ),
              ),
            ],
          ],
        );
      } else {
        return Row(
          children: <Widget>[
            Expanded(flex: 2, child: hero),
            SizedBox(width: gap),
            Expanded(
              child: Column(
                children: features
                    .map(
                      (Widget feature) => Padding(
                        padding: EdgeInsets.only(bottom: gap),
                        child: feature,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      }
    },
  );
}
