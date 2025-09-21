import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Defines how images should be fitted within their container.
enum CorpoImageFit {
  /// Scale the image to fill the container, maintaining aspect ratio
  cover,

  /// Scale the image to fit entirely within the container
  contain,

  /// Scale the image to fill the container exactly
  fill,

  /// Scale the image to fit the width of the container
  fitWidth,

  /// Scale the image to fit the height of the container
  fitHeight,

  /// Display the image at its natural size
  none,

  /// Scale the image down to fit the container if needed
  scaleDown,
}

/// Defines the shape of the image container.
enum CorpoImageShape {
  /// Rectangular shape with optional border radius
  rectangle,

  /// Circular shape
  circle,

  /// Rounded rectangle with predefined border radius
  rounded,
}

/// Defines loading behavior for images.
enum CorpoImageLoadingBehavior {
  /// Show placeholder while loading
  placeholder,

  /// Show progressive loading with blur effect
  progressive,

  /// Show skeleton loading animation
  skeleton,

  /// No loading indicator
  none,
}

/// A comprehensive image widget following Corpo UI design principles.
///
/// This component provides professional image display with loading states,
/// error handling, and various styling options suitable for corporate
/// applications.
class CorpoImage extends StatefulWidget {
  /// Creates a Corpo UI image from a network URL.
  const CorpoImage.network(
    this.imageUrl, {
    this.width,
    this.height,
    this.fit = CorpoImageFit.cover,
    this.shape = CorpoImageShape.rectangle,
    this.borderRadius,
    this.loadingBehavior = CorpoImageLoadingBehavior.placeholder,
    this.placeholder,
    this.errorWidget,
    this.loadingWidget,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.elevation = 0.0,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.heroTag,
    super.key,
  }) : imageProvider = null,
       imageData = null,
       assetPath = null,
       _imageType = _CorpoImageType.network;

  /// Creates a Corpo UI image from an asset.
  const CorpoImage.asset(
    this.assetPath, {
    this.width,
    this.height,
    this.fit = CorpoImageFit.cover,
    this.shape = CorpoImageShape.rectangle,
    this.borderRadius,
    this.loadingBehavior = CorpoImageLoadingBehavior.placeholder,
    this.placeholder,
    this.errorWidget,
    this.loadingWidget,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.elevation = 0.0,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.heroTag,
    super.key,
  }) : imageUrl = null,
       imageProvider = null,
       imageData = null,
       _imageType = _CorpoImageType.asset;

  /// Creates a Corpo UI image from memory (bytes).
  const CorpoImage.memory(
    this.imageData, {
    this.width,
    this.height,
    this.fit = CorpoImageFit.cover,
    this.shape = CorpoImageShape.rectangle,
    this.borderRadius,
    this.loadingBehavior = CorpoImageLoadingBehavior.placeholder,
    this.placeholder,
    this.errorWidget,
    this.loadingWidget,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.elevation = 0.0,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.heroTag,
    super.key,
  }) : imageUrl = null,
       imageProvider = null,
       assetPath = null,
       _imageType = _CorpoImageType.memory;

  /// Creates a Corpo UI image from an ImageProvider.
  const CorpoImage.provider(
    this.imageProvider, {
    this.width,
    this.height,
    this.fit = CorpoImageFit.cover,
    this.shape = CorpoImageShape.rectangle,
    this.borderRadius,
    this.loadingBehavior = CorpoImageLoadingBehavior.placeholder,
    this.placeholder,
    this.errorWidget,
    this.loadingWidget,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.elevation = 0.0,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.heroTag,
    super.key,
  }) : imageUrl = null,
       imageData = null,
       assetPath = null,
       _imageType = _CorpoImageType.provider;

  /// The network URL for the image (when using network constructor).
  final String? imageUrl;

  /// The asset path for the image (when using asset constructor).
  final String? assetPath;

  /// The image data bytes (when using memory constructor).
  final Uint8List? imageData;

  /// The image provider (when using provider constructor).
  final ImageProvider? imageProvider;

  /// Width of the image container.
  final double? width;

  /// Height of the image container.
  final double? height;

  /// How the image should be fitted within its container.
  final CorpoImageFit fit;

  /// Shape of the image container.
  final CorpoImageShape shape;

  /// Border radius for rectangular shapes.
  final BorderRadius? borderRadius;

  /// Loading behavior configuration.
  final CorpoImageLoadingBehavior loadingBehavior;

  /// Widget displayed while the image is loading.
  final Widget? placeholder;

  /// Widget displayed when image loading fails.
  final Widget? errorWidget;

  /// Custom loading widget override.
  final Widget? loadingWidget;

  /// Background color of the image container.
  final Color? backgroundColor;

  /// Border color of the image container.
  final Color? borderColor;

  /// Border width of the image container.
  final double borderWidth;

  /// Elevation of the image container.
  final double elevation;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Callback when the image is tapped.
  final VoidCallback? onTap;

  /// Callback when the image is long-pressed.
  final VoidCallback? onLongPress;

  /// Hero tag for hero animations.
  final String? heroTag;

  final _CorpoImageType _imageType;

  @override
  State<CorpoImage> createState() => _CorpoImageState();
}

enum _CorpoImageType { network, asset, memory, provider }

