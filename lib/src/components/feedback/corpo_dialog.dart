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

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double maxWidth = _getMaxWidth(context, size);

    return Dialog(
      backgroundColor: isDark
          ? CorpoColors.neutral800
          : CorpoColors.neutralWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CorpoSpacing.small),
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
            if (title != null) _buildTitleSection(isDark),
            if (content != null) _buildContentSection(isDark),
            if (actions != null && actions!.isNotEmpty) _buildActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(bool isDark) => Padding(
      padding: const EdgeInsets.fromLTRB(
        CorpoSpacing.large,
        CorpoSpacing.large,
        CorpoSpacing.large,
        CorpoSpacing.medium,
      ),
      child: DefaultTextStyle(
        style: CorpoTypography.heading3.copyWith(
          color: isDark ? CorpoColors.neutralWhite : CorpoColors.neutral900,
        ),
        child: title!,
      ),
    );

  Widget _buildContentSection(bool isDark) => Flexible(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          CorpoSpacing.large,
          title != null ? 0 : CorpoSpacing.large,
          CorpoSpacing.large,
          CorpoSpacing.medium,
        ),
        child: DefaultTextStyle(
          style: CorpoTypography.bodyMedium.copyWith(
            color: isDark ? CorpoColors.neutral200 : CorpoColors.neutral700,
          ),
          child: content!,
        ),
      ),
    );

  Widget _buildActionsSection() => Padding(
      padding: const EdgeInsets.fromLTRB(
        CorpoSpacing.large,
        CorpoSpacing.medium,
        CorpoSpacing.large,
        CorpoSpacing.large,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < actions!.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(width: CorpoSpacing.small),
            actions![i],
          ],
        ],
      ),
    );

  /// Gets the maximum width based on size variant and screen size.
  double _getMaxWidth(BuildContext context, CorpoDialogSize size) {
    final double screenWidth = MediaQuery.of(context).size.width;

    switch (size) {
      case CorpoDialogSize.small:
        return (screenWidth * 0.3).clamp(280.0, 400.0);
      case CorpoDialogSize.medium:
        return (screenWidth * 0.5).clamp(400.0, 600.0);
      case CorpoDialogSize.large:
        return (screenWidth * 0.7).clamp(600.0, 800.0);
      case CorpoDialogSize.fullWidth:
        return screenWidth - (CorpoSpacing.large * 2);
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
