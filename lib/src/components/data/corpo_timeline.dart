import 'package:flutter/material.dart';
import '../../constants/spacing.dart';

/// Defines the alignment of timeline items.
enum CorpoTimelineAlignment {
  /// Items aligned to the left of the timeline
  left,

  /// Items aligned to the right of the timeline
  right,

  /// Items alternating between left and right
  alternating,

  /// Items centered on the timeline
  center,
}

/// Defines the variant styles for [CorpoTimeline].
enum CorpoTimelineVariant {
  /// Standard timeline with default styling
  standard,

  /// Compact timeline with reduced spacing
  compact,

  /// Card-based timeline with elevated appearance
  card,

  /// Outlined timeline with visible borders
  outlined,
}

/// Defines the density configuration for [CorpoTimeline].
enum CorpoTimelineDensity {
  /// Standard density with default spacing
  standard,

  /// Compact density with reduced spacing
  compact,

  /// Comfortable density with increased spacing
  comfortable,
}

/// Represents a single item in a [CorpoTimeline].
class CorpoTimelineItem {
  /// Creates a timeline item.
  const CorpoTimelineItem({
    required this.content,
    this.indicator,
    this.oppositeContent,
    this.alignment,
    this.indicatorColor,
    this.lineColor,
    this.padding,
  });

  /// The main content of the timeline item.
  final Widget content;

  /// The indicator widget (e.g., icon, dot) for this item.
  final Widget? indicator;

  /// Content displayed on the opposite side of the timeline.
  final Widget? oppositeContent;

  /// Override alignment for this specific item.
  final CorpoTimelineAlignment? alignment;

  /// Color for the timeline indicator.
  final Color? indicatorColor;

  /// Color for the connecting line.
  final Color? lineColor;

  /// Custom padding for this item.
  final EdgeInsetsGeometry? padding;
}

/// A comprehensive timeline widget following Corpo UI design principles.
///
/// This component displays a chronological sequence of events with
/// customizable styling and layout options. It supports various
/// alignments and visual configurations for professional applications.
class CorpoTimeline extends StatelessWidget {
  /// Creates a Corpo UI timeline.
  const CorpoTimeline({
    required this.items,
    this.alignment = CorpoTimelineAlignment.left,
    this.variant = CorpoTimelineVariant.standard,
    this.density = CorpoTimelineDensity.standard,
    this.indicatorSize = 24.0,
    this.lineWidth = 2.0,
    this.indicatorColor,
    this.lineColor,
    this.backgroundColor,
    this.shrinkWrap = false,
    this.physics,
    this.reverse = false,
    super.key,
  });

  /// List of timeline items to display.
  final List<CorpoTimelineItem> items;

  /// Alignment of timeline items.
  final CorpoTimelineAlignment alignment;

  /// Visual variant of the timeline.
  final CorpoTimelineVariant variant;

  /// Density configuration for spacing and sizing.
  final CorpoTimelineDensity density;

  /// Size of the timeline indicators.
  final double indicatorSize;

  /// Width of the connecting line.
  final double lineWidth;

  /// Default color for timeline indicators.
  final Color? indicatorColor;

  /// Default color for connecting lines.
  final Color? lineColor;

  /// Background color for the timeline.
  final Color? backgroundColor;

  /// Whether the timeline should shrink-wrap its content.
  final bool shrinkWrap;

  /// Scroll physics for the timeline.
  final ScrollPhysics? physics;

  /// Whether to reverse the order of items.
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Color effectiveIndicatorColor = indicatorColor ?? colorScheme.primary;
    final Color effectiveLineColor =
        lineColor ?? colorScheme.outline.withValues(alpha: 0.3);

    final EdgeInsetsGeometry itemPadding = _getItemPadding();

