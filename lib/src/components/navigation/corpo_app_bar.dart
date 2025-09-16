/// A comprehensive app bar component for the Corpo UI design system.
///
/// CorpoAppBar provides consistent application header styling and behavior
/// across corporate applications, with support for titles, actions, navigation,
/// and various visual states.
///
/// Example usage:
/// ```dart
/// CorpoAppBar(
///   title: 'Dashboard',
///   actions: [
///     CorpoIconButton(
///       icon: Icons.notifications,
///       onPressed: () => showNotifications(),
///     ),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// App bar variant types for different use cases.
enum CorpoAppBarVariant {
  /// Standard app bar
  standard,

  /// Large app bar with prominent title
  large,

  /// Compact app bar for space-constrained layouts
  compact,
}

/// A comprehensive app bar widget following Corpo UI design principles.
///
/// This component provides consistent header styling with support for
/// titles, navigation, actions, and various size configurations.
class CorpoAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a Corpo UI app bar.
  const CorpoAppBar({
    this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.variant = CorpoAppBarVariant.standard,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle,
    super.key,
  });

  /// The title widget to display in the app bar.
  final Widget? title;

  /// The subtitle widget to display below the title.
  final Widget? subtitle;

  /// Widget to display before the title.
  final Widget? leading;

  /// Widgets to display after the title.
  final List<Widget>? actions;

  /// The visual variant of the app bar.
  final CorpoAppBarVariant variant;

  /// Background color for the app bar.
  final Color? backgroundColor;

  /// Foreground color for the app bar content.
  final Color? foregroundColor;

  /// Elevation of the app bar.
  final double? elevation;

  /// Whether to center the title.
  final bool? centerTitle;

  @override
  Size get preferredSize {
    switch (variant) {
      case CorpoAppBarVariant.compact:
        return const Size.fromHeight(48);
      case CorpoAppBarVariant.standard:
        return const Size.fromHeight(56);
      case CorpoAppBarVariant.large:
        return const Size.fromHeight(96);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final Color effectiveBackgroundColor =
        backgroundColor ?? tokens.surfaceColor;
    final Color effectiveForegroundColor =
        foregroundColor ?? tokens.textPrimary;

    if (variant == CorpoAppBarVariant.large) {
      return _buildLargeAppBar(
        context,
        tokens,
        effectiveBackgroundColor,
        effectiveForegroundColor,
      );
    }

    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: elevation ?? 1.0,
      centerTitle: centerTitle ?? false,
      titleTextStyle: _getTitleStyle(
        tokens,
        variant,
      ).copyWith(color: effectiveForegroundColor),
      toolbarHeight: preferredSize.height,
    );
  }

  Widget _buildLargeAppBar(
    BuildContext context,
    CorpoDesignTokens tokens,
    Color backgroundColor,
    Color foregroundColor,
  ) => Container(
    height: preferredSize.height,
    color: backgroundColor,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: tokens.spacing4x),
        child: Column(
          crossAxisAlignment: centerTitle == true
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            // Top row with leading and actions
            SizedBox(
              height: 56,
              child: Row(
                children: <Widget>[
                  if (leading != null) ...<Widget>[
                    leading!,
                    SizedBox(width: tokens.spacing2x),
                  ],
                  const Spacer(),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
            // Title section
            Expanded(
              child: Align(
                alignment: centerTitle == true
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: centerTitle == true
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    if (title != null)
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: tokens.fontSizeXLarge,
                          fontFamily: tokens.fontFamily,
                          color: foregroundColor,
                        ),
                        child: title!,
                      ),
                    if (subtitle != null) ...<Widget>[
                      SizedBox(height: tokens.spacing1x),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: tokens.baseFontSize,
                          fontFamily: tokens.fontFamily,
                          color: foregroundColor.withValues(alpha: 0.7),
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  /// Gets the title text style based on variant.
  TextStyle _getTitleStyle(
    CorpoDesignTokens tokens,
    CorpoAppBarVariant variant,
  ) {
    switch (variant) {
      case CorpoAppBarVariant.compact:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
        );
      case CorpoAppBarVariant.standard:
        return TextStyle(
          fontSize: tokens.fontSizeXLarge,
          fontFamily: tokens.fontFamily,
        );
      case CorpoAppBarVariant.large:
        return TextStyle(
          fontSize: tokens.fontSizeXLarge * 1.2,
          fontFamily: tokens.fontFamily,
        );
    }
  }
}
