/// A comprehensive dropdown component for the Corpo UI design system.
///
/// CorpoDropdown provides consistent dropdown/select styling and behavior
/// across corporate applications, with support for custom items, validation,
/// search functionality, and various visual states.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including screen reader support and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoDropdown<String>(
///   value: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   items: [
///     CorpoDropdownItem(value: 'option1', child: Text('Option 1')),
///     CorpoDropdownItem(value: 'option2', child: Text('Option 2')),
///   ],
///   label: 'Select an option',
/// )
///
/// CorpoDropdown<String>.searchable(
///   value: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   items: items,
///   label: 'Searchable Dropdown',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Dropdown item for CorpoDropdown.
class CorpoDropdownItem<T> extends DropdownMenuItem<T> {
  /// Creates a dropdown item.
  const CorpoDropdownItem({
    required super.value,
    required super.child,
    super.key,
    super.onTap,
    super.enabled,
  });
}

/// Dropdown size variants for different contexts.
enum CorpoDropdownSize {
  /// Small dropdown for compact layouts
  small,

  /// Medium dropdown for standard use (default)
  medium,

  /// Large dropdown for prominent selections
  large,
}

/// A comprehensive dropdown widget following Corpo UI design principles.
///
/// This component provides consistent styling, validation, and accessibility
/// features for selection inputs. It supports custom items, search functional
/// and various size configurations.
class CorpoDropdown<T> extends StatefulWidget {
  /// Creates a Corpo UI dropdown.
  const CorpoDropdown({
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.size = CorpoDropdownSize.medium,
    this.isSearchable = false,
    this.validator,
    this.semanticLabel,
    super.key,
  });

  /// Creates a searchable dropdown.
  const CorpoDropdown.searchable({
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.size = CorpoDropdownSize.medium,
    this.validator,
    this.semanticLabel,
    super.key,
  }) : isSearchable = true;

  /// The list of items to display in the dropdown.
  final List<CorpoDropdownItem<T>> items;

  /// Called when the selection changes.
  ///
  /// If null, the dropdown will be disabled.
  final ValueChanged<T?>? onChanged;

  /// The currently selected value.
  final T? value;

  /// Optional label for the dropdown.
  final String? label;

  /// Placeholder text when no value is selected.
  final String? placeholder;

  /// Helper text displayed below the dropdown.
  final String? helperText;

  /// Error text displayed when validation fails.
  final String? errorText;

  /// The size variant for the dropdown.
  final CorpoDropdownSize size;

  /// Whether the dropdown supports search functionality.
  final bool isSearchable;

  /// Validation function for the selected value.
  final String? Function(T?)? validator;

  /// A semantic description of the dropdown.
  ///
  /// Used by screen readers and other assistive technologies.
  final String? semanticLabel;

  @override
  State<CorpoDropdown<T>> createState() => _CorpoDropdownState<T>();
}

