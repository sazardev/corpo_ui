/// Screen size detection and breakpoint utilities for the Corpo UI design system.
///
/// This file provides comprehensive screen size detection utilities including
/// standardized breakpoints, device type detection, and responsive value
/// selection for building adaptive corporate applications.
///
/// The system includes industry-standard breakpoints optimized for business
/// applications and enterprise software requirements.
///
/// Example usage:
/// ```dart
/// final screenSize = CorpoScreenSize.of(context);
/// final isDesktop = screenSize.isDesktop;
/// final breakpoint = screenSize.currentBreakpoint;
///
/// final value = screenSize.select(
///   mobile: 16.0,
///   tablet: 24.0,
///   desktop: 32.0,
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Defines the standard breakpoints for responsive design.
enum CorpoBreakpoint {
  /// Extra small screens (< 576px) - Mobile portrait
  xs,

  /// Small screens (576px - 767px) - Mobile landscape
  sm,

  /// Medium screens (768px - 991px) - Tablet
  md,

  /// Large screens (992px - 1199px) - Desktop
  lg,

  /// Extra large screens (1200px - 1399px) - Large desktop
  xl,

  /// Extra extra large screens (≥ 1400px) - Ultra-wide desktop
  xxl,
}

/// Device type categories for responsive design.
enum CorpoDeviceType {
  /// Mobile phones (portrait and landscape)
  mobile,

  /// Tablets (portrait and landscape)
  tablet,

  /// Desktop computers and laptops
  desktop,

  /// Ultra-wide desktop displays
  ultrawide,
}

/// Screen orientation detection.
enum CorpoOrientation {
  /// Portrait orientation (height > width)
  portrait,

  /// Landscape orientation (width > height)
  landscape,

  /// Square orientation (width ≈ height)
  square,
}

/// Corporate breakpoint configuration with industry-standard values.
abstract final class CorpoBreakpoints {
  /// Extra small breakpoint (mobile portrait)
  static const double xs = 0;

  /// Small breakpoint (mobile landscape)
  static const double sm = 576;

  /// Medium breakpoint (tablet)
  static const double md = 768;

  /// Large breakpoint (desktop)
  static const double lg = 992;

  /// Extra large breakpoint (large desktop)
  static const double xl = 1200;

  /// Extra extra large breakpoint (ultra-wide)
  static const double xxl = 1400;

  /// Gets the breakpoint enum for a given width.
  static CorpoBreakpoint getBreakpoint(double width) {
    if (width >= xxl) return CorpoBreakpoint.xxl;
    if (width >= xl) return CorpoBreakpoint.xl;
    if (width >= lg) return CorpoBreakpoint.lg;
    if (width >= md) return CorpoBreakpoint.md;
    if (width >= sm) return CorpoBreakpoint.sm;
    return CorpoBreakpoint.xs;
  }

  /// Gets the minimum width for a breakpoint.
  static double getBreakpointWidth(CorpoBreakpoint breakpoint) {
    switch (breakpoint) {
      case CorpoBreakpoint.xs:
        return xs;
      case CorpoBreakpoint.sm:
        return sm;
      case CorpoBreakpoint.md:
        return md;
      case CorpoBreakpoint.lg:
        return lg;
      case CorpoBreakpoint.xl:
        return xl;
      case CorpoBreakpoint.xxl:
        return xxl;
    }
  }
}

/// Screen size information and utility methods.
class CorpoScreenSize {
  /// Creates a screen size instance.
  const CorpoScreenSize({
    required this.size,
    required this.devicePixelRatio,
    required this.textScaleFactor,
    required this.padding,
    required this.viewInsets,
    required this.viewPadding,
  });

  /// Creates a screen size from MediaQueryData.
  factory CorpoScreenSize.fromMediaQuery(MediaQueryData mediaQuery) => CorpoScreenSize(
      size: mediaQuery.size,
      devicePixelRatio: mediaQuery.devicePixelRatio,
      textScaleFactor: mediaQuery.textScaler.scale(1),
      padding: mediaQuery.padding,
      viewInsets: mediaQuery.viewInsets,
      viewPadding: mediaQuery.viewPadding,
    );

