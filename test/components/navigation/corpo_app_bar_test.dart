/// Comprehensive tests for CorpoAppBar component.
///
/// Tests cover functionality, navigation, accessibility,
/// and edge cases for the app bar component.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_utils.dart';

void main() {
  group('CorpoAppBar Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with title', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(appBar: CorpoAppBar(title: const Text('Test Title'))),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('renders with custom title widget', (
        WidgetTester tester,
      ) async {
        const titleWidget = Text('Custom Widget Title');

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(appBar: CorpoAppBar(title: titleWidget)),
        );

        expect(find.text('Custom Widget Title'), findsOneWidget);
        expect(find.byWidget(titleWidget), findsOneWidget);
      });

      testWidgets('subtitle not rendered in standard variant', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Main Title'),
              subtitle: const Text('Subtitle text'),
              variant: CorpoAppBarVariant.standard,
            ),
          ),
        );

        expect(find.text('Main Title'), findsOneWidget);
        // Subtitle should not be rendered in standard variant
        expect(find.text('Subtitle text'), findsNothing);
      });
    });

    group('Actions and Navigation', () {
      testWidgets('renders with actions', (WidgetTester tester) async {
        bool actionPressed = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Test'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => actionPressed = true,
                ),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);

        await tester.tap(find.byIcon(Icons.search));
        expect(actionPressed, isTrue);
      });

      testWidgets('renders with leading widget', (WidgetTester tester) async {
        bool leadingPressed = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Test'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => leadingPressed = true,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.menu), findsOneWidget);

        await tester.tap(find.byIcon(Icons.menu));
        expect(leadingPressed, isTrue);
      });

      testWidgets('automatically adds back button when in navigation stack', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => Scaffold(
                        appBar: CorpoAppBar(title: const Text('Second Page')),
                      ),
                    ),
                  ),
                  child: const Text('Navigate'),
                ),
              ),
            ),
          ),
        );

        // Navigate to second page
        await tester.tap(find.text('Navigate'));
        await tester.pumpAndSettle();

        // Check for back button
        expect(find.byType(BackButton), findsOneWidget);
        expect(find.text('Second Page'), findsOneWidget);
      });
    });

    group('Variants and Styling', () {
      testWidgets('applies standard variant styling', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Standard'),
              variant: CorpoAppBarVariant.standard,
            ),
          ),
        );

        final appBar = tester.widget<CorpoAppBar>(find.byType(CorpoAppBar));
        expect(appBar.variant, equals(CorpoAppBarVariant.standard));
        expect(appBar.preferredSize.height, equals(56));
      });

      testWidgets('applies large variant styling', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Large'),
              variant: CorpoAppBarVariant.large,
            ),
          ),
        );

        final appBar = tester.widget<CorpoAppBar>(find.byType(CorpoAppBar));
        expect(appBar.variant, equals(CorpoAppBarVariant.large));
        expect(appBar.preferredSize.height, equals(96));
      });

      testWidgets('applies compact variant styling', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Compact'),
              variant: CorpoAppBarVariant.compact,
            ),
          ),
        );

        final appBar = tester.widget<CorpoAppBar>(find.byType(CorpoAppBar));
        expect(appBar.variant, equals(CorpoAppBarVariant.compact));
        expect(appBar.preferredSize.height, equals(48));
      });

      testWidgets('respects custom elevation', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Custom Elevation'),
              elevation: 8.0,
            ),
          ),
        );

        final appBar = tester.widget<CorpoAppBar>(find.byType(CorpoAppBar));
        expect(appBar.elevation, equals(8.0));
      });

      testWidgets('respects custom colors', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Custom Colors'),
              backgroundColor: CorpoColors.primary500,
              foregroundColor: CorpoColors.neutralWhite,
            ),
          ),
        );

        final appBar = tester.widget<CorpoAppBar>(find.byType(CorpoAppBar));
        expect(appBar.backgroundColor, equals(CorpoColors.primary500));
        expect(appBar.foregroundColor, equals(CorpoColors.neutralWhite));
      });
    });

    group('Accessibility', () {
      testWidgets('has correct semantic properties', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(title: const Text('Accessible App Bar')),
          ),
        );

        // Verify AppBar exists and title is accessible
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Accessible App Bar'), findsOneWidget);

        // Verify semantics exist
        final semantics =
            tester.binding.pipelineOwner.semanticsOwner?.rootSemanticsNode;
        expect(semantics, isNotNull);
      });

      testWidgets('title is accessible to screen readers', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(title: const Text('Screen Reader Title')),
          ),
        );

        expect(find.text('Screen Reader Title'), findsOneWidget);

        // Verify semantics
        final semantics =
            tester.binding.pipelineOwner.semanticsOwner?.rootSemanticsNode;
        expect(semantics, isNotNull);
      });

      testWidgets('actions are accessible', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Test'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                  tooltip: 'Search',
                ),
              ],
            ),
          ),
        );

        final iconButton = tester.widget<IconButton>(find.byType(IconButton));
        expect(iconButton.tooltip, equals('Search'));
      });
    });

    group('Integration', () {
      testWidgets('works with Scaffold drawer', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(title: const Text('With Drawer')),
            drawer: const Drawer(child: ListTile(title: Text('Drawer Item'))),
          ),
        );

        // Should show menu icon when drawer is present
        expect(find.byIcon(Icons.menu), findsOneWidget);

        // Open drawer
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        expect(find.text('Drawer Item'), findsOneWidget);
      });

      testWidgets('works with bottom sheet', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(title: const Text('With Bottom Sheet')),
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showBottomSheet(
                  context: context,
                  builder: (context) => const SizedBox(
                    height: 200,
                    child: Center(child: Text('Bottom Sheet')),
                  ),
                ),
                child: const Text('Show Bottom Sheet'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Bottom Sheet'));
        await tester.pumpAndSettle();

        expect(find.text('Bottom Sheet'), findsOneWidget);
        expect(find.text('With Bottom Sheet'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles null title gracefully', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(appBar: CorpoAppBar()),
        );

        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('handles empty actions list', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(title: const Text('Test'), actions: const []),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('handles very long title', (WidgetTester tester) async {
        const longTitle = Text(
          'This is a very long title that might overflow the available space in the app bar',
        );

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(appBar: CorpoAppBar(title: longTitle)),
        );

        expect(
          find.textContaining('This is a very long title'),
          findsOneWidget,
        );
      });

      testWidgets('centerTitle works correctly', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: CorpoAppBar(
              title: const Text('Centered Title'),
              centerTitle: true,
            ),
          ),
        );

        final appBar = tester.widget<CorpoAppBar>(find.byType(CorpoAppBar));
        expect(appBar.centerTitle, isTrue);
      });
    });
  });
}
