import 'package:flutter/material.dart';
import '../../design_tokens.dart';

/// Defines the position of the sheet.
enum CorpoSheetPosition {
  /// Sheet slides from the bottom
  bottom,

  /// Sheet slides from the top
  top,

  /// Sheet slides from the left
  left,

  /// Sheet slides from the right
  right,
}

/// Defines the behavior when dragging the sheet.
enum CorpoSheetDragBehavior {
  /// Sheet can be dragged to dismiss
  dismissible,

  /// Sheet can be dragged but not dismissed
  scrollable,

  /// Sheet cannot be dragged
  none,
}

/// Defines the sheet size behavior.
enum CorpoSheetSizeBehavior {
  /// Sheet takes only the space needed by its content
  content,

  /// Sheet takes a fixed fraction of the screen
  fraction,

  /// Sheet takes a fixed pixel size
  fixed,

  /// Sheet can expand to fill available space
  expand,
}

/// A comprehensive sheet widget following Corpo UI design principles.
///
/// This component provides slide-in content overlay with professional styling,
/// drag gestures, and responsive behavior. It supports various positions
/// and sizing configurations.
class CorpoSheet extends StatelessWidget {
  /// Creates a Corpo UI sheet.
  const CorpoSheet({
    required this.child,
    this.position = CorpoSheetPosition.bottom,
    this.dragBehavior = CorpoSheetDragBehavior.dismissible,
    this.sizeBehavior = CorpoSheetSizeBehavior.content,
    this.size = 0.5,
    this.minSize = 0.1,
    this.maxSize = 0.9,
    this.isScrollControlled = false,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation = 16.0,
    this.barrierColor,
    this.enableDrag = true,
    this.showDragHandle = true,
    this.dragHandleColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onDismiss,
    super.key,
  });

  /// Content to display in the sheet.
  final Widget child;

  /// Position from which the sheet appears.
  final CorpoSheetPosition position;

  /// Drag behavior configuration.
  final CorpoSheetDragBehavior dragBehavior;

  /// Size behavior configuration.
  final CorpoSheetSizeBehavior sizeBehavior;

  /// Size value (fraction for fraction mode, pixels for fixed mode).
  final double size;

  /// Minimum size (as fraction of screen).
  final double minSize;

  /// Maximum size (as fraction of screen).
  final double maxSize;

  /// Whether the sheet should be scroll controlled.
  final bool isScrollControlled;

  /// Padding inside the sheet.
  final EdgeInsetsGeometry? padding;

  /// Margin around the sheet.
  final EdgeInsetsGeometry? margin;

  /// Background color of the sheet.
  final Color? backgroundColor;

  /// Border radius of the sheet.
  final BorderRadius? borderRadius;

  /// Elevation of the sheet.
  final double elevation;

  /// Color of the barrier behind the sheet.
  final Color? barrierColor;

  /// Whether drag gestures are enabled.
  final bool enableDrag;

  /// Whether to show the drag handle.
  final bool showDragHandle;

  /// Color of the drag handle.
  final Color? dragHandleColor;

  /// Duration of show/hide animations.
  final Duration animationDuration;

  /// Callback when sheet is dismissed.
  final VoidCallback? onDismiss;

