/// Responsive design utilities for the Corpo UI design system.
///
/// This file provides comprehensive responsive design utilities including
/// breakpoints, adaptive layouts, and screen size detection for building
/// responsive corporate applications that work across all device types.
///
/// The responsive system includes:
/// - Standardized breakpoints for different screen sizes
/// - Adaptive helpers for conditional rendering
/// - Screen size detection utilities
/// - Responsive value selection based on context
///
/// Example usage:
/// ```dart
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return CorpoResponsive.builder(
///       mobile: (context) => MobileLayout(),
///       tablet: (context) => TabletLayout(),
///       desktop: (context) => DesktopLayout(),
///     );
///   }
/// }
///
/// // Responsive padding
/// final padding = CorpoResponsive.value(
///   context: context,
///   mobile: 16.0,
///   tablet: 24.0,
///   desktop: 32.0,
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Screen size categories for responsive design.
///
/// These categories provide semantic meaning to different
/// screen sizes and help create appropriate layouts.
enum CorpoScreenSize {
  /// Small mobile screens (< 480px width)
  mobile,

  /// Tablet screens (480px - 768px width)
  tablet,

  /// Small desktop screens (768px - 1024px width)
  smallDesktop,

  /// Large desktop screens (> 1024px width)
  desktop,
}

/// Responsive design breakpoints in logical pixels.
///
/// These breakpoints follow common responsive design patterns
/// and provide consistent behavior across different screen sizes.
abstract final class CorpoBreakpoints {
  /// Mobile breakpoint (480px)
  /// Below this width, consider as mobile device
  static const double mobile = 480.0;

  /// Tablet breakpoint (768px)
  /// Between mobile and tablet breakpoints
  static const double tablet = 768.0;

  /// Small desktop breakpoint (1024px)
  /// Between tablet and desktop breakpoints
  static const double smallDesktop = 1024.0;

  /// Desktop breakpoint (1200px)
  /// Above this width, consider as large desktop
  static const double desktop = 1200.0;
}

/// A comprehensive responsive design utility class.
///
/// Provides static methods for responsive design patterns,
/// screen size detection, and adaptive value selection
/// based on the current screen context.
abstract final class CorpoResponsive {
  /// Gets the current screen size category.
  ///
  /// Analyzes the current screen width and returns the
  /// appropriate screen size category for responsive decisions.
  static CorpoScreenSize getScreenSize(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width < CorpoBreakpoints.mobile) {
      return CorpoScreenSize.mobile;
    } else if (width < CorpoBreakpoints.tablet) {
      return CorpoScreenSize.tablet;
    } else if (width < CorpoBreakpoints.smallDesktop) {
      return CorpoScreenSize.smallDesktop;
    } else {
      return CorpoScreenSize.desktop;
    }
  }

  /// Checks if the current screen is mobile size.
  static bool isMobile(BuildContext context) =>
      getScreenSize(context) == CorpoScreenSize.mobile;

  /// Checks if the current screen is tablet size.
  static bool isTablet(BuildContext context) =>
      getScreenSize(context) == CorpoScreenSize.tablet;

  /// Checks if the current screen is small desktop size.
  static bool isSmallDesktop(BuildContext context) =>
      getScreenSize(context) == CorpoScreenSize.smallDesktop;

  /// Checks if the current screen is desktop size.
  static bool isDesktop(BuildContext context) =>
      getScreenSize(context) == CorpoScreenSize.desktop;

  /// Checks if the current screen is mobile or tablet.
  static bool isMobileOrTablet(BuildContext context) {
    final CorpoScreenSize size = getScreenSize(context);
    return size == CorpoScreenSize.mobile || size == CorpoScreenSize.tablet;
  }

  /// Checks if the current screen is desktop or small desktop.
  static bool isDesktopOrSmallDesktop(BuildContext context) {
    final CorpoScreenSize size = getScreenSize(context);
    return size == CorpoScreenSize.desktop ||
        size == CorpoScreenSize.smallDesktop;
  }

  /// Returns a responsive value based on screen size.
  ///
  /// Selects the appropriate value based on the current screen size.
  /// Falls back to smaller screen values if larger ones are not provided.
  static T value<T>({
    required BuildContext context,
    T? mobile,
    T? tablet,
    T? smallDesktop,
    T? desktop,
  }) {
    final CorpoScreenSize screenSize = getScreenSize(context);

    switch (screenSize) {
      case CorpoScreenSize.desktop:
        return desktop ?? smallDesktop ?? tablet ?? mobile as T;
      case CorpoScreenSize.smallDesktop:
        return smallDesktop ?? tablet ?? mobile as T;
      case CorpoScreenSize.tablet:
        return tablet ?? mobile as T;
      case CorpoScreenSize.mobile:
        return mobile as T;
    }
  }

  /// Builds a responsive widget based on screen size.
  ///
  /// Returns different widgets for different screen sizes.
  /// Falls back to smaller screen widgets if larger ones are not provided.
  static Widget builder({
    required BuildContext context,
    Widget Function(BuildContext)? mobile,
    Widget Function(BuildContext)? tablet,
    Widget Function(BuildContext)? smallDesktop,
    Widget Function(BuildContext)? desktop,
  }) {
    final CorpoScreenSize screenSize = getScreenSize(context);

    Widget Function(BuildContext)? builder;

    switch (screenSize) {
      case CorpoScreenSize.desktop:
        builder = desktop ?? smallDesktop ?? tablet ?? mobile;
      case CorpoScreenSize.smallDesktop:
        builder = smallDesktop ?? tablet ?? mobile;
      case CorpoScreenSize.tablet:
        builder = tablet ?? mobile;
      case CorpoScreenSize.mobile:
        builder = mobile;
    }

    if (builder == null) {
      throw ArgumentError(
        'No builder provided for screen size: $screenSize. '
        'At least one builder must be provided.',
      );
    }

    return builder(context);
  }

  /// Gets the number of columns for a responsive grid.
  ///
  /// Returns an appropriate number of columns based on screen size
  /// for creating responsive grid layouts.
  static int getGridColumns(
    BuildContext context, {
    int mobileColumns = 1,
    int tabletColumns = 2,
    int smallDesktopColumns = 3,
    int desktopColumns = 4,
  }) {
    return value<int>(
      context: context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      smallDesktop: smallDesktopColumns,
      desktop: desktopColumns,
    );
  }

  /// Gets responsive padding based on screen size.
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? smallDesktop,
    EdgeInsets? desktop,
  }) {
    return value<EdgeInsets>(
      context: context,
      mobile: mobile ?? const EdgeInsets.all(16),
      tablet: tablet ?? const EdgeInsets.all(24),
      smallDesktop: smallDesktop ?? const EdgeInsets.all(32),
      desktop: desktop ?? const EdgeInsets.all(40),
    );
  }

  /// Gets responsive margin based on screen size.
  static EdgeInsets getResponsiveMargin(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? smallDesktop,
    EdgeInsets? desktop,
  }) {
    return value<EdgeInsets>(
      context: context,
      mobile: mobile ?? const EdgeInsets.all(8),
      tablet: tablet ?? const EdgeInsets.all(12),
      smallDesktop: smallDesktop ?? const EdgeInsets.all(16),
      desktop: desktop ?? const EdgeInsets.all(20),
    );
  }

  /// Gets responsive font size based on screen size.
  static double getResponsiveFontSize(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? smallDesktop,
    double? desktop,
  }) {
    return value<double>(
      context: context,
      mobile: mobile ?? 14,
      tablet: tablet ?? 16,
      smallDesktop: smallDesktop ?? 16,
      desktop: desktop ?? 18,
    );
  }

  /// Creates a responsive container with adaptive constraints.
  static Widget container({
    required BuildContext context,
    required Widget child,
    double? mobileMaxWidth,
    double? tabletMaxWidth,
    double? smallDesktopMaxWidth,
    double? desktopMaxWidth,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    final double? maxWidth = value<double?>(
      context: context,
      mobile: mobileMaxWidth,
      tablet: tabletMaxWidth,
      smallDesktop: smallDesktopMaxWidth,
      desktop: desktopMaxWidth,
    );

    final EdgeInsets effectivePadding =
        padding ?? getResponsivePadding(context);
    final EdgeInsets effectiveMargin = margin ?? getResponsiveMargin(context);

    Widget container = Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      padding: effectivePadding,
      margin: effectiveMargin,
      child: child,
    );

    // Center the container if max width is specified
    if (maxWidth != null) {
      container = Center(child: container);
    }

    return container;
  }

  /// Creates a responsive wrap widget with adaptive spacing.
  static Widget wrap({
    required List<Widget> children,
    required BuildContext context,
    double? mobileSpacing,
    double? tabletSpacing,
    double? smallDesktopSpacing,
    double? desktopSpacing,
    double? mobileRunSpacing,
    double? tabletRunSpacing,
    double? smallDesktopRunSpacing,
    double? desktopRunSpacing,
    WrapAlignment alignment = WrapAlignment.start,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
  }) {
    final double spacing = value<double>(
      context: context,
      mobile: mobileSpacing ?? 8,
      tablet: tabletSpacing ?? 12,
      smallDesktop: smallDesktopSpacing ?? 16,
      desktop: desktopSpacing ?? 20,
    );

    final double runSpacing = value<double>(
      context: context,
      mobile: mobileRunSpacing ?? 8,
      tablet: tabletRunSpacing ?? 12,
      smallDesktop: smallDesktopRunSpacing ?? 16,
      desktop: desktopRunSpacing ?? 20,
    );

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
