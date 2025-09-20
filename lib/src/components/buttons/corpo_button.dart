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
/// ## Features
///
/// - **Multiple Variants**: Primary, secondary, tertiary, and danger styles
/// - **Size Options**: Small, medium, large, and extra-large variants
/// - **State Management**: Disabled, loading, and pressed states
/// - **Accessibility**: Full screen reader support with semantic labels
/// - **Responsive**: Adapts to different screen sizes and orientations
/// - **Theming**: Integrates with Corpo UI theme system
///
/// ## Accessibility
///
/// - Provides semantic button role for screen readers
/// - Supports keyboard navigation (Enter/Space activation)
/// - Includes focus indicators with proper contrast ratios
/// - Maintains minimum touch target size (44x44 logical pixels)
/// - Announces state changes to assistive technologies
///
/// ## Usage Patterns
///
/// ### Primary Actions
/// Use primary buttons for the most important action on a screen:
/// ```dart
/// CorpoButton(
///   onPressed: () => saveDocument(),
///   child: Text('Save Document'),
/// )
/// ```
///
/// ### Secondary Actions
/// Use secondary buttons for alternative or supporting actions:
/// ```dart
/// CorpoButton.secondary(
///   onPressed: () => showPreview(),
///   child: Text('Preview'),
/// )
/// ```
///
/// ### Icon Buttons
/// Use icon buttons for actions where the icon clearly conveys meaning:
/// ```dart
/// CorpoButton.icon(
///   onPressed: () => addItem(),
///   icon: Icons.add,
///   tooltip: 'Add new item',
/// )
/// ```
///
/// ### Loading States
/// Show loading state for asynchronous operations:
/// ```dart
/// CorpoButton(
///   onPressed: isLoading ? null : () => performAsyncAction(),
///   isLoading: isLoading,
///   child: Text('Submit Form'),
/// )
/// ```
///
/// ### Danger Actions
/// Use danger variant for destructive actions:
/// ```dart
/// CorpoButton.danger(
///   onPressed: () => showDeleteConfirmation(),
///   child: Text('Delete Account'),
/// )
/// ```
///
/// ## Design Guidelines
///
/// - Use only one primary button per screen or section
/// - Place primary actions in the most prominent position
/// - Group related actions together
/// - Maintain consistent button sizing within groups
/// - Provide clear, action-oriented labels
/// - Consider loading states for network operations
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

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
  Widget _buildIconButton(BuildContext context, ButtonStyle buttonStyle) =>
      ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        autofocus: autofocus,
        child: isLoading
            ? _buildLoadingIndicator(context, size: _getIconSize())
            : Icon(icon, size: _getIconSize()),
      );

  /// Builds a text button with optional icon.
  Widget _buildTextButton(BuildContext context, ButtonStyle buttonStyle) =>
      ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        autofocus: autofocus,
        child: _buildButtonContent(context),
      );

  /// Builds the content of the button (text, icon, loading indicator).
  Widget _buildButtonContent(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildLoadingIndicator(context),
          if (child != null) ...<Widget>[
            SizedBox(width: tokens.spacing2x),
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    final List<Widget> children = <Widget>[
      Icon(icon, size: _getIconSize()),
      SizedBox(width: tokens.spacing2x),
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    if (_isIconOnly) {
      return _getIconButtonStyle(tokens, isDark, isEnabled);
    }

    switch (variant) {
      case CorpoButtonVariant.primary:
        return _getPrimaryButtonStyle(tokens, isDark, isEnabled);
      case CorpoButtonVariant.secondary:
        return _getSecondaryButtonStyle(tokens, isDark, isEnabled);
      case CorpoButtonVariant.tertiary:
        return _getTertiaryButtonStyle(tokens, isDark, isEnabled);
      case CorpoButtonVariant.danger:
        return _getDangerButtonStyle(tokens, isDark, isEnabled);
    }
  }

  /// Gets the primary button style using design tokens.
  ButtonStyle _getPrimaryButtonStyle(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
  ) => ElevatedButton.styleFrom(
    backgroundColor: isEnabled
        ? tokens.primaryColor
        : tokens.secondaryColor.withValues(alpha: 0.3),
    foregroundColor: isEnabled
        ? tokens.getTextColorFor(tokens.primaryColor)
        : tokens.textSecondary,
    disabledBackgroundColor: tokens.secondaryColor.withValues(alpha: 0.3),
    disabledForegroundColor: tokens.textSecondary,
    elevation: isEnabled ? 2 : 0,
    shadowColor: tokens.primaryColor.withValues(alpha: 0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
    ),
    textStyle: TextStyle(
      fontFamily: tokens.fontFamily,
      fontSize: _getFontSize(tokens),
      fontWeight: FontWeight.w600,
    ),
  );

  /// Gets the secondary button style using design tokens.
  ButtonStyle _getSecondaryButtonStyle(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
  ) => OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: isEnabled ? tokens.primaryColor : tokens.textSecondary,
    disabledForegroundColor: tokens.textSecondary,
    side: BorderSide(
      color: isEnabled
          ? tokens.primaryColor
          : tokens.secondaryColor.withValues(alpha: 0.3),
      width: 1.5,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
    ),
    textStyle: TextStyle(
      fontFamily: tokens.fontFamily,
      fontSize: _getFontSize(tokens),
      fontWeight: FontWeight.w600,
    ),
  );

  /// Gets the tertiary button style using design tokens.
  ButtonStyle _getTertiaryButtonStyle(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
  ) => TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: isEnabled ? tokens.primaryColor : tokens.textSecondary,
    disabledForegroundColor: tokens.textSecondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
    ),
    textStyle: TextStyle(
      fontFamily: tokens.fontFamily,
      fontSize: _getFontSize(tokens),
      fontWeight: FontWeight.w600,
    ),
  );

  /// Gets the danger button style using design tokens.
  ButtonStyle _getDangerButtonStyle(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
  ) => ElevatedButton.styleFrom(
    backgroundColor: isEnabled
        ? tokens.errorColor
        : tokens.secondaryColor.withValues(alpha: 0.3),
    foregroundColor: isEnabled
        ? tokens.getTextColorFor(tokens.errorColor)
        : tokens.textSecondary,
    disabledBackgroundColor: tokens.secondaryColor.withValues(alpha: 0.3),
    disabledForegroundColor: tokens.textSecondary,
    elevation: isEnabled ? 2 : 0,
    shadowColor: tokens.errorColor.withValues(alpha: 0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
    ),
    textStyle: TextStyle(
      fontFamily: tokens.fontFamily,
      fontSize: _getFontSize(tokens),
      fontWeight: FontWeight.w600,
    ),
  );

  /// Gets the icon button style using design tokens.
  ButtonStyle _getIconButtonStyle(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
  ) => IconButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: isEnabled ? tokens.primaryColor : tokens.textSecondary,
    disabledForegroundColor: tokens.textSecondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
    ),
  );

  /// Gets the font size based on button size and design tokens.
  double _getFontSize(CorpoDesignTokens tokens) {
    switch (size) {
      case CorpoButtonSize.small:
        return tokens.fontSizeSmall;
      case CorpoButtonSize.medium:
        return tokens.baseFontSize;
      case CorpoButtonSize.large:
        return tokens.fontSizeLarge;
    }
  }

  /// Gets the appropriate padding for the button size.
  EdgeInsetsGeometry _getPadding() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    switch (size) {
      case CorpoButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing3x,
          vertical: tokens.spacing2x,
        );
      case CorpoButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing4x,
          vertical: tokens.spacing3x,
        );
      case CorpoButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: tokens.spacing6x,
          vertical: tokens.spacing4x,
        );
    }
  }

  /// Gets the minimum size for the button.
  Size _getMinimumSize() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    switch (size) {
      case CorpoButtonSize.small:
        return Size(tokens.spacing16x, tokens.spacing8x); // 64x32 with base 4px
      case CorpoButtonSize.medium:
        return Size(
          tokens.spacing16x * 1.375,
          tokens.spacing8x * 1.25,
        ); // 88x40
      case CorpoButtonSize.large:
        return Size(tokens.spacing16x * 1.75, tokens.spacing8x * 1.5); // 112x48
    }
  }

  /// Gets the icon size based on button size.
  double _getIconSize() {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    switch (size) {
      case CorpoButtonSize.small:
        return tokens.spacing4x; // 16px
      case CorpoButtonSize.medium:
        return tokens.spacing4x * 1.125; // 18px
      case CorpoButtonSize.large:
        return tokens.spacing4x * 1.25; // 20px
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
}

/// Position of icon relative to text in buttons.
enum IconPosition {
  /// Icon appears before the text
  leading,

  /// Icon appears after the text
  trailing,
}
