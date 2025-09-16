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

import '../../design_tokens.dart';

/// A generic form field wrapper following Corpo UI design principles.
///
/// This component provides consistent form field styling with support
/// for labels, validation, error states, and accessibility features.
class CorpoFormField<T> extends FormField<T> {
  /// Creates a Corpo UI form field.
  CorpoFormField({
    required this.fieldBuilder,
    super.key,
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
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.label!,
                style: TextStyle(
                  fontSize: tokens.baseFontSize,
                  fontFamily: tokens.fontFamily,
                ),
              ),
              if (widget.required) ...<Widget>[
                SizedBox(width: tokens.spacing1x),
                Text(
                  '*',
                  style: TextStyle(
                    color: tokens.errorColor,
                    fontSize: tokens.baseFontSize,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: tokens.spacing2x),
        ],
        widget.fieldBuilder(context, this),
        if (widget.helpText != null || hasError) ...<Widget>[
          SizedBox(height: tokens.spacing2x),
          Text(
            errorText ?? widget.helpText!,
            style: TextStyle(
              fontSize: tokens.fontSizeSmall,
              color: hasError ? tokens.errorColor : tokens.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
