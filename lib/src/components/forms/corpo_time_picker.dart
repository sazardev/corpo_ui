/// A comprehensive time picker component for the Corpo UI design system.
///
/// CorpoTimePicker provides consistent time selection styling and behavior
/// across corporate applications, with support for validation, 12/24 hour
/// formats, and various visual states.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including screen reader support and keyboard navigation.
///
/// Example usage:
/// ```dart
/// CorpoTimePicker(
///   selectedTime: selectedTime,
///   onTimeSelected: (time) => setState(() => selectedTime = time),
///   label: 'Select Time',
/// )
///
/// CorpoTimePicker.range(
///   startTime: startTime,
///   endTime: endTime,
///   onRangeSelected: (start, end) => setState(() {
///     startTime = start;
///     endTime = end;
///   }),
///   label: 'Time Range',
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Time picker variant types for different use cases.
enum CorpoTimePickerVariant {
  /// Single time selection
  single,

  /// Time range selection
  range,
}

/// Time picker size variants for different contexts.
enum CorpoTimePickerSize {
  /// Small time picker for compact layouts
  small,

  /// Medium time picker for standard forms
  medium,

  /// Large time picker for prominent selection
  large,
}

/// Time format for display and input.
enum CorpoTimeFormat {
  /// 12-hour format with AM/PM
  hour12,

  /// 24-hour format
  hour24,
}

/// A comprehensive time picker widget following Corpo UI design principles.
///
/// This component provides consistent time selection styling with support
/// for single times, time ranges, validation, and accessibility features.
class CorpoTimePicker extends StatefulWidget {
  /// Creates a Corpo UI time picker.
  const CorpoTimePicker({
    super.key,
    this.selectedTime,
    this.onTimeSelected,
    this.label,
    this.placeholder = 'Select time',
    this.validator,
    this.enabled = true,
    this.variant = CorpoTimePickerVariant.single,
    this.size = CorpoTimePickerSize.medium,
    this.format = CorpoTimeFormat.hour12,
    this.helpText,
    this.errorText,
    this.required = false,
  }) : startTime = null,
       endTime = null,
       onRangeSelected = null;

  /// Creates a range time picker.
  const CorpoTimePicker.range({
    super.key,
    this.startTime,
    this.endTime,
    this.onRangeSelected,
    this.label,
    this.placeholder = 'Select time range',
    this.validator,
    this.enabled = true,
    this.size = CorpoTimePickerSize.medium,
    this.format = CorpoTimeFormat.hour12,
    this.helpText,
    this.errorText,
    this.required = false,
  }) : variant = CorpoTimePickerVariant.range,
       selectedTime = null,
       onTimeSelected = null;

  /// Currently selected time (for single time picker).
  final TimeOfDay? selectedTime;

  /// Called when a time is selected (for single time picker).
  final ValueChanged<TimeOfDay?>? onTimeSelected;

  /// Start time for range picker.
  final TimeOfDay? startTime;

  /// End time for range picker.
  final TimeOfDay? endTime;

  /// Called when a time range is selected.
  final void Function(TimeOfDay? start, TimeOfDay? end)? onRangeSelected;

  /// Label text for the time picker.
  final String? label;

  /// Placeholder text shown when no time is selected.
  final String placeholder;

  /// Validation function for the selected time.
  final String? Function(TimeOfDay?)? validator;

  /// Whether the time picker is enabled.
  final bool enabled;

  /// Time picker variant.
  final CorpoTimePickerVariant variant;

  /// Size variant for the time picker.
  final CorpoTimePickerSize size;

  /// Time format for display.
  final CorpoTimeFormat format;

  /// Help text shown below the time picker.
  final String? helpText;

  /// Error text shown when validation fails.
  final String? errorText;

  /// Whether the field is required.
  final bool required;

  @override
  State<CorpoTimePicker> createState() => _CorpoTimePickerState();
}

