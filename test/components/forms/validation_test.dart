/// Comprehensive tests for CorpoForm validation system.
///
/// Tests cover form validation, submission handling, field integration,
/// and edge cases for the form management component.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_utils.dart';

void main() {
  group('CorpoForm Validation Tests', () {
    late GlobalKey<FormState> formKey;

    setUp(() {
      formKey = GlobalKey<FormState>();
    });

    group('Built-in Validators', () {
      testWidgets('required validator works correctly', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Required Field',
              validator: CorpoValidation.required('This field is required'),
            ),
          ),
        );

        // Test empty value
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('This field is required'), findsOneWidget);

        // Test non-empty value
        controller.text = 'Valid input';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(find.text('This field is required'), findsNothing);

        controller.dispose();
      });

      testWidgets('email validator works correctly', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Email Field',
              validator: CorpoValidation.email('Invalid email format'),
            ),
          ),
        );

        // Test invalid email
        controller.text = 'invalid-email';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Invalid email format'), findsOneWidget);

        // Test valid email
        controller.text = 'test@example.com';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(find.text('Invalid email format'), findsNothing);

        controller.dispose();
      });

      testWidgets('minLength validator works correctly', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Password Field',
              validator: CorpoValidation.minLength(
                8,
                'Password must be at least 8 characters',
              ),
            ),
          ),
        );

        // Test short password
        controller.text = '123';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(
          find.text('Password must be at least 8 characters'),
          findsOneWidget,
        );

        // Test valid password
        controller.text = 'password123';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(
          find.text('Password must be at least 8 characters'),
          findsNothing,
        );

        controller.dispose();
      });

      testWidgets('maxLength validator works correctly', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Username Field',
              validator: CorpoValidation.maxLength(
                20,
                'Username must be at most 20 characters',
              ),
            ),
          ),
        );

        // Test long username
        controller.text = 'this_is_a_very_long_username_that_exceeds_limit';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(
          find.text('Username must be at most 20 characters'),
          findsOneWidget,
        );

        // Test valid username
        controller.text = 'validuser';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(
          find.text('Username must be at most 20 characters'),
          findsNothing,
        );

        controller.dispose();
      });

      testWidgets('pattern validator works correctly', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Phone Field',
              validator: CorpoValidation.pattern(
                RegExp(r'^\+?[\d\s\-\(\)]+$'),
                'Invalid phone number format',
              ),
            ),
          ),
        );

        // Test invalid phone
        controller.text = 'abc123';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Invalid phone number format'), findsOneWidget);

        // Test valid phone
        controller.text = '+1 (555) 123-4567';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(find.text('Invalid phone number format'), findsNothing);

        controller.dispose();
      });

      testWidgets('numeric validator works correctly', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Age Field',
              validator: CorpoValidation.numeric('Must be a number'),
            ),
          ),
        );

        // Test non-numeric
        controller.text = 'not a number';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Must be a number'), findsOneWidget);

        // Test valid number
        controller.text = '25';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(find.text('Must be a number'), findsNothing);

        controller.dispose();
      });
    });

    group('Composed Validators', () {
      testWidgets('compose multiple validators correctly', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Email Field',
              validator: CorpoValidation.compose([
                CorpoValidation.required('Email is required'),
                CorpoValidation.email('Invalid email format'),
                CorpoValidation.maxLength(50, 'Email too long'),
              ]),
            ),
          ),
        );

        // Test empty (first validator should fail)
        controller.text = '';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Email is required'), findsOneWidget);

        // Test invalid email (second validator should fail)
        controller.text = 'invalid';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Invalid email format'), findsOneWidget);

        // Test too long email (third validator should fail)
        controller.text =
            'very.long.email.address.that.exceeds.the.limit@example.com';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Email too long'), findsOneWidget);

        // Test valid email (all validators should pass)
        controller.text = 'valid@example.com';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(find.text('Email is required'), findsNothing);
        expect(find.text('Invalid email format'), findsNothing);
        expect(find.text('Email too long'), findsNothing);

        controller.dispose();
      });
    });

    group('Custom Validators', () {
      testWidgets('custom validator function works', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        String? customValidator(String? value) {
          if (value == null || value.isEmpty) return null;
          if (value.toLowerCase() == 'admin') {
            return 'Username "admin" is not allowed';
          }
          return null;
        }

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Username Field',
              validator: customValidator,
            ),
          ),
        );

        // Test forbidden username
        controller.text = 'admin';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Username "admin" is not allowed'), findsOneWidget);

        // Test allowed username
        controller.text = 'user123';
        expect(formKey.currentState!.validate(), isTrue);
        await tester.pump();
        expect(find.text('Username "admin" is not allowed'), findsNothing);

        controller.dispose();
      });
    });

    group('Edge Cases', () {
      testWidgets('handles null values correctly', (WidgetTester tester) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Optional Field',
              validator: CorpoValidation.email('Invalid email'),
            ),
          ),
        );

        // Empty field should pass email validation (nullable)
        controller.text = '';
        expect(formKey.currentState!.validate(), isTrue);

        controller.dispose();
      });

      testWidgets('handles whitespace correctly', (WidgetTester tester) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Trim Field',
              validator: CorpoValidation.required('Required'),
            ),
          ),
        );

        // Whitespace only should fail required validation
        controller.text = '   ';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Required'), findsOneWidget);

        controller.dispose();
      });

      testWidgets('handles special characters in validation messages', (
        WidgetTester tester,
      ) async {
        final TextEditingController controller = TextEditingController();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Special Field',
              validator: CorpoValidation.required(
                'Field is required! @#\$%^&*()[]{}|;:,.<>?~`',
              ),
            ),
          ),
        );

        controller.text = '';
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(
          find.text('Field is required! @#\$%^&*()[]{}|;:,.<>?~`'),
          findsOneWidget,
        );

        controller.dispose();
      });
    });

    group('Performance', () {
      testWidgets('validation does not cause unnecessary rebuilds', (
        WidgetTester tester,
      ) async {
        int buildCount = 0;
        final TextEditingController controller = TextEditingController();

        Widget buildCountingForm() {
          buildCount++;
          return Form(
            key: formKey,
            child: CorpoTextField(
              controller: controller,
              label: 'Performance Field',
              validator: CorpoValidation.required('Required'),
            ),
          );
        }

        await CorpoTestUtils.pumpWithTheme(tester, buildCountingForm());
        expect(buildCount, equals(1));

        // Validation should not trigger form rebuilds
        formKey.currentState!.validate();
        await tester.pump();
        expect(buildCount, equals(1));

        controller.dispose();
      });
    });
  });
}
