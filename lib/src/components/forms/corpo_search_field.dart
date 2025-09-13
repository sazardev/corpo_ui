/// A comprehensive search field component for the Corpo UI design system.
///
/// CorpoSearchField provides consistent search input styling and behavior
/// across corporate applications, with support for suggestions, filters,
/// and various visual states.
///
/// Example usage:
/// ```dart
/// CorpoSearchField(
///   onChanged: (value) => performSearch(value),
///   placeholder: 'Search products...',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// A search field widget following Corpo UI design principles.
class CorpoSearchField extends StatefulWidget {
  /// Creates a Corpo UI search field.
  const CorpoSearchField({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.placeholder = 'Search...',
    this.label,
    this.prefixIcon = Icons.search,
    this.clearButton = true,
    super.key,
  });

  /// Text editing controller for the search field.
  final TextEditingController? controller;

  /// Called when the search text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the search is submitted.
  final ValueChanged<String>? onSubmitted;

  /// Placeholder text for the search field.
  final String placeholder;

  /// Optional label for the search field.
  final String? label;

  /// Icon to show at the beginning of the field.
  final IconData? prefixIcon;

  /// Whether to show a clear button.
  final bool clearButton;

  @override
  State<CorpoSearchField> createState() => _CorpoSearchFieldState();
}

class _CorpoSearchFieldState extends State<CorpoSearchField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final bool hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Text(
            widget.label!,
            style: CorpoTypography.labelMedium.copyWith(
              color: isDark ? CorpoColors.neutral200 : CorpoColors.neutral700,
            ),
          ),
          const SizedBox(height: CorpoSpacing.extraSmall),
        ],
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          style: CorpoTypography.bodyMedium.copyWith(
            color: isDark ? CorpoColors.neutral100 : CorpoColors.neutral800,
          ),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: CorpoTypography.bodyMedium.copyWith(
              color: isDark ? CorpoColors.neutral500 : CorpoColors.neutral400,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: isDark
                        ? CorpoColors.neutral400
                        : CorpoColors.neutral500,
                  )
                : null,
            suffixIcon: widget.clearButton && _hasText
                ? IconButton(
                    onPressed: _clearText,
                    icon: Icon(
                      Icons.clear,
                      color: isDark
                          ? CorpoColors.neutral400
                          : CorpoColors.neutral500,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
              borderSide: BorderSide(
                color: isDark ? CorpoColors.neutral600 : CorpoColors.neutral400,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
              borderSide: BorderSide(
                color: isDark ? CorpoColors.neutral600 : CorpoColors.neutral400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CorpoSpacing.extraSmall),
              borderSide: const BorderSide(
                color: CorpoColors.primary500,
                width: 2.0,
              ),
            ),
            filled: true,
            fillColor: isDark
                ? CorpoColors.neutral800
                : CorpoColors.neutralWhite,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: CorpoSpacing.medium,
              vertical: CorpoSpacing.small,
            ),
          ),
        ),
      ],
    );
  }
}
