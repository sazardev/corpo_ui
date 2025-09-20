import 'package:flutter/material.dart';
import '../../constants/spacing.dart';

/// Defines the variant styles for [CorpoExpansionPanel].
enum CorpoExpansionPanelVariant {
  /// Standard expansion panel style
  standard,

  /// Compact expansion panel with reduced padding
  compact,

  /// Outlined expansion panel with visible borders
  outlined,

  /// Card-like expansion panel with elevated appearance
  card,
}

/// Defines the density configuration for [CorpoExpansionPanel].
enum CorpoExpansionPanelDensity {
  /// Standard density with default spacing
  standard,

  /// Compact density with reduced spacing
  compact,

  /// Comfortable density with increased spacing
  comfortable,
}

/// A data structure representing a single item in an expansion panel list.
///
/// This class encapsulates the header and body content for an expansion panel
/// item, along with properties for controlling its expanded state and behavior.
class CorpoExpansionPanelItem {
  /// Creates an expansion panel item.
  const CorpoExpansionPanelItem({
    required this.headerBuilder,
    required this.body,
    this.isExpanded = false,
    this.canTapOnHeader = true,
    this.backgroundColor,
  });

  /// Builder function for the header content.
  ///
  /// The builder receives the context and expanded state to allow
  /// for dynamic header content based on the expansion state.
  final Widget Function(BuildContext context, bool isExpanded) headerBuilder;

  /// The body content displayed when the panel is expanded.
  final Widget body;

  /// Whether this panel is currently expanded.
  final bool isExpanded;

  /// Whether tapping on the header should toggle the expansion state.
  final bool canTapOnHeader;

  /// Background color for this specific panel item.
  final Color? backgroundColor;
}

/// A comprehensive expansion panel widget following Corpo UI design principles.
///
/// This component provides collapsible content panels with corporate styling
/// and accessibility features. It supports both single and multiple expansion
/// modes, with customizable styling options.
class CorpoExpansionPanel extends StatefulWidget {
  /// Creates a Corpo UI expansion panel.
  const CorpoExpansionPanel({
    required this.children,
    this.variant = CorpoExpansionPanelVariant.standard,
    this.density = CorpoExpansionPanelDensity.standard,
    this.expansionCallback,
    this.animationDuration = const Duration(milliseconds: 200),
    this.elevation,
    this.materialGapSize = 16.0,
    this.dividerColor,
    this.expandedHeaderPadding,
    this.expandedAlignment = Alignment.centerLeft,
    this.allowOnlyOnePanelOpen = false,
    super.key,
  });

  /// List of expansion panel items to display.
  final List<CorpoExpansionPanelItem> children;

  /// Visual variant of the expansion panel.
  final CorpoExpansionPanelVariant variant;

  /// Density configuration for spacing and sizing.
  final CorpoExpansionPanelDensity density;

  /// Callback function called when a panel's expansion state changes.
  ///
  /// The function receives the panel index and whether it should be expanded.
  final void Function(int panelIndex, bool isExpanded)? expansionCallback;

  /// Duration of the expansion/collapse animation.
  final Duration animationDuration;

  /// Elevation of the expansion panel when using card variant.
  final double? elevation;

  /// Size of the gap between material panels.
  final double materialGapSize;

  /// Color of dividers between panels.
  final Color? dividerColor;

  /// Padding applied to expanded headers.
  final EdgeInsetsGeometry? expandedHeaderPadding;

  /// Alignment of content in expanded panels.
  final AlignmentGeometry expandedAlignment;

  /// Whether only one panel can be open at a time.
  final bool allowOnlyOnePanelOpen;

  @override
  State<CorpoExpansionPanel> createState() => _CorpoExpansionPanelState();
}