  /// Gets the screen size information from the current context.
  static CorpoScreenSize of(BuildContext context) => CorpoScreenSize.fromMediaQuery(MediaQuery.of(context));

  /// The logical size of the screen.
  final Size size;

  /// The device pixel ratio.
  final double devicePixelRatio;

  /// The text scale factor.
  final double textScaleFactor;

  /// The system UI padding.
  final EdgeInsets padding;

  /// The view insets (keyboard, etc.).
  final EdgeInsets viewInsets;

  /// The view padding.
  final EdgeInsets viewPadding;

  /// Gets the screen width.
  double get width => size.width;

  /// Gets the screen height.
  double get height => size.height;

  /// Gets the aspect ratio.
  double get aspectRatio => width / height;

  /// Gets the current breakpoint.
  CorpoBreakpoint get currentBreakpoint =>
      CorpoBreakpoints.getBreakpoint(width);

  /// Gets the device type.
  CorpoDeviceType get deviceType {
    if (width >= CorpoBreakpoints.xxl) return CorpoDeviceType.ultrawide;
    if (width >= CorpoBreakpoints.lg) return CorpoDeviceType.desktop;
    if (width >= CorpoBreakpoints.md) return CorpoDeviceType.tablet;
    return CorpoDeviceType.mobile;
  }

  /// Gets the orientation.
  CorpoOrientation get orientation {
    const double threshold = 0.1;
    final double ratio = aspectRatio;

    if ((ratio - 1.0).abs() < threshold) return CorpoOrientation.square;
    return ratio > 1.0 ? CorpoOrientation.landscape : CorpoOrientation.portrait;
  }

  /// Checks if the screen is extra small.
  bool get isXs => currentBreakpoint == CorpoBreakpoint.xs;

  /// Checks if the screen is small.
  bool get isSm => currentBreakpoint == CorpoBreakpoint.sm;

  /// Checks if the screen is medium.
  bool get isMd => currentBreakpoint == CorpoBreakpoint.md;

  /// Checks if the screen is large.
  bool get isLg => currentBreakpoint == CorpoBreakpoint.lg;

  /// Checks if the screen is extra large.
  bool get isXl => currentBreakpoint == CorpoBreakpoint.xl;

  /// Checks if the screen is extra extra large.
  bool get isXxl => currentBreakpoint == CorpoBreakpoint.xxl;

  /// Checks if the screen is mobile size.
  bool get isMobile => deviceType == CorpoDeviceType.mobile;

  /// Checks if the screen is tablet size.
  bool get isTablet => deviceType == CorpoDeviceType.tablet;

  /// Checks if the screen is desktop size.
  bool get isDesktop => deviceType == CorpoDeviceType.desktop;

  /// Checks if the screen is ultrawide.
  bool get isUltrawide => deviceType == CorpoDeviceType.ultrawide;

  /// Checks if the screen is in portrait orientation.
  bool get isPortrait => orientation == CorpoOrientation.portrait;

  /// Checks if the screen is in landscape orientation.
  bool get isLandscape => orientation == CorpoOrientation.landscape;

  /// Checks if the screen is square.
  bool get isSquare => orientation == CorpoOrientation.square;

  /// Checks if the screen width is at least the given breakpoint.
  bool isAtLeast(CorpoBreakpoint breakpoint) => width >= CorpoBreakpoints.getBreakpointWidth(breakpoint);

  /// Checks if the screen width is at most the given breakpoint.
  bool isAtMost(CorpoBreakpoint breakpoint) {
    final CorpoBreakpoint? nextBreakpoint = _getNextBreakpoint(breakpoint);
    if (nextBreakpoint == null) return true;
    return width < CorpoBreakpoints.getBreakpointWidth(nextBreakpoint);
  }

  /// Checks if the screen width is between two breakpoints.
  bool isBetween(CorpoBreakpoint min, CorpoBreakpoint max) => isAtLeast(min) && isAtMost(max);

