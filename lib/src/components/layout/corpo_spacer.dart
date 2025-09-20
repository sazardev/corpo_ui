/// A flexible spacer component for the Corpo UI design system.
///
/// CorpoSpacer provides consistent spacing between elements using the
/// design system's spacing scale. It supports both horizontal and vertical
/// spacing with predefined sizes that ensure visual consistency.
///
/// The component follows corporate design principles with standardized
/// spacing values based on a 4px grid system, maintaining visual rhythm
/// and hierarchy throughout the application.
///
/// Example usage:
/// ```dart
/// Column(
///   children: [
///     Text('First item'),
///     CorpoSpacer.medium(),
///     Text('Second item'),
///     CorpoSpacer.large(),
///     Text('Third item'),
///   ],
/// )
///
/// Row(
///   children: [
///     Icon(Icons.star),
///     CorpoSpacer.small(),
///     Text('Rating'),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Spacer size variants for different spacing needs.
enum CorpoSpacerSize {
  /// Extra small spacing (4px)
  extraSmall,

  /// Small spacing (8px)
  small,

  /// Medium spacing (16px)
  medium,

  /// Large spacing (24px)
  large,

  /// Extra large spacing (32px)
  extraLarge,

  /// XXX large spacing (64px)
  xxxLarge,
}

/// A flexible spacer widget following Corpo UI design principles.
///
/// This component provides consistent spacing between elements using
/// the design system's spacing scale. It automatically adapts to the
/// layout direction (horizontal or vertical) based on its parent container.
class CorpoSpacer extends StatelessWidget {
  /// Creates a Corpo UI spacer with custom dimensions.
  const CorpoSpacer({this.width, this.height, this.flex, super.key})
    : _size = null;

  /// Creates an extra small spacer (4px).
  const CorpoSpacer.extraSmall({super.key})
    : width = null,
      height = null,
      flex = null,
      _size = CorpoSpacerSize.extraSmall;

  /// Creates a small spacer (8px).
  const CorpoSpacer.small({super.key})
    : width = null,
      height = null,
      flex = null,
      _size = CorpoSpacerSize.small;

  /// Creates a medium spacer (16px).
  const CorpoSpacer.medium({super.key})
    : width = null,
      height = null,
      flex = null,
      _size = CorpoSpacerSize.medium;

  /// Creates a large spacer (24px).
  const CorpoSpacer.large({super.key})
    : width = null,
      height = null,
      flex = null,
      _size = CorpoSpacerSize.large;

  /// Creates an extra large spacer (32px).
  const CorpoSpacer.extraLarge({super.key})
    : width = null,
      height = null,
      flex = null,
      _size = CorpoSpacerSize.extraLarge;

  /// Creates a XXX large spacer (64px).
  const CorpoSpacer.xxxLarge({super.key})
    : width = null,
      height = null,
      flex = null,
      _size = CorpoSpacerSize.xxxLarge;

  /// Creates a horizontal spacer with the specified size.
  const CorpoSpacer.horizontal(CorpoSpacerSize size, {super.key})
    : width = null,
      height = 0,
      flex = null,
      _size = size;

  /// Creates a vertical spacer with the specified size.
  const CorpoSpacer.vertical(CorpoSpacerSize size, {super.key})
    : width = 0,
      height = null,
      flex = null,
      _size = size;

  /// Creates a flexible spacer that expands to fill available space.
  const CorpoSpacer.flexible({this.flex = 1, super.key})
    : width = null,
      height = null,
      _size = null;

  /// The width of the spacer.
  ///
  /// If null, the spacer will expand horizontally in a Row or Flex.
  final double? width;

  /// The height of the spacer.
  ///
  /// If null, the spacer will expand vertically in a Column or Flex.
  final double? height;

  /// The flex value for flexible spacers.
  ///
  /// Only used when both width and height are null.
  final int? flex;

  /// Internal size variant for predefined spacers.
  final CorpoSpacerSize? _size;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    // If both width and height are null, return a flexible Spacer
    if (width == null && height == null && _size == null) {
      return Spacer(flex: flex ?? 1);
    }

    // Get dimensions from size variant if specified
    double? effectiveWidth = width;
    double? effectiveHeight = height;

    if (_size != null) {
      final double sizeValue = _getSizeValue(_size, tokens);
      effectiveWidth ??= sizeValue;
      effectiveHeight ??= sizeValue;
    }

    // Return a SizedBox with the specified dimensions
    return SizedBox(width: effectiveWidth, height: effectiveHeight);
  }

  /// Gets the spacing value for the given size variant.
  static double _getSizeValue(CorpoSpacerSize? size, CorpoDesignTokens tokens) {
    if (size == null) return 0;

    switch (size) {
      case CorpoSpacerSize.extraSmall:
        return tokens.spacing1x;
      case CorpoSpacerSize.small:
        return tokens.spacing2x;
      case CorpoSpacerSize.medium:
        return tokens.spacing4x;
      case CorpoSpacerSize.large:
        return tokens.spacing6x;
      case CorpoSpacerSize.extraLarge:
        return tokens.spacing8x;
      case CorpoSpacerSize.xxxLarge:
        return tokens.spacing16x;
    }
  }
}
