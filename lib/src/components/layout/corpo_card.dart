/// A comprehensive card component for the Corpo UI design system.
///
/// CorpoCard provides consistent container styling and behavior
/// across corporate applications, with support for elevation, borders,
/// padding variants, and interactive states.
///
/// The component follows corporate design principles with clean edges,
/// subtle shadows, and professional styling suitable for content
/// organization and visual hierarchy.
///
/// Example usage:
/// ```dart
/// CorpoCard(
///   child: Column(
///     children: [
///       Text('Card Title'),
///       Text('Card content goes here'),
///     ],
///   ),
/// )
///
/// CorpoCard.elevated(
///   elevation: CorpoCardElevation.high,
///   child: ProfileWidget(),
/// )
///
/// CorpoCard.outlined(
///   child: FormContent(),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';

/// Card elevation variants for different visual hierarchy levels.
///
/// Determines the shadow depth and visual prominence of the card.
enum CorpoCardElevation {
  /// No elevation - flat card
  none,

  /// Low elevation - subtle shadow
  low,

  /// Medium elevation - standard shadow (default)
  medium,

  /// High elevation - prominent shadow
  high,

  /// Maximum elevation - dramatic shadow
  maximum,
}

/// Card variant types for different use cases.
///
/// Determines the primary styling approach for the card.
enum CorpoCardVariant {
  /// Standard card with background and elevation
  filled,

  /// Card with border and minimal background
  outlined,

  /// Card with elevated appearance
  elevated,

  /// Card with subtle background tint
  tinted,
}

/// Padding size variants for card content.
enum CorpoCardPadding {
  /// No padding
  none,

  /// Small padding for compact content
  small,

  /// Medium padding for standard content (default)
  medium,

  /// Large padding for spacious layouts
  large,

  /// Extra large padding for prominent content
  extraLarge,
}

/// A comprehensive card widget following Corpo UI design principles.
///
/// This component provides consistent container styling for content
/// organization, with support for different elevation levels, variants,
/// and interactive states. It's designed for professional corporate
/// applications requiring clear visual hierarchy.
class CorpoCard extends StatelessWidget {
  /// Creates a Corpo UI card.
  ///
  /// The [child] parameter contains the content to display in the card.
  const CorpoCard({
    required this.child,
    this.variant = CorpoCardVariant.filled,
    this.elevation = CorpoCardElevation.medium,
    this.padding = CorpoCardPadding.medium,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  });

  /// Convenience constructor for filled cards.
  const CorpoCard.filled({
    required this.child,
    this.elevation = CorpoCardElevation.medium,
    this.padding = CorpoCardPadding.medium,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  }) : variant = CorpoCardVariant.filled;

  /// Convenience constructor for outlined cards.
  const CorpoCard.outlined({
    required this.child,
    this.padding = CorpoCardPadding.medium,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  }) : variant = CorpoCardVariant.outlined,
       elevation = CorpoCardElevation.none;

  /// Convenience constructor for elevated cards.
  const CorpoCard.elevated({
    required this.child,
    this.elevation = CorpoCardElevation.high,
    this.padding = CorpoCardPadding.medium,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  }) : variant = CorpoCardVariant.elevated;

  /// Convenience constructor for tinted cards.
  const CorpoCard.tinted({
    required this.child,
    this.elevation = CorpoCardElevation.low,
    this.padding = CorpoCardPadding.medium,
    this.onTap,
    this.onLongPress,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  }) : variant = CorpoCardVariant.tinted;

  /// The widget to display inside the card.
  final Widget child;

  /// The card variant determining the styling approach.
  final CorpoCardVariant variant;

  /// The elevation level for shadow depth.
  final CorpoCardElevation elevation;

  /// The padding size for the card content.
  final CorpoCardPadding padding;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Called when the card is long-pressed.
  final VoidCallback? onLongPress;

  /// External margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Fixed width for the card.
  final double? width;

  /// Fixed height for the card.
  final double? height;

