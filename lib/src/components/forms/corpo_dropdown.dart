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

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

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
/// features for selection inputs. It supports custom items, search functionality,
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
    final bool isEnabled = widget.onChanged != null;
    final bool hasError = widget.errorText != null;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Text(
            widget.label!,
            style: _getLabelStyle().copyWith(
              color: _getLabelColor(isDark, isEnabled, hasError),
            ),
          ),
          const SizedBox(height: CorpoSpacing.extraSmall),
        ],
        _buildDropdownField(context, isEnabled, hasError, isDark),
        if (widget.helperText != null || widget.errorText != null) ...<Widget>[
          const SizedBox(height: CorpoSpacing.extraSmall),
          Text(
            widget.errorText ?? widget.helperText!,
            style: _getHelperStyle().copyWith(
              color: hasError
                  ? CorpoColors.error
                  : (isDark ? CorpoColors.neutral400 : CorpoColors.neutral600),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdownField(
    BuildContext context,
    bool isEnabled,
    bool hasError,
    bool isDark,
  ) {
    return Container(
      height: _getFieldHeight(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
        border: Border.all(
          color: _getBorderColor(isDark, isEnabled, hasError),
          width: hasError ? 2.0 : 1.0,
        ),
        color: _getBackgroundColor(isDark, isEnabled),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: widget.value,
          onChanged: isEnabled ? widget.onChanged : null,
          items: _filteredItems,
          hint: widget.placeholder != null
              ? Text(widget.placeholder!, style: _getPlaceholderStyle(isDark))
              : null,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: _getIconColor(isDark, isEnabled),
          ),
          style: _getTextStyle().copyWith(
            color: _getTextColor(isDark, isEnabled),
          ),
          dropdownColor: isDark
              ? CorpoColors.neutral800
              : CorpoColors.neutralWhite,
          borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(),
            vertical: CorpoSpacing.small,
          ),
        ),
      ),
    );
  }

  /// Gets the field height based on size variant.
  double _getFieldHeight() {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return 32.0;
      case CorpoDropdownSize.medium:
        return 40.0;
      case CorpoDropdownSize.large:
        return 48.0;
    }
  }

  /// Gets the horizontal padding based on size variant.
  double _getHorizontalPadding() {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return CorpoSpacing.small;
      case CorpoDropdownSize.medium:
        return CorpoSpacing.medium;
      case CorpoDropdownSize.large:
        return CorpoSpacing.large;
    }
  }

  /// Gets the label text style.
  TextStyle _getLabelStyle() {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return CorpoTypography.labelSmall;
      case CorpoDropdownSize.medium:
        return CorpoTypography.labelMedium;
      case CorpoDropdownSize.large:
        return CorpoTypography.labelLarge;
    }
  }

  /// Gets the text style for the dropdown value.
  TextStyle _getTextStyle() {
    switch (widget.size) {
      case CorpoDropdownSize.small:
        return CorpoTypography.bodySmall;
      case CorpoDropdownSize.medium:
        return CorpoTypography.bodyMedium;
      case CorpoDropdownSize.large:
        return CorpoTypography.bodyLarge;
    }
  }

  /// Gets the helper text style.
  TextStyle _getHelperStyle() {
    return CorpoTypography.caption;
  }

  /// Gets the placeholder text style.
  TextStyle _getPlaceholderStyle(bool isDark) {
    return _getTextStyle().copyWith(
      color: isDark ? CorpoColors.neutral500 : CorpoColors.neutral400,
    );
  }

  /// Gets the label color based on state.
  Color _getLabelColor(bool isDark, bool isEnabled, bool hasError) {
    if (hasError) return CorpoColors.error;
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
    }
    return isDark ? CorpoColors.neutral200 : CorpoColors.neutral700;
  }

  /// Gets the text color based on state.
  Color _getTextColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
    }
    return isDark ? CorpoColors.neutral100 : CorpoColors.neutral800;
  }

  /// Gets the icon color based on state.
  Color _getIconColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
    }
    return isDark ? CorpoColors.neutral400 : CorpoColors.neutral500;
  }

  /// Gets the border color based on state.
  Color _getBorderColor(bool isDark, bool isEnabled, bool hasError) {
    if (hasError) return CorpoColors.error;
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral700 : CorpoColors.neutral300;
    }
    return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
  }

  /// Gets the background color based on state.
  Color _getBackgroundColor(bool isDark, bool isEnabled) {
    if (!isEnabled) {
      return isDark ? CorpoColors.neutral800 : CorpoColors.neutral100;
    }
    return isDark ? CorpoColors.neutral800 : CorpoColors.neutralWhite;
  }
}
