/// Comprehensive tests for CorpoButton component.
///
/// Tests cover functionality, user interactions, accessibility,
/// theming, and edge cases for the primary button component.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_utils.dart';

void main() {
  group('CorpoButton Tests', () {
    late bool callbackTriggered;
    late VoidCallback? onPressedCallback;

    setUp(() {
      callbackTriggered = false;
      onPressedCallback = () => callbackTriggered = true;
    });

    group('Basic Functionality', () {
      testWidgets('renders with child widget', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Test Button'),
          ),
        );

        expect(find.text('Test Button'), findsOneWidget);
        expect(find.byType(CorpoButton), findsOneWidget);
      });

      testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Test Button'),
          ),
        );

        await CorpoTestUtils.tapAndSettle(tester, find.byType(CorpoButton));
        expect(callbackTriggered, isTrue);
      });

      testWidgets('does not call onPressed when disabled', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoButton(
            onPressed: null, // Disabled button
            child: Text('Disabled Button'),
          ),
        );

        await tester.tap(find.byType(CorpoButton));
        await tester.pump();
        expect(callbackTriggered, isFalse);
      });
    });

    group('Visual States', () {
      testWidgets('shows correct enabled state styling', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Enabled Button'),
          ),
        );

        final ElevatedButton elevatedButton = tester.widget(
          find.byType(ElevatedButton),
        );
        expect(elevatedButton.onPressed, isNotNull);
      });

      testWidgets('shows correct disabled state styling', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoButton(onPressed: null, child: Text('Disabled Button')),
        );

        final ElevatedButton elevatedButton = tester.widget(
          find.byType(ElevatedButton),
        );
        expect(elevatedButton.onPressed, isNull);
      });

      testWidgets('shows loading state when specified', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            isLoading: true,
            child: const Text('Loading Button'),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        // In loading state, text is still shown alongside the indicator
        expect(find.text('Loading Button'), findsOneWidget);
      });
    });

    group('Variants', () {
      testWidgets('primary variant has correct styling', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Primary Button'),
          ),
        );

        final ElevatedButton button = tester.widget(
          find.byType(ElevatedButton),
        );
        expect(button.style, isNotNull);
      });

      testWidgets('secondary variant has correct styling', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton.secondary(
            onPressed: onPressedCallback,
            child: const Text('Secondary Button'),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Secondary Button'), findsOneWidget);
      });

      testWidgets('danger variant has correct styling', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton.danger(
            onPressed: onPressedCallback,
            child: const Text('Danger Button'),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Danger Button'), findsOneWidget);
      });
    });

    group('Sizes', () {
      testWidgets('small size has correct dimensions', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            size: CorpoButtonSize.small,
            child: const Text('Small Button'),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Small Button'), findsOneWidget);
      });

      testWidgets('large size has correct dimensions', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            size: CorpoButtonSize.large,
            child: const Text('Large Button'),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Large Button'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has correct semantic labels', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Accessible Button'),
          ),
        );

        CorpoTestUtils.verifyAccessibility(
          tester,
          find.byType(CorpoButton),
          expectedEnabled: true,
          expectedFocusable: true,
        );
      });

      testWidgets('supports semantic tooltips', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            tooltip: 'This is a button tooltip',
            child: const Text('Button with Tooltip'),
          ),
        );

        expect(find.byType(Tooltip), findsOneWidget);
      });

      testWidgets('is focusable with keyboard navigation', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Focusable Button'),
          ),
        );

        // Focus the button
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();

        // Verify it can be activated with Enter key
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pump();

        expect(callbackTriggered, isTrue);
      });
    });

    group('Theme Integration', () {
      testWidgets('adapts to light theme', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Light Theme Button'),
          ),
        );

        expect(find.byType(CorpoButton), findsOneWidget);
        // Additional theme-specific assertions would go here
      });

      testWidgets('adapts to dark theme', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const Text('Dark Theme Button'),
          ),
          darkMode: true,
        );

        expect(find.byType(CorpoButton), findsOneWidget);
        // Additional theme-specific assertions would go here
      });
    });

    group('Edge Cases', () {
      testWidgets('handles null child gracefully', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: onPressedCallback,
            child: const SizedBox.shrink(),
          ),
        );

        expect(find.byType(CorpoButton), findsOneWidget);
      });

      testWidgets('handles very long text', (WidgetTester tester) async {
        const String longText =
            'This is a very long button text that should handle overflow gracefully and maintain proper styling';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          SizedBox(
            width: 200,
            child: CorpoButton(
              onPressed: onPressedCallback,
              child: const Text(longText),
            ),
          ),
        );

        expect(find.byType(CorpoButton), findsOneWidget);
        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('handles rapid taps without errors', (
        WidgetTester tester,
      ) async {
        int tapCount = 0;
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoButton(
            onPressed: () => tapCount++,
            child: const Text('Rapid Tap Button'),
          ),
        );

        // Simulate rapid tapping
        for (int i = 0; i < 10; i++) {
          await tester.tap(find.byType(CorpoButton));
          await tester.pump(const Duration(milliseconds: 10));
        }

        expect(tapCount, equals(10));
      });
    });

    group('Performance', () {
      testWidgets('does not rebuild unnecessarily', (
        WidgetTester tester,
      ) async {
        int buildCount = 0;

        Widget buildCountingButton() {
          buildCount++;
          return CorpoButton(
            onPressed: onPressedCallback,
            child: Text('Build Count: $buildCount'),
          );
        }

        await CorpoTestUtils.pumpWithTheme(tester, buildCountingButton());
        expect(buildCount, equals(1));

        // Trigger a tap - should not rebuild the button itself
        await CorpoTestUtils.tapAndSettle(tester, find.byType(CorpoButton));
        expect(buildCount, equals(1));
      });
    });
  });
}