  /// Selects a value based on the current breakpoint.
  T select<T>({
    required T fallback, T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    switch (currentBreakpoint) {
      case CorpoBreakpoint.xxl:
        return xxl ?? xl ?? lg ?? md ?? sm ?? xs ?? fallback;
      case CorpoBreakpoint.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? fallback;
      case CorpoBreakpoint.lg:
        return lg ?? md ?? sm ?? xs ?? fallback;
      case CorpoBreakpoint.md:
        return md ?? sm ?? xs ?? fallback;
      case CorpoBreakpoint.sm:
        return sm ?? xs ?? fallback;
      case CorpoBreakpoint.xs:
        return xs ?? fallback;
    }
  }

  /// Selects a value based on device type.
  T selectByDevice<T>({
    required T fallback, T? mobile,
    T? tablet,
    T? desktop,
    T? ultrawide,
  }) {
    switch (deviceType) {
      case CorpoDeviceType.mobile:
        return mobile ?? fallback;
      case CorpoDeviceType.tablet:
        return tablet ?? mobile ?? fallback;
      case CorpoDeviceType.desktop:
        return desktop ?? tablet ?? mobile ?? fallback;
      case CorpoDeviceType.ultrawide:
        return ultrawide ?? desktop ?? tablet ?? mobile ?? fallback;
    }
  }

  /// Selects a value based on orientation.
  T selectByOrientation<T>({
    required T fallback, T? portrait,
    T? landscape,
    T? square,
  }) {
    switch (orientation) {
      case CorpoOrientation.portrait:
        return portrait ?? fallback;
      case CorpoOrientation.landscape:
        return landscape ?? fallback;
      case CorpoOrientation.square:
        return square ?? landscape ?? portrait ?? fallback;
    }
  }

  /// Gets the safe area (excluding system UI).
  EdgeInsets get safeArea => EdgeInsets.fromLTRB(
    padding.left,
    padding.top,
    padding.right,
    padding.bottom,
  );

  /// Gets the available content size (excluding system UI and keyboard).
  Size get contentSize => Size(
    width - viewInsets.horizontal - padding.horizontal,
    height - viewInsets.vertical - padding.vertical,
  );

  /// Gets the next larger breakpoint.
  CorpoBreakpoint? _getNextBreakpoint(CorpoBreakpoint breakpoint) {
    switch (breakpoint) {
      case CorpoBreakpoint.xs:
        return CorpoBreakpoint.sm;
      case CorpoBreakpoint.sm:
        return CorpoBreakpoint.md;
      case CorpoBreakpoint.md:
        return CorpoBreakpoint.lg;
      case CorpoBreakpoint.lg:
        return CorpoBreakpoint.xl;
      case CorpoBreakpoint.xl:
        return CorpoBreakpoint.xxl;
      case CorpoBreakpoint.xxl:
        return null;
    }
  }

  @override
  String toString() => 'CorpoScreenSize('
        'size: $size, '
        'breakpoint: $currentBreakpoint, '
        'deviceType: $deviceType, '
        'orientation: $orientation'
        ')';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CorpoScreenSize &&
        other.size == size &&
        other.devicePixelRatio == devicePixelRatio &&
        other.textScaleFactor == textScaleFactor &&
        other.padding == padding &&
        other.viewInsets == viewInsets &&
        other.viewPadding == viewPadding;
  }

  @override
  int get hashCode => Object.hash(
      size,
      devicePixelRatio,
      textScaleFactor,
      padding,
      viewInsets,
      viewPadding,
    );
}

/// Extension methods for convenient screen size access.
extension CorpoScreenSizeExtension on BuildContext {
  /// Gets the screen size information.
  CorpoScreenSize get screenSize => CorpoScreenSize.of(this);

  /// Gets the current breakpoint.
  CorpoBreakpoint get breakpoint => screenSize.currentBreakpoint;

  /// Gets the device type.
  CorpoDeviceType get deviceType => screenSize.deviceType;

  /// Gets the orientation.
  CorpoOrientation get orientation => screenSize.orientation;

  /// Checks if the screen is mobile size.
  bool get isMobile => screenSize.isMobile;

  /// Checks if the screen is tablet size.
  bool get isTablet => screenSize.isTablet;

  /// Checks if the screen is desktop size.
  bool get isDesktop => screenSize.isDesktop;

  /// Checks if the screen is in portrait orientation.
  bool get isPortrait => screenSize.isPortrait;

  /// Checks if the screen is in landscape orientation.
  bool get isLandscape => screenSize.isLandscape;
}
