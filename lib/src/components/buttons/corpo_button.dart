/// A comprehensive button component for the Corpo UI design system.
///
/// CorpoButton provides consistent button styling and behavior across
/// corporate applications, with support for multiple variants, states,
/// and accessibility features.
///
/// The component follows corporate design principles with clear visual
/// hierarchy, professional styling, and comprehensive interaction states
/// including hover, focus, pressed, and disabled.
///
/// Example usage:
/// ```dart
/// CorpoButton(
///   onPressed: () => print('Primary action'),
///   child: Text('Primary Button'),
/// )
///
/// CorpoButton.secondary(
///   onPressed: () => print('Secondary action'),
///   child: Text('Secondary Button'),
/// )
///
/// CorpoButton.icon(
///   onPressed: () => print('Icon action'),
///   icon: Icons.add,
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/spacing.dart';
import 'button_style.dart';

/// Button variants for different use cases.
///
/// Determines the visual style and prominence of the button
/// within the interface hierarchy.
enum CorpoButtonVariant {
  /// Primary button for main call-to-action
  primary,

  /// Secondary button for secondary actions
  secondary,

  /// Tertiary button for minimal actions
  tertiary,

  /// Danger button for destructive actions
  danger,
}

/// Button sizes for different layout contexts.
///
/// Provides consistent sizing options optimized for
/// different use cases and screen densities.
enum CorpoButtonSize {
  /// Small button for compact layouts
  small,

  /// Medium button for standard use (default)
  medium,

  /// Large button for prominent actions
  large,
}

/// A comprehensive button widget following Corpo UI design principles.
///
/// This component provides consistent styling, behavior, and accessibility
/// features across all button variants. It supports text, icon, and
/// combined text+icon configurations.
class CorpoButton extends StatelessWidget {
  /// Creates a Corpo UI button.
  ///
  /// The [onPressed] callback is called when the button is tapped.
  /// If [onPressed] is null, the button will be disabled.
  const CorpoButton({
    required this.onPressed,
    required this.child,
    this.variant = CorpoButtonVariant.primary,
    this.size = CorpoButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.fullWidth = false,
    this.autofocus = false,
    this.tooltip,
    super.key,
  }) : _isIconOnly = false;

  /// Convenience constructor for primary buttons.
  const CorpoButton.primary({
    required this.onPressed,
    required this.child,
    this.size = CorpoButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.fullWidth = false,
    this.autofocus = false,
    this.tooltip,
    super.key,
  }) : variant = CorpoButtonVariant.primary,
       _isIconOnly = false;

  /// Convenience constructor for secondary buttons.
  const CorpoButton.secondary({
    required this.onPressed,
    required this.child,
    this.size = CorpoButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.fullWidth = false,
    this.autofocus = false,
    this.tooltip,
    super.key,
  }) : variant = CorpoButtonVariant.secondary,
       _isIconOnly = false;

  /// Convenience constructor for tertiary buttons.
  const CorpoButton.tertiary({
    required this.onPressed,
    required this.child,
    this.size = CorpoButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.fullWidth = false,
    this.autofocus = false,
    this.tooltip,
    super.key,
  }) : variant = CorpoButtonVariant.tertiary,
       _isIconOnly = false;

  /// Convenience constructor for danger buttons.
  const CorpoButton.danger({
    required this.onPressed,
    required this.child,
    this.size = CorpoButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.fullWidth = false,
    this.autofocus = false,
    this.tooltip,
    super.key,
  }) : variant = CorpoButtonVariant.danger,
       _isIconOnly = false;

  /// Convenience constructor for icon-only buttons.
  const CorpoButton.icon({
    required this.onPressed,
    required IconData icon,
    this.size = CorpoButtonSize.medium,
    this.isLoading = false,
    this.autofocus = false,
    this.tooltip,
    super.key,
  }) : variant = CorpoButtonVariant.tertiary,
       child = null,
       icon = icon,
       iconPosition = IconPosition.leading,
       fullWidth = false,
       _isIconOnly = true;

  /// Called when the button is tapped.
  ///
  /// If null, the button will be disabled and will not respond to touch.
  final VoidCallback? onPressed;

  /// The widget to display inside the button.
  ///
  /// Typically a [Text] widget, but can be any widget.
  /// For icon-only buttons, this should be null.
  final Widget? child;

  /// The button variant determining visual style.
  final CorpoButtonVariant variant;

  /// The button size determining dimensions and padding.
  final CorpoButtonSize size;

  /// Whether the button is in a loading state.
  ///
  /// When true, displays a loading indicator and disables interaction.
  final bool isLoading;

  /// Optional icon to display in the button.
  ///
  /// For icon-only buttons, this is required. For text buttons,
  /// this is optional and will be displayed alongside the text.
  final IconData? icon;

  /// Position of the icon relative to the text.
  final IconPosition iconPosition;

  /// Whether the button should expand to fill available width.
  final bool fullWidth;

  /// Whether this button should be focused initially.
  final bool autofocus;

  /// Optional tooltip text to display on hover.
  final String? tooltip;

  /// Internal flag to determine if this is an icon-only button.
  final bool _isIconOnly;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final bool isEnabled = onPressed != null && !isLoading;

