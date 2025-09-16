import 'package:flutter/material.dart';
import '../../design_tokens.dart';

/// Defines the size variants for modals.
enum CorpoModalSize {
  /// Small modal - typically for confirmations
  small,

  /// Medium modal - standard size for most content
  medium,

  /// Large modal - for complex forms or detailed content
  large,

  /// Extra large modal - for maximum content area
  extraLarge,

  /// Full screen modal
  fullScreen,

  /// Custom size - uses provided width/height
  custom,
}

/// Defines the animation style for modal appearance.
enum CorpoModalAnimation {
  /// Fade in/out animation
  fade,

  /// Scale animation
  scale,

  /// Slide from bottom
  slideUp,

  /// Slide from top
  slideDown,

  /// No animation
  none,
}

/// Defines the dismiss behavior for the modal.
enum CorpoModalDismissBehavior {
  /// Dismiss on barrier tap and escape key
  barrierAndEscape,

  /// Dismiss only on barrier tap
  barrierOnly,

  /// Dismiss only on escape key
  escapeOnly,

  /// Manual dismissal only
  manual,

  /// Never dismiss automatically
  never,
}

/// A comprehensive modal widget following Corpo UI design principles.
///
/// This component provides overlay content with professional styling,
/// flexible sizing, and smooth animations. It supports various dismiss
/// behaviors and content configurations.
class CorpoModal extends StatelessWidget {
  /// Creates a Corpo UI modal.
  const CorpoModal({
    required this.child,
    this.size = CorpoModalSize.medium,
    this.animation = CorpoModalAnimation.scale,
    this.dismissBehavior = CorpoModalDismissBehavior.barrierAndEscape,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation = 24.0,
    this.barrierColor,
    this.barrierDismissible = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onDismiss,
    super.key,
  });

  /// Content to display in the modal.
  final Widget child;

  /// Size variant of the modal.
  final CorpoModalSize size;

  /// Animation style for modal appearance.
  final CorpoModalAnimation animation;

  /// Dismissal behavior configuration.
  final CorpoModalDismissBehavior dismissBehavior;

  /// Custom width (used with CorpoModalSize.custom).
  final double? width;

  /// Custom height (used with CorpoModalSize.custom).
  final double? height;

  /// Constraints for the modal size.
  final BoxConstraints? constraints;

  /// Padding inside the modal.
  final EdgeInsetsGeometry? padding;

  /// Margin around the modal.
  final EdgeInsetsGeometry? margin;

  /// Background color of the modal.
  final Color? backgroundColor;

  /// Border radius of the modal.
  final BorderRadius? borderRadius;

  /// Elevation of the modal.
  final double elevation;

  /// Color of the barrier behind the modal.
  final Color? barrierColor;

  /// Whether tapping the barrier should dismiss the modal.
  final bool barrierDismissible;

  /// Duration of show/hide animations.
  final Duration animationDuration;

  /// Callback when modal is dismissed.
  final VoidCallback? onDismiss;

  /// Show the modal.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    CorpoModalSize size = CorpoModalSize.medium,
    CorpoModalAnimation animation = CorpoModalAnimation.scale,
    CorpoModalDismissBehavior dismissBehavior =
        CorpoModalDismissBehavior.barrierAndEscape,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double elevation = 24.0,
    Color? barrierColor,
    bool barrierDismissible = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    VoidCallback? onDismiss,
  }) => showGeneralDialog<T>(
    context: context,
    barrierDismissible:
        _shouldDismissOnBarrier(dismissBehavior) && barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor:
        barrierColor ?? CorpoDesignTokens().textPrimary.withValues(alpha: 0.54),
    transitionDuration: animationDuration,
    pageBuilder:
        (
          BuildContext context,
          Animation<double> pageAnimation,
          Animation<double> secondaryAnimation,
        ) => _ModalWrapper(
          modal: CorpoModal(
            size: size,
            animation: animation,
            dismissBehavior: dismissBehavior,
            width: width,
            height: height,
            constraints: constraints,
            padding: padding,
            margin: margin,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            elevation: elevation,
            barrierColor: barrierColor,
            barrierDismissible: barrierDismissible,
            animationDuration: animationDuration,
            onDismiss: onDismiss,
            child: child,
          ),
          buildAnimation: pageAnimation,
          onDismiss: () {
            onDismiss?.call();
            Navigator.of(context).pop();
          },
        ),
  );

  static bool _shouldDismissOnBarrier(CorpoModalDismissBehavior behavior) =>
      behavior == CorpoModalDismissBehavior.barrierAndEscape ||
      behavior == CorpoModalDismissBehavior.barrierOnly;

  @override
  Widget build(BuildContext context) {
    // This widget is primarily used with the static show method
    return _buildModalContent(context);
  }

  Widget _buildModalContent(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surface;

    return Material(
      color: effectiveBackgroundColor,
      elevation: elevation,
      borderRadius: borderRadius ?? _getDefaultBorderRadius(tokens),
      child: Container(
        width: _getWidth(context),
        height: _getHeight(context),
        constraints: constraints ?? _getConstraints(context),
        padding: padding ?? _getDefaultPadding(tokens),
        margin: margin,
        child: child,
      ),
    );
  }

  double? _getWidth(BuildContext context) {
    if (size == CorpoModalSize.custom) return width;
    if (size == CorpoModalSize.fullScreen) return double.infinity;

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;

    return switch (size) {
      CorpoModalSize.small => screenWidth * 0.3,
      CorpoModalSize.medium => screenWidth * 0.5,
      CorpoModalSize.large => screenWidth * 0.7,
      CorpoModalSize.extraLarge => screenWidth * 0.9,
      _ => null,
    };
  }

  double? _getHeight(BuildContext context) {
    if (size == CorpoModalSize.custom) return height;
    if (size == CorpoModalSize.fullScreen) return double.infinity;
    return null; // Let content determine height
  }

  BoxConstraints _getConstraints(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;

    if (size == CorpoModalSize.fullScreen) {
      return const BoxConstraints.expand();
    }

    return BoxConstraints(
      maxWidth: screenSize.width * 0.95,
      maxHeight: screenSize.height * 0.9,
      minWidth: 280,
    );
  }

  EdgeInsetsGeometry _getDefaultPadding(CorpoDesignTokens tokens) =>
      switch (size) {
        CorpoModalSize.small => EdgeInsets.all(tokens.spacing4x),
        CorpoModalSize.fullScreen => EdgeInsets.zero,
        _ => EdgeInsets.all(tokens.spacing6x),
      };

  BorderRadius _getDefaultBorderRadius(CorpoDesignTokens tokens) {
    if (size == CorpoModalSize.fullScreen) {
      return BorderRadius.zero;
    }
    return BorderRadius.circular(tokens.borderRadius);
  }
}

