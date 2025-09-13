/// A comprehensive text field component for the Corpo UI design system.
///
/// CorpoTextField provides consistent form input styling and behavior
/// across corporate applications, with support for validation, error states,
/// helper text, and various input types.
///
/// The component follows corporate design principles with clear visual
/// feedback, professional styling, and comprehensive accessibility features
/// including screen reader support and keyboard navigation.
///
/// ## Features
///
/// - **Input Variants**: Standard, password, multiline, and email types
/// - **Validation**: Built-in and custom validation with error display
/// - **States**: Focus, error, disabled, and readonly states
/// - **Accessibility**: Full screen reader support and keyboard navigation
/// - **Customization**: Configurable styling and behavior options
/// - **Helper Text**: Support for descriptive and instructional text
///
/// ## Accessibility
///
/// - Proper labeling for screen readers
/// - Focus management and keyboard navigation
/// - Error announcement for validation feedback
/// - Semantic input types for virtual keyboards
/// - High contrast focus indicators
///
/// ## Usage Patterns
///
/// ### Basic Text Input
/// Standard single-line text input with validation:
/// ```dart
/// CorpoTextField(
///   label: 'Full Name',
///   placeholder: 'Enter your full name',
///   validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
///   onChanged: (value) => updateUserName(value),
/// )
/// ```
///
/// ### Email Input
/// Email input with built-in keyboard type and validation:
/// ```dart
/// CorpoTextField.email(
///   label: 'Email Address',
///   placeholder: 'user@company.com',
///   validator: CorpoValidation.compose([
///     CorpoValidation.required('Email is required'),
///     CorpoValidation.email('Please enter a valid email'),
///   ]),
/// )
/// ```
///
/// ### Password Input
/// Password input with visibility toggle:
/// ```dart
/// CorpoTextField.password(
///   label: 'Password',
///   placeholder: 'Enter your password',
///   helperText: 'Minimum 8 characters required',
///   validator: CorpoValidation.minLength(8, 'Too short'),
/// )
/// ```
///
/// ### Multiline Text
/// Multi-line text input for longer content:
/// ```dart
/// CorpoTextField.multiline(
///   label: 'Description',
///   placeholder: 'Enter description...',
///   maxLines: 4,
///   maxLength: 500,
/// )
/// ```
///
/// ### Form Integration
/// Use with CorpoForm for complete form management:
/// ```dart
/// CorpoForm(
///   children: [
///     CorpoTextField(
///       name: 'username',
///       label: 'Username',
///       validator: CorpoValidation.required(),
///     ),
///   ],
/// )
/// ```
///
/// ## Design Guidelines
///
/// - Use clear, descriptive labels
/// - Provide helpful placeholder text when appropriate
/// - Include validation messages for user guidance
/// - Group related fields visually
/// - Consider input constraints and formatting
/// - Provide helper text for complex requirements
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Input variants for different use cases.
///
/// Determines the input behavior and visual presentation.
enum CorpoTextFieldVariant {
  /// Standard single-line text input
  standard,

  /// Password input with visibility toggle
  password,

  /// Multi-line text input
  multiline,

  /// Search input with search icon
  search,

  /// Email input with email keyboard
  email,

  /// Number input with numeric keyboard
  number,
}

/// Size variants for different layout contexts.
enum CorpoTextFieldSize {
  /// Small input for compact layouts
  small,

  /// Medium input for standard use (default)
  medium,

  /// Large input for prominent forms
  large,
}

/// A comprehensive text field widget following Corpo UI design principles.
///
/// This component provides consistent styling, validation, and accessibility
/// features across all input variants. It supports labels, helper text,
/// error states, and various input configurations.
class CorpoTextField extends StatefulWidget {
  /// Creates a Corpo UI text field.
  const CorpoTextField({
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = CorpoTextFieldVariant.standard,
    this.size = CorpoTextFieldSize.medium,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.autofocus = false,
    this.obscureText = false,
    super.key,
  });

  /// Convenience constructor for password fields.
  const CorpoTextField.password({
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.size = CorpoTextFieldSize.medium,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.inputFormatters,
    this.autofocus = false,
    super.key,
  }) : variant = CorpoTextFieldVariant.password,
       suffixIcon = null,
       maxLines = 1,
       maxLength = null,
       keyboardType = null,
       obscureText = true;

