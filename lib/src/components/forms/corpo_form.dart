/// A comprehensive form container component for the Corpo UI design system.
///
/// CorpoForm provides consistent form styling and behavior across
/// corporate applications, with support for validation, submission
/// handling, and various layout configurations.
///
/// The component follows corporate design principles with professional
/// styling, comprehensive accessibility features, and robust form
/// state management for business applications.
///
/// Example usage:
/// ```dart
/// CorpoForm(
///   onSubmit: (data) => submitForm(data),
///   children: [
///     CorpoTextField(
///       name: 'email',
///       label: 'Email Address',
///       validator: CorpoValidation.email(),
///     ),
///     CorpoTextField(
///       name: 'password',
///       label: 'Password',
///       obscureText: true,
///       validator: CorpoValidation.required(),
///     ),
///     CorpoButton(
///       onPressed: () => CorpoForm.of(context)?.submit(),
///       child: Text('Submit'),
///     ),
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';

/// Form layout variants for different use cases.
enum CorpoFormLayout {
  /// Vertical layout with fields stacked vertically
  vertical,

  /// Horizontal layout with fields side by side
  horizontal,

  /// Grid layout with multiple columns
  grid,
}

/// Form validation modes.
enum CorpoFormValidationMode {
  /// Validate on form submission only
  onSubmit,

  /// Validate on field changes
  onChange,

  /// Validate on field focus loss
  onBlur,

  /// Validate on form submission and then on field changes
  onSubmitThenChange,
}

/// A comprehensive form container widget following Corpo UI design principles.
///
/// This component provides consistent form styling with support for
/// validation, submission handling, and accessibility features.
class CorpoForm extends StatefulWidget {
  /// Creates a Corpo UI form.
  const CorpoForm({
    required this.children, super.key,
    this.onSubmit,
    this.onChanged,
    this.validationMode = CorpoFormValidationMode.onSubmitThenChange,
    this.layout = CorpoFormLayout.vertical,
    this.spacing = CorpoSpacing.medium,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.enabled = true,
    this.autovalidateMode,
  });

  /// Called when the form is submitted.
  final void Function(Map<String, dynamic> data)? onSubmit;

  /// Called when any form field value changes.
  final void Function(Map<String, dynamic> data)? onChanged;

  /// Form validation mode.
  final CorpoFormValidationMode validationMode;

  /// Layout configuration for the form.
  final CorpoFormLayout layout;

  /// Spacing between form fields.
  final double spacing;

  /// Cross axis alignment for form fields.
  final CrossAxisAlignment crossAxisAlignment;

  /// Main axis alignment for form fields.
  final MainAxisAlignment mainAxisAlignment;

  /// Whether the form is enabled.
  final bool enabled;

  /// Autovalidate mode for the form.
  final AutovalidateMode? autovalidateMode;

  /// Child widgets (form fields and other content).
  final List<Widget> children;

  @override
  State<CorpoForm> createState() => CorpoFormState();

  /// Gets the nearest CorpoForm instance from the widget tree.
  static CorpoFormState? of(BuildContext context) => context.findAncestorStateOfType<CorpoFormState>();
}

/// State for CorpoForm.
class CorpoFormState extends State<CorpoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = <String, dynamic>{};
  bool _isSubmitting = false;

  /// Whether the form is currently submitting.
  bool get isSubmitting => _isSubmitting;

  /// Current form data.
  Map<String, dynamic> get formData => Map<String, dynamic>.from(_formData);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? CorpoColors.neutral800 : CorpoColors.neutralWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: widget.autovalidateMode ?? _getAutovalidateMode(),
        onChanged: _onFormChanged,
        child: _buildLayout(),
      ),
    );
  }

  Widget _buildLayout() {
    switch (widget.layout) {
      case CorpoFormLayout.vertical:
        return _buildVerticalLayout();
      case CorpoFormLayout.horizontal:
        return _buildHorizontalLayout();
      case CorpoFormLayout.grid:
        return _buildGridLayout();
    }
  }

  Widget _buildVerticalLayout() => Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisAlignment: widget.mainAxisAlignment,
      children: _addSpacing(widget.children),
    );

  Widget _buildHorizontalLayout() => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: widget.mainAxisAlignment,
      children: _addSpacing(
        widget.children.map((Widget child) => Expanded(child: child)).toList(),
      ),
    );

  Widget _buildGridLayout() {
    // For grid layout, wrap in a responsive grid
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.spacing,
      children: widget.children.map((Widget child) => SizedBox(width: _getGridItemWidth(), child: child)).toList(),
    );
  }

  double _getGridItemWidth() {
    // Calculate grid item width based on screen size
    return MediaQuery.of(context).size.width > 768 ? 300 : double.infinity;
  }

  List<Widget> _addSpacing(List<Widget> children) {
    if (children.isEmpty) return children;

    final List<Widget> spacedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        if (widget.layout == CorpoFormLayout.vertical) {
          spacedChildren.add(SizedBox(height: widget.spacing));
        } else {
          spacedChildren.add(SizedBox(width: widget.spacing));
        }
      }
    }
    return spacedChildren;
  }

  AutovalidateMode _getAutovalidateMode() {
    switch (widget.validationMode) {
      case CorpoFormValidationMode.onSubmit:
        return AutovalidateMode.disabled;
      case CorpoFormValidationMode.onChange:
        return AutovalidateMode.onUserInteraction;
      case CorpoFormValidationMode.onBlur:
        return AutovalidateMode.onUserInteraction;
      case CorpoFormValidationMode.onSubmitThenChange:
        return AutovalidateMode.onUserInteraction;
    }
  }

  void _onFormChanged() {
    widget.onChanged?.call(_formData);
  }

  /// Validates the form and returns whether it's valid.
  bool validate() => _formKey.currentState?.validate() ?? false;

  /// Saves all form fields.
  void save() {
    _formKey.currentState?.save();
  }

  /// Resets the form to its initial state.
  void reset() {
    _formKey.currentState?.reset();
    _formData.clear();
    setState(() {});
  }

  /// Submits the form after validation.
  Future<void> submit() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      if (validate()) {
        save();
        widget.onSubmit?.call(_formData);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  /// Updates a field value in the form data.
  void updateField(String name, dynamic value) {
    _formData[name] = value;
    _onFormChanged();
  }

  /// Gets a field value from the form data.
  T? getField<T>(String name) => _formData[name] as T?;

  /// Sets multiple field values at once.
  void setFormData(Map<String, dynamic> data) {
    _formData.clear();
    _formData.addAll(data);
    _onFormChanged();
  }
}
