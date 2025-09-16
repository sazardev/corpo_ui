/// A comprehensive date picker component for the Corpo UI design system.
///
/// CorpoDatePicker provides consistent date selection styling and behavior
/// across corporate applications, with support for validation, date ranges,
/// and various visual states.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including screen reader support and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoDatePicker(
///   selectedDate: selectedDate,
///   onDateSelected: (date) => setState(() => selectedDate = date),
///   label: 'Select Date',
/// )
///
/// CorpoDatePicker.range(
///   startDate: startDate,
///   endDate: endDate,
///   onRangeSelected: (start, end) => setState(() {
///     startDate = start;
///     endDate = end;
///   }),
///   label: 'Date Range',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../design_tokens.dart';

/// Date picker variant types for different use cases.
enum CorpoDatePickerVariant {
  /// Single date selection
  single,

  /// Date range selection
  range,

  /// Month picker
  month,

  /// Year picker
  year,
}

/// Date picker size variants for different contexts.
enum CorpoDatePickerSize {
  /// Small date picker for compact layouts
  small,

  /// Medium date picker for standard forms
  medium,

  /// Large date picker for prominent selection
  large,
}

/// A comprehensive date picker widget following Corpo UI design principles.
///
/// This component provides consistent date selection styling with support
/// for single dates, date ranges, validation, and accessibility features.
class CorpoDatePicker extends StatefulWidget {
  /// Creates a Corpo UI date picker.
  const CorpoDatePicker({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    this.label,
    this.placeholder = 'Select date',
    this.validator,
    this.enabled = true,
    this.firstDate,
    this.lastDate,
    this.variant = CorpoDatePickerVariant.single,
    this.size = CorpoDatePickerSize.medium,
    this.helpText,
    this.errorText,
    this.required = false,
  }) : startDate = null,
       endDate = null,
       onRangeSelected = null;

  /// Creates a range date picker.
  const CorpoDatePicker.range({
    super.key,
    this.startDate,
    this.endDate,
    this.onRangeSelected,
    this.label,
    this.placeholder = 'Select date range',
    this.validator,
    this.enabled = true,
    this.firstDate,
    this.lastDate,
    this.size = CorpoDatePickerSize.medium,
    this.helpText,
    this.errorText,
    this.required = false,
  }) : variant = CorpoDatePickerVariant.range,
       selectedDate = null,
       onDateSelected = null;

  /// Currently selected date (for single date picker).
  final DateTime? selectedDate;

  /// Called when a date is selected (for single date picker).
  final ValueChanged<DateTime?>? onDateSelected;

  /// Start date for range picker.
  final DateTime? startDate;

  /// End date for range picker.
  final DateTime? endDate;

  /// Called when a date range is selected.
  final void Function(DateTime? start, DateTime? end)? onRangeSelected;

  /// Label text for the date picker.
  final String? label;

  /// Placeholder text shown when no date is selected.
  final String placeholder;

  /// Validation function for the selected date.
  final String? Function(DateTime?)? validator;

  /// Whether the date picker is enabled.
  final bool enabled;

  /// Earliest selectable date.
  final DateTime? firstDate;

  /// Latest selectable date.
  final DateTime? lastDate;

  /// Date picker variant.
  final CorpoDatePickerVariant variant;

  /// Size variant for the date picker.
  final CorpoDatePickerSize size;

  /// Help text shown below the date picker.
  final String? helpText;

  /// Error text shown when validation fails.
  final String? errorText;

  /// Whether the field is required.
  final bool required;

  @override
  State<CorpoDatePicker> createState() => _CorpoDatePickerState();
}

class _CorpoDatePickerState extends State<CorpoDatePicker> {
  String? _validationError;

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Row(
            children: <Widget>[
              Text(widget.label!, style: _getLabelStyle(tokens)),
              if (widget.required) ...<Widget>[
                SizedBox(width: tokens.spacing1x),
                Text(
                  '*',
                  style: TextStyle(
                    color: tokens.errorColor,
                    fontSize: _getLabelStyle(tokens).fontSize,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: tokens.spacing2x),
        ],
        InkWell(
          onTap: widget.enabled ? _showDatePicker : null,
          borderRadius: BorderRadius.circular(tokens.borderRadius),
          child: Container(
            height: _getHeight(tokens),
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(tokens),
              vertical: _getVerticalPadding(tokens),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: _getBorderColor(tokens, isDark)),
              borderRadius: BorderRadius.circular(tokens.borderRadius),
              color: widget.enabled
                  ? tokens.surfaceColor
                  : tokens.surfaceColor.withOpacity(0.5),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _getDisplayText(),
                    style: _getTextStyle(tokens, isDark),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: _getIconSize(tokens),
                  color: widget.enabled
                      ? tokens.textSecondary
                      : tokens.textSecondary.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
        if (widget.helpText != null || _validationError != null) ...<Widget>[
          SizedBox(height: tokens.spacing2x),
          Text(
            _validationError ?? widget.helpText!,
            style: TextStyle(
              fontSize: tokens.fontSizeSmall,
              color: _validationError != null
                  ? tokens.errorColor
                  : tokens.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  TextStyle _getLabelStyle(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
        );
      case CorpoDatePickerSize.medium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
        );
      case CorpoDatePickerSize.large:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
        );
    }
  }

  double _getHeight(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return tokens.spacing8x;
      case CorpoDatePickerSize.medium:
        return tokens.spacing8x * 1.25; // 40px equivalent
      case CorpoDatePickerSize.large:
        return tokens.spacing12x;
    }
  }

  double _getHorizontalPadding(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return tokens.spacing2x;
      case CorpoDatePickerSize.medium:
        return tokens.spacing4x;
      case CorpoDatePickerSize.large:
        return tokens.spacing4x;
    }
  }

  double _getVerticalPadding(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return tokens.spacing2x;
      case CorpoDatePickerSize.medium:
        return tokens.spacing2x;
      case CorpoDatePickerSize.large:
        return tokens.spacing2x;
    }
  }

