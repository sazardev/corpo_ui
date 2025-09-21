/// Comprehensive tests for CorpoCard component.
///
/// Tests cover functionality, styling, accessibility,
/// and edge cases for the card layout component.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/semantics/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_utils.dart';

void main() {
  group('CorpoCard Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with child content', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(child: Text('Card Content')),
        );

        expect(find.text('Card Content'), findsOneWidget);
        expect(find.byType(CorpoCard), findsOneWidget);
      });

      testWidgets('renders with complex child', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            child: Column(
              children: <Widget>[
                Text('Title'),
                Text('Subtitle'),
                Icon(Icons.star),
              ],
            ),
          ),
        );

        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Subtitle'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });
    });

    group('Styling and Variants', () {
      testWidgets('applies default styling', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(child: Text('Default Card')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.variant, equals(CorpoCardVariant.filled));
        expect(card.elevation, equals(CorpoCardElevation.medium));
        expect(card.padding, equals(CorpoCardPadding.medium));
      });

      testWidgets('applies elevated variant', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard.elevated(child: Text('Elevated Card')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.variant, equals(CorpoCardVariant.elevated));
        expect(card.elevation, equals(CorpoCardElevation.high));
      });

      testWidgets('applies outlined variant', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard.outlined(child: Text('Outlined Card')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.variant, equals(CorpoCardVariant.outlined));
        expect(card.elevation, equals(CorpoCardElevation.none));
      });

      testWidgets('applies tinted variant', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard.tinted(child: Text('Tinted Card')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.variant, equals(CorpoCardVariant.tinted));
        expect(card.elevation, equals(CorpoCardElevation.low));
      });

      testWidgets('respects custom padding', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            padding: CorpoCardPadding.large,
            child: Text('Custom Padding'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.padding, equals(CorpoCardPadding.large));
      });

      testWidgets('respects custom margin', (WidgetTester tester) async {
        const EdgeInsets customMargin = EdgeInsets.symmetric(horizontal: 16);

        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(margin: customMargin, child: Text('Custom Margin')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.margin, equals(customMargin));
      });

      testWidgets('applies custom color', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            color: const Color(0xFFE3F2FD),
            child: Text('Colored Card'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.color, equals(const Color(0xFFE3F2FD)));
      });
    });

    group('Interactions', () {
      testWidgets('handles tap when onTap provided', (
        WidgetTester tester,
      ) async {
        bool tapped = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCard(
            onTap: () => tapped = true,
            child: const Text('Tappable Card'),
          ),
        );

        await tester.tap(find.byType(CorpoCard));
        expect(tapped, isTrue);
      });

      testWidgets('handles long press when onLongPress provided', (
        WidgetTester tester,
      ) async {
        bool longPressed = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCard(
            onLongPress: () => longPressed = true,
            child: const Text('Long Press Card'),
          ),
        );

        await tester.longPress(find.byType(CorpoCard));
        expect(longPressed, isTrue);
      });

      testWidgets('shows material when interactive', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCard(onTap: () {}, child: const Text('Interactive Card')),
        );

        // Should have Material widget for ink effects
        expect(find.byType(Material), findsWidgets);
      });
    });

    group('Elevation Levels', () {
      testWidgets('renders none elevation correctly', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            elevation: CorpoCardElevation.none,
            child: Text('No Elevation'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.elevation, equals(CorpoCardElevation.none));
      });

      testWidgets('renders low elevation correctly', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            elevation: CorpoCardElevation.low,
            child: Text('Low Elevation'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.elevation, equals(CorpoCardElevation.low));
      });

      testWidgets('renders medium elevation correctly', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(child: Text('Medium Elevation')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.elevation, equals(CorpoCardElevation.medium));
      });

      testWidgets('renders high elevation correctly', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            elevation: CorpoCardElevation.high,
            child: Text('High Elevation'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.elevation, equals(CorpoCardElevation.high));
      });

      testWidgets('renders maximum elevation correctly', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            elevation: CorpoCardElevation.maximum,
            child: Text('Maximum Elevation'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.elevation, equals(CorpoCardElevation.maximum));
      });
    });

    group('Padding Variants', () {
      testWidgets('applies none padding', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            padding: CorpoCardPadding.none,
            child: Text('No Padding'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.padding, equals(CorpoCardPadding.none));
      });

      testWidgets('applies small padding', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            padding: CorpoCardPadding.small,
            child: Text('Small Padding'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.padding, equals(CorpoCardPadding.small));
      });

      testWidgets('applies large padding', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            padding: CorpoCardPadding.large,
            child: Text('Large Padding'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.padding, equals(CorpoCardPadding.large));
      });

      testWidgets('applies extra large padding', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            padding: CorpoCardPadding.extraLarge,
            child: Text('Extra Large Padding'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.padding, equals(CorpoCardPadding.extraLarge));
      });
    });

    group('Layout Behavior', () {
      testWidgets('respects custom width', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(width: 200, child: Text('Fixed Width Card')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.width, equals(200));
      });

      testWidgets('respects custom height', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(height: 150, child: Text('Fixed Height Card')),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.height, equals(150));
      });

      testWidgets('respects custom border radius', (WidgetTester tester) async {
        const BorderRadius customRadius = BorderRadius.all(Radius.circular(16));

        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            borderRadius: customRadius,
            child: Text('Custom Radius'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.borderRadius, equals(customRadius));
      });

      testWidgets('respects clip behavior', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(
            clipBehavior: Clip.hardEdge,
            child: Text('Hard Edge Clip'),
          ),
        );

        final CorpoCard card = tester.widget<CorpoCard>(find.byType(CorpoCard));
        expect(card.clipBehavior, equals(Clip.hardEdge));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles complex nested content', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCard(
            child: ListView(
              shrinkWrap: true,
              children: const <Widget>[
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
                ListTile(title: Text('Item 3')),
              ],
            ),
          ),
        );

        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Item 2'), findsOneWidget);
        expect(find.text('Item 3'), findsOneWidget);
      });

      testWidgets('handles very long content', (WidgetTester tester) async {
        const String longText =
            'This is a very long text content that might wrap to multiple lines and test how the card handles overflow and text wrapping behavior in various scenarios';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(child: Text(longText)),
        );

        expect(find.textContaining('This is a very long text'), findsOneWidget);
      });

      testWidgets('handles empty child content', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(child: SizedBox.shrink()),
        );

        expect(find.byType(CorpoCard), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('content is accessible', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(child: Text('Accessible Card Content')),
        );

        expect(find.text('Accessible Card Content'), findsOneWidget);
        // Verify semantics structure exists
        final SemanticsNode? semantics =
            tester.binding.pipelineOwner.semanticsOwner?.rootSemanticsNode;
        expect(semantics, isNotNull);
      });

      testWidgets('interactive card is accessible', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCard(onTap: () {}, child: const Text('Interactive Card')),
        );

        expect(find.text('Interactive Card'), findsOneWidget);
        // Interactive cards should have Material for accessibility
        expect(find.byType(Material), findsWidgets);
      });
    });

    group('Theme Integration', () {
      testWidgets('adapts to theme', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCard(child: Text('Themed Card')),
        );

        expect(find.text('Themed Card'), findsOneWidget);
        expect(find.byType(CorpoCard), findsOneWidget);
      });
    });
  });
}
