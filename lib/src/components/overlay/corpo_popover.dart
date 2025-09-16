import 'package:flutter/material.dart';
import '../../design_tokens.dart';

/// Defines the preferred position of the popover relative to its anchor.
enum CorpoPopoverPosition {
  /// Position popover above the anchor
  top,

  /// Position popover below the anchor
  bottom,

  /// Position popover to the left of the anchor
  left,

  /// Position popover to the right of the anchor
  right,

  /// Position popover above-left of the anchor
  topLeft,

  /// Position popover above-right of the anchor
  topRight,

  /// Position popover below-left of the anchor
  bottomLeft,

  /// Position popover below-right of the anchor
  bottomRight,

  /// Auto-position based on available space
  auto,
}

/// Defines the dismissal behavior for the popover.
enum CorpoPopoverDismissBehavior {
  /// Dismiss on tap outside
  tapOutside,

  /// Dismiss on tap outside or escape key
  tapOutsideAndEscape,

  /// Manual dismissal only
  manual,

  /// Never dismiss automatically
  never,
}

/// Defines the animation style for popover appearance.
enum CorpoPopoverAnimation {
  /// Fade in/out animation
  fade,

  /// Scale animation
  scale,

  /// Slide animation
  slide,

  /// No animation
  none,
}

/// Controller for manually controlling popover visibility.
class CorpoPopoverController {
  VoidCallback? _show;
  VoidCallback? _hide;
  VoidCallback? _toggle;
  bool Function()? _isVisible;

  /// Show the popover.
  void show() => _show?.call();

  /// Hide the popover.
  void hide() => _hide?.call();

  /// Toggle the popover visibility.
  void toggle() => _toggle?.call();

  /// Check if the popover is currently visible.
  bool get isVisible => _isVisible?.call() ?? false;

  void _attach({
    required VoidCallback show,
    required VoidCallback hide,
    required VoidCallback toggle,
    required bool Function() isVisible,
  }) {
    _show = show;
    _hide = hide;
    _toggle = toggle;
    _isVisible = isVisible;
  }

  void _detach() {
    _show = null;
    _hide = null;
    _toggle = null;
    _isVisible = null;
  }
}

/// A comprehensive popover widget following Corpo UI design principles.
///
/// This component provides contextual content overlay with professional styling,
/// flexible positioning, and smooth animations. It supports both automatic
/// and manual trigger modes with rich content options.
class CorpoPopover extends StatefulWidget {
  /// Creates a Corpo UI popover.
  const CorpoPopover({
    required this.child,
    required this.content,
    this.position = CorpoPopoverPosition.bottom,
    this.animation = CorpoPopoverAnimation.scale,
    this.dismissBehavior = CorpoPopoverDismissBehavior.tapOutside,
    this.controller,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    EdgeInsetsGeometry? margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation = 8.0,
    this.arrow = true,
    this.arrowSize = 12.0,
    this.arrowColor,
    this.animationDuration = const Duration(milliseconds: 200),
    this.barrierColor,
    this.onShow,
    this.onHide,
    super.key,
  }) : margin = margin ?? const EdgeInsets.all(8.0);

  /// The widget that triggers the popover.
  final Widget child;

  /// Content to display in the popover.
  final Widget content;

  /// Preferred position of the popover relative to the child.
  final CorpoPopoverPosition position;

  /// Animation style for popover appearance.
  final CorpoPopoverAnimation animation;

  /// Dismissal behavior configuration.
  final CorpoPopoverDismissBehavior dismissBehavior;

  /// Controller for manual popover control.
  final CorpoPopoverController? controller;

  /// Fixed width of the popover.
  final double? width;

  /// Fixed height of the popover.
  final double? height;

  /// Constraints for the popover size.
  final BoxConstraints? constraints;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? padding;

  /// Margin around the popover.
  final EdgeInsetsGeometry margin;

  /// Background color of the popover.
  final Color? backgroundColor;

  /// Border radius of the popover.
  final BorderRadius? borderRadius;

  /// Elevation of the popover.
  final double elevation;

  /// Whether to show an arrow pointing to the child.
  final bool arrow;

  /// Size of the arrow.
  final double arrowSize;

  /// Color of the arrow.
  final Color? arrowColor;

  /// Duration of show/hide animations.
  final Duration animationDuration;

  /// Color of the barrier behind the popover.
  final Color? barrierColor;

  /// Callback when popover is shown.
  final VoidCallback? onShow;

