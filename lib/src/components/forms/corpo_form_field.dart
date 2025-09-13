/// A generic form field wrapper component for the Corpo UI design system.
///
/// CorpoFormField provides consistent form field styling and behavior
/// across corporate applications, with support for labels, validation,
/// error states, and accessibility features.
///
/// This component serves as a wrapper around various input components
/// to provide consistent form layout and validation handling.
///
/// Example usage:
/// ```dart
/// CorpoFormField<String>(
///   label: 'Email Address',
///   required: true,
///   validator: CorpoValidation.compose([
///     CorpoValidation.required(),
///     CorpoValidation.email(),
///   ]),
///   builder: (context, state) => TextField(
///     onChanged: state.didChange,
///     decoration: InputDecoration(
///       errorText: state.errorText,
///     ),
///   ),
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// A generic form field wrapper following Corpo UI design principles.
///
/// This component provides consistent form field styling with support
/// for labels, validation, error states, and accessibility features.
class CorpoFormField<T> extends FormField<T> {
  /// Creates a Corpo UI form field.
  CorpoFormField({
    required this.fieldBuilder, super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.enabled = true,
    super.autovalidateMode,
    this.label,
    this.helpText,
    this.required = false,
  }) : super(
         builder: (FormFieldState<T> field) {
           final CorpoFormFieldState<T> state = field as CorpoFormFieldState<T>;
           return state._buildField();
         },
       );

  /// Label text for the form field.
  final String? label;

  /// Help text shown below the form field.
  final String? helpText;

  /// Whether the field is required.
  final bool required;

  /// Builder function for the form field widget.
  final Widget Function(BuildContext context, CorpoFormFieldState<T> field)
  fieldBuilder;

  @override
  FormFieldState<T> createState() => CorpoFormFieldState<T>();
}

/// State for CorpoFormField.
class CorpoFormFieldState<T> extends FormFieldState<T> {
  @override
  CorpoFormField<T> get widget => super.widget as CorpoFormField<T>;

  Widget _buildField() {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Row(
            children: <Widget>[
              Text(widget.label!, style: CorpoTypography.labelMedium),
              if (widget.required) ...<Widget>[
                const SizedBox(width: CorpoSpacing.extraSmall),
                Text(
                  '*',
                  style: TextStyle(
                    color: isDark ? CorpoColors.error : CorpoColors.error,
                    fontSize: CorpoFontSize.medium,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: CorpoSpacing.small),
        ],
        widget.fieldBuilder(context, this),
        if (widget.helpText != null || hasError) ...<Widget>[
          const SizedBox(height: CorpoSpacing.small),
          Text(
            errorText ?? widget.helpText!,
            style: TextStyle(
              fontSize: CorpoFontSize.small,
              color: hasError
                  ? (isDark ? CorpoColors.error : CorpoColors.error)
                  : (isDark ? CorpoColors.neutral400 : CorpoColors.neutral600),
            ),
          ),
        ],
      ],
    );
  }
}
