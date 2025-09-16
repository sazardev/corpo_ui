import 'dart:async';

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Defines the preferred position of the tooltip relative to its child.
enum CorpoTooltipPosition {
  /// Position tooltip above the child
  top,

  /// Position tooltip below the child
  bottom,

  /// Position tooltip to the left of the child
  left,

  /// Position tooltip to the right of the child
  right,

  /// Position tooltip above-left of the child
  topLeft,

  /// Position tooltip above-right of the child
  topRight,

  /// Position tooltip below-left of the child
  bottomLeft,

  /// Position tooltip below-right of the child
  bottomRight,
}

/// Defines the animation style for tooltip appearance.
enum CorpoTooltipAnimation {
  /// Fade in/out animation
  fade,

  /// Scale animation
  scale,

  /// Slide animation
  slide,

  /// No animation
  none,
}

/// Defines the trigger behavior for showing the tooltip.
enum CorpoTooltipTrigger {
  /// Show on hover (desktop) and long press (mobile)
  hover,

  /// Show only on long press
  longPress,

  /// Show only on tap
  tap,

  /// Show manually via controller
  manual,
}

/// Controller for manually controlling tooltip visibility.
class CorpoTooltipController {
  VoidCallback? _show;
  VoidCallback? _hide;
  VoidCallback? _toggle;

  /// Show the tooltip.
  void show() => _show?.call();

  /// Hide the tooltip.
  void hide() => _hide?.call();

  /// Toggle the tooltip visibility.
  void toggle() => _toggle?.call();

  void _attach({
    required VoidCallback show,
    required VoidCallback hide,
    required VoidCallback toggle,
  }) {
    _show = show;
    _hide = hide;
    _toggle = toggle;
  }

  void _detach() {
    _show = null;
    _hide = null;
    _toggle = null;
  }
}

/// A comprehensive tooltip widget following Corpo UI design principles.
///
/// This component provides contextual information with professional styling,
/// flexible positioning, and smooth animations. It supports both automatic
/// and manual trigger modes with rich content options.
class CorpoTooltip extends StatefulWidget {
  /// Creates a Corpo UI tooltip.
  const CorpoTooltip({
    required this.child,
    required this.message,
    this.richMessage,
    this.position = CorpoTooltipPosition.top,
    this.animation = CorpoTooltipAnimation.fade,
    this.trigger = CorpoTooltipTrigger.hover,
    this.controller,
    this.showDelay = const Duration(milliseconds: 500),
    this.hideDelay = const Duration(milliseconds: 100),
    this.animationDuration = const Duration(milliseconds: 200),
    this.maxWidth = 320.0,
    this.padding,
    EdgeInsetsGeometry? margin,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.elevation = 4.0,
    this.arrow = true,
    this.arrowSize = 8.0,
    this.onShow,
    this.onHide,
    super.key,
  }) : margin = margin ?? const EdgeInsets.all(8.0);

  /// The widget that the tooltip is attached to.
  final Widget child;

  /// Simple text message for the tooltip.
  final String? message;

  /// Rich text message for the tooltip (takes precedence over message).
  final InlineSpan? richMessage;

  /// Preferred position of the tooltip relative to the child.
  final CorpoTooltipPosition position;

  /// Animation style for tooltip appearance.
  final CorpoTooltipAnimation animation;

  /// Trigger behavior for showing the tooltip.
  final CorpoTooltipTrigger trigger;

  /// Controller for manual tooltip control.
  final CorpoTooltipController? controller;

  /// Delay before showing the tooltip.
  final Duration showDelay;

  /// Delay before hiding the tooltip.
  final Duration hideDelay;

  /// Duration of show/hide animations.
  final Duration animationDuration;

  /// Maximum width of the tooltip.
  final double maxWidth;

  /// Padding inside the tooltip.
  final EdgeInsetsGeometry? padding;

  /// Margin around the tooltip.
  final EdgeInsetsGeometry margin;

  /// Background color of the tooltip.
  final Color? backgroundColor;

  /// Text style for the tooltip message.
  final TextStyle? textStyle;

  /// Border radius of the tooltip.
  final BorderRadius? borderRadius;

  /// Elevation of the tooltip.
  final double elevation;

  /// Whether to show an arrow pointing to the child.
  final bool arrow;

  /// Size of the arrow.
  final double arrowSize;

  /// Callback when tooltip is shown.
  final VoidCallback? onShow;

  /// Callback when tooltip is hidden.
  final VoidCallback? onHide;

  @override
  State<CorpoTooltip> createState() => _CorpoTooltipState();
}