  /// Callback when popover is hidden.
  final VoidCallback? onHide;

  @override
  State<CorpoPopover> createState() => _CorpoPopoverState();
}

class _CorpoPopoverState extends State<CorpoPopover>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;
  final GlobalKey _childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _setupAnimation();
    widget.controller?._attach(
      show: _show,
      hide: _hide,
      toggle: _toggle,
      isVisible: () => _isVisible,
    );
  }

  @override
  void didUpdateWidget(CorpoPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation) {
      _setupAnimation();
    }
    if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    widget.controller?._detach();
    super.dispose();
  }

  void _setupAnimation() {
    switch (widget.animation) {
      case CorpoPopoverAnimation.fade:
        _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
      case CorpoPopoverAnimation.scale:
        _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        );
      case CorpoPopoverAnimation.slide:
        _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
      case CorpoPopoverAnimation.none:
        _animation = Tween<double>(
          begin: 1,
          end: 1,
        ).animate(_animationController);
    }
  }

  void _show() {
    if (_isVisible) return;

    setState(() {
      _isVisible = true;
    });

    _showOverlay();
    widget.onShow?.call();
  }

  void _hide() {
    if (!_isVisible) return;

    setState(() {
      _isVisible = false;
    });

    _animationController.reverse().then((_) {
      _removeOverlay();
    });
    widget.onHide?.call();
  }

  void _toggle() {
    if (_isVisible) {
      _hide();
    } else {
      _show();
    }
  }

  void _showOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _PopoverOverlay(
        target: widget,
        childKey: _childKey,
        animation: _animation,
        onDismiss: _shouldDismiss() ? _hide : null,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  bool _shouldDismiss() =>
      widget.dismissBehavior == CorpoPopoverDismissBehavior.tapOutside ||
      widget.dismissBehavior == CorpoPopoverDismissBehavior.tapOutsideAndEscape;

  @override
  Widget build(BuildContext context) =>
      GestureDetector(key: _childKey, onTap: _toggle, child: widget.child);
}

class _PopoverOverlay extends StatelessWidget {
  const _PopoverOverlay({
    required this.target,
    required this.childKey,
    required this.animation,
    this.onDismiss,
  });

  final CorpoPopover target;
  final GlobalKey childKey;
  final Animation<double> animation;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      // Barrier
      if (onDismiss != null)
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            child: Container(color: target.barrierColor ?? Colors.transparent),
          ),
        ),
      // Popover content
      _PopoverPositioned(
        target: target,
        childKey: childKey,
        animation: animation,
      ),
    ],
  );
}

class _PopoverPositioned extends StatelessWidget {
  const _PopoverPositioned({
    required this.target,
    required this.childKey,
    required this.animation,
  });