  /// Show a bottom sheet.
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    CorpoSheetDragBehavior dragBehavior = CorpoSheetDragBehavior.dismissible,
    CorpoSheetSizeBehavior sizeBehavior = CorpoSheetSizeBehavior.content,
    double size = 0.5,
    double minSize = 0.1,
    double maxSize = 0.9,
    bool isScrollControlled = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double elevation = 16.0,
    Color? barrierColor,
    bool enableDrag = true,
    bool showDragHandle = true,
    Color? dragHandleColor,
    Duration animationDuration = const Duration(milliseconds: 300),
    VoidCallback? onDismiss,
  }) => showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor ?? CorpoDesignTokens().textPrimary.withValues(alpha: 0.54),
      elevation: 0,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag && dragBehavior != CorpoSheetDragBehavior.none,
      builder: (BuildContext context) => CorpoSheet(
        dragBehavior: dragBehavior,
        sizeBehavior: sizeBehavior,
        size: size,
        minSize: minSize,
        maxSize: maxSize,
        isScrollControlled: isScrollControlled,
        padding: padding,
        margin: margin,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        elevation: elevation,
        barrierColor: barrierColor,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        dragHandleColor: dragHandleColor,
        animationDuration: animationDuration,
        onDismiss: onDismiss,
        child: child,
      ),
    );

  /// Show a modal sheet from any position.
  static Future<T?> showModalSheet<T>({
    required BuildContext context,
    required Widget child,
    CorpoSheetPosition position = CorpoSheetPosition.bottom,
    CorpoSheetDragBehavior dragBehavior = CorpoSheetDragBehavior.dismissible,
    CorpoSheetSizeBehavior sizeBehavior = CorpoSheetSizeBehavior.content,
    double size = 0.5,
    double minSize = 0.1,
    double maxSize = 0.9,
    bool isScrollControlled = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double elevation = 16.0,
    Color? barrierColor,
    bool enableDrag = true,
    bool showDragHandle = true,
    Color? dragHandleColor,
    Duration animationDuration = const Duration(milliseconds: 300),
    VoidCallback? onDismiss,
  }) => showGeneralDialog<T>(
      context: context,
      barrierDismissible: dragBehavior != CorpoSheetDragBehavior.none,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? CorpoDesignTokens().textPrimary.withValues(alpha: 0.54),
      transitionDuration: animationDuration,
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => _SheetWrapper(
              sheet: CorpoSheet(
                position: position,
                dragBehavior: dragBehavior,
                sizeBehavior: sizeBehavior,
                size: size,
                minSize: minSize,
                maxSize: maxSize,
                isScrollControlled: isScrollControlled,
                padding: padding,
                margin: margin,
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                elevation: elevation,
                barrierColor: barrierColor,
                enableDrag: enableDrag,
                showDragHandle: showDragHandle,
                dragHandleColor: dragHandleColor,
                animationDuration: animationDuration,
                onDismiss: onDismiss,
                child: child,
              ),
              animation: animation,
              onDismiss: () {
                onDismiss?.call();
                Navigator.of(context).pop();
              },
            ),
    );

  @override
  Widget build(BuildContext context) => _buildSheetContent(context);

  Widget _buildSheetContent(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surface;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showDragHandle && _showDragHandleForPosition())
          _buildDragHandle(context),
        Flexible(
          child: Container(
            width: double.infinity,
            padding: padding ?? _getDefaultPadding(tokens),
            margin: margin,
            child: child,
          ),
        ),
      ],
    );

    if (sizeBehavior == CorpoSheetSizeBehavior.expand) {
      content = Expanded(child: content);
    }

    return Material(
      color: effectiveBackgroundColor,
      elevation: elevation,
      borderRadius: borderRadius ?? _getDefaultBorderRadius(tokens),
      child: Container(constraints: _getConstraints(context), child: content),
    );
  }

  bool _showDragHandleForPosition() => position == CorpoSheetPosition.bottom ||
        position == CorpoSheetPosition.top;

  Widget _buildDragHandle(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final Color handleColor =
        dragHandleColor ?? colorScheme.onSurface.withValues(alpha: 0.4);

    return Container(
      margin: EdgeInsets.only(
        top: tokens.spacing2x,
        bottom: tokens.spacing2x,
      ),
      child: Container(
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: handleColor,
          borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getDefaultPadding(CorpoDesignTokens tokens) => EdgeInsets.all(tokens.spacing6x);

  BorderRadius _getDefaultBorderRadius(CorpoDesignTokens tokens) {
    final double radius = tokens.borderRadius;

    return switch (position) {
      CorpoSheetPosition.bottom => BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      CorpoSheetPosition.top => BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      CorpoSheetPosition.left => BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      CorpoSheetPosition.right => BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      ),
    };
  }

  BoxConstraints _getConstraints(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;

    final bool isHorizontal =
        position == CorpoSheetPosition.left ||
        position == CorpoSheetPosition.right;

    switch (sizeBehavior) {
      case CorpoSheetSizeBehavior.content:
        if (isHorizontal) {
          return BoxConstraints(
            maxWidth: screenSize.width * maxSize,
            minWidth: screenSize.width * minSize,
            maxHeight: screenSize.height,
          );
        } else {
          return BoxConstraints(
            maxHeight: screenSize.height * maxSize,
            minHeight: screenSize.height * minSize,
            maxWidth: screenSize.width,
          );
        }

      case CorpoSheetSizeBehavior.fraction:
        if (isHorizontal) {
          return BoxConstraints.tightFor(
            width: screenSize.width * size,
            height: screenSize.height,
          );
        } else {
          return BoxConstraints.tightFor(
            height: screenSize.height * size,
            width: screenSize.width,
          );
        }

      case CorpoSheetSizeBehavior.fixed:
        if (isHorizontal) {
          return BoxConstraints.tightFor(
            width: size,
            height: screenSize.height,
          );
        } else {
          return BoxConstraints.tightFor(height: size, width: screenSize.width);
        }

      case CorpoSheetSizeBehavior.expand:
        return const BoxConstraints.expand();
    }
  }
}

class _SheetWrapper extends StatelessWidget {
  const _SheetWrapper({
    required this.sheet,
    required this.animation,
    required this.onDismiss,
  });

  final CorpoSheet sheet;
  final Animation<double> animation;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: sheet.dragBehavior != CorpoSheetDragBehavior.none
          ? onDismiss
          : null,
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) => _buildAnimatedSheet(context),
      ),
    );

  Widget _buildAnimatedSheet(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;

    final Widget sheetContent = sheet._buildSheetContent(context);

    // Calculate slide offset based on position
    Offset slideOffset;
    switch (sheet.position) {
      case CorpoSheetPosition.bottom:
        slideOffset = Offset(0, screenSize.height * (1 - animation.value));
      case CorpoSheetPosition.top:
        slideOffset = Offset(0, -screenSize.height * (1 - animation.value));
      case CorpoSheetPosition.left:
        slideOffset = Offset(-screenSize.width * (1 - animation.value), 0);
      case CorpoSheetPosition.right:
        slideOffset = Offset(screenSize.width * (1 - animation.value), 0);
    }

    // Position the sheet
    Widget positionedSheet;
    switch (sheet.position) {
      case CorpoSheetPosition.bottom:
        positionedSheet = Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: sheetContent,
        );
      case CorpoSheetPosition.top:
        positionedSheet = Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: sheetContent,
        );
      case CorpoSheetPosition.left:
        positionedSheet = Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: sheetContent,
        );
      case CorpoSheetPosition.right:
        positionedSheet = Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: sheetContent,
        );
    }

    return Stack(
      children: <Widget>[
        Transform.translate(offset: slideOffset, child: positionedSheet),
      ],
    );
  }
}

