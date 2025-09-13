import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Corpo UI Foundation Tests', () {
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