  final CorpoPopover target;
  final GlobalKey childKey;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final RenderBox? renderBox =
        childKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      return const SizedBox.shrink();
    }

    final Offset childPosition = renderBox.localToGlobal(Offset.zero);
    final Size childSize = renderBox.size;

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final CorpoPopoverPosition actualPosition = _calculatePosition(
          context,
          childPosition,
          childSize,
        );

        return Positioned(
          left: _calculateLeft(
            context,
            childPosition,
            childSize,
            actualPosition,
          ),
          top: _calculateTop(context, childPosition, childSize, actualPosition),
          child: _buildPopoverContent(context, actualPosition),
        );
      },
    );
  }

  CorpoPopoverPosition _calculatePosition(
    BuildContext context,
    Offset childPosition,
    Size childSize,
  ) {
    if (target.position != CorpoPopoverPosition.auto) {
      return target.position;
    }

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;

    // Simple auto-positioning logic
    final double spaceAbove = childPosition.dy;
    final double spaceBelow =
        screenSize.height - childPosition.dy - childSize.height;
    final double spaceLeft = childPosition.dx;
    final double spaceRight =
        screenSize.width - childPosition.dx - childSize.width;

    if (spaceBelow > spaceAbove) {
      return CorpoPopoverPosition.bottom;
    } else if (spaceAbove > 200) {
      return CorpoPopoverPosition.top;
    } else if (spaceRight > spaceLeft) {
      return CorpoPopoverPosition.right;
    } else {
      return CorpoPopoverPosition.left;
    }
  }

  double _calculateLeft(
    BuildContext context,
    Offset childPosition,
    Size childSize,
    CorpoPopoverPosition position,
  ) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double popoverWidth = target.width ?? 200.0; // Default estimate

    switch (position) {
      case CorpoPopoverPosition.left:
      case CorpoPopoverPosition.topLeft:
      case CorpoPopoverPosition.bottomLeft:
        return (childPosition.dx - popoverWidth - target.arrowSize).clamp(
          target.margin.horizontal,
          screenWidth - popoverWidth,
        );
      case CorpoPopoverPosition.right:
      case CorpoPopoverPosition.topRight:
      case CorpoPopoverPosition.bottomRight:
        return (childPosition.dx + childSize.width + target.arrowSize).clamp(
          0.0,
          screenWidth - popoverWidth - target.margin.horizontal,
        );
      default:
        return (childPosition.dx + childSize.width / 2 - popoverWidth / 2)
            .clamp(
              target.margin.horizontal,
              screenWidth - popoverWidth - target.margin.horizontal,
            );
    }
  }

  double _calculateTop(
    BuildContext context,
    Offset childPosition,
    Size childSize,
    CorpoPopoverPosition position,
  ) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenHeight = mediaQuery.size.height;
    final double popoverHeight = target.height ?? 100.0; // Default estimate

    switch (position) {
      case CorpoPopoverPosition.top:
      case CorpoPopoverPosition.topLeft:
      case CorpoPopoverPosition.topRight:
        return (childPosition.dy - popoverHeight - target.arrowSize).clamp(
          target.margin.vertical,
          screenHeight - popoverHeight,
        );
      case CorpoPopoverPosition.bottom:
      case CorpoPopoverPosition.bottomLeft:
      case CorpoPopoverPosition.bottomRight:
        return (childPosition.dy + childSize.height + target.arrowSize).clamp(
          0.0,
          screenHeight - popoverHeight - target.margin.vertical,
        );
      default:
        return (childPosition.dy + childSize.height / 2 - popoverHeight / 2)
            .clamp(
              target.margin.vertical,
              screenHeight - popoverHeight - target.margin.vertical,
            );
    }
  }

  Widget _buildPopoverContent(
    BuildContext context,
    CorpoPopoverPosition position,
  ) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Color backgroundColor = target.backgroundColor ?? colorScheme.surface;

    Widget content = Material(
      color: backgroundColor,
      elevation: target.elevation,
      borderRadius: target.borderRadius ?? BorderRadius.circular(12),
      child: Container(
        width: target.width,
        height: target.height,
        constraints: target.constraints,
        padding: target.padding ?? const EdgeInsets.all(CorpoSpacing.medium),
        child: target.content,
      ),
    );

    // Apply animation transform
    switch (target.animation) {
      case CorpoPopoverAnimation.fade:
        content = Opacity(opacity: animation.value, child: content);
      case CorpoPopoverAnimation.scale:
        content = Transform.scale(
          scale: animation.value,
          alignment: _getScaleAlignment(position),
          child: content,
        );
      case CorpoPopoverAnimation.slide:
        final Offset offset = _getSlideOffset(position);
        content = Transform.translate(
          offset: Offset.lerp(offset, Offset.zero, animation.value)!,
          child: content,
        );
      case CorpoPopoverAnimation.none:
        // No animation transform
        break;
    }

    return content;
  }

  Alignment _getScaleAlignment(CorpoPopoverPosition position) {
    switch (position) {
      case CorpoPopoverPosition.top:
      case CorpoPopoverPosition.topLeft:
      case CorpoPopoverPosition.topRight:
        return Alignment.bottomCenter;
      case CorpoPopoverPosition.bottom:
      case CorpoPopoverPosition.bottomLeft:
      case CorpoPopoverPosition.bottomRight:
        return Alignment.topCenter;
      case CorpoPopoverPosition.left:
        return Alignment.centerRight;
      case CorpoPopoverPosition.right:
        return Alignment.centerLeft;
      default:
        return Alignment.center;
    }
  }

  Offset _getSlideOffset(CorpoPopoverPosition position) {
    const double distance = 20;

    switch (position) {
      case CorpoPopoverPosition.top:
      case CorpoPopoverPosition.topLeft:
      case CorpoPopoverPosition.topRight:
        return const Offset(0, distance);
      case CorpoPopoverPosition.bottom:
      case CorpoPopoverPosition.bottomLeft:
      case CorpoPopoverPosition.bottomRight:
        return const Offset(0, -distance);
      case CorpoPopoverPosition.left:
        return const Offset(distance, 0);
      case CorpoPopoverPosition.right:
        return const Offset(-distance, 0);
      default:
        return const Offset(0, -distance);
    }
  }
}