/// A sheet header widget with consistent styling.
///
/// This helper widget provides common header layouts for sheets.
class CorpoSheetHeader extends StatelessWidget {
  /// Creates a sheet header.
  const CorpoSheetHeader({
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.showCloseButton = true,
    this.onClose,
    this.titleStyle,
    this.subtitleStyle,
    this.backgroundColor,
    this.padding,
    super.key,
  });

  /// Primary title text.
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional leading widget.
  final Widget? leading;

  /// Action widgets (e.g., buttons).
  final List<Widget>? actions;

  /// Whether to show a close button.
  final bool showCloseButton;

  /// Callback when close button is pressed.
  final VoidCallback? onClose;

  /// Text style for the title.
  final TextStyle? titleStyle;

  /// Text style for the subtitle.
  final TextStyle? subtitleStyle;

  /// Background color of the header.
  final Color? backgroundColor;

  /// Padding for the header content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Container(
      padding:
          padding ??
          EdgeInsets.fromLTRB(
            tokens.spacing6x,
            tokens.spacing4x,
            tokens.spacing4x,
            tokens.spacing4x,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          if (leading != null) ...<Widget>[
            leading!,
            SizedBox(width: tokens.spacing4x),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style:
                      titleStyle ??
                      textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (subtitle != null) ...<Widget>[
                  SizedBox(height: tokens.spacing1x),
                  Text(
                    subtitle!,
                    style:
                        subtitleStyle ??
                        textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (actions != null) ...<Widget>[
            SizedBox(width: tokens.spacing4x),
            ...actions!
                .expand(
                  (Widget action) => <Widget>[
                    action,
                    SizedBox(width: tokens.spacing2x),
                  ],
                )
                .take(actions!.length * 2 - 1),
          ],
          if (showCloseButton) ...<Widget>[
            SizedBox(width: tokens.spacing2x),
            IconButton(
              onPressed: onClose ?? () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              tooltip: 'Close',
            ),
          ],
        ],
      ),
    );
  }
}
