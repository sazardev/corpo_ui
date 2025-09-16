/// A comprehensive dialog component for the Corpo UI design system.
///
/// CorpoDialog provides consistent modal dialog styling and behavior
/// across corporate applications, with support for titles, content,
/// actions, and various sizes.
///
/// Example usage:
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => CorpoDialog(
///     title: 'Confirm Action',
///     content: Text('Are you sure you want to delete this item?'),
///     actions: [
///       CorpoTextButton(
///         onPressed: () => Navigator.pop(context),
///         child: Text('Cancel'),
///       ),
///       CorpoButton(
///         onPressed: () => deleteItem(),
///         child: Text('Delete'),
///       ),
///     ],
///   ),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Dialog size variants for different content amounts.
enum CorpoDialogSize {
  /// Small dialog for simple confirmations
  small,

  /// Medium dialog for standard content (default)
  medium,

  /// Large dialog for complex content
  large,

  /// Full-width dialog for maximum space
  fullWidth,
}

/// A comprehensive dialog widget following Corpo UI design principles.
///
/// This component provides consistent modal dialog styling with support
/// for titles, content, actions, and various size configurations.
class CorpoDialog extends StatelessWidget {
  /// Creates a Corpo UI dialog.
  const CorpoDialog({
    this.title,
    this.content,
    this.actions,
    this.size = CorpoDialogSize.medium,
    this.isDismissible = true,
    super.key,
  });

  /// The title widget for the dialog.
  final Widget? title;

  /// The content widget for the dialog.
  final Widget? content;

  /// Action widgets to display at the bottom.
  final List<Widget>? actions;

  /// The size variant for the dialog.
  final CorpoDialogSize size;

  /// Whether the dialog can be dismissed by tapping outside.
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double maxWidth = _getMaxWidth(context, size, tokens);

    return Dialog(
      backgroundColor: isDark
          ? tokens.surfaceColor.withOpacity(0.95)
          : tokens.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.borderRadius),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (title != null) _buildTitleSection(isDark, tokens),
            if (content != null) _buildContentSection(isDark, tokens),
            if (actions != null && actions!.isNotEmpty)
              _buildActionsSection(tokens),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(bool isDark, CorpoDesignTokens tokens) => Padding(
    padding: EdgeInsets.fromLTRB(
      tokens.spacing6x,
      tokens.spacing6x,
      tokens.spacing6x,
      tokens.spacing4x,
    ),
    child: DefaultTextStyle(
      style: TextStyle(
        fontSize: tokens.fontSizeLarge,
        fontFamily: tokens.fontFamily,
        color: isDark ? tokens.surfaceColor : tokens.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      child: title!,
    ),
  );

  Widget _buildContentSection(bool isDark, CorpoDesignTokens tokens) =>
      Flexible(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            tokens.spacing6x,
            title != null ? 0 : tokens.spacing6x,
            tokens.spacing6x,
            tokens.spacing4x,
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: tokens.baseFontSize,
              fontFamily: tokens.fontFamily,
              color: isDark ? tokens.textSecondary : tokens.textSecondary,
            ),
            child: content!,
          ),
        ),
      );

  Widget _buildActionsSection(CorpoDesignTokens tokens) => Padding(
    padding: EdgeInsets.fromLTRB(
      tokens.spacing6x,
      tokens.spacing4x,
      tokens.spacing6x,
      tokens.spacing6x,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        for (int i = 0; i < actions!.length; i++) ...<Widget>[
          if (i > 0) SizedBox(width: tokens.spacing2x),
          actions![i],
        ],
      ],
    ),
  );

  /// Gets the maximum width based on size variant and screen size.
  double _getMaxWidth(
    BuildContext context,
    CorpoDialogSize size,
    CorpoDesignTokens tokens,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;

    switch (size) {
      case CorpoDialogSize.small:
        return (screenWidth * 0.3).clamp(280.0, 400.0);
      case CorpoDialogSize.medium:
        return (screenWidth * 0.5).clamp(400.0, 600.0);
      case CorpoDialogSize.large:
        return (screenWidth * 0.7).clamp(600.0, 800.0);
      case CorpoDialogSize.fullWidth:
        return screenWidth - (tokens.spacing6x * 2);
    }
  }

  /// Shows a Corpo dialog.
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
  }) => showDialog<T>(
    context: context,
    builder: builder,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
  );
}