class _ModalWrapper extends StatefulWidget {
  const _ModalWrapper({
    required this.modal,
    required this.buildAnimation,
    required this.onDismiss,
  });

  final CorpoModal modal;
  final Animation<double> buildAnimation;
  final VoidCallback onDismiss;

  @override
  State<_ModalWrapper> createState() => _ModalWrapperState();
}

class _ModalWrapperState extends State<_ModalWrapper> {
  @override
  Widget build(BuildContext context) => PopScope(
    canPop: _shouldDismissOnEscape(),
    onPopInvokedWithResult: (bool didPop, Object? result) {
      if (didPop && _shouldDismissOnEscape()) {
        widget.onDismiss();
      }
    },
    child: Center(
      child: AnimatedBuilder(
        animation: widget.buildAnimation,
        builder: (BuildContext context, Widget? child) =>
            _buildAnimatedModal(context),
      ),
    ),
  );

  bool _shouldDismissOnEscape() =>
      widget.modal.dismissBehavior ==
          CorpoModalDismissBehavior.barrierAndEscape ||
      widget.modal.dismissBehavior == CorpoModalDismissBehavior.escapeOnly;

  Widget _buildAnimatedModal(BuildContext context) {
    Widget modal = widget.modal._buildModalContent(context);

    // Apply animation transform
    switch (widget.modal.animation) {
      case CorpoModalAnimation.fade:
        modal = Opacity(opacity: widget.buildAnimation.value, child: modal);
      case CorpoModalAnimation.scale:
        modal = Transform.scale(
          scale: Tween<double>(begin: 0.7, end: 1)
              .animate(
                CurvedAnimation(
                  parent: widget.buildAnimation,
                  curve: Curves.elasticOut,
                ),
              )
              .value,
          child: Opacity(opacity: widget.buildAnimation.value, child: modal),
        );
      case CorpoModalAnimation.slideUp:
        modal = Transform.translate(
          offset:
              Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
                  .animate(
                    CurvedAnimation(
                      parent: widget.buildAnimation,
                      curve: Curves.easeOut,
                    ),
                  )
                  .value *
              MediaQuery.of(context).size.height,
          child: Opacity(opacity: widget.buildAnimation.value, child: modal),
        );
      case CorpoModalAnimation.slideDown:
        modal = Transform.translate(
          offset:
              Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero)
                  .animate(
                    CurvedAnimation(
                      parent: widget.buildAnimation,
                      curve: Curves.easeOut,
                    ),
                  )
                  .value *
              MediaQuery.of(context).size.height,
          child: Opacity(opacity: widget.buildAnimation.value, child: modal),
        );
      case CorpoModalAnimation.none:
        // No animation transform
        break;
    }

    return modal;
  }
}

/// A modal header widget with consistent styling.
///
/// This helper widget provides common header layouts for modals.
class CorpoModalHeader extends StatelessWidget {
  /// Creates a modal header.
  const CorpoModalHeader({
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
            tokens.spacing6x,
            tokens.spacing4x,
            tokens.spacing4x,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
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
                      textTheme.headlineSmall?.copyWith(
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

/// A modal footer widget with consistent styling.
///
/// This helper widget provides common footer layouts for modals.
class CorpoModalFooter extends StatelessWidget {
  /// Creates a modal footer.
  const CorpoModalFooter({
    required this.actions,
    this.alignment = MainAxisAlignment.end,
    this.backgroundColor,
    this.padding,
    super.key,
  });

  /// Action widgets (e.g., buttons).
  final List<Widget> actions;

  /// Alignment of the actions.
  final MainAxisAlignment alignment;

  /// Background color of the footer.
  final Color? backgroundColor;

  /// Padding for the footer content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Container(
      padding:
          padding ??
          EdgeInsets.fromLTRB(
            tokens.spacing6x,
            tokens.spacing4x,
            tokens.spacing6x,
            tokens.spacing6x,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: alignment,
        children: actions
            .expand(
              (Widget action) => <Widget>[
                action,
                SizedBox(width: tokens.spacing2x),
              ],
            )
            .take(actions.length * 2 - 1)
            .toList(),
      ),
    );
  }
}