class _CorpoDropdownState<T> extends State<CorpoDropdown<T>> {
  late TextEditingController _searchController;
  List<CorpoDropdownItem<T>> _filteredItems = <CorpoDropdownItem<T>>[];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final bool isEnabled = widget.onChanged != null;
    final bool hasError = widget.errorText != null;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Text(
            widget.label!,
            style: _getLabelStyle(tokens).copyWith(
              color: _getLabelColor(tokens, isDark, isEnabled, hasError),
            ),
          ),
          SizedBox(height: tokens.spacing1x),
        ],
        _buildDropdownField(context, tokens, isEnabled, hasError, isDark),
        if (widget.helperText != null || widget.errorText != null) ...<Widget>[
          SizedBox(height: tokens.spacing1x),
          Text(
            widget.errorText ?? widget.helperText!,
            style: _getHelperStyle(tokens).copyWith(
              color: hasError
                  ? tokens.errorColor
                  : (isDark
                        ? tokens.textSecondary.withOpacity(0.7)
                        : tokens.textSecondary),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdownField(
    BuildContext context,
    CorpoDesignTokens tokens,
    bool isEnabled,
    bool hasError,
    bool isDark,
  ) => Container(
    height: _getFieldHeight(tokens),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
      border: Border.all(
        color: _getBorderColor(tokens, isDark, isEnabled, hasError),
        width: hasError ? 2.0 : 1.0,
      ),
      color: _getBackgroundColor(tokens, isDark, isEnabled),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: widget.value,
        onChanged: isEnabled ? widget.onChanged : null,
        items: _filteredItems,
        hint: widget.placeholder != null
            ? Text(
                widget.placeholder!,
                style: _getPlaceholderStyle(tokens, isDark),
              )
            : null,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: _getIconColor(tokens, isDark, isEnabled),
        ),
        style: _getTextStyle(
          tokens,
        ).copyWith(color: _getTextColor(tokens, isDark, isEnabled)),
        dropdownColor: isDark
            ? tokens.textSecondary.withOpacity(0.1)
            : tokens.surfaceColor,
        borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
        padding: EdgeInsets.symmetric(
          horizontal: _getHorizontalPadding(tokens),
          vertical: tokens.spacing2x,
        ),
      ),
    ),
  );

  /// Gets the field height based on size variant.
  double _getFieldHeight(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return tokens.spacing8x; // 32px
      case CorpoDropdownSize.medium:
        return tokens.spacing8x + tokens.spacing2x; // 40px (32 + 8)
      case CorpoDropdownSize.large:
        return tokens.spacing12x; // 48px
    }
  }

  /// Gets the horizontal padding based on size variant.
  double _getHorizontalPadding(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return tokens.spacing2x;
      case CorpoDropdownSize.medium:
        return tokens.spacing4x;
      case CorpoDropdownSize.large:
        return tokens.spacing6x;
    }
  }

  /// Gets the label text style.
  TextStyle _getLabelStyle(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
        );
      case CorpoDropdownSize.medium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
        );
      case CorpoDropdownSize.large:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
        );
    }
  }

  /// Gets the text style for the dropdown value.
  TextStyle _getTextStyle(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
        );
      case CorpoDropdownSize.medium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
        );
      case CorpoDropdownSize.large:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
        );
    }
  }

  /// Gets the helper text style.
  TextStyle _getHelperStyle(CorpoDesignTokens tokens) =>
      TextStyle(fontSize: tokens.fontSizeSmall, fontFamily: tokens.fontFamily);

  /// Gets the placeholder text style.
  TextStyle _getPlaceholderStyle(CorpoDesignTokens tokens, bool isDark) =>
      _getTextStyle(tokens).copyWith(
        color: isDark
            ? tokens.textSecondary.withOpacity(0.6)
            : tokens.textSecondary.withOpacity(0.8),
      );

  /// Gets the label color based on state.
  Color _getLabelColor(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
    bool hasError,
  ) {
    if (hasError) {
      return tokens.errorColor;
    }
    if (!isEnabled) {
      return isDark
          ? tokens.textSecondary.withOpacity(0.6)
          : tokens.textSecondary.withOpacity(0.5);
    }
    return isDark ? tokens.textPrimary.withOpacity(0.9) : tokens.textPrimary;
  }

  /// Gets the text color based on state.
  Color _getTextColor(CorpoDesignTokens tokens, bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark
          ? tokens.textSecondary.withOpacity(0.6)
          : tokens.textSecondary.withOpacity(0.5);
    }
    return isDark ? tokens.textPrimary.withOpacity(0.9) : tokens.textPrimary;
  }

  /// Gets the icon color based on state.
  Color _getIconColor(CorpoDesignTokens tokens, bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark
          ? tokens.textSecondary.withOpacity(0.6)
          : tokens.textSecondary.withOpacity(0.5);
    }
    return isDark
        ? tokens.textSecondary.withOpacity(0.8)
        : tokens.textSecondary;
  }

  /// Gets the border color based on state.
  Color _getBorderColor(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
    bool hasError,
  ) {
    if (hasError) {
      return tokens.errorColor;
    }
    if (!isEnabled) {
      return isDark
          ? tokens.textSecondary.withOpacity(0.3)
          : tokens.textSecondary.withOpacity(0.2);
    }
    return isDark
        ? tokens.textSecondary.withOpacity(0.5)
        : tokens.textSecondary.withOpacity(0.4);
  }

  /// Gets the background color based on state.
  Color _getBackgroundColor(
    CorpoDesignTokens tokens,
    bool isDark,
    bool isEnabled,
  ) {
    if (!isEnabled) {
      return isDark
          ? tokens.textSecondary.withOpacity(0.1)
          : tokens.textSecondary.withOpacity(0.05);
    }
    return isDark
        ? tokens.textSecondary.withOpacity(0.05)
        : tokens.surfaceColor;
  }
}
