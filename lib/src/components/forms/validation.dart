/// Built-in validation rules for Corpo UI form components.
///
/// This file provides a comprehensive set of validation functions
/// for common form validation scenarios in corporate applications.
/// All validators return null for valid input and an error message
/// string for invalid input.
///
/// Example usage:
/// ```dart
/// CorpoTextField(
///   validator: CorpoValidation.compose([
///     CorpoValidation.required('Email is required'),
///     CorpoValidation.email('Please enter a valid email'),
///   ]),
/// )
/// ```
library;

/// Built-in validation functions for form fields.
abstract final class CorpoValidation {
  /// Validates that a field is not empty.
  static String? Function(String?) required([String? message]) =>
      (String? value) {
        if (value == null || value.trim().isEmpty) {
          return message ?? 'This field is required';
        }
        return null;
      };

  /// Validates email format.
  static String? Function(String?) email([String? message]) => (String? value) {
    if (value == null || value.isEmpty) return null;

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return message ?? 'Please enter a valid email address';
    }
    return null;
  };

  /// Validates minimum length.
  static String? Function(String?) minLength(int min, [String? message]) =>
      (String? value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        if (value.length < min) {
          return message ?? 'Must be at least $min characters long';
        }
        return null;
      };

  /// Validates maximum length.
  static String? Function(String?) maxLength(int max, [String? message]) =>
      (String? value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        if (value.length > max) {
          return message ?? 'Must be no more than $max characters long';
        }
        return null;
      };

  /// Validates phone number format.
  static String? Function(String?) phone([String? message]) => (String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final RegExp phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');

    if (!phoneRegex.hasMatch(value)) {
      return message ?? 'Please enter a valid phone number';
    }
    return null;
  };

  /// Validates URL format.
  static String? Function(String?) url([String? message]) => (String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final RegExp urlRegex = RegExp(
      r'^https?:\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    );

    if (!urlRegex.hasMatch(value)) {
      return message ?? 'Please enter a valid URL';
    }
    return null;
  };

  /// Validates that field matches another field
  static String? Function(String?) matches(String? other, [String? message]) =>
      (String? value) {
        if (value != other) {
          return message ?? 'Fields do not match';
        }
        return null;
      };

  /// Validates numeric input.
  static String? Function(String?) numeric([String? message]) =>
      (String? value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        if (double.tryParse(value) == null) {
          return message ?? 'Please enter a valid number';
        }
        return null;
      };

  /// Validates integer input.
  static String? Function(String?) integer([String? message]) =>
      (String? value) {
        if (value == null || value.isEmpty) return null;

        if (int.tryParse(value) == null) {
          return message ?? 'Please enter a valid integer';
        }
        return null;
      };

  /// Validates minimum numeric value.
  static String? Function(String?) min(double minimum, [String? message]) =>
      (String? value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        final double? number = double.tryParse(value);
        if (number == null) {
          return 'Please enter a valid number';
        }

        if (number < minimum) {
          return message ?? 'Must be at least $minimum';
        }
        return null;
      };

  /// Validates maximum numeric value.
  static String? Function(String?) max(double maximum, [String? message]) =>
      (String? value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        final double? number = double.tryParse(value);
        if (number == null) {
          return 'Please enter a valid number';
        }

        if (number > maximum) {
          return message ?? 'Must be no more than $maximum';
        }
        return null;
      };

  /// Validates using a custom regular expression.
  static String? Function(String?) pattern(RegExp regex, [String? message]) =>
      (String? value) {
        if (value == null || value.isEmpty) {
          return null;
        }

        if (!regex.hasMatch(value)) {
          return message ?? 'Invalid format';
        }
        return null;
      };

  /// Composes multiple validators into a single validator.
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) => (String? value) {
    for (final String? Function(String?) validator in validators) {
      final String? error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  };

  /// Validates date format.
  static String? Function(String?) date([String? message]) => (String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return message ?? 'Please enter a valid date';
    }
  };

  /// Validates strong password
  /// (at least 8 chars, contains uppercase, lowercase, number)
  static String? Function(String?) strongPassword([
    String? message,
  ]) => (String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length < 8) {
      return message ?? 'Password must be at least 8 characters long';
    }

    if (!RegExp('[A-Z]').hasMatch(value)) {
      return message ?? 'Password must contain at least one uppercase letter';
    }

    if (!RegExp('[a-z]').hasMatch(value)) {
      return message ?? 'Password must contain at least one lowercase letter';
    }

    if (!RegExp('[0-9]').hasMatch(value)) {
      return message ?? 'Password must contain at least one number';
    }

    return null;
  };
}