class _CorpoTooltipState extends State<CorpoTooltip>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _showTimer;
  Timer? _hideTimer;
  bool _isVisible = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _setupAnimation();
    widget.controller?._attach(show: _show, hide: _hide, toggle: _toggle);
  }

  @override
  void didUpdateWidget(CorpoTooltip oldWidget) {
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
    _hideTimer?.cancel();
    _showTimer?.cancel();
    _removeOverlay();
    _animationController.dispose();
    widget.controller?._detach();
    super.dispose();
  }

  void _setupAnimation() {
    switch (widget.animation) {
      case CorpoTooltipAnimation.fade:
        _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
      case CorpoTooltipAnimation.scale:
        _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        );
      case CorpoTooltipAnimation.slide:
        _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
      case CorpoTooltipAnimation.none:
        _animation = Tween<double>(
          begin: 1,
          end: 1,
        ).animate(_animationController);
    }
  }

  void _show() {
    if (_isVisible) return;

    _hideTimer?.cancel();
    _showTimer = Timer(widget.showDelay, () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
        _showOverlay();
        widget.onShow?.call();
      }
    });
  }

  void _hide() {
    if (!_isVisible) return;

    _showTimer?.cancel();
    _hideTimer = Timer(widget.hideDelay, () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
        _animationController.reverse().then((_) {
          _removeOverlay();
        });
        widget.onHide?.call();
      }
    });
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
      builder: (BuildContext context) => _TooltipOverlay(
        target: widget,
        animation: _animation,
        onTap: widget.trigger == CorpoTooltipTrigger.tap ? null : _hide,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    switch (widget.trigger) {
      case CorpoTooltipTrigger.hover:
        child = MouseRegion(
          onEnter: (_) => _show(),
          onExit: (_) => _hide(),
          child: GestureDetector(onLongPress: _show, child: child),
        );
      case CorpoTooltipTrigger.longPress:
        child = GestureDetector(onLongPress: _show, child: child);
      case CorpoTooltipTrigger.tap:
        child = GestureDetector(onTap: _toggle, child: child);
      case CorpoTooltipTrigger.manual:
        // No gesture handling for manual mode
        break;
    }

    return child;
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    required this.target,
    required this.animation,
    this.onTap,
  });

  final CorpoTooltip target;
  final Animation<double> animation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.translucent,
    child: Stack(
      children: <Widget>[
        // Invisible tap area to dismiss tooltip
        if (onTap != null) const Positioned.fill(child: SizedBox.expand()),
        // Tooltip content
        _TooltipPositioned(target: target, animation: animation),
      ],
    ),
  );
}

class _TooltipPositioned extends StatelessWidget {
  const _TooltipPositioned({required this.target, required this.animation});

  final CorpoTooltip target;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset targetPosition = renderBox.localToGlobal(Offset.zero);
    final Size targetSize = renderBox.size;

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) => Positioned(
        left: _calculateLeft(context, targetPosition, targetSize),
        top: _calculateTop(context, targetPosition, targetSize),
        child: _buildTooltipContent(context),
      ),
    );
  }

  double _calculateLeft(
    BuildContext context,
    Offset targetPosition,
    Size targetSize,
  ) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double tooltipWidth = target.maxWidth;

    switch (target.position) {
      case CorpoTooltipPosition.left:
      case CorpoTooltipPosition.topLeft:
      case CorpoTooltipPosition.bottomLeft:
        return (targetPosition.dx - tooltipWidth - target.arrowSize).clamp(
          target.margin.horizontal,
          screenWidth - tooltipWidth,
        );
      case CorpoTooltipPosition.right:
      case CorpoTooltipPosition.topRight:
      case CorpoTooltipPosition.bottomRight:
        return (targetPosition.dx + targetSize.width + target.arrowSize).clamp(
          0.0,
          screenWidth - tooltipWidth - target.margin.horizontal,
        );
      default:
        return (targetPosition.dx + targetSize.width / 2 - tooltipWidth / 2)
            .clamp(
              target.margin.horizontal,
              screenWidth - tooltipWidth - target.margin.horizontal,
            );
    }
  }

  double _calculateTop(
    BuildContext context,
    Offset targetPosition,
    Size targetSize,
  ) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenHeight = mediaQuery.size.height;

    switch (target.position) {
      case CorpoTooltipPosition.top:
      case CorpoTooltipPosition.topLeft:
      case CorpoTooltipPosition.topRight:
        return targetPosition.dy - target.arrowSize - 100; // Estimated height
      case CorpoTooltipPosition.bottom:
      case CorpoTooltipPosition.bottomLeft:
      case CorpoTooltipPosition.bottomRight:
        return targetPosition.dy + targetSize.height + target.arrowSize;
      default:
        return (targetPosition.dy + targetSize.height / 2 - 50).clamp(
          target.margin.vertical,
          screenHeight - 100 - target.margin.vertical,
        );
    }
  }

  Widget _buildTooltipContent(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final Color backgroundColor =
        target.backgroundColor ?? colorScheme.inverseSurface;
    final TextStyle textStyle =
        target.textStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ) ??
        const TextStyle();

    Widget content = Material(
      color: backgroundColor,
      elevation: target.elevation,
      borderRadius:
          target.borderRadius ?? BorderRadius.circular(tokens.borderRadius),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: target.maxWidth),
        child: Padding(
          padding:
              target.padding ??
              EdgeInsets.symmetric(
                horizontal: tokens.spacing4x,
                vertical: tokens.spacing2x,
              ),
          child: target.richMessage != null
              ? Text.rich(target.richMessage!, style: textStyle)
              : Text(target.message ?? '', style: textStyle),
        ),
      ),
    );

    // Apply animation transform
    switch (target.animation) {
      case CorpoTooltipAnimation.fade:
        content = Opacity(opacity: animation.value, child: content);
      case CorpoTooltipAnimation.scale:
        content = Transform.scale(scale: animation.value, child: content);
      case CorpoTooltipAnimation.slide:
        final Offset offset = _getSlideOffset();
        content = Transform.translate(
          offset: Offset.lerp(offset, Offset.zero, animation.value)!,
          child: content,
        );
      case CorpoTooltipAnimation.none:
        // No animation transform
        break;
    }

    return content;
  }

  Offset _getSlideOffset() {
    const double distance = 20;

    switch (target.position) {
      case CorpoTooltipPosition.top:
      case CorpoTooltipPosition.topLeft:
      case CorpoTooltipPosition.topRight:
        return const Offset(0, distance);
      case CorpoTooltipPosition.bottom:
      case CorpoTooltipPosition.bottomLeft:
      case CorpoTooltipPosition.bottomRight:
        return const Offset(0, -distance);
      case CorpoTooltipPosition.left:
        return const Offset(distance, 0);
      case CorpoTooltipPosition.right:
        return const Offset(-distance, 0);
    }
  }
}