    final ButtonStyle buttonStyle = _getButtonStyle(isDark, isEnabled);
    final EdgeInsetsGeometry padding = _getPadding();
    final Size minimumSize = _getMinimumSize();

    Widget button = _buildButton(context, buttonStyle, padding, minimumSize);

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    return button;
  }

  /// Builds the button widget with appropriate content.
  Widget _buildButton(
    BuildContext context,
    ButtonStyle buttonStyle,
    EdgeInsetsGeometry padding,
    Size minimumSize,
  ) {
    final ButtonStyle effectiveStyle = buttonStyle.copyWith(
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(padding),
      minimumSize: WidgetStateProperty.all<Size>(minimumSize),
    );

    if (_isIconOnly) {
      return _buildIconButton(context, effectiveStyle);
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: _buildTextButton(context, effectiveStyle),
      );
    }

    return _buildTextButton(context, effectiveStyle);
  }

  /// Builds an icon-only button.
  Widget _buildIconButton(BuildContext context, ButtonStyle buttonStyle) => ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      autofocus: autofocus,
      child: isLoading
          ? _buildLoadingIndicator(context, size: _getIconSize())
          : Icon(icon, size: _getIconSize()),
    );

  /// Builds a text button with optional icon.
  Widget _buildTextButton(BuildContext context, ButtonStyle buttonStyle) => ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      autofocus: autofocus,
      child: _buildButtonContent(context),
    );

  /// Builds the content of the button (text, icon, loading indicator).
  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildLoadingIndicator(context),
          if (child != null) ...<Widget>[
            const SizedBox(width: CorpoSpacing.small),
            child!,
          ],
        ],
      );
    }

    if (icon == null || child == null) {
      return child ?? Icon(icon, size: _getIconSize());
    }

    return _buildIconTextContent();
  }

  /// Builds content with both icon and text.
  Widget _buildIconTextContent() {
    final List<Widget> children = <Widget>[
      Icon(icon, size: _getIconSize()),
      const SizedBox(width: CorpoSpacing.small),
      child!,
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconPosition == IconPosition.leading
          ? children
          : children.reversed.toList(),
    );
  }

  /// Builds a loading indicator appropriate for the button size.
  Widget _buildLoadingIndicator(BuildContext context, {double? size}) {
    final ThemeData theme = Theme.of(context);
    final Color? indicatorColor = theme
        .elevatedButtonTheme
        .style
        ?.foregroundColor
        ?.resolve(<WidgetState>{});

    return SizedBox(
      width: size ?? _getLoadingIndicatorSize(),
      height: size ?? _getLoadingIndicatorSize(),
      child: CircularProgressIndicator(strokeWidth: 2, color: indicatorColor),
    );
  }

  /// Gets the appropriate button style for the variant and theme.
  ButtonStyle _getButtonStyle(bool isDark, bool isEnabled) {
    if (_isIconOnly) {
      return CorpoButtonStyle.icon(
        isDark: isDark,
        isEnabled: isEnabled,
        size: _getIconButtonSize(),
      );
    }

    switch (variant) {
      case CorpoButtonVariant.primary:
        return CorpoButtonStyle.primary(isDark: isDark, isEnabled: isEnabled);
      case CorpoButtonVariant.secondary:
        return CorpoButtonStyle.secondary(isDark: isDark, isEnabled: isEnabled);
      case CorpoButtonVariant.tertiary:
        return CorpoButtonStyle.tertiary(isDark: isDark, isEnabled: isEnabled);
      case CorpoButtonVariant.danger:
        return CorpoButtonStyle.danger(isDark: isDark, isEnabled: isEnabled);
    }
  }

  /// Gets the appropriate padding for the button size.
  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case CorpoButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.medium,
          vertical: CorpoSpacing.small,
        );
      case CorpoButtonSize.medium:
        return CorpoPadding.medium;
      case CorpoButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.large,
          vertical: CorpoSpacing.medium,
        );
    }
  }

  /// Gets the minimum size for the button.
  Size _getMinimumSize() {
    switch (size) {
      case CorpoButtonSize.small:
        return const Size(64, 32);
      case CorpoButtonSize.medium:
        return const Size(88, 40);
      case CorpoButtonSize.large:
        return const Size(112, 48);
    }
  }

  /// Gets the icon size based on button size.
  double _getIconSize() {
    switch (size) {
      case CorpoButtonSize.small:
        return 16;
      case CorpoButtonSize.medium:
        return 18;
      case CorpoButtonSize.large:
        return 20;
    }
  }

  /// Gets the loading indicator size based on button size.
  double _getLoadingIndicatorSize() {
    switch (size) {
      case CorpoButtonSize.small:
        return 14;
      case CorpoButtonSize.medium:
        return 16;
      case CorpoButtonSize.large:
        return 18;
    }
  }

  /// Gets the icon button size for icon-only buttons.
  double _getIconButtonSize() {
    switch (size) {
      case CorpoButtonSize.small:
        return 32;
      case CorpoButtonSize.medium:
        return 40;
      case CorpoButtonSize.large:
        return 48;
    }
  }
}

/// Position of icon relative to text in buttons.
enum IconPosition {
  /// Icon appears before the text
  leading,

  /// Icon appears after the text
  trailing,
}
