/// A flexible divider component for the Corpo UI design system.
///
/// CorpoDivider provides consistent visual separation between content
/// sections with support for horizontal and vertical orientations,
/// different thicknesses, colors, and optional labels.
///
/// The component follows corporate design principles with subtle
/// styling that maintains visual hierarchy without being distracting.
/// It's designed for professional applications requiring clear
/// content organization.
///
/// Example usage:
/// ```dart
/// CorpoDivider()
///
/// CorpoDivider.vertical(
///   height: 100,
/// )
///
/// CorpoDivider.labeled(
///   label: 'OR',
///   thickness: CorpoDividerThickness.thick,
/// )
///
/// CorpoDivider.custom(
///   color: CorpoDesignTokens().primaryColor,
///   thickness: 2,
///   indent: 16,
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Divider thickness variants for different emphasis levels.
///
/// Determines the visual weight of the divider line.
enum CorpoDividerThickness {
  /// Hairline divider for subtle separation
  hairline,

  /// Thin divider for standard separation (default)
  thin,

  /// Medium divider for moderate emphasis
  medium,

  /// Thick divider for strong separation
  thick,
}

/// Divider orientation for layout positioning.
enum CorpoDividerOrientation {
  /// Horizontal divider spanning width
  horizontal,

  /// Vertical divider spanning height
  vertical,
}

/// A flexible divider widget following Corpo UI design principles.
///
/// This component provides consistent visual separation between content
/// areas with support for different orientations, thicknesses, and
/// optional labeling. It's designed for professional interfaces
/// requiring clear content organization.
class CorpoDivider extends StatelessWidget {
  /// Creates a Corpo UI divider.
  const CorpoDivider({
    this.orientation = CorpoDividerOrientation.horizontal,
    this.thickness = CorpoDividerThickness.thin,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.width,
    this.height,
    super.key,
  }) : label = null,
       _customThickness = null;

  /// Convenience constructor for horizontal dividers.
  const CorpoDivider.horizontal({
    this.thickness = CorpoDividerThickness.thin,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.width,
    super.key,
  }) : orientation = CorpoDividerOrientation.horizontal,
       height = null,
       label = null,
       _customThickness = null;

  /// Convenience constructor for vertical dividers.
  const CorpoDivider.vertical({
    this.thickness = CorpoDividerThickness.thin,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.height,
    super.key,
  }) : orientation = CorpoDividerOrientation.vertical,
       width = null,
       label = null,
       _customThickness = null;

  /// Convenience constructor for labeled dividers.
  const CorpoDivider.labeled({
    required this.label,
    this.thickness = CorpoDividerThickness.thin,
    this.color,
    this.width,
    super.key,
  }) : orientation = CorpoDividerOrientation.horizontal,
       indent = 0,
       endIndent = 0,
       height = null,
       _customThickness = null;

  /// Convenience constructor for custom dividers.
  const CorpoDivider.custom({
    required double thickness,
    this.orientation = CorpoDividerOrientation.horizontal,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
    this.width,
    this.height,
    super.key,
  }) : thickness = null,
       label = null,
       _customThickness = thickness;

  /// The divider orientation.
  final CorpoDividerOrientation orientation;

  /// The divider thickness variant.
  final CorpoDividerThickness? thickness;

  /// Custom thickness value (used with CorpoDivider.custom).
  final double? _customThickness;

  /// Custom color for the divider.
  final Color? color;

  /// Leading indent space.
  final double indent;

  /// Trailing indent space.
  final double endIndent;

  /// Fixed width for the divider.
  final double? width;

  /// Fixed height for the divider.
  final double? height;

  /// Optional label text for the divider.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    if (label != null) {
      return _buildLabeledDivider(isDark, tokens);
    }

    switch (orientation) {
      case CorpoDividerOrientation.horizontal:
        return _buildHorizontalDivider(isDark, tokens);
      case CorpoDividerOrientation.vertical:
        return _buildVerticalDivider(isDark, tokens);
    }
  }

  /// Builds a horizontal divider.
  Widget _buildHorizontalDivider(bool isDark, CorpoDesignTokens tokens) =>
      Container(
        width: width,
        margin: EdgeInsets.only(left: indent, right: endIndent),
        child: Divider(
          height: 1,
          thickness: _getThickness(),
          color: _getDividerColor(isDark, tokens),
        ),
      );

  /// Builds a vertical divider.
  Widget _buildVerticalDivider(bool isDark, CorpoDesignTokens tokens) =>
      Container(
        height: height,
        margin: EdgeInsets.only(top: indent, bottom: endIndent),
        child: VerticalDivider(
          width: 1,
          thickness: _getThickness(),
          color: _getDividerColor(isDark, tokens),
        ),
      );

  /// Builds a labeled divider with text in the center.
  Widget _buildLabeledDivider(bool isDark, CorpoDesignTokens tokens) {
    final Color dividerColor = _getDividerColor(isDark, tokens);
    final Color labelColor = isDark
        ? tokens.textSecondary
        : tokens.textSecondary;

    return SizedBox(
      width: width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              height: 1,
              thickness: _getThickness(),
              color: dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: tokens.spacing4x),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: tokens.fontSizeSmall,
                fontFamily: tokens.fontFamily,
                color: labelColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 1,
              thickness: _getThickness(),
              color: dividerColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Gets the divider color based on theme.
  Color _getDividerColor(bool isDark, CorpoDesignTokens tokens) {
    if (color != null) return color!;

    return isDark
        ? tokens.textSecondary.withOpacity(0.3)
        : tokens.textSecondary.withOpacity(0.2);
  }

  /// Gets the thickness value based on the thickness variant.
  double _getThickness() {
    if (_customThickness != null) return _customThickness;

    switch (thickness!) {
      case CorpoDividerThickness.hairline:
        return 0.5;
      case CorpoDividerThickness.thin:
        return 1;
      case CorpoDividerThickness.medium:
        return 2;
      case CorpoDividerThickness.thick:
        return 4;
    }
  }
}
