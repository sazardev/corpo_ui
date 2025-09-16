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

import '../../design_tokens.dart';

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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: tokens.baseFontSize,
              fontFamily: tokens.fontFamily,
              color: isDark
                  ? tokens.textPrimary.withOpacity(0.9)
                  : tokens.textPrimary,
            ),
          ),
          SizedBox(height: tokens.spacing1x),
        ],
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          style: TextStyle(
            fontSize: tokens.baseFontSize,
            fontFamily: tokens.fontFamily,
            color: isDark
                ? tokens.textPrimary.withOpacity(0.9)
                : tokens.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: TextStyle(
              fontSize: tokens.baseFontSize,
              fontFamily: tokens.fontFamily,
              color: isDark
                  ? tokens.textSecondary.withOpacity(0.6)
                  : tokens.textSecondary.withOpacity(0.8),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: isDark
                        ? tokens.textSecondary.withOpacity(0.8)
                        : tokens.textSecondary,
                  )
                : null,
            suffixIcon: widget.clearButton && _hasText
                ? IconButton(
                    onPressed: _clearText,
                    icon: Icon(
                      Icons.clear,
                      color: isDark
                          ? tokens.textSecondary.withOpacity(0.8)
                          : tokens.textSecondary,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
              borderSide: BorderSide(
                color: isDark
                    ? tokens.textSecondary.withOpacity(0.5)
                    : tokens.textSecondary.withOpacity(0.4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
              borderSide: BorderSide(
                color: isDark
                    ? tokens.textSecondary.withOpacity(0.5)
                    : tokens.textSecondary.withOpacity(0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
              borderSide: BorderSide(color: tokens.primaryColor, width: 2),
            ),
            filled: true,
            fillColor: isDark
                ? tokens.textSecondary.withOpacity(0.05)
                : tokens.surfaceColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: tokens.spacing4x,
              vertical: tokens.spacing2x,
            ),
          ),
        ),
      ],
    );
  }
}