    return Container(
      color: backgroundColor,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        physics: physics,
        reverse: reverse,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final CorpoTimelineItem item = items[index];
          final bool isFirst = index == 0;
          final bool isLast = index == items.length - 1;
          final CorpoTimelineAlignment itemAlignment =
              item.alignment ?? alignment;

          return _buildTimelineItem(
            context,
            item,
            index,
            isFirst,
            isLast,
            itemAlignment,
            effectiveIndicatorColor,
            effectiveLineColor,
            itemPadding,
          );
        },
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    CorpoTimelineItem item,
    int index,
    bool isFirst,
    bool isLast,
    CorpoTimelineAlignment itemAlignment,
    Color indicatorColor,
    Color lineColor,
    EdgeInsetsGeometry itemPadding,
  ) {
    switch (itemAlignment) {
      case CorpoTimelineAlignment.left:
        return _buildLeftAlignedItem(
          context,
          item,
          isFirst,
          isLast,
          indicatorColor,
          lineColor,
          itemPadding,
        );
      case CorpoTimelineAlignment.right:
        return _buildRightAlignedItem(
          context,
          item,
          isFirst,
          isLast,
          indicatorColor,
          lineColor,
          itemPadding,
        );
      case CorpoTimelineAlignment.alternating:
        final bool isEven = index % 2 == 0;
        return isEven
            ? _buildLeftAlignedItem(
                context,
                item,
                isFirst,
                isLast,
                indicatorColor,
                lineColor,
                itemPadding,
              )
            : _buildRightAlignedItem(
                context,
                item,
                isFirst,
                isLast,
                indicatorColor,
                lineColor,
                itemPadding,
              );
      case CorpoTimelineAlignment.center:
        return _buildCenterAlignedItem(
          context,
          item,
          isFirst,
          isLast,
          indicatorColor,
          lineColor,
          itemPadding,
        );
    }
  }

  Widget _buildLeftAlignedItem(
    BuildContext context,
    CorpoTimelineItem item,
    bool isFirst,
    bool isLast,
    Color indicatorColor,
    Color lineColor,
    EdgeInsetsGeometry itemPadding,
  ) => IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildIndicatorColumn(
            context,
            item,
            isFirst,
            isLast,
            indicatorColor,
            lineColor,
          ),
          const SizedBox(width: CorpoSpacing.medium),
          Expanded(
            child: Padding(
              padding: itemPadding,
              child: _buildContentCard(context, item.content),
            ),
          ),
        ],
      ),
    );

  Widget _buildRightAlignedItem(
    BuildContext context,
    CorpoTimelineItem item,
    bool isFirst,
    bool isLast,
    Color indicatorColor,
    Color lineColor,
    EdgeInsetsGeometry itemPadding,
  ) => IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: itemPadding,
              child: _buildContentCard(context, item.content),
            ),
          ),
          const SizedBox(width: CorpoSpacing.medium),
          _buildIndicatorColumn(
            context,
            item,
            isFirst,
            isLast,
            indicatorColor,
            lineColor,
          ),
        ],
      ),
    );

  Widget _buildCenterAlignedItem(
    BuildContext context,
    CorpoTimelineItem item,
    bool isFirst,
    bool isLast,
    Color indicatorColor,
    Color lineColor,
    EdgeInsetsGeometry itemPadding,
  ) => IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (item.oppositeContent != null) ...<Widget>[
            Expanded(
              child: Padding(
                padding: itemPadding,
                child: _buildContentCard(context, item.oppositeContent!),
              ),
            ),
            const SizedBox(width: CorpoSpacing.small),
          ] else
            const Spacer(),
          _buildIndicatorColumn(
            context,
            item,
            isFirst,
            isLast,
            indicatorColor,
            lineColor,
          ),
          const SizedBox(width: CorpoSpacing.small),
          Expanded(
            child: Padding(
              padding: itemPadding,
              child: _buildContentCard(context, item.content),
            ),
          ),
        ],
      ),
    );

  Widget _buildIndicatorColumn(
    BuildContext context,
    CorpoTimelineItem item,
    bool isFirst,
    bool isLast,
    Color indicatorColor,
    Color lineColor,
  ) => SizedBox(
      width: indicatorSize,
      child: Column(
        children: <Widget>[
          if (!isFirst)
            Expanded(
              child: Container(
                width: lineWidth,
                color: item.lineColor ?? lineColor,
              ),
            ),
          _buildIndicator(context, item, item.indicatorColor ?? indicatorColor),
          if (!isLast)
            Expanded(
              child: Container(
                width: lineWidth,
                color: item.lineColor ?? lineColor,
              ),
            ),
        ],
      ),
    );

  Widget _buildIndicator(
    BuildContext context,
    CorpoTimelineItem item,
    Color indicatorColor,
  ) {
    if (item.indicator != null) {
      return SizedBox(
        width: indicatorSize,
        height: indicatorSize,
        child: item.indicator,
      );
    }

    return Container(
      width: indicatorSize,
      height: indicatorSize,
      decoration: BoxDecoration(
        color: indicatorColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context, Widget content) => switch (variant) {
      CorpoTimelineVariant.card => Card(
        margin: EdgeInsets.zero,
        child: Padding(padding: _getContentPadding(), child: content),
      ),
      CorpoTimelineVariant.outlined => Container(
        padding: _getContentPadding(),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: content,
      ),
      _ => Padding(padding: _getContentPadding(), child: content),
    };

  EdgeInsetsGeometry _getItemPadding() => switch (density) {
      CorpoTimelineDensity.compact => const EdgeInsets.symmetric(
        vertical: CorpoSpacing.extraSmall,
      ),
      CorpoTimelineDensity.comfortable => const EdgeInsets.symmetric(
        vertical: CorpoSpacing.large,
      ),
      CorpoTimelineDensity.standard => const EdgeInsets.symmetric(
        vertical: CorpoSpacing.small,
      ),
    };

  EdgeInsetsGeometry _getContentPadding() => switch (density) {
      CorpoTimelineDensity.compact => const EdgeInsets.all(CorpoSpacing.small),
      CorpoTimelineDensity.comfortable => const EdgeInsets.all(
        CorpoSpacing.large,
      ),
      CorpoTimelineDensity.standard => const EdgeInsets.all(
        CorpoSpacing.medium,
      ),
    };
}

/// A builder widget for creating timeline content with consistent styling.
///
/// This helper widget provides common content layouts and styling patterns
/// for use with [CorpoTimelineItem.content].
class CorpoTimelineContent extends StatelessWidget {
  /// Creates timeline content.
  const CorpoTimelineContent({
    required this.title,
    this.subtitle,
    this.description,
    this.timestamp,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
    this.descriptionStyle,
    this.timestampStyle,
    super.key,
  });

  /// Primary title text.
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional description text.
  final String? description;

  /// Optional timestamp text.
  final String? timestamp;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Text style for the title.
  final TextStyle? titleStyle;

  /// Text style for the subtitle.
  final TextStyle? subtitleStyle;

  /// Text style for the description.
  final TextStyle? descriptionStyle;

  /// Text style for the timestamp.
  final TextStyle? timestampStyle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style:
                    titleStyle ??
                    textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            if (trailing != null) ...<Widget>[
              const SizedBox(width: CorpoSpacing.small),
              trailing!,
            ],
          ],
        ),
        if (subtitle != null) ...<Widget>[
          const SizedBox(height: CorpoSpacing.extraSmall),
          Text(
            subtitle!,
            style:
                subtitleStyle ??
                textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
        if (description != null) ...<Widget>[
          const SizedBox(height: CorpoSpacing.small),
          Text(
            description!,
            style:
                descriptionStyle ??
                textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
          ),
        ],
        if (timestamp != null) ...<Widget>[
          const SizedBox(height: CorpoSpacing.small),
          Text(
            timestamp!,
            style:
                timestampStyle ??
                textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
        ],
      ],
    );
  }
}