class _CorpoTimePickerState extends State<CorpoTimePicker> {
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
          onTap: widget.enabled ? _showTimePicker : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: _getHeight(),
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(),
              vertical: _getVerticalPadding(),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: _getBorderColor(isDark)),
              borderRadius: BorderRadius.circular(8),
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
                  Icons.access_time,
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
      case CorpoTimePickerSize.small:
        return CorpoTypography.labelSmall;
      case CorpoTimePickerSize.medium:
        return CorpoTypography.labelMedium;
      case CorpoTimePickerSize.large:
        return CorpoTypography.labelLarge;
    }
  }

  double _getHeight() {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return 32;
      case CorpoTimePickerSize.medium:
        return 40;
      case CorpoTimePickerSize.large:
        return 48;
    }
  }

  double _getHorizontalPadding() {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return CorpoSpacing.small;
      case CorpoTimePickerSize.medium:
        return CorpoSpacing.medium;
      case CorpoTimePickerSize.large:
        return CorpoSpacing.medium;
    }
  }

  double _getVerticalPadding() {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return CorpoSpacing.small;
      case CorpoTimePickerSize.medium:
        return CorpoSpacing.small;
      case CorpoTimePickerSize.large:
        return CorpoSpacing.small;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return 16;
      case CorpoTimePickerSize.medium:
        return 20;
      case CorpoTimePickerSize.large:
        return 24;
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
    final TextStyle baseStyle = widget.size == CorpoTimePickerSize.small
        ? CorpoTypography.bodySmall
        : CorpoTypography.bodyMedium;

    final Color textColor = _getDisplayText() == widget.placeholder
        ? (isDark ? CorpoColors.neutral400 : CorpoColors.neutral500)
        : (isDark ? CorpoColors.neutralWhite : CorpoColors.neutral900);

    return baseStyle.copyWith(color: textColor);
  }

  String _getDisplayText() {
    switch (widget.variant) {
      case CorpoTimePickerVariant.single:
        if (widget.selectedTime != null) {
          return _formatTime(widget.selectedTime!);
        }
        break;
      case CorpoTimePickerVariant.range:
        if (widget.startTime != null && widget.endTime != null) {
          return '${_formatTime(widget.startTime!)} - ${_formatTime(widget.endTime!)}';
        } else if (widget.startTime != null) {
          return '${_formatTime(widget.startTime!)} - ...';
        }
        break;
    }
    return widget.placeholder;
  }

  String _formatTime(TimeOfDay time) {
    switch (widget.format) {
      case CorpoTimeFormat.hour12:
        final String period = time.period == DayPeriod.am ? 'AM' : 'PM';
        final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
        return '${hour.toString()}:${time.minute.toString().padLeft(2, '0')} $period';
      case CorpoTimeFormat.hour24:
        return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay now = TimeOfDay.now();

    switch (widget.variant) {
      case CorpoTimePickerVariant.single:
        final TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: widget.selectedTime ?? now,
          builder: (BuildContext context, Widget? child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(
                  context,
                ).colorScheme.copyWith(primary: CorpoColors.primary500),
              ),
              child: child!,
            ),
        );

        if (selectedTime != null) {
          widget.onTimeSelected?.call(selectedTime);
          _validateTime(selectedTime);
        }
        break;

      case CorpoTimePickerVariant.range:
        // For range selection, show start time picker first
        final TimeOfDay? startTime = await showTimePicker(
          context: context,
          initialTime: widget.startTime ?? now,
          helpText: 'Select start time',
          builder: (BuildContext context, Widget? child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(
                  context,
                ).colorScheme.copyWith(primary: CorpoColors.primary500),
              ),
              child: child!,
            ),
        );

        if (startTime != null) {
          // Then show end time picker
          final TimeOfDay? endTime = await showTimePicker(
            context: context,
            initialTime:
                widget.endTime ??
                TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute),
            helpText: 'Select end time',
            builder: (BuildContext context, Widget? child) => Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(
                    context,
                  ).colorScheme.copyWith(primary: CorpoColors.primary500),
                ),
                child: child!,
              ),
          );

          if (endTime != null) {
            widget.onRangeSelected?.call(startTime, endTime);
            _validateTime(startTime);
          }
        }
        break;
    }
  }

  void _validateTime(TimeOfDay? time) {
    if (widget.validator != null) {
      setState(() {
        _validationError = widget.validator!(time);
      });
    }
  }
}