  /// Custom background color for the card.
  final Color? color;

  /// Custom border radius for the card.
  final BorderRadius? borderRadius;

  /// How to clip the card content.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final bool isInteractive = onTap != null || onLongPress != null;

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: _buildDecoration(isDark),
      clipBehavior: clipBehavior,
      child: _buildContent(),
    );

    if (isInteractive) {
      card = Material(
        color: Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: card,
        ),
      );
    }

    return card;
  }

  /// Builds the card content with appropriate padding.
  Widget _buildContent() {
    final EdgeInsetsGeometry contentPadding = _getContentPadding();

    if (contentPadding == EdgeInsets.zero) {
      return child;
    }

    return Padding(padding: contentPadding, child: child);
  }

  /// Builds the card decoration based on variant and theme.
  BoxDecoration _buildDecoration(bool isDark) {
    final Color backgroundColor = _getBackgroundColor(isDark);
    final BorderRadius radius = borderRadius ?? BorderRadius.circular(12);

    switch (variant) {
      case CorpoCardVariant.filled:
        return BoxDecoration(
          color: backgroundColor,
          borderRadius: radius,
          boxShadow: _getBoxShadow(isDark),
        );

      case CorpoCardVariant.outlined:
        return BoxDecoration(
          color: backgroundColor,
          borderRadius: radius,
          border: Border.all(color: _getBorderColor(isDark)),
        );

      case CorpoCardVariant.elevated:
        return BoxDecoration(
          color: backgroundColor,
          borderRadius: radius,
          boxShadow: _getBoxShadow(isDark),
        );

      case CorpoCardVariant.tinted:
        return BoxDecoration(
          color: backgroundColor,
          borderRadius: radius,
          boxShadow: _getBoxShadow(isDark),
        );
    }
  }

  /// Gets the background color based on variant and theme.
  Color _getBackgroundColor(bool isDark) {
    if (color != null) return color!;

    switch (variant) {
      case CorpoCardVariant.filled:
        return isDark ? CorpoColors.neutral800 : CorpoColors.neutralWhite;

      case CorpoCardVariant.outlined:
        return isDark ? CorpoColors.neutral900 : CorpoColors.neutralWhite;

      case CorpoCardVariant.elevated:
        return isDark ? CorpoColors.neutral800 : CorpoColors.neutralWhite;

      case CorpoCardVariant.tinted:
        return isDark ? CorpoColors.neutral800 : CorpoColors.neutral50;
    }
  }

  /// Gets the border color for outlined cards.
  Color _getBorderColor(bool isDark) =>
      isDark ? CorpoColors.neutral700 : CorpoColors.neutral200;

  /// Gets the box shadow based on elevation level.
  List<BoxShadow> _getBoxShadow(bool isDark) {
    if (variant == CorpoCardVariant.outlined) return <BoxShadow>[];

    final Color shadowColor = isDark
        ? CorpoColors.neutralBlack.withOpacity(0.5)
        : CorpoColors.neutralBlack.withOpacity(0.1);

    switch (elevation) {
      case CorpoCardElevation.none:
        return <BoxShadow>[];

      case CorpoCardElevation.low:
        return <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ];

      case CorpoCardElevation.medium:
        return <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ];

      case CorpoCardElevation.high:
        return <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ];

      case CorpoCardElevation.maximum:
        return <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 8),
            blurRadius: 16,
          ),
        ];
    }
  }

  /// Gets the content padding based on the padding variant.
  EdgeInsetsGeometry _getContentPadding() {
    switch (padding) {
      case CorpoCardPadding.none:
        return EdgeInsets.zero;

      case CorpoCardPadding.small:
        return CorpoPadding.small;

      case CorpoCardPadding.medium:
        return CorpoPadding.medium;

      case CorpoCardPadding.large:
        return const EdgeInsets.all(CorpoSpacing.large);

      case CorpoCardPadding.extraLarge:
        return const EdgeInsets.all(CorpoSpacing.extraLarge);
    }
  }
}
