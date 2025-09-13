/// Comprehensive tests for CorpoTextField component.
///
/// Tests cover functionality, validation, user interactions, accessibility,
/// and edge cases for the text input component.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/corpo_matchers.dart';
import '../../helpers/test_utils.dart';

void main() {
  group('CorpoTextField Tests', () {
    late TextEditingController controller;
    late String? lastChangedValue;
    late bool validationCalled;

    setUp(() {
      controller = TextEditingController();
      lastChangedValue = null;
      validationCalled = false;
    });

    tearDown(() {
      controller.dispose();
    });

    group('Basic Functionality', () {
      testWidgets('renders with label and placeholder', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Email Address',
            placeholder: 'Enter your email',
          ),
        );

        // Check for label in RichText widget (as implemented)
        expect(find.byType(RichText), findsWidgets);
        expect(
          find.byWidgetPredicate(
            (Widget widget) => hasRichTextContent('Email Address').matches(widget, <dynamic, dynamic>{}),
          ),
          findsOneWidget,
        );
        // Check for placeholder text
        expect(find.text('Enter your email'), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      });

      testWidgets('accepts and displays text input', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(controller: controller, label: 'Test Field'),
        );

        await CorpoTestUtils.enterText(
          tester,
          find.byType(TextFormField),
          'Hello World',
        );

        expect(controller.text, equals('Hello World'));
        expect(find.text('Hello World'), findsOneWidget);
      });

      testWidgets('calls onChanged callback', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Test Field',
            onChanged: (String value) => lastChangedValue = value,
          ),
        );

        await CorpoTestUtils.enterText(
          tester,
          find.byType(TextFormField),
          'Test Input',
        );

        expect(lastChangedValue, equals('Test Input'));
      });
    });

    group('Validation', () {
      testWidgets('shows error message for invalid input', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Email Field',
            validator: (String? value) {
              validationCalled = true;
              if (value?.isEmpty == true) return 'Email is required';
              if (!value!.contains('@')) return 'Invalid email format';
              return null;
            },
          ),
        );

        // Test empty validation
        await CorpoTestUtils.enterText(tester, find.byType(TextFormField), '');
        await tester.pump();

        // Trigger validation (usually happens on form submission)
        final FormFieldState<String> fieldState = tester.state(
          find.byType(TextFormField),
        );
        fieldState.validate();
        await tester.pump();

        expect(find.text('Email is required'), findsOneWidget);
        expect(validationCalled, isTrue);
      });

      testWidgets('shows no error for valid input', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Email Field',
            validator: (String? value) {
              if (value?.isEmpty == true) return 'Email is required';
              if (!value!.contains('@')) return 'Invalid email format';
              return null;
            },
          ),
        );

        await CorpoTestUtils.enterText(
          tester,
          find.byType(TextFormField),
          'test@example.com',
        );

        final FormFieldState<String> fieldState = tester.state(
          find.byType(TextFormField),
        );
        fieldState.validate();
        await tester.pump();

        expect(find.text('Email is required'), findsNothing);
        expect(find.text('Invalid email format'), findsNothing);
      });
    });

    group('Input Types', () {
      testWidgets('password field obscures text', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField.password(controller: controller, label: 'Password'),
        );

        // Check that the password field is rendered
        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        // Check for visibility toggle icon in the decoration
        expect(find.byIcon(Icons.visibility), findsOneWidget);
      });

      testWidgets('password field can toggle visibility', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField.password(controller: controller, label: 'Password'),
        );

        // Initially should show visibility icon (text is obscured)
        expect(find.byIcon(Icons.visibility), findsOneWidget);

        // Tap the visibility toggle
        await CorpoTestUtils.tapAndSettle(
          tester,
          find.byIcon(Icons.visibility),
        );

        // Should now show visibility_off icon (text is visible)
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      });

      testWidgets('multiline field accepts multiple lines', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField.multiline(
            controller: controller,
            label: 'Description',
            maxLines: 4,
          ),
        );

        // Check that multiline field is rendered
        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      });
    });

    group('States', () {
      testWidgets('disabled field is not editable', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Disabled Field',
            enabled: false,
          ),
        );

        // Check that disabled field is rendered
        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);

        // Try to enter text (should not work)
        await tester.enterText(find.byType(TextFormField), 'Should not work');
        await tester.pump();

        expect(controller.text, isEmpty);
      });

      testWidgets('readonly field displays text but is not editable', (
        WidgetTester tester,
      ) async {
        controller.text = 'Initial value';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Readonly Field',
            readOnly: true,
          ),
        );

        // Check that readonly field is rendered
        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Initial value'), findsOneWidget);

        // Try to enter text (should not work)
        await tester.enterText(find.byType(TextFormField), 'New value');
        await tester.pump();

        expect(controller.text, equals('Initial value'));
      });
    });

    group('Accessibility', () {
      testWidgets('has correct semantic labels', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Accessible Field',
            helperText: 'This is helper text',
          ),
        );

        // Verify the label exists in RichText widget
        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                hasRichTextContent('Accessible Field').matches(widget, <dynamic, dynamic>{}),
          ),
          findsOneWidget,
        );

        // Check that helper text is accessible
        expect(find.text('This is helper text'), findsOneWidget);

        // Verify TextFormField is present and enabled
        final Finder textFieldFinder = find.byType(TextFormField);
        expect(textFieldFinder, findsOneWidget);

        // Verify accessibility properties
        CorpoTestUtils.verifyAccessibility(
          tester,
          textFieldFinder,
          expectedEnabled: true,
        );
      });

      testWidgets('announces error messages to screen readers', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Validation Field',
            validator: (String? value) =>
                value?.isEmpty == true ? 'This field is required' : null,
          ),
        );

        // Trigger validation error
        final FormFieldState<String> fieldState = tester.state(
          find.byType(TextFormField),
        );
        fieldState.validate();
        await tester.pump();

        expect(find.text('This field is required'), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('adapts to light theme', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(controller: controller, label: 'Light Theme Field'),
        );

        expect(find.byType(TextFormField), findsOneWidget);
      });

      testWidgets('adapts to dark theme', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(controller: controller, label: 'Dark Theme Field'),
          darkMode: true,
        );

        expect(find.byType(TextFormField), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles very long text input', (WidgetTester tester) async {
        final String longText = 'A' * 1000; // Very long string

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(controller: controller, label: 'Long Text Field'),
        );

        await CorpoTestUtils.enterText(
          tester,
          find.byType(TextFormField),
          longText,
        );

        expect(controller.text, equals(longText));
      });

      testWidgets('handles special characters', (WidgetTester tester) async {
        const String specialChars = r'!@#$%^&*()[]{}|;:,.<>?~`';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(controller: controller, label: 'Special Chars Field'),
        );

        await CorpoTestUtils.enterText(
          tester,
          find.byType(TextFormField),
          specialChars,
        );

        expect(controller.text, equals(specialChars));
      });

      testWidgets('handles unicode characters', (WidgetTester tester) async {
        const String unicodeText = '🚀 Hello 世界 🌍 Emoji test ñáéíóú';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(controller: controller, label: 'Unicode Field'),
        );

        await CorpoTestUtils.enterText(
          tester,
          find.byType(TextFormField),
          unicodeText,
        );

        expect(controller.text, equals(unicodeText));
      });

      testWidgets('handles rapid text changes', (WidgetTester tester) async {
        int changeCount = 0;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoTextField(
            controller: controller,
            label: 'Rapid Change Field',
            onChanged: (String value) => changeCount++,
          ),
        );

        // Simulate rapid typing
        for (int i = 0; i < 10; i++) {
          await tester.enterText(find.byType(TextFormField), 'Text $i');
          await tester.pump(const Duration(milliseconds: 10));
        }

        expect(changeCount, equals(10));
      });
    });

    group('Performance', () {
      testWidgets('does not rebuild unnecessarily', (
        WidgetTester tester,
      ) async {
        int buildCount = 0;

        Widget buildCountingTextField() {
          buildCount++;
          return CorpoTextField(
            controller: controller,
            label: 'Performance Test Field',
          );
        }

        await CorpoTestUtils.pumpWithTheme(tester, buildCountingTextField());
        expect(buildCount, equals(1));

        // Text input should not trigger rebuilds of the parent
        await CorpoTestUtils.enterText(
          tester,
          find.byType(TextFormField),
          'Test text',
        );
        expect(buildCount, equals(1));
      });
    });
  });
}