  double _getIconSize(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return tokens.spacing4x;
      case CorpoDatePickerSize.medium:
        return tokens.spacing4x * 1.25; // 20px equivalent
      case CorpoDatePickerSize.large:
        return tokens.spacing6x;
    }
  }

  Color _getBorderColor(CorpoDesignTokens tokens, bool isDark) {
    if (_validationError != null) {
      return tokens.errorColor;
    }

    if (!widget.enabled) {
      return tokens.textSecondary.withOpacity(0.3);
    }

    return tokens.textSecondary.withOpacity(0.6);
  }

  TextStyle _getTextStyle(CorpoDesignTokens tokens, bool isDark) {
    final TextStyle baseStyle = widget.size == CorpoDatePickerSize.small
        ? TextStyle(
            fontSize: tokens.fontSizeSmall,
            fontFamily: tokens.fontFamily,
          )
        : TextStyle(
            fontSize: tokens.baseFontSize,
            fontFamily: tokens.fontFamily,
          );

    final Color textColor = _getDisplayText() == widget.placeholder
        ? tokens.textSecondary
        : tokens.textPrimary;

    return baseStyle.copyWith(color: textColor);
  }

  String _getDisplayText() {
    switch (widget.variant) {
      case CorpoDatePickerVariant.single:
        if (widget.selectedDate != null) {
          return _formatDate(widget.selectedDate!);
        }
        break;
      case CorpoDatePickerVariant.range:
        if (widget.startDate != null && widget.endDate != null) {
          return '${_formatDate(widget.startDate!)} - ${_formatDate(widget.endDate!)}';
        } else if (widget.startDate != null) {
          return '${_formatDate(widget.startDate!)} - ...';
        }
        break;
      case CorpoDatePickerVariant.month:
      case CorpoDatePickerVariant.year:
        // TODO: Implement month/year formatting
        break;
    }
    return widget.placeholder;
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  Future<void> _showDatePicker() async {
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final DateTime now = DateTime.now();
    final DateTime firstDate = widget.firstDate ?? DateTime(now.year - 100);
    final DateTime lastDate = widget.lastDate ?? DateTime(now.year + 100);

    switch (widget.variant) {
      case CorpoDatePickerVariant.single:
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: widget.selectedDate ?? now,
          firstDate: firstDate,
          lastDate: lastDate,
          builder: (BuildContext context, Widget? child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: tokens.primaryColor),
            ),
            child: child!,
          ),
        );

        if (selectedDate != null) {
          widget.onDateSelected?.call(selectedDate);
          _validateDate(selectedDate);
        }
        break;

      case CorpoDatePickerVariant.range:
        final DateTimeRange? selectedRange = await showDateRangePicker(
          context: context,
          firstDate: firstDate,
          lastDate: lastDate,
          initialDateRange: widget.startDate != null && widget.endDate != null
              ? DateTimeRange(start: widget.startDate!, end: widget.endDate!)
              : null,
          builder: (BuildContext context, Widget? child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: tokens.primaryColor),
            ),
            child: child!,
          ),
        );

        if (selectedRange != null) {
          widget.onRangeSelected?.call(selectedRange.start, selectedRange.end);
          _validateDate(selectedRange.start);
        }
        break;

      case CorpoDatePickerVariant.month:
      case CorpoDatePickerVariant.year:
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: widget.selectedDate ?? now,
          firstDate: firstDate,
          lastDate: lastDate,
          initialDatePickerMode: widget.variant == CorpoDatePickerVariant.month
              ? DatePickerMode.day
              : DatePickerMode.year,
          builder: (BuildContext context, Widget? child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: tokens.primaryColor),
            ),
            child: child!,
          ),
        );

        if (selectedDate != null) {
          widget.onDateSelected?.call(selectedDate);
          _validateDate(selectedDate);
        }
        break;
    }
  }

  void _validateDate(DateTime? date) {
    if (widget.validator != null) {
      setState(() {
        _validationError = widget.validator!(date);
      });
    }
  }
}
