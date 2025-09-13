/// Responsive layout builder for the Corpo UI design system.
///
/// This file provides comprehensive responsive layout building utilities
/// including breakpoint-aware builders, responsive containers, and adaptive
/// layout components for creating professional corporate applications.
///
/// The responsive system enables building layouts that adapt gracefully
/// across all device sizes while maintaining corporate design principles.
///
/// Example usage:
/// ```dart
/// CorpoResponsiveBuilder(
///   builder: (context, screenSize) {
///     return screenSize.isDesktop
///         ? DesktopLayout()
///         : MobileLayout();
///   },
/// )
///
/// CorpoResponsiveRow(
///   children: [
///     CorpoResponsiveColumn(
///       xs: 12, md: 6, lg: 4,
///       child: MyWidget(),
///     ),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'screen_size.dart';

/// Signature for responsive builder functions.
typedef CorpoResponsiveWidgetBuilder =
    Widget Function(BuildContext context, CorpoScreenSize screenSize);

/// Signature for breakpoint-specific builder functions.
typedef CorpoBreakpointBuilder<T> = T Function(CorpoScreenSize screenSize);

/// A responsive builder widget that rebuilds when screen size changes.
///
/// This component provides a convenient way to build responsive layouts
/// that adapt to different screen sizes and orientations.
class CorpoResponsiveBuilder extends StatelessWidget {
  /// Creates a responsive builder.
  const CorpoResponsiveBuilder({required this.builder, super.key});

  /// The builder function that creates the widget tree.
  final CorpoResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);
    return builder(context, screenSize);
  }
}

/// A responsive widget that shows different content based on breakpoints.
///
/// This component allows you to define different widget trees for different
/// screen sizes, providing a declarative way to handle responsive design.
class CorpoResponsiveWidget extends StatelessWidget {
  /// Creates a responsive widget.
  const CorpoResponsiveWidget({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
    this.fallback,
    super.key,
  }) : assert(
         xs != null ||
             sm != null ||
             md != null ||
             lg != null ||
             xl != null ||
             xxl != null ||
             fallback != null,
         'At least one widget must be provided',
       );

  /// Widget for extra small screens.
  final Widget? xs;

  /// Widget for small screens.
  final Widget? sm;

  /// Widget for medium screens.
  final Widget? md;

  /// Widget for large screens.
  final Widget? lg;

  /// Widget for extra large screens.
  final Widget? xl;

  /// Widget for extra extra large screens.
  final Widget? xxl;

  /// Fallback widget if no specific breakpoint widget is provided.
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);

    final Widget? widget = screenSize.select<Widget?>(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: fallback,
    );

    return widget ?? const SizedBox.shrink();
  }
}

/// A responsive container that adapts its constraints and padding.
///
/// This component provides responsive constraints, padding, and margin
/// based on screen size, following corporate design principles.
class CorpoResponsiveContainer extends StatelessWidget {
  /// Creates a responsive container.
  const CorpoResponsiveContainer({
    required this.child,
    this.maxWidth,
    this.padding,
    this.margin,
    this.alignment,
    this.decoration,
    this.constraints,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Maximum width constraints by breakpoint.
  final CorpoBreakpointBuilder<double?>? maxWidth;

  /// Padding by breakpoint.
  final CorpoBreakpointBuilder<EdgeInsetsGeometry?>? padding;

  /// Margin by breakpoint.
  final CorpoBreakpointBuilder<EdgeInsetsGeometry?>? margin;

  /// Alignment within the container.
  final AlignmentGeometry? alignment;

  /// Container decoration.
  final Decoration? decoration;

  /// Additional constraints.
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);

    final double? effectiveMaxWidth = maxWidth?.call(screenSize);
    final EdgeInsetsGeometry? effectivePadding = padding?.call(screenSize);
    final EdgeInsetsGeometry? effectiveMargin = margin?.call(screenSize);

    BoxConstraints? effectiveConstraints = constraints;
    if (effectiveMaxWidth != null) {
      effectiveConstraints = (effectiveConstraints ?? const BoxConstraints())
          .copyWith(maxWidth: effectiveMaxWidth);
    }

    return Container(
      constraints: effectiveConstraints,
      padding: effectivePadding,
      margin: effectiveMargin,
      alignment: alignment,
      decoration: decoration,
      child: child,
    );
  }
}

/// Column span configuration for responsive grid layouts.
class CorpoColumnSpan {
  /// Creates a column span configuration.
  const CorpoColumnSpan({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  /// Columns for extra small screens (out of 12).
  final int? xs;

  /// Columns for small screens (out of 12).
  final int? sm;

  /// Columns for medium screens (out of 12).
  final int? md;

  /// Columns for large screens (out of 12).
  final int? lg;

  /// Columns for extra large screens (out of 12).
  final int? xl;

  /// Columns for extra extra large screens (out of 12).
  final int? xxl;

  /// Gets the column span for the current screen size.
  int getSpan(CorpoScreenSize screenSize) {
    final int? span = screenSize.select<int?>(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: null,
    );
    return span ?? 12; // Default to full width
  }

  /// Gets the flex value (column span).
  int getFlex(CorpoScreenSize screenSize) => getSpan(screenSize);

  /// Gets the width percentage (span / 12).
  double getWidthPercentage(CorpoScreenSize screenSize) => getSpan(screenSize) / 12.0;
}

/// A responsive column that adapts its width based on screen size.
///
/// This component implements a 12-column grid system similar to Bootstrap
/// or CSS Grid, providing responsive column layouts.
class CorpoResponsiveColumn extends StatelessWidget {
  /// Creates a responsive column.
  const CorpoResponsiveColumn({
    required this.child,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
    this.padding,
    super.key,
  });

  /// Creates a responsive column with span configuration.
  CorpoResponsiveColumn.span({
    required this.child,
    required CorpoColumnSpan span,
    this.padding,
    super.key,
  }) : xs = span.xs,
       sm = span.sm,
       md = span.md,
       lg = span.lg,
       xl = span.xl,
       xxl = span.xxl;

  /// The child widget.
  final Widget child;

  /// Columns for extra small screens (out of 12).
  final int? xs;

  /// Columns for small screens (out of 12).
  final int? sm;

  /// Columns for medium screens (out of 12).
  final int? md;

  /// Columns for large screens (out of 12).
  final int? lg;

  /// Columns for extra large screens (out of 12).
  final int? xl;

  /// Columns for extra extra large screens (out of 12).
  final int? xxl;

  /// Padding around the column content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);
    final CorpoColumnSpan span = CorpoColumnSpan(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
    );

    final int flex = span.getFlex(screenSize);

    Widget content = child;
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    return Expanded(flex: flex, child: content);
  }
}

/// A responsive row that contains responsive columns.
///
/// This component provides the container for responsive column layouts,
/// implementing a 12-column grid system.
class CorpoResponsiveRow extends StatelessWidget {
  /// Creates a responsive row.
  const CorpoResponsiveRow({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.gutter,
    super.key,
  });

