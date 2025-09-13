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

import '../../constants/spacing.dart';

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
  const CorpoSpacer({this.width, this.height, this.flex, super.key});

  /// Creates an extra small spacer (4px).
  const CorpoSpacer.extraSmall({super.key})
    : width = CorpoSpacing.extraSmall,
      height = CorpoSpacing.extraSmall,
      flex = null;

  /// Creates a small spacer (8px).
  const CorpoSpacer.small({super.key})
    : width = CorpoSpacing.small,
      height = CorpoSpacing.small,
      flex = null;

  /// Creates a medium spacer (16px).
  const CorpoSpacer.medium({super.key})
    : width = CorpoSpacing.medium,
      height = CorpoSpacing.medium,
      flex = null;

  /// Creates a large spacer (24px).
  const CorpoSpacer.large({super.key})
    : width = CorpoSpacing.large,
      height = CorpoSpacing.large,
      flex = null;

  /// Creates an extra large spacer (32px).
  const CorpoSpacer.extraLarge({super.key})
    : width = CorpoSpacing.extraLarge,
      height = CorpoSpacing.extraLarge,
      flex = null;

  /// Creates a XXX large spacer (64px).
  const CorpoSpacer.xxxLarge({super.key})
    : width = CorpoSpacing.xxxLarge,
      height = CorpoSpacing.xxxLarge,
      flex = null;

  /// Creates a horizontal spacer with the specified size.
  CorpoSpacer.horizontal(CorpoSpacerSize size, {super.key})
    : width = _getSizeValue(size),
      height = 0,
      flex = null;

  /// Creates a vertical spacer with the specified size.
  CorpoSpacer.vertical(CorpoSpacerSize size, {super.key})
    : width = 0,
      height = _getSizeValue(size),
      flex = null;

  /// Creates a flexible spacer that expands to fill available space.
  const CorpoSpacer.flexible({this.flex = 1, super.key})
    : width = null,
      height = null;

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

  @override
  Widget build(BuildContext context) {
    // If both width and height are null, return a flexible Spacer
    if (width == null && height == null) {
      return Spacer(flex: flex ?? 1);
    }

    // Return a SizedBox with the specified dimensions
    return SizedBox(width: width, height: height);
  }

  /// Gets the spacing value for the given size variant.
  static double _getSizeValue(CorpoSpacerSize size) {
    switch (size) {
      case CorpoSpacerSize.extraSmall:
        return CorpoSpacing.extraSmall;
      case CorpoSpacerSize.small:
        return CorpoSpacing.small;
      case CorpoSpacerSize.medium:
        return CorpoSpacing.medium;
      case CorpoSpacerSize.large:
        return CorpoSpacing.large;
      case CorpoSpacerSize.extraLarge:
        return CorpoSpacing.extraLarge;
      case CorpoSpacerSize.xxxLarge:
        return CorpoSpacing.xxxLarge;
    }
  }
}
