/// A comprehensive avatar component for the Corpo UI design system.
///
/// CorpoAvatar provides consistent user representation across corporate
/// applications, with support for images, initials, status indicators,
/// and various sizing options.
///
/// The component follows corporate design principles with professional
/// styling, accessibility features, and comprehensive fallback handling
/// for missing or invalid images.
///
/// Example usage:
/// ```dart
/// CorpoAvatar(
///   name: 'John Doe',
///   imageUrl: 'https://example.com/avatar.jpg',
///   size: CorpoAvatarSize.medium,
/// )
///
/// CorpoAvatar.initials(
///   'Jane Smith',
///   backgroundColor: CorpoColors.primary500,
/// )
///
/// CorpoAvatar.withStatus(
///   name: 'Bob Wilson',
///   status: CorpoAvatarStatus.online,
///   imageUrl: 'https://example.com/bob.jpg',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Avatar size variants for different contexts.
///
/// Provides consistent sizing options optimized for
/// various use cases and layout contexts.
enum CorpoAvatarSize {
  /// Extra small avatar (24px) for dense layouts
  extraSmall,

  /// Small avatar (32px) for compact elements
  small,

  /// Medium avatar (40px) for standard use (default)
  medium,

  /// Large avatar (56px) for prominent display
  large,

  /// Extra large avatar (80px) for hero elements
  extraLarge,

  /// XXL avatar (120px) for profile pages
  xxLarge,
}

/// Avatar status indicators for user presence.
///
/// Provides visual indicators for user availability
/// and activity status in corporate applications.
enum CorpoAvatarStatus {
  /// User is online and available
  online,

  /// User is away from keyboard
  away,

  /// User is busy or in a meeting
  busy,

  /// User is offline or unavailable
  offline,

  /// User is in do not disturb mode
  doNotDisturb,
}

/// Avatar shape variants for different design needs.
enum CorpoAvatarShape {
  /// Circular avatar (default)
  circle,

  /// Square avatar with rounded corners
  square,
}

/// A comprehensive avatar widget following Corpo UI design principles.
///
/// This component provides consistent user representation with support
/// for images, initials, status indicators, and various styling options.
/// It includes comprehensive fallback handling and accessibility features.
class CorpoAvatar extends StatelessWidget {
  /// Creates a Corpo UI avatar.
  ///
  /// The [name] parameter is used for initials and accessibility.
  /// The [imageUrl] parameter provides the avatar image source.
  const CorpoAvatar({
    required this.name, super.key,
    this.imageUrl,
    this.size = CorpoAvatarSize.medium,
    this.shape = CorpoAvatarShape.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.status,
    this.onTap,
  });

  /// Convenience constructor for initials-only avatars.
  ///
  /// Forces the avatar to display initials without attempting
  /// to load an image, useful for consistent styling.
  const CorpoAvatar.initials(
    this.name, {
    super.key,
    this.size = CorpoAvatarSize.medium,
    this.shape = CorpoAvatarShape.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.status,
    this.onTap,
  }) : imageUrl = null;

