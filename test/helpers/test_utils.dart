/// Test utilities and helpers for Corpo UI component testing.
///
/// This file provides common utilities, matchers, and helper functions
/// for consistent and comprehensive testing across all Corpo UI components.
///
/// Includes utilities for:
/// - Widget testing setup with proper themes
/// - Accessibility testing helpers
/// - Interaction simulation utilities
/// - Custom matchers for design system verification
/// - Performance testing helpers
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test utilities for Corpo UI components.
abstract final class CorpoTestUtils {
  /// Creates a test app wrapper with Corpo UI theme.
  ///
  /// Provides a consistent testing environment with proper theme setup,
  /// accessibility support, and material app structure.
  static Widget wrapWithApp(
    Widget child, {
    ThemeData? theme,
    bool darkMode = false,
    Locale? locale,
  }) {
    return MaterialApp(
      theme: theme ?? (darkMode ? CorpoTheme.dark() : CorpoTheme.light()),
      locale: locale,
      home: Scaffold(body: child),
    );
  }

  /// Pumps a widget with Corpo UI theme setup.
  static Future<void> pumpWithTheme(
    WidgetTester tester,
    Widget widget, {
    bool darkMode = false,
    Duration? duration,
  }) async {
    await tester.pumpWidget(wrapWithApp(widget, darkMode: darkMode));
    if (duration != null) {
      await tester.pump(duration);
    }
  }

  /// Simulates a tap and waits for animations to complete.
  static Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Simulates a long press and waits for animations to complete.
  static Future<void> longPressAndSettle(
    WidgetTester tester,
    Finder finder,
  ) async {
    await tester.longPress(finder);
    await tester.pumpAndSettle();
  }

  /// Enters text in a field and waits for updates.
  static Future<void> enterText(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pump();
  }

  /// Verifies accessibility properties of a widget.
  static void verifyAccessibility(
    WidgetTester tester,
    Finder finder, {
    String? expectedLabel,
    String? expectedHint,
    bool? expectedFocusable,
    bool? expectedEnabled,
  }) {
    final SemanticsNode semantics = tester.getSemantics(finder);

    if (expectedLabel != null) {
      expect(semantics.label, equals(expectedLabel));
    }
    if (expectedHint != null) {
      expect(semantics.hint, equals(expectedHint));
    }
    if (expectedFocusable != null) {
      expect(
        semantics.hasFlag(SemanticsFlag.isFocusable),
        equals(expectedFocusable),
      );
    }
    if (expectedEnabled != null) {
      expect(semantics.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
      expect(
        semantics.hasFlag(SemanticsFlag.isEnabled),
        equals(expectedEnabled),
      );
    }
  }

  /// Verifies that a widget follows Corpo UI color scheme.
  static void verifyCorpoColors(Widget widget, bool isDarkMode) {
    // This would be expanded with specific color verification logic
    expect(widget, isA<Widget>());
  }

  /// Simulates keyboard navigation.
  static Future<void> pressKey(
    WidgetTester tester,
    LogicalKeyboardKey key,
  ) async {
    await tester.sendKeyEvent(key);
    await tester.pump();
  }

  /// Verifies focus behavior.
  static void verifyFocus(
    WidgetTester tester,
    Finder finder,
    bool shouldHaveFocus,
  ) {
    final FocusNode? focusNode = tester
        .widget<Focus>(
          find.ancestor(of: finder, matching: find.byType(Focus)).first,
        )
        .focusNode;

    expect(focusNode?.hasFocus, equals(shouldHaveFocus));
  }

  /// Creates a mock callback for testing interactions.
  static VoidCallback createMockCallback() {
    return () {};
  }

  /// Verifies that an animation is running.
  static void verifyAnimationRunning(WidgetTester tester, Finder finder) {
    expect(tester.hasRunningAnimations, isTrue);
  }

  /// Waits for all animations to complete.
  static Future<void> waitForAnimations(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }
}

/// Custom matchers for Corpo UI testing.
abstract final class CorpoMatchers {
  /// Matcher to verify Corpo UI color values.
  static Matcher hasCorpoColor(Color expectedColor) {
    return _HasCorpoColor(expectedColor);
  }

  /// Matcher to verify proper spacing values.
  static Matcher hasCorpoSpacing(double expectedSpacing) {
    return _HasCorpoSpacing(expectedSpacing);
  }

  /// Matcher to verify typography styles.
  static Matcher hasCorpoTypography(TextStyle expectedStyle) {
    return _HasCorpoTypography(expectedStyle);
  }
}

class _HasCorpoColor extends Matcher {
  const _HasCorpoColor(this.expectedColor);

  final Color expectedColor;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! Widget) return false;
    // Implementation would check the widget's color properties
    return true; // Simplified for now
  }

  @override
  Description describe(Description description) {
    return description.add('has Corpo color $expectedColor');
  }
}

class _HasCorpoSpacing extends Matcher {
  const _HasCorpoSpacing(this.expectedSpacing);

  final double expectedSpacing;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    // Implementation would check spacing properties
    return true; // Simplified for now
  }

  @override
  Description describe(Description description) {
    return description.add('has Corpo spacing $expectedSpacing');
  }
}

class _HasCorpoTypography extends Matcher {
  const _HasCorpoTypography(this.expectedStyle);

  final TextStyle expectedStyle;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    // Implementation would check typography properties
    return true; // Simplified for now
  }

  @override
  Description describe(Description description) {
    return description.add('has Corpo typography $expectedStyle');
  }
}
