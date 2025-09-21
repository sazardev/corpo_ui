import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Corpo UI Foundation Tests', () {
    group('✅ NEW: Design Tokens (ShadCN-style)', () {
      test('CorpoDesignTokens provides default values', () {
        final CorpoDesignTokens tokens = CorpoDesignTokens();

        // Colors
        expect(tokens.primaryColor, isA<Color>());
        expect(tokens.secondaryColor, isA<Color>());
        expect(tokens.surfaceColor, isA<Color>());
        expect(tokens.textPrimary, isA<Color>());
        expect(tokens.textSecondary, isA<Color>());
        expect(tokens.errorColor, isA<Color>());
        expect(tokens.successColor, isA<Color>());
        expect(tokens.warningColor, isA<Color>());
        expect(tokens.infoColor, isA<Color>());

        // Spacing
        expect(tokens.baseSpacing, equals(4.0));
        expect(tokens.spacing1x, equals(4.0));
        expect(tokens.spacing2x, equals(8.0));
        expect(tokens.spacing4x, equals(16.0));
        expect(tokens.spacing6x, equals(24.0));
        expect(tokens.spacing8x, equals(32.0));

        // Typography - test actual values not specific numbers
        expect(tokens.baseFontSize, greaterThan(12.0));
        expect(tokens.baseFontSize, lessThan(20.0));
        expect(tokens.fontFamily, isNotNull);
        expect(tokens.fontSizeSmall, lessThan(tokens.baseFontSize));
        expect(tokens.fontSizeLarge, greaterThan(tokens.baseFontSize));

        // Border radius
        expect(tokens.borderRadius, equals(8.0));
        expect(tokens.borderRadiusSmall, equals(4.0));
        expect(tokens.borderRadiusLarge, equals(16.0));
      });

      test('CorpoDesignTokens.configure() changes values globally', () {
        final CorpoDesignTokens tokens = CorpoDesignTokens();
        final Color originalPrimary = tokens.primaryColor;

        // Configure with new values
        CorpoDesignTokens.configure(primaryColor: Colors.purple);

        expect(tokens.primaryColor, equals(Colors.purple));
        expect(tokens.primaryColor, isNot(equals(originalPrimary)));

        // Note: Reset manually for next test
        CorpoDesignTokens.configure(primaryColor: originalPrimary);
      });

      test('CorpoDesignTokens provides accessible text colors', () {
        final CorpoDesignTokens tokens = CorpoDesignTokens();

        // Test contrast function
        final Color textOnPrimary = tokens.getTextColorFor(tokens.primaryColor);
        expect(textOnPrimary, isA<Color>());

        final Color textOnLight = tokens.getTextColorFor(Colors.white);
        final Color textOnDark = tokens.getTextColorFor(Colors.black);

        expect(
          textOnLight,
          isNot(equals(textOnDark)),
        ); // Should be different for contrast
      });
    });

    testWidgets('CorpoTheme.light() creates a valid light theme', (
      WidgetTester tester,
    ) async {
      final CorpoDesignTokens tokens = CorpoDesignTokens();
      final ThemeData lightTheme = CorpoTheme.light();

      expect(lightTheme.brightness, equals(Brightness.light));
      expect(lightTheme.useMaterial3, isTrue);
      expect(lightTheme.colorScheme.primary, equals(tokens.primaryColor));

      // Test that the theme can be applied without errors
      await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: const Scaffold(body: Text('Test')),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('CorpoTheme.dark() creates a valid dark theme', (
      WidgetTester tester,
    ) async {
      final CorpoDesignTokens tokens = CorpoDesignTokens();
      final ThemeData darkTheme = CorpoTheme.dark();

      expect(darkTheme.brightness, equals(Brightness.dark));
      expect(darkTheme.useMaterial3, isTrue);
      expect(darkTheme.colorScheme.primary, equals(tokens.primaryColor));

      // Test that the theme can be applied without errors
      await tester.pumpWidget(
        MaterialApp(
          theme: darkTheme,
          home: const Scaffold(body: Text('Test')),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });
  });
}
