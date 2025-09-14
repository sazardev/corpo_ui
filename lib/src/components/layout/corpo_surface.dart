/// A foundational surface component for the Corpo UI design system.
///
/// CorpoSurface provides consistent background styling and elevation
/// for content areas, dialogs, sheets, and other UI surfaces. It serves
/// as a base component for other container components.
///
/// The component follows Material Design surface principles adapted
/// for corporate applications, with support for different surface types,
/// elevation levels, and theme integration.
///
/// Example usage:
/// ```dart
/// CorpoSurface(
///   child: ContentWidget(),
/// )
///
/// CorpoSurface.elevated(
///   elevation: 8,
///   child: DialogContent(),
/// )
///
/// CorpoSurface.tinted(
///   tint: CorpoColors.primary50,
///   child: HighlightedContent(),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';

/// Surface types for different use cases.
///
/// Determines the background treatment and elevation behavior.
enum CorpoSurfaceType {
  /// Standard surface for general content areas
  standard,

  /// Elevated surface for modals and dialogs
  elevated,

  /// Tinted surface for highlighted content
  tinted,

  /// Transparent surface with minimal styling
  transparent,
}

/// A foundational surface widget following Corpo UI design principles.
///
/// This component provides consistent background styling and elevation
/// for content containers. It's designed to be a building block for
/// other UI components while maintaining visual consistency.
class CorpoSurface extends StatelessWidget {
  /// Creates a Corpo UI surface.
  ///
  /// The [child] parameter contains the content to display on the surface.
  const CorpoSurface({
    required this.child,
    this.type = CorpoSurfaceType.standard,
    this.elevation = 0,
    this.color,
    this.tint,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.clipBehavior = Clip.none,
    super.key,
  });

  /// Convenience constructor for elevated surfaces.
  const CorpoSurface.elevated({
    required this.child,
    this.elevation = 4,
    this.color,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  }) : type = CorpoSurfaceType.elevated,
       tint = null;

  /// Convenience constructor for tinted surfaces.
  const CorpoSurface.tinted({
    required this.child,
    this.tint,
    this.elevation = 0,
    this.color,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.clipBehavior = Clip.none,
    super.key,
  }) : type = CorpoSurfaceType.tinted;

  /// Convenience constructor for transparent surfaces.
  const CorpoSurface.transparent({
    required this.child,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.clipBehavior = Clip.none,
    super.key,
  }) : type = CorpoSurfaceType.transparent,
       elevation = 0,
       color = Colors.transparent,
       tint = null;

  /// The widget to display on the surface.
  final Widget child;

  /// The surface type determining the styling approach.
  final CorpoSurfaceType type;

  /// The elevation level for shadow depth.
  final double elevation;

  /// Custom background color for the surface.
  final Color? color;

  /// Tint color for highlighted surfaces.
  final Color? tint;

  /// Border radius for the surface.
  final BorderRadius? borderRadius;

  /// Custom border for the surface.
  final Border? border;

  /// Internal padding for the surface content.
  final EdgeInsetsGeometry? padding;

  /// External margin around the surface.
  final EdgeInsetsGeometry? margin;

  /// Fixed width for the surface.
  final double? width;

  /// Fixed height for the surface.
  final double? height;

  /// How to clip the surface content.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: _buildDecoration(isDark),
      clipBehavior: clipBehavior,
      child: _buildContent(),
    );
  }

  /// Builds the surface content with appropriate padding.
  Widget _buildContent() {
    if (padding == null) return child;

    return Padding(padding: padding!, child: child);
  }

  /// Builds the surface decoration based on type and theme.
  BoxDecoration _buildDecoration(bool isDark) {
    final Color backgroundColor = _getBackgroundColor(isDark);
    final BorderRadius radius = borderRadius ?? BorderRadius.zero;

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: radius,
      border: border,
      boxShadow: _getBoxShadow(isDark),
    );
  }

  /// Gets the background color based on type and theme.
  Color _getBackgroundColor(bool isDark) {
    if (color != null) return color!;

    switch (type) {
      case CorpoSurfaceType.standard:
        return isDark ? CorpoColors.neutral900 : CorpoColors.neutralWhite;

      case CorpoSurfaceType.elevated:
        return isDark ? CorpoColors.neutral800 : CorpoColors.neutralWhite;

      case CorpoSurfaceType.tinted:
        if (tint != null) return tint!;
        return isDark ? CorpoColors.neutral800 : CorpoColors.neutral50;

      case CorpoSurfaceType.transparent:
        return Colors.transparent;
    }
  }

  /// Gets the box shadow based on elevation level.
  List<BoxShadow> _getBoxShadow(bool isDark) {
    if (elevation <= 0 || type == CorpoSurfaceType.transparent) {
      return <BoxShadow>[];
    }

    final Color shadowColor = isDark
        ? CorpoColors.neutralBlack.withValues(alpha: 0.5)
        : CorpoColors.neutralBlack.withValues(alpha: 0.15);

    // Calculate shadow properties based on elevation
    final double blurRadius = elevation * 2;
    final double spreadRadius = elevation * 0.25;
    final Offset offset = Offset(0, elevation * 0.5);

    return <BoxShadow>[
      BoxShadow(
        color: shadowColor,
        offset: offset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ];
  }
}
