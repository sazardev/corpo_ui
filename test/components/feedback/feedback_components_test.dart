/// Comprehensive tests for feedback components.
///
/// Tests cover CorpoDialog, CorpoAlert, CorpoSnackbar functionality,
/// accessibility, and edge cases.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/semantics/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_utils.dart';

void main() {
  group('CorpoDialog Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with title and content', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => const CorpoDialog(
                  title: Text('Test Dialog'),
                  content: Text('Dialog content'),
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Test Dialog'), findsOneWidget);
        expect(find.text('Dialog content'), findsOneWidget);
        expect(find.byType(CorpoDialog), findsOneWidget);
      });

      testWidgets('renders with actions', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => CorpoDialog(
                  title: const Text('Confirm Action'),
                  content: const Text('Dialog content'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Confirm'), findsOneWidget);
      });

      testWidgets('closes when cancel button tapped', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => CorpoDialog(
                  title: const Text('Test Dialog'),
                  content: const Text('Content'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(CorpoDialog), findsOneWidget);

        await tester.tap(find.text('Close'));
        await tester.pumpAndSettle();

        expect(find.byType(CorpoDialog), findsNothing);
      });
    });

    group('Dialog Variants', () {
      testWidgets('renders small dialog', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => const CorpoDialog(
                  title: Text('Small Dialog'),
                  content: Text('Small content'),
                  size: CorpoDialogSize.small,
                ),
              ),
              child: const Text('Show Small'),
            ),
          ),
        );

        await tester.tap(find.text('Show Small'));
        await tester.pumpAndSettle();

        expect(find.text('Small Dialog'), findsOneWidget);
      });

      testWidgets('renders large dialog', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => const CorpoDialog(
                  title: Text('Large Dialog'),
                  content: Text('Large content'),
                  size: CorpoDialogSize.large,
                ),
              ),
              child: const Text('Show Large'),
            ),
          ),
        );

        await tester.tap(find.text('Show Large'));
        await tester.pumpAndSettle();

        expect(find.text('Large Dialog'), findsOneWidget);
      });

      testWidgets('renders confirmation dialog', (WidgetTester tester) async {
        bool confirmed = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => CorpoDialog(
                  title: const Text('Confirm Action'),
                  content: const Text('Are you sure you want to continue?'),
                  actions: <Widget>[
                    CorpoTextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    CorpoButton(
                      onPressed: () {
                        confirmed = true;
                        Navigator.pop(context);
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ),
              child: const Text('Show Confirm'),
            ),
          ),
        );

        await tester.tap(find.text('Show Confirm'));
        await tester.pumpAndSettle();

        expect(find.text('Confirm Action'), findsOneWidget);
        expect(find.text('Are you sure you want to continue?'), findsOneWidget);

        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        expect(confirmed, isTrue);
      });
    });

    group('Accessibility', () {
      testWidgets('has correct semantic properties', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => const CorpoDialog(
                  title: Text('Accessible Dialog'),
                  content: Text('Accessible content'),
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Accessible Dialog'), findsOneWidget);
        // Verify semantics
        final SemanticsNode? semantics =
            tester.binding.pipelineOwner.semanticsOwner?.rootSemanticsNode;
        expect(semantics, isNotNull);
      });

      testWidgets('supports dismissible dialogs', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => const CorpoDialog(
                  title: Text('Dismissible Dialog'),
                  content: Text('Tap outside to close'),
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(CorpoDialog), findsOneWidget);

        // Tap outside to dismiss
        await tester.tapAt(const Offset(50, 50));
        await tester.pumpAndSettle();

        expect(find.byType(CorpoDialog), findsNothing);
      });
    });
  });

  group('CorpoAlert Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders success alert', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoAlert(
            type: CorpoAlertType.success,
            title: 'Success',
            message: 'Operation completed successfully',
          ),
        );

        expect(find.text('Success'), findsOneWidget);
        expect(find.text('Operation completed successfully'), findsOneWidget);
        expect(find.byType(CorpoAlert), findsOneWidget);
      });

      testWidgets('renders error alert', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoAlert.error(title: 'Error', message: 'Something went wrong'),
        );

        expect(find.text('Error'), findsOneWidget);
        expect(find.text('Something went wrong'), findsOneWidget);
      });

      testWidgets('renders warning alert', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoAlert.warning(
            title: 'Warning',
            message: 'Please check your input',
          ),
        );

        expect(find.text('Warning'), findsOneWidget);
        expect(find.text('Please check your input'), findsOneWidget);
      });

      testWidgets('renders info alert', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoAlert.info(
            title: 'Information',
            message: 'Here is some helpful information',
          ),
        );

        expect(find.text('Information'), findsOneWidget);
        expect(find.text('Here is some helpful information'), findsOneWidget);
      });
    });

    group('Dismissible Alerts', () {
      testWidgets('shows dismiss button when onDismiss provided', (
        WidgetTester tester,
      ) async {
        bool dismissed = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoAlert(
            type: CorpoAlertType.info,
            title: 'Dismissible Alert',
            message: 'This alert can be dismissed',
            onDismiss: () => dismissed = true,
          ),
        );

        expect(find.byIcon(Icons.close), findsOneWidget);

        await tester.tap(find.byIcon(Icons.close));
        expect(dismissed, isTrue);
      });

      testWidgets('does not show dismiss button when onDismiss is null', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoAlert(
            type: CorpoAlertType.info,
            title: 'Non-dismissible Alert',
            message: 'This alert cannot be dismissed',
          ),
        );

        expect(find.byIcon(Icons.close), findsNothing);
      });
    });

    group('Alert Actions', () {
      testWidgets('renders custom actions', (WidgetTester tester) async {
        bool actionPressed = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoAlert(
            type: CorpoAlertType.warning,
            title: 'Alert with Action',
            message: 'This alert has a custom action',
            actions: <Widget>[
              TextButton(
                onPressed: () => actionPressed = true,
                child: const Text('Custom Action'),
              ),
            ],
          ),
        );

        expect(find.text('Custom Action'), findsOneWidget);

        await tester.tap(find.text('Custom Action'));
        expect(actionPressed, isTrue);
      });

      testWidgets('renders multiple actions', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoAlert(
            type: CorpoAlertType.error,
            title: 'Multiple Actions',
            message: 'This alert has multiple actions',
            actions: <Widget>[
              TextButton(onPressed: () {}, child: const Text('Action 1')),
              TextButton(onPressed: () {}, child: const Text('Action 2')),
            ],
          ),
        );

        expect(find.text('Action 1'), findsOneWidget);
        expect(find.text('Action 2'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has correct semantic properties', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoAlert(
            type: CorpoAlertType.success,
            title: 'Accessible Alert',
            message: 'This alert is accessible',
          ),
        );

        expect(find.text('Accessible Alert'), findsOneWidget);
        // Verify semantics
        final SemanticsNode? semantics =
            tester.binding.pipelineOwner.semanticsOwner?.rootSemanticsNode;
        expect(semantics, isNotNull);
      });

      testWidgets('dismiss button is accessible', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoAlert(
            type: CorpoAlertType.info,
            title: 'Alert',
            message: 'Content',
            onDismiss: () {},
          ),
        );

        final Finder dismissButton = find.byIcon(Icons.close);
        expect(dismissButton, findsOneWidget);
      });
    });
  });

  group('CorpoSnackbar Tests', () {
    group('Basic Functionality', () {
      testWidgets('shows snackbar with message', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () =>
                  CorpoSnackbar.show(context, message: 'Test snackbar message'),
              child: const Text('Show Snackbar'),
            ),
          ),
        );

        await tester.tap(find.text('Show Snackbar'));
        await tester.pump();

        expect(find.text('Test snackbar message'), findsOneWidget);
      });

      testWidgets('shows success snackbar', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () =>
                  CorpoSnackbar.success(context, message: 'Success message'),
              child: const Text('Show Success'),
            ),
          ),
        );

        await tester.tap(find.text('Show Success'));
        await tester.pump();

        expect(find.text('Success message'), findsOneWidget);
      });

      testWidgets('shows error snackbar', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () =>
                  CorpoSnackbar.error(context, message: 'Error message'),
              child: const Text('Show Error'),
            ),
          ),
        );

        await tester.tap(find.text('Show Error'));
        await tester.pump();

        expect(find.text('Error message'), findsOneWidget);
      });
    });

    group('Snackbar Actions', () {
      testWidgets('shows action button', (WidgetTester tester) async {
        bool actionPressed = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => CorpoSnackbar.show(
                context,
                message: 'Message with action',
                action: CorpoSnackbarAction(
                  label: 'Undo',
                  onPressed: () => actionPressed = true,
                ),
              ),
              child: const Text('Show with Action'),
            ),
          ),
        );

        await tester.tap(find.text('Show with Action'));
        await tester.pump();

        expect(find.text('Undo'), findsOneWidget);

        await tester.tap(find.text('Undo'));
        expect(actionPressed, isTrue);
      });
    });

    group('Auto-dismiss', () {
      testWidgets('dismisses automatically after duration', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () => CorpoSnackbar.show(
                context,
                message: 'Auto dismiss message',
                duration: const Duration(milliseconds: 100),
              ),
              child: const Text('Show Auto Dismiss'),
            ),
          ),
        );

        await tester.tap(find.text('Show Auto Dismiss'));
        await tester.pump();

        expect(find.text('Auto dismiss message'), findsOneWidget);

        // Wait for auto-dismiss
        await tester.pump(const Duration(milliseconds: 150));

        expect(find.text('Auto dismiss message'), findsNothing);
      });
    });
  });

  group('Integration Tests', () {
    testWidgets('multiple feedback components work together', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        Scaffold(
          body: Column(
            children: <Widget>[
              Builder(
                builder: (BuildContext context) => ElevatedButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => const CorpoDialog(
                      title: Text('Dialog'),
                      content: CorpoAlert(
                        type: CorpoAlertType.warning,
                        title: 'Warning',
                        message: 'Alert inside dialog',
                      ),
                    ),
                  ),
                  child: const Text('Show Complex Dialog'),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Show Complex Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog'), findsOneWidget);
      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('Alert inside dialog'), findsOneWidget);
    });
  });
}