  /// Convenience constructor for multiline fields.
  const CorpoTextField.multiline({
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = CorpoTextFieldSize.medium,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLines = 3,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.inputFormatters,
    this.autofocus = false,
    super.key,
  }) : variant = CorpoTextFieldVariant.multiline,
       textInputAction = TextInputAction.newline,
       keyboardType = TextInputType.multiline,
       obscureText = false;

  /// Convenience constructor for search fields.
  const CorpoTextField.search({
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder = 'Search...',
    this.helperText,
    this.errorText,
    this.suffixIcon,
    this.size = CorpoTextFieldSize.medium,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.inputFormatters,
    this.autofocus = false,
    super.key,
  }) : variant = CorpoTextFieldVariant.search,
       prefixIcon = Icons.search,
       maxLines = 1,
       maxLength = null,
       textInputAction = TextInputAction.search,
       keyboardType = null,
       obscureText = false;

  /// Convenience constructor for email fields.
  const CorpoTextField.email({
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder = 'Enter email address',
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = CorpoTextFieldSize.medium,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.inputFormatters,
    this.autofocus = false,
    super.key,
  }) : variant = CorpoTextFieldVariant.email,
       maxLines = 1,
       maxLength = null,
       textInputAction = TextInputAction.next,
       keyboardType = TextInputType.emailAddress,
       obscureText = false;

  /// Convenience constructor for number fields.
  const CorpoTextField.number({
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = CorpoTextFieldSize.medium,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.inputFormatters,
    this.autofocus = false,
    super.key,
  }) : variant = CorpoTextFieldVariant.number,
       maxLines = 1,
       maxLength = null,
       textInputAction = TextInputAction.done,
       keyboardType = TextInputType.number,
       obscureText = false;

  /// Controller for the text field.
  final TextEditingController? controller;

  /// Initial value for the text field.
  final String? initialValue;

  /// Label text displayed above the field.
  final String? label;

  /// Placeholder text shown when field is empty.
  final String? placeholder;

  /// Helper text displayed below the field.
  final String? helperText;

  /// Error text displayed below the field.
  final String? errorText;

  /// Icon displayed at the start of the field.
  final IconData? prefixIcon;

  /// Icon displayed at the end of the field.
  final IconData? suffixIcon;

  /// Input variant determining behavior and appearance.
  final CorpoTextFieldVariant variant;

  /// Size of the input field.
  final CorpoTextFieldSize size;

  /// Whether the field is enabled for input.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether the field is required.
  final bool required;

  /// Maximum number of lines for the input.
  final int maxLines;

  /// Maximum character length.
  final int? maxLength;

  /// Validation function for the input.
  final String? Function(String?)? validator;

  /// Called when the input value changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the field.
  final ValueChanged<String>? onSubmitted;

  /// Called when the field is tapped.
  final VoidCallback? onTap;

  /// Focus node for the field.
  final FocusNode? focusNode;

  /// Text input action for the keyboard.
  final TextInputAction? textInputAction;

  /// Keyboard type for the input.
  final TextInputType? keyboardType;

  /// Input formatters for the field.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the field should be focused initially.
  final bool autofocus;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  @override
  State<CorpoTextField> createState() => _CorpoTextFieldState();
}

