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

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

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
  CorpoDatePicker.range({
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
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Row(
            children: <Widget>[
              Text(widget.label!, style: _getLabelStyle()),
              if (widget.required) ...<Widget>[
                const SizedBox(width: CorpoSpacing.extraSmall),
                Text(
                  '*',
                  style: TextStyle(
                    color: isDark ? CorpoColors.error : CorpoColors.error,
                    fontSize: _getLabelStyle().fontSize,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: CorpoSpacing.small),
        ],
        InkWell(
          onTap: widget.enabled ? _showDatePicker : null,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            height: _getHeight(),
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(),
              vertical: _getVerticalPadding(),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: _getBorderColor(isDark), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
              color: widget.enabled
                  ? (isDark ? CorpoColors.neutral800 : CorpoColors.neutralWhite)
                  : (isDark ? CorpoColors.neutral700 : CorpoColors.neutral100),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(_getDisplayText(), style: _getTextStyle(isDark)),
                ),
                Icon(
                  Icons.calendar_today,
                  size: _getIconSize(),
                  color: widget.enabled
                      ? (isDark
                            ? CorpoColors.neutral300
                            : CorpoColors.neutral600)
                      : (isDark
                            ? CorpoColors.neutral500
                            : CorpoColors.neutral400),
                ),
              ],
            ),
          ),
        ),
        if (widget.helpText != null || _validationError != null) ...<Widget>[
          const SizedBox(height: CorpoSpacing.small),
          Text(
            _validationError ?? widget.helpText!,
            style: TextStyle(
              fontSize: CorpoFontSize.small,
              color: _validationError != null
                  ? (isDark ? CorpoColors.error : CorpoColors.error)
                  : (isDark ? CorpoColors.neutral400 : CorpoColors.neutral600),
            ),
          ),
        ],
      ],
    );
  }

  TextStyle _getLabelStyle() {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return CorpoTypography.labelSmall;
      case CorpoDatePickerSize.medium:
        return CorpoTypography.labelMedium;
      case CorpoDatePickerSize.large:
        return CorpoTypography.labelLarge;
    }
  }

  double _getHeight() {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return 32.0;
      case CorpoDatePickerSize.medium:
        return 40.0;
      case CorpoDatePickerSize.large:
        return 48.0;
    }
  }

  double _getHorizontalPadding() {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return CorpoSpacing.small;
      case CorpoDatePickerSize.medium:
        return CorpoSpacing.medium;
      case CorpoDatePickerSize.large:
        return CorpoSpacing.medium;
    }
  }

  double _getVerticalPadding() {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return CorpoSpacing.small;
      case CorpoDatePickerSize.medium:
        return CorpoSpacing.small;
      case CorpoDatePickerSize.large:
        return CorpoSpacing.small;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case CorpoDatePickerSize.small:
        return 16.0;
      case CorpoDatePickerSize.medium:
        return 20.0;
      case CorpoDatePickerSize.large:
        return 24.0;
    }
  }

  Color _getBorderColor(bool isDark) {
    if (_validationError != null) {
      return isDark ? CorpoColors.error : CorpoColors.error;
    }

    if (!widget.enabled) {
      return isDark ? CorpoColors.neutral600 : CorpoColors.neutral300;
    }

    return isDark ? CorpoColors.neutral600 : CorpoColors.neutral400;
  }

  TextStyle _getTextStyle(bool isDark) {
    final TextStyle baseStyle = widget.size == CorpoDatePickerSize.small
        ? CorpoTypography.bodySmall
        : CorpoTypography.bodyMedium;

    final Color textColor = _getDisplayText() == widget.placeholder
        ? (isDark ? CorpoColors.neutral400 : CorpoColors.neutral500)
        : (isDark ? CorpoColors.neutralWhite : CorpoColors.neutral900);

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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _showDatePicker() async {
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
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(
                  context,
                ).colorScheme.copyWith(primary: CorpoColors.primary500),
              ),
              child: child!,
            );
          },
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
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(
                  context,
                ).colorScheme.copyWith(primary: CorpoColors.primary500),
              ),
              child: child!,
            );
          },
        );

        if (selectedRange != null) {
          widget.onRangeSelected?.call(selectedRange.start, selectedRange.end);
          _validateDate(selectedRange.start);
        }
        break;

      case CorpoDatePickerVariant.month:
      case CorpoDatePickerVariant.year:
        // TODO: Implement month/year pickers
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