class _CorpoExpansionPanelState extends State<CorpoExpansionPanel> {
  late List<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.children
        .map((CorpoExpansionPanelItem item) => item.isExpanded)
        .toList();
  }

  @override
  void didUpdateWidget(CorpoExpansionPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      _isExpanded = widget.children
          .map((CorpoExpansionPanelItem item) => item.isExpanded)
          .toList();
    }
  }

  void _handleExpansionChanged(int index, bool isExpanded) {
    setState(() {
      if (widget.allowOnlyOnePanelOpen && isExpanded) {
        // Close all other panels
        for (int i = 0; i < _isExpanded.length; i++) {
          _isExpanded[i] = i == index;
        }
      } else {
        _isExpanded[index] = isExpanded;
      }
    });

    widget.expansionCallback?.call(index, isExpanded);
  }

  EdgeInsetsGeometry _getPadding() => switch (widget.density) {
    CorpoExpansionPanelDensity.compact => const EdgeInsets.symmetric(
      horizontal: CorpoSpacing.small,
      vertical: CorpoSpacing.extraSmall,
    ),
    CorpoExpansionPanelDensity.comfortable => const EdgeInsets.symmetric(
      horizontal: CorpoSpacing.large,
      vertical: CorpoSpacing.medium,
    ),
    CorpoExpansionPanelDensity.standard => const EdgeInsets.symmetric(
      horizontal: CorpoSpacing.medium,
      vertical: CorpoSpacing.small,
    ),
  };

  double _getElevation() {
    if (widget.elevation != null) return widget.elevation!;
    return switch (widget.variant) {
      CorpoExpansionPanelVariant.card => 2.0,
      _ => 0.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Color dividerColor =
        widget.dividerColor ?? colorScheme.outline.withValues(alpha: 0.2);

    final EdgeInsetsGeometry padding = _getPadding();
    final double elevation = _getElevation();

    final List<ExpansionPanel> panels = widget.children.asMap().entries.map((
      MapEntry<int, CorpoExpansionPanelItem> entry,
    ) {
      final int index = entry.key;
      final CorpoExpansionPanelItem item = entry.value;

      return ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) => Padding(
          padding: padding,
          child: item.headerBuilder(context, isExpanded),
        ),
        body: Container(
          width: double.infinity,
          padding: padding,
          alignment: widget.expandedAlignment,
          child: item.body,
        ),
        isExpanded: _isExpanded[index],
        canTapOnHeader: item.canTapOnHeader,
        backgroundColor:
            item.backgroundColor ??
            _getBackgroundColor(context, widget.variant),
      );
    }).toList();

    final Widget expansionPanelList = ExpansionPanelList(
      expansionCallback: _handleExpansionChanged,
      animationDuration: widget.animationDuration,
      elevation: elevation,
      materialGapSize: widget.materialGapSize,
      dividerColor: dividerColor,
      expandedHeaderPadding:
          widget.expandedHeaderPadding as EdgeInsets? ??
          const EdgeInsets.symmetric(
            horizontal: CorpoSpacing.medium,
            vertical: CorpoSpacing.small,
          ),
      children: panels,
    );

    return switch (widget.variant) {
      CorpoExpansionPanelVariant.outlined => Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: expansionPanelList,
      ),
      CorpoExpansionPanelVariant.card => Card(
        elevation: elevation,
        margin: EdgeInsets.zero,
        child: expansionPanelList,
      ),
      _ => expansionPanelList,
    };
  }

  Color _getBackgroundColor(
    BuildContext context,
    CorpoExpansionPanelVariant variant,
  ) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return switch (variant) {
      CorpoExpansionPanelVariant.card => colorScheme.surface,
      CorpoExpansionPanelVariant.outlined => colorScheme.surface,
      _ => Colors.transparent,
    };
  }
}

/// A builder widget for creating expansion panel headers with consistent styling.
///
/// This helper widget provides common header layouts and styling patterns
/// for use with [CorpoExpansionPanelItem.headerBuilder].
class CorpoExpansionPanelHeader extends StatelessWidget {
  /// Creates an expansion panel header.
  const CorpoExpansionPanelHeader({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
    this.isExpanded = false,
    super.key,
  });

  /// Primary title text.
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional leading widget (e.g., icon).
  final Widget? leading;

  /// Optional trailing widget (e.g., badge, icon).
  final Widget? trailing;

  /// Text style for the title.
  final TextStyle? titleStyle;

  /// Text style for the subtitle.
  final TextStyle? subtitleStyle;

  /// Whether the panel is currently expanded.
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final TextStyle effectiveTitleStyle =
        titleStyle ??
        textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ) ??
        const TextStyle();

    final TextStyle effectiveSubtitleStyle =
        subtitleStyle ??
        textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.7),
        ) ??
        const TextStyle();

    return Row(
      children: <Widget>[
        if (leading != null) ...<Widget>[
          leading!,
          const SizedBox(width: CorpoSpacing.small),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: effectiveTitleStyle),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: CorpoSpacing.extraSmall),
                Text(subtitle!, style: effectiveSubtitleStyle),
              ],
            ],
          ),
        ),
        if (trailing != null) ...<Widget>[
          const SizedBox(width: CorpoSpacing.small),
          trailing!,
        ],
      ],
    );
  }
}