  /// The responsive columns.
  final List<Widget> children;

  /// How to align children along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How to align children along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;

  /// The text direction to use for the row.
  final TextDirection? textDirection;

  /// The vertical direction to use for the row.
  final VerticalDirection verticalDirection;

  /// The baseline to use for text alignment.
  final TextBaseline? textBaseline;

  /// Spacing between columns.
  final double? gutter;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = children;

    // Add gutter spacing between columns
    if (gutter != null && gutter! > 0 && children.length > 1) {
      rowChildren = <Widget>[];
      for (int i = 0; i < children.length; i++) {
        rowChildren.add(children[i]);
        if (i < children.length - 1) {
          rowChildren.add(SizedBox(width: gutter));
        }
      }
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: rowChildren,
    );
  }
}

/// A responsive wrap that adjusts its behavior based on screen size.
///
/// This component provides responsive wrapping behavior with breakpoint-aware
/// spacing and alignment.
class CorpoResponsiveWrap extends StatelessWidget {
  /// Creates a responsive wrap.
  const CorpoResponsiveWrap({
    required this.children,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing,
    this.runSpacing,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    super.key,
  });

  /// The widgets to wrap.
  final List<Widget> children;

  /// The direction of the main axis.
  final Axis direction;

  /// How to align children within a run.
  final WrapAlignment alignment;

  /// Spacing between children in the main axis.
  final CorpoBreakpointBuilder<double>? spacing;

  /// Spacing between runs in the cross axis.
  final CorpoBreakpointBuilder<double>? runSpacing;

  /// How to align runs in the cross axis.
  final WrapAlignment runAlignment;

  /// How to align children within a run in the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// The text direction to use.
  final TextDirection? textDirection;

  /// The vertical direction to use.
  final VerticalDirection verticalDirection;

  /// The clip behavior.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);

    final double effectiveSpacing = spacing?.call(screenSize) ?? 8.0;
    final double effectiveRunSpacing = runSpacing?.call(screenSize) ?? 8.0;

    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: effectiveSpacing,
      runSpacing: effectiveRunSpacing,
      runAlignment: runAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      children: children,
    );
  }
}

/// Utility class for creating responsive layouts.
abstract final class CorpoResponsiveUtils {
  /// Creates a responsive value selector.
  static T select<T>(
    BuildContext context, {
    required T fallback, T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    final CorpoScreenSize screenSize = CorpoScreenSize.of(context);
    return screenSize.select<T>(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: fallback,
    );
  }

  /// Creates a responsive padding selector.
  static EdgeInsetsGeometry selectPadding(
    BuildContext context, {
    required EdgeInsetsGeometry fallback, EdgeInsetsGeometry? xs,
    EdgeInsetsGeometry? sm,
    EdgeInsetsGeometry? md,
    EdgeInsetsGeometry? lg,
    EdgeInsetsGeometry? xl,
    EdgeInsetsGeometry? xxl,
  }) => select<EdgeInsetsGeometry>(
      context,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: fallback,
    );

  /// Creates a responsive margin selector.
  static EdgeInsetsGeometry selectMargin(
    BuildContext context, {
    required EdgeInsetsGeometry fallback, EdgeInsetsGeometry? xs,
    EdgeInsetsGeometry? sm,
    EdgeInsetsGeometry? md,
    EdgeInsetsGeometry? lg,
    EdgeInsetsGeometry? xl,
    EdgeInsetsGeometry? xxl,
  }) => select<EdgeInsetsGeometry>(
      context,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: fallback,
    );

  /// Creates a responsive font size selector.
  static double selectFontSize(
    BuildContext context, {
    required double fallback, double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) => select<double>(
      context,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: fallback,
    );

  /// Gets standard container max widths for breakpoints.
  static double? getContainerMaxWidth(CorpoScreenSize screenSize) => screenSize.select<double?>(
      sm: 540,
      md: 720,
      lg: 960,
      xl: 1140,
      xxl: 1320,
      fallback: null,
    );

  /// Creates a responsive container with standard max widths.
  static Widget container({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    AlignmentGeometry? alignment,
  }) => CorpoResponsiveContainer(
      maxWidth: getContainerMaxWidth,
      padding: padding != null ? (_) => padding : null,
      margin: margin != null ? (_) => margin : null,
      alignment: alignment,
      child: child,
    );
}
