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

import '../../design_tokens.dart';

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
          onTap: widget.enabled ? _showTimePicker : null,
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
                  Icons.access_time,
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
      case CorpoTimePickerSize.small:
        return TextStyle(
          fontSize: tokens.fontSizeSmall,
          fontFamily: tokens.fontFamily,
        );
      case CorpoTimePickerSize.medium:
        return TextStyle(
          fontSize: tokens.baseFontSize,
          fontFamily: tokens.fontFamily,
        );
      case CorpoTimePickerSize.large:
        return TextStyle(
          fontSize: tokens.fontSizeLarge,
          fontFamily: tokens.fontFamily,
        );
    }
  }

  double _getHeight(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return tokens.spacing8x;
      case CorpoTimePickerSize.medium:
        return tokens.spacing8x * 1.25; // 40px equivalent
      case CorpoTimePickerSize.large:
        return tokens.spacing12x;
    }
  }

  double _getHorizontalPadding(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return tokens.spacing2x;
      case CorpoTimePickerSize.medium:
        return tokens.spacing4x;
      case CorpoTimePickerSize.large:
        return tokens.spacing4x;
    }
  }

  double _getVerticalPadding(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return tokens.spacing2x;
      case CorpoTimePickerSize.medium:
        return tokens.spacing2x;
      case CorpoTimePickerSize.large:
        return tokens.spacing2x;
    }
  }

  double _getIconSize(CorpoDesignTokens tokens) {
    switch (widget.size) {
      case CorpoTimePickerSize.small:
        return tokens.spacing4x;
      case CorpoTimePickerSize.medium:
        return tokens.spacing4x * 1.25; // 20px equivalent
      case CorpoTimePickerSize.large:
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
    final TextStyle baseStyle = widget.size == CorpoTimePickerSize.small
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
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
              ).colorScheme.copyWith(primary: tokens.primaryColor),
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
              ).colorScheme.copyWith(primary: tokens.primaryColor),
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
                ).colorScheme.copyWith(primary: tokens.primaryColor),
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
