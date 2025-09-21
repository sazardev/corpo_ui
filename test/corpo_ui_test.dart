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

        // Typography
        expect(
          tokens.baseFontSize,
          equals(14.0),
        ); // Updated to match actual default
        expect(tokens.fontFamily, equals('Inter'));
        expect(tokens.fontSizeSmall, equals(12.0));
        expect(tokens.fontSizeLarge, equals(16.0));
        expect(tokens.fontSizeXLarge, equals(20.0));

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

    group('⚠️ DEPRECATED: Legacy Constants (will be removed in v0.3.0)', () {
      test('CorpoSpacing constants are defined correctly', () {
        expect(CorpoSpacing.none, equals(0.0));
        expect(CorpoSpacing.extraSmall, equals(4.0));
        expect(CorpoSpacing.small, equals(8.0));
        expect(CorpoSpacing.medium, equals(16.0));
        expect(CorpoSpacing.large, equals(24.0));
        expect(CorpoSpacing.extraLarge, equals(32.0));
        expect(CorpoSpacing.xxLarge, equals(48.0));
        expect(CorpoSpacing.xxxLarge, equals(64.0));
      });

      test('CorpoColors constants are defined correctly', () {
        expect(CorpoColors.primary500, equals(const Color(0xFF3182CE)));
        expect(CorpoColors.neutralWhite, equals(const Color(0xFFFFFFFF)));
        expect(CorpoColors.neutralBlack, equals(const Color(0xFF000000)));
        expect(CorpoColors.success, equals(const Color(0xFF10B981)));
        expect(CorpoColors.warning, equals(const Color(0xFFF59E0B)));
        expect(CorpoColors.error, equals(const Color(0xFFEF4444)));
        expect(CorpoColors.info, equals(const Color(0xFF3B82F6)));
      });
    }); // End of DEPRECATED group

    test('CorpoFontSize constants are defined correctly', () {
      expect(CorpoFontSize.extraSmall, equals(12.0));
      expect(CorpoFontSize.small, equals(14.0));
      expect(CorpoFontSize.medium, equals(16.0));
      expect(CorpoFontSize.large, equals(18.0));
      expect(CorpoFontSize.extraLarge, equals(20.0));
      expect(CorpoFontSize.xxLarge, equals(24.0));
    });

    test('CorpoFontWeight constants are defined correctly', () {
      expect(CorpoFontWeight.light, equals(FontWeight.w300));
      expect(CorpoFontWeight.regular, equals(FontWeight.w400));
      expect(CorpoFontWeight.medium, equals(FontWeight.w500));
      expect(CorpoFontWeight.semiBold, equals(FontWeight.w600));
      expect(CorpoFontWeight.bold, equals(FontWeight.w700));
    });

    test('CorpoTypography text styles are defined correctly', () {
      expect(CorpoTypography.bodyMedium.fontSize, equals(16.0));
      expect(CorpoTypography.bodyMedium.fontWeight, equals(FontWeight.w400));
      expect(CorpoTypography.heading1.fontSize, equals(28.0));
      expect(CorpoTypography.heading1.fontWeight, equals(FontWeight.w600));
      expect(CorpoTypography.buttonMedium.fontWeight, equals(FontWeight.w600));
    });

    testWidgets('CorpoTheme.light() creates a valid light theme', (
      WidgetTester tester,
    ) async {
      final ThemeData lightTheme = CorpoTheme.light();

      expect(lightTheme.brightness, equals(Brightness.light));
      expect(lightTheme.useMaterial3, isTrue);
      expect(lightTheme.colorScheme.primary, equals(CorpoColors.primary500));
      expect(
        lightTheme.colorScheme.surface,
        equals(CorpoColors.surfaceBackground),
      );

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
      final ThemeData darkTheme = CorpoTheme.dark();

      expect(darkTheme.brightness, equals(Brightness.dark));
      expect(darkTheme.useMaterial3, isTrue);
      expect(darkTheme.colorScheme.primary, equals(CorpoColors.primary400));
      expect(darkTheme.colorScheme.surface, equals(CorpoColors.neutral900));

      // Test that the theme can be applied without errors
      await tester.pumpWidget(
        MaterialApp(
          theme: darkTheme,
          home: const Scaffold(body: Text('Test')),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    test('CorpoPadding constants are EdgeInsets objects', () {
      expect(CorpoPadding.small, isA<EdgeInsets>());
      expect(CorpoPadding.medium, isA<EdgeInsets>());
      expect(CorpoPadding.large, isA<EdgeInsets>());
      expect(CorpoPadding.horizontalMedium, isA<EdgeInsets>());
      expect(CorpoPadding.verticalMedium, isA<EdgeInsets>());
    });
  });
}