class _CorpoImageState extends State<CorpoImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _imageLoaded = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Widget imageWidget = _buildImageWidget(context);
    final Widget styledImage = _buildStyledContainer(
      context,
      imageWidget,
      colorScheme,
    );

    final Widget finalWidget = widget.heroTag != null
        ? Hero(tag: widget.heroTag!, child: styledImage)
        : styledImage;

    if (widget.onTap != null || widget.onLongPress != null) {
      return GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: finalWidget,
      );
    }

    return finalWidget;
  }

  Widget _buildImageWidget(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget(context);
    }

    final ImageProvider provider = _getImageProvider();
    final BoxFit boxFit = _mapImageFit(widget.fit);

    return Stack(
      children: <Widget>[
        if (!_imageLoaded) _buildLoadingWidget(context),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Image(
            image: provider,
            width: widget.width,
            height: widget.height,
            fit: boxFit,
            semanticLabel: widget.semanticLabel,
            frameBuilder:
                (
                  BuildContext context,
                  Widget child,
                  int? frame,
                  bool wasSynchronouslyLoaded,
                ) {
                  _handleFrameBuilder(
                    context,
                    child,
                    frame,
                    wasSynchronouslyLoaded,
                  );
                  return child;
                },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) =>
                    _handleErrorBuilder(context, error, stackTrace) ??
                    const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _buildStyledContainer(
    BuildContext context,
    Widget child,
    ColorScheme colorScheme,
  ) {
    final BorderRadius? effectiveBorderRadius =
        widget.shape == CorpoImageShape.circle
        ? null
        : widget.borderRadius ?? _getDefaultBorderRadius();

    final BoxDecoration decoration = BoxDecoration(
      color: widget.backgroundColor ?? colorScheme.surface,
      borderRadius: effectiveBorderRadius,
      shape: widget.shape == CorpoImageShape.circle
          ? BoxShape.circle
          : BoxShape.rectangle,
      border: widget.borderWidth > 0
          ? Border.all(
              color: widget.borderColor ?? colorScheme.outline,
              width: widget.borderWidth,
            )
          : null,
    );

    final Widget container = Container(
      width: widget.width,
      height: widget.height,
      decoration: decoration,
      clipBehavior: Clip.antiAlias,
      child: child,
    );

    if (widget.elevation > 0) {
      if (widget.shape == CorpoImageShape.circle) {
        return Material(
          elevation: widget.elevation,
          shape: const CircleBorder(),
          child: container,
        );
      } else {
        return Material(
          elevation: widget.elevation,
          borderRadius: effectiveBorderRadius,
          child: container,
        );
      }
    }

    return container;
  }

  Widget _buildLoadingWidget(BuildContext context) {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return switch (widget.loadingBehavior) {
      CorpoImageLoadingBehavior.placeholder =>
        widget.placeholder ?? _buildDefaultPlaceholder(context),
      CorpoImageLoadingBehavior.skeleton => _buildSkeletonLoader(context),
      CorpoImageLoadingBehavior.progressive => _buildProgressiveLoader(context),
      CorpoImageLoadingBehavior.none => const SizedBox.shrink(),
    };
  }

  Widget _buildErrorWidget(BuildContext context) {
    if (widget.errorWidget != null) {
      return widget.errorWidget!;
    }

    return _buildDefaultErrorWidget(context);
  }

  Widget _buildDefaultPlaceholder(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: widget.width,
      height: widget.height,
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_outlined,
        size: 48,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildDefaultErrorWidget(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: widget.width,
      height: widget.height,
      color: colorScheme.errorContainer,
      child: Icon(
        Icons.broken_image_outlined,
        size: 48,
        color: colorScheme.onErrorContainer,
      ),
    );
  }

  Widget _buildSkeletonLoader(BuildContext context) => Container(
    width: widget.width,
    height: widget.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.grey.shade300,
          Colors.grey.shade100,
          Colors.grey.shade300,
        ],
        stops: const <double>[0, 0.5, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );

  Widget _buildProgressiveLoader(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: widget.width,
      height: widget.height,
      color: colorScheme.surfaceContainerHighest,
      child: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  ImageProvider _getImageProvider() => switch (widget._imageType) {
    _CorpoImageType.network => NetworkImage(widget.imageUrl!),
    _CorpoImageType.asset => AssetImage(widget.assetPath!),
    _CorpoImageType.memory => MemoryImage(widget.imageData!),
    _CorpoImageType.provider => widget.imageProvider!,
  };

  BoxFit _mapImageFit(CorpoImageFit fit) => switch (fit) {
    CorpoImageFit.cover => BoxFit.cover,
    CorpoImageFit.contain => BoxFit.contain,
    CorpoImageFit.fill => BoxFit.fill,
    CorpoImageFit.fitWidth => BoxFit.fitWidth,
    CorpoImageFit.fitHeight => BoxFit.fitHeight,
    CorpoImageFit.none => BoxFit.none,
    CorpoImageFit.scaleDown => BoxFit.scaleDown,
  };

  BorderRadius? _getDefaultBorderRadius() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    return switch (widget.shape) {
      CorpoImageShape.rounded => BorderRadius.circular(tokens.borderRadius),
      CorpoImageShape.rectangle => null,
      CorpoImageShape.circle => null,
    };
  }

  Widget? _handleFrameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (frame != null && !_imageLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _imageLoaded = true;
          });
          _fadeController.forward();
        }
      });
    }
    return child;
  }

  Widget? _handleErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    });
    return null;
  }
}