class _CorpoTextFieldState extends State<CorpoTextField> {
  late final FocusNode _focusNode;
  late bool _obscureText;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final bool hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) _buildLabel(isDark, hasError),
        _buildTextField(context, isDark, hasError),
        if (widget.helperText != null || widget.errorText != null)
          _buildHelperText(isDark, hasError),
      ],
    );
  }

  /// Builds the field label.
  Widget _buildLabel(bool isDark, bool hasError) {
    final Color labelColor = hasError
        ? CorpoColors.error
        : isDark
        ? CorpoColors.neutral300
        : CorpoColors.neutral700;

    return Padding(
      padding: const EdgeInsets.only(bottom: CorpoSpacing.extraSmall),
      child: RichText(
        text: TextSpan(
          text: widget.label,
          style: CorpoTypography.labelMedium.copyWith(
            color: labelColor,
            fontWeight: CorpoFontWeight.medium,
          ),
          children: widget.required
              ? <TextSpan>[
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: CorpoColors.error),
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  /// Builds the main text field.
  Widget _buildTextField(BuildContext context, bool isDark, bool hasError) {
    final InputDecoration decoration = _buildInputDecoration(isDark, hasError);

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus,
      obscureText: _obscureText,
      style: _getTextStyle(isDark),
      decoration: decoration,
    );
  }

  /// Builds the input decoration.
  InputDecoration _buildInputDecoration(bool isDark, bool hasError) {
    final Color borderColor = hasError
        ? CorpoColors.error
        : _isFocused
        ? CorpoColors.primary500
        : isDark
        ? CorpoColors.neutral600
        : CorpoColors.neutral300;

    final Color fillColor = isDark
        ? CorpoColors.neutral800
        : CorpoColors.neutralWhite;

    return InputDecoration(
      hintText: widget.placeholder,
      hintStyle: CorpoTypography.bodyMedium.copyWith(
        color: isDark ? CorpoColors.neutral500 : CorpoColors.neutral400,
      ),
      prefixIcon: widget.prefixIcon != null
          ? Icon(
              widget.prefixIcon,
              color: isDark ? CorpoColors.neutral400 : CorpoColors.neutral500,
              size: _getIconSize(),
            )
          : null,
      suffixIcon: _buildSuffixIcon(isDark),
      filled: true,
      fillColor: fillColor,
      contentPadding: _getContentPadding(),
      border: _buildBorder(borderColor),
      enabledBorder: _buildBorder(borderColor),
      focusedBorder: _buildBorder(borderColor, width: 2),
      errorBorder: _buildBorder(CorpoColors.error),
      focusedErrorBorder: _buildBorder(CorpoColors.error, width: 2),
      counterText: widget.maxLength != null ? null : '',
    );
  }

  /// Builds the suffix icon with special handling for password fields.
  Widget? _buildSuffixIcon(bool isDark) {
    if (widget.variant == CorpoTextFieldVariant.password) {
      return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: isDark ? CorpoColors.neutral400 : CorpoColors.neutral500,
          size: _getIconSize(),
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return Icon(
        widget.suffixIcon,
        color: isDark ? CorpoColors.neutral400 : CorpoColors.neutral500,
        size: _getIconSize(),
      );
    }

    return null;
  }

  /// Builds the helper text or error text.
  Widget _buildHelperText(bool isDark, bool hasError) {
    final String text = widget.errorText ?? widget.helperText ?? '';
    final Color textColor = hasError
        ? CorpoColors.error
        : isDark
        ? CorpoColors.neutral400
        : CorpoColors.neutral500;

    return Padding(
      padding: const EdgeInsets.only(top: CorpoSpacing.extraSmall),
      child: Text(
        text,
        style: CorpoTypography.bodySmall.copyWith(color: textColor),
      ),
    );
  }

  /// Gets the text style for the input.
  TextStyle _getTextStyle(bool isDark) {
    final Color textColor = isDark
        ? CorpoColors.neutral100
        : CorpoColors.neutral800;

    return CorpoTypography.bodyMedium.copyWith(
      color: textColor,
      fontSize: _getFontSize(),
    );
  }

  /// Gets the content padding based on size.
  EdgeInsetsGeometry _getContentPadding() {
    switch (widget.size) {
      case CorpoTextFieldSize.small:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.medium,
          vertical: CorpoSpacing.small,
        );
      case CorpoTextFieldSize.medium:
        return CorpoPadding.medium;
      case CorpoTextFieldSize.large:
        return const EdgeInsets.symmetric(
          horizontal: CorpoSpacing.large,
          vertical: CorpoSpacing.medium,
        );
    }
  }

  /// Gets the font size based on input size.
  double _getFontSize() {
    switch (widget.size) {
      case CorpoTextFieldSize.small:
        return CorpoFontSize.small;
      case CorpoTextFieldSize.medium:
        return CorpoFontSize.medium;
      case CorpoTextFieldSize.large:
        return CorpoFontSize.large;
    }
  }

  /// Gets the icon size based on input size.
  double _getIconSize() {
    switch (widget.size) {
      case CorpoTextFieldSize.small:
        return 18;
      case CorpoTextFieldSize.medium:
        return 20;
      case CorpoTextFieldSize.large:
        return 22;
    }
  }

  /// Builds the input border.
  OutlineInputBorder _buildBorder(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color, width: width),
      );
}