  /// Convenience constructor for avatars with status indicators.
  ///
  /// Displays an avatar with a visible status indicator overlay
  /// for user presence and availability information.
  const CorpoAvatar.withStatus({
    required this.name, required this.status, super.key,
    this.imageUrl,
    this.size = CorpoAvatarSize.medium,
    this.shape = CorpoAvatarShape.circle,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  /// The name used for generating initials and accessibility.
  final String name;

  /// The URL of the avatar image.
  ///
  /// If null or fails to load, initials will be displayed instead.
  final String? imageUrl;

  /// The size variant of the avatar.
  final CorpoAvatarSize size;

  /// The shape of the avatar.
  final CorpoAvatarShape shape;

  /// The background color for initials avatars.
  ///
  /// If null, a color will be generated based on the name.
  final Color? backgroundColor;

  /// The text color for initials.
  ///
  /// If null, a contrasting color will be automatically chosen.
  final Color? foregroundColor;

  /// Optional status indicator for user presence.
  final CorpoAvatarStatus? status;

  /// Optional tap handler for interactive avatars.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double avatarSize = _getAvatarSize();
    final Widget avatarContent = _buildAvatarContent(context);

    Widget avatar = SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: avatarContent,
    );

    // Add status indicator if provided
    if (status != null) {
      avatar = _buildAvatarWithStatus(avatar, avatarSize);
    }

    // Add interactive behavior if onTap is provided
    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        borderRadius: _getBorderRadius(avatarSize),
        child: avatar,
      );
    }

    return avatar;
  }

  /// Builds the main avatar content (image or initials).
  Widget _buildAvatarContent(BuildContext context) {
    final double avatarSize = _getAvatarSize();
    final BorderRadius borderRadius = _getBorderRadius(avatarSize);

    // Try to display image if URL is provided
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          imageUrl!,
          width: avatarSize,
          height: avatarSize,
          fit: BoxFit.cover,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
                // Fallback to initials on image load error
                return _buildInitialsAvatar(context, avatarSize, borderRadius);
              },
          loadingBuilder:
              (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) {
                  return child;
                }
                // Show loading placeholder
                return _buildLoadingPlaceholder(avatarSize, borderRadius);
              },
        ),
      );
    }

    // Display initials avatar
    return _buildInitialsAvatar(context, avatarSize, borderRadius);
  }

  /// Builds an initials-based avatar.
  Widget _buildInitialsAvatar(
    BuildContext context,
    double avatarSize,
    BorderRadius borderRadius,
  ) {
    final String initials = _generateInitials(name);
    final Color effectiveBackgroundColor =
        backgroundColor ?? _generateBackgroundColor(name);
    final Color effectiveForegroundColor =
        foregroundColor ?? _getContrastingColor(effectiveBackgroundColor);
    final TextStyle textStyle = _getInitialsTextStyle(avatarSize);

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Text(
          initials,
          style: textStyle.copyWith(color: effectiveForegroundColor),
          semanticsLabel: 'Avatar for $name',
        ),
      ),
    );
  }

  /// Builds a loading placeholder for image avatars.
  Widget _buildLoadingPlaceholder(
    double avatarSize,
    BorderRadius borderRadius,
  ) => Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: CorpoColors.neutral200,
        borderRadius: borderRadius,
      ),
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );

  /// Builds an avatar with status indicator overlay.
  Widget _buildAvatarWithStatus(Widget avatar, double avatarSize) {
    final double statusSize = _getStatusIndicatorSize(avatarSize);
    final Color statusColor = _getStatusColor(status!);

    return Stack(
      children: <Widget>[
        avatar,
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: statusSize,
            height: statusSize,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
              border: Border.all(color: CorpoColors.neutralWhite, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  /// Gets the avatar size in pixels.
  double _getAvatarSize() {
    switch (size) {
      case CorpoAvatarSize.extraSmall:
        return 24;
      case CorpoAvatarSize.small:
        return 32;
      case CorpoAvatarSize.medium:
        return 40;
      case CorpoAvatarSize.large:
        return 56;
      case CorpoAvatarSize.extraLarge:
        return 80;
      case CorpoAvatarSize.xxLarge:
        return 120;
    }
  }

  /// Gets the border radius based on shape and size.
  BorderRadius _getBorderRadius(double avatarSize) {
    switch (shape) {
      case CorpoAvatarShape.circle:
        return BorderRadius.circular(avatarSize / 2);
      case CorpoAvatarShape.square:
        return BorderRadius.circular(CorpoSpacing.small);
    }
  }

  /// Gets the text style for initials based on avatar size.
  TextStyle _getInitialsTextStyle(double avatarSize) {
    if (avatarSize <= 32) {
      return CorpoTypography.labelSmall.copyWith(
        fontWeight: CorpoFontWeight.semiBold,
      );
    } else if (avatarSize <= 56) {
      return CorpoTypography.labelMedium.copyWith(
        fontWeight: CorpoFontWeight.semiBold,
      );
    } else if (avatarSize <= 80) {
      return CorpoTypography.labelLarge.copyWith(
        fontWeight: CorpoFontWeight.semiBold,
      );
    } else {
      return CorpoTypography.heading4.copyWith(
        fontWeight: CorpoFontWeight.semiBold,
      );
    }
  }

  /// Gets the status indicator size based on avatar size.
  double _getStatusIndicatorSize(double avatarSize) {
    if (avatarSize <= 32) {
      return 8;
    } else if (avatarSize <= 56) {
      return 12;
    } else {
      return 16;
    }
  }

  /// Generates initials from a name.
  String _generateInitials(String name) {
    final List<String> words = name.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) {
      return '?';
    }

    if (words.length == 1) {
      // Single word - take first two characters
      final String word = words[0];
      return word.length >= 2
          ? word.substring(0, 2).toUpperCase()
          : word.toUpperCase();
    }

    // Multiple words - take first character of first and last words
    final String firstInitial = words.first.isNotEmpty
        ? words.first[0].toUpperCase()
        : '';
    final String lastInitial = words.last.isNotEmpty
        ? words.last[0].toUpperCase()
        : '';

    return firstInitial + lastInitial;
  }

  /// Generates a background color based on the name for consistency.
  Color _generateBackgroundColor(String name) {
    final List<Color> colors = <Color>[
      CorpoColors.primary500,
      CorpoColors.secondary500,
      CorpoColors.success,
      CorpoColors.info,
      CorpoColors.warning,
      CorpoColors.neutral500,
      CorpoColors.primary600,
      CorpoColors.secondary600,
    ];

    // Use hash code to consistently generate the same color for the same name
    final int hash = name.hashCode;
    final int index = hash.abs() % colors.length;
    return colors[index];
  }

  /// Gets a contrasting color for text based on background color.
  Color _getContrastingColor(Color backgroundColor) {
    // Calculate relative luminance
    final double luminance = backgroundColor.computeLuminance();

    // Return white text for dark backgrounds, dark text for light backgrounds
    return luminance > 0.5 ? CorpoColors.neutral800 : CorpoColors.neutralWhite;
  }

  /// Gets the color for a status indicator.
  Color _getStatusColor(CorpoAvatarStatus status) {
    switch (status) {
      case CorpoAvatarStatus.online:
        return CorpoColors.success;
      case CorpoAvatarStatus.away:
        return CorpoColors.warning;
      case CorpoAvatarStatus.busy:
        return CorpoColors.error;
      case CorpoAvatarStatus.offline:
        return CorpoColors.neutral400;
      case CorpoAvatarStatus.doNotDisturb:
        return CorpoColors.error;
    }
  }
}
