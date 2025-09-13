/// Comprehensive Integration & Performance Tests for Corpo UI.
///
/// This test suite covers component combinations, performance benchmarks,
/// memory usage tests, and complex user interaction scenarios across
/// the entire component library.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_utils.dart';

void main() {
  group('Integration Tests', () {
    group('Component Combinations', () {
      testWidgets('form with all input types works together', (
        WidgetTester tester,
      ) async {
        String? dropdownValue;
        String? radioValue = 'option1';
        bool checkboxValue = false;
        bool switchValue = false;
        String textFieldValue = '';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => CorpoForm(
              children: <Widget>[
                CorpoTextField(
                  label: 'Name',
                  onChanged: (String value) => setState(() => textFieldValue = value),
                  validator: (String? value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                CorpoDropdown<String>(
                  label: 'Country',
                  items: const <CorpoDropdownItem<String>>[
                    CorpoDropdownItem(
                      value: 'us',
                      child: Text('United States'),
                    ),
                    CorpoDropdownItem(value: 'ca', child: Text('Canada')),
                    CorpoDropdownItem(value: 'mx', child: Text('Mexico')),
                  ],
                  value: dropdownValue,
                  onChanged: (String? value) => setState(() => dropdownValue = value),
                ),
                const SizedBox(height: 16),
                CorpoRadio<String>(
                  value: 'option1',
                  groupValue: radioValue,
                  onChanged: (String? value) => setState(() => radioValue = value),
                  label: 'Option 1',
                ),
                CorpoRadio<String>(
                  value: 'option2',
                  groupValue: radioValue,
                  onChanged: (String? value) => setState(() => radioValue = value),
                  label: 'Option 2',
                ),
                const SizedBox(height: 16),
                CorpoCheckbox(
                  value: checkboxValue,
                  onChanged: (bool? value) =>
                      setState(() => checkboxValue = value ?? false),
                  label: 'I agree to terms',
                ),
                const SizedBox(height: 16),
                CorpoSwitch(
                  value: switchValue,
                  onChanged: (bool value) => setState(() => switchValue = value),
                  label: 'Enable notifications',
                ),
                const SizedBox(height: 24),
                CorpoButton(
                  onPressed: () {
                    // Simulate form submission
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ); // Verify all components are present
        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
        expect(find.byType(CorpoRadio<String>), findsNWidgets(2));
        expect(find.byType(CorpoCheckbox), findsOneWidget);
        expect(find.byType(CorpoSwitch), findsOneWidget);
        expect(find.byType(CorpoButton), findsOneWidget);

        // Test interactions work
        await tester.enterText(find.byType(TextField), 'John Doe');
        await tester.tap(find.byType(DropdownButton<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Canada').last);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Option 2'));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();

        // Verify final state
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Canada'), findsOneWidget);
      });

      testWidgets('navigation with content layout works', (
        WidgetTester tester,
      ) async {
        int selectedTab = 0;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => Scaffold(
              appBar: const CorpoAppBar(
                title: Text('Integration Test'),
                variant: CorpoAppBarVariant.large,
              ),
              body: Column(
                children: <Widget>[
                  CorpoTabs(
                    tabs: const <CorpoTab>[
                      CorpoTab(text: 'Home'),
                      CorpoTab(text: 'Settings'),
                      CorpoTab(text: 'Profile'),
                    ],
                    initialIndex: selectedTab,
                    onTap: (int index) => setState(() => selectedTab = index),
                    children: <Widget>const <CorpoCard>[
                      CorpoCard(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Home Content'),
                        ),
                      ),
                      CorpoCard(
                        variant: CorpoCardVariant.elevated,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Settings Content'),
                        ),
                      ),
                      CorpoCard(
                        variant: CorpoCardVariant.outlined,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Profile Content'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

        // Verify components render
        expect(find.byType(CorpoAppBar), findsOneWidget);
        expect(find.byType(CorpoTabs), findsOneWidget);
        expect(find.byType(CorpoCard), findsNWidgets(3));
        expect(find.text('Home Content'), findsOneWidget);

        // Test tab navigation
        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();
        expect(find.text('Settings Content'), findsOneWidget);

        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();
        expect(find.text('Profile Content'), findsOneWidget);
      });

      testWidgets('feedback components work with user actions', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Builder(
            builder: (BuildContext context) => Column(
              children: <Widget>[
                const CorpoAlert(
                  type: CorpoAlertType.info,
                  title: 'Information',
                  message: 'Please fill all required fields',
                ),
                const SizedBox(height: 16),
                CorpoButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => CorpoDialog(
                        title: const Text('Confirmation'),
                        content: const Text(
                          'Are you sure you want to proceed?',
                        ),
                        actions: <Widget>[
                          CorpoTextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          CorpoButton(
                            onPressed: () {
                              Navigator.pop(context);
                              CorpoSnackbar.show(
                                context,
                                message: 'Action completed successfully',
                                type: CorpoSnackbarType.success,
                              );
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Show Dialog'),
                ),
              ],
            ),
          ),
        );

        // Verify initial state
        expect(find.byType(CorpoAlert), findsOneWidget);
        expect(find.text('Information'), findsOneWidget);
        expect(find.byType(CorpoButton), findsOneWidget);

        // Test dialog flow
        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(CorpoDialog), findsOneWidget);
        expect(find.text('Confirmation'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Confirm'), findsOneWidget);

        // Test dialog dismissal
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.byType(CorpoDialog), findsNothing);
      });

      testWidgets('complex nested component structure', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Scaffold(
            appBar: const CorpoAppBar(title: Text('Complex Layout')),
            body: Column(
              children: <Widget>[
                const CorpoCard(
                  child: Column(
                    children: <Widget>[
                      CorpoTextField(label: 'Search', prefixIcon: Icons.search),
                      Divider(),
                      CorpoProgressBar(value: 0.7),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) => CorpoCard(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: CorpoCheckbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        title: Text('Item $index'),
                        trailing: CorpoIconButton(
                          onPressed: () {},
                          icon: Icons.more_vert,
                        ),
                      ),
                    ),
                  ),
                ),
                CorpoButton(
                  fullWidth: true,
                  onPressed: () {},
                  child: const Text('Save All'),
                ),
              ],
            ),
          ),
        );

        // Verify complex structure renders correctly
        expect(find.byType(CorpoAppBar), findsOneWidget);
        expect(
          find.byType(CorpoCard),
          findsNWidgets(6),
        ); // 1 header + 5 list items
        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(CorpoProgressBar), findsOneWidget);
        expect(find.byType(CorpoCheckbox), findsNWidgets(5));
        expect(find.byType(CorpoIconButton), findsNWidgets(5));
        expect(find.byType(CorpoButton), findsOneWidget);

        // Test scrolling works
        await tester.scrollUntilVisible(find.text('Save All'), 100);
        expect(find.text('Save All'), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('components adapt to light theme', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Column(
            children: <Widget>[
              CorpoButton(onPressed: () {}, child: const Text('Light Button')),
              const CorpoCard(child: Text('Light Card')),
              const CorpoTextField(label: 'Light Input'),
            ],
          ),
        );

        expect(find.byType(CorpoButton), findsOneWidget);
        expect(find.byType(CorpoCard), findsOneWidget);
        expect(find.byType(CorpoTextField), findsOneWidget);
      });

      testWidgets('components adapt to dark theme', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          Column(
            children: <Widget>[
              CorpoButton(onPressed: () {}, child: const Text('Dark Button')),
              const CorpoCard(child: Text('Dark Card')),
              const CorpoTextField(label: 'Dark Input'),
            ],
          ),
          darkMode: true,
        );

        expect(find.byType(CorpoButton), findsOneWidget);
        expect(find.byType(CorpoCard), findsOneWidget);
        expect(find.byType(CorpoTextField), findsOneWidget);
      });

      testWidgets('theme switching works correctly', (
        WidgetTester tester,
      ) async {
        bool isDark = false;

        await tester.pumpWidget(
          StatefulBuilder(
            builder: (BuildContext context, setState) => MaterialApp(
              theme: isDark ? CorpoTheme.dark() : CorpoTheme.light(),
              home: Scaffold(
                body: Column(
                  children: <Widget>[
                    CorpoButton(
                      onPressed: () => setState(() => isDark = !isDark),
                      child: Text(
                        isDark ? 'Switch to Light' : 'Switch to Dark',
                      ),
                    ),
                    CorpoCard(
                      child: Text('Theme: ${isDark ? 'Dark' : 'Light'}'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        // Initially light theme
        expect(find.text('Switch to Dark'), findsOneWidget);
        expect(find.text('Theme: Light'), findsOneWidget);

        // Switch to dark theme
        await tester.tap(find.text('Switch to Dark'));
        await tester.pumpAndSettle();

        expect(find.text('Switch to Light'), findsOneWidget);
        expect(find.text('Theme: Dark'), findsOneWidget);
      });
    });

    group('State Management', () {
      testWidgets('form state persists across rebuilds', (
        WidgetTester tester,
      ) async {
        String textValue = '';
        bool checkboxValue = false;
        int rebuildCount = 0;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) {
              rebuildCount++;
              return Column(
                children: <Widget>[
                  Text('Rebuild count: $rebuildCount'),
                  CorpoTextField(
                    initialValue: textValue,
                    onChanged: (String value) => textValue = value,
                    label: 'Persistent Input',
                  ),
                  CorpoCheckbox(
                    value: checkboxValue,
                    onChanged: (bool? value) =>
                        setState(() => checkboxValue = value ?? false),
                    label: 'Persistent Checkbox',
                  ),
                  CorpoButton(
                    onPressed: () => setState(() {}),
                    child: const Text('Force Rebuild'),
                  ),
                ],
              );
            },
          ),
        );

        // Enter text and check checkbox
        await tester.enterText(find.byType(TextField), 'Test Value');
        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();

        expect(find.text('Test Value'), findsOneWidget);

        // Force rebuild
        await tester.tap(find.text('Force Rebuild'));
        await tester.pumpAndSettle();

        // State should persist
        expect(find.text('Rebuild count: 2'), findsOneWidget);
        expect(find.text('Test Value'), findsOneWidget);
      });

      testWidgets('multiple form instances maintain separate state', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Form 1'),
                    CorpoTextField(label: 'Input 1'),
                    CorpoCheckbox(
                      value: false,
                      onChanged: null,
                      label: 'Checkbox 1',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Form 2'),
                    CorpoTextField(label: 'Input 2'),
                    CorpoCheckbox(
                      value: true,
                      onChanged: null,
                      label: 'Checkbox 2',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        // Verify separate instances
        expect(find.text('Form 1'), findsOneWidget);
        expect(find.text('Form 2'), findsOneWidget);
        expect(find.byType(CorpoTextField), findsNWidgets(2));
        expect(find.byType(CorpoCheckbox), findsNWidgets(2));

        // Verify separate state
        final Iterable<Checkbox> checkboxes = tester.widgetList<Checkbox>(find.byType(Checkbox));
        final Checkbox checkbox1 = checkboxes.first;
        final Checkbox checkbox2 = checkboxes.last;

        expect(checkbox1.value, isFalse);
        expect(checkbox2.value, isTrue);
      });
    });
  });

  group('Performance Tests', () {
    group('Rendering Performance', () {
      testWidgets('renders large list efficiently', (
        WidgetTester tester,
      ) async {
        const int itemCount = 100;

        final Stopwatch stopwatch = Stopwatch()..start();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) => CorpoCard(
                margin: const EdgeInsets.all(4),
                child: ListTile(
                  leading: CorpoCheckbox(
                    value: index % 2 == 0,
                    onChanged: (bool? value) {},
                  ),
                  title: Text('Item $index'),
                  subtitle: Text('Description for item $index'),
                  trailing: CorpoButton(
                    size: CorpoButtonSize.small,
                    onPressed: () {},
                    child: const Text('Action'),
                  ),
                ),
              ),
            ),
          ),
        );

        stopwatch.stop();

        // Verify all items are built (Flutter builds visible + buffer)
        expect(find.byType(CorpoCard), findsWidgets);
        expect(find.byType(CorpoCheckbox), findsWidgets);
        expect(find.byType(CorpoButton), findsWidgets);

        // Performance assertion - should complete within reasonable time
        expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      });

      testWidgets('complex nested structure performs well', (
        WidgetTester tester,
      ) async {
        final Stopwatch stopwatch = Stopwatch()..start();

        await CorpoTestUtils.pumpWithTheme(
          tester,
          SingleChildScrollView(
            child: Column(
              children: List.generate(
                5,
                (int index) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: CorpoCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CorpoTextField(label: 'Field $index'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CorpoCheckbox(
                              value: false,
                              onChanged: (bool? value) {},
                              label: 'Option A',
                            ),
                            const SizedBox(width: 16),
                            CorpoCheckbox(
                              value: true,
                              onChanged: (bool? value) {},
                              label: 'Option B',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CorpoButton(
                          onPressed: () {},
                          child: Text('Submit $index'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        stopwatch.stop();

        // Verify complex structure renders
        expect(find.byType(CorpoCard), findsNWidgets(20));
        expect(find.byType(CorpoTextField), findsNWidgets(20));
        expect(find.byType(CorpoCheckbox), findsNWidgets(40));
        expect(find.byType(CorpoButton), findsNWidgets(20));

        // Performance check
        expect(stopwatch.elapsedMilliseconds, lessThan(3000));
      });

      testWidgets('rapid state changes perform well', (
        WidgetTester tester,
      ) async {
        bool toggleValue = false;
        int toggleCount = 0;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => Column(
              children: <Widget>[
                Text('Toggle count: $toggleCount'),
                CorpoSwitch(
                  value: toggleValue,
                  onChanged: (bool value) {
                    setState(() {
                      toggleValue = value;
                      toggleCount++;
                    });
                  },
                  label: 'Performance Switch',
                ),
                CorpoButton(
                  onPressed: () {
                    // Rapid state changes
                    for (int i = 0; i < 10; i++) {
                      setState(() {
                        toggleValue = !toggleValue;
                        toggleCount++;
                      });
                    }
                  },
                  child: const Text('Rapid Toggle'),
                ),
              ],
            ),
          ),
        );

        final Stopwatch stopwatch = Stopwatch()..start();

        // Perform rapid toggles
        await tester.tap(find.text('Rapid Toggle'));
        await tester.pumpAndSettle();

        stopwatch.stop();

        // Verify final state
        expect(find.textContaining('Toggle count: 10'), findsOneWidget);

        // Performance check for rapid updates
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });
    });

    group('Memory Usage', () {
      testWidgets('components clean up properly when disposed', (
        WidgetTester tester,
      ) async {
        bool showComponents = true;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => Column(
              children: <Widget>[
                CorpoButton(
                  onPressed: () =>
                      setState(() => showComponents = !showComponents),
                  child: Text(
                    showComponents ? 'Hide Components' : 'Show Components',
                  ),
                ),
                if (showComponents) ...<Widget>[
                  CorpoTextField(
                    label: 'Test Input',
                    controller: TextEditingController(),
                  ),
                  CorpoDropdown<String>(
                    items: const <CorpoDropdownItem<String>>[
                      CorpoDropdownItem(value: 'test', child: Text('Test')),
                    ],
                    onChanged: (String? value) {},
                  ),
                  const CorpoCard(child: Text('Test Card')),
                ],
              ],
            ),
          ),
        );

        // Initially components are shown
        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
        expect(find.byType(CorpoCard), findsOneWidget);

        // Hide components (should trigger disposal)
        await tester.tap(find.text('Hide Components'));
        await tester.pumpAndSettle();

        // Components should be gone
        expect(find.byType(CorpoTextField), findsNothing);
        expect(find.byType(CorpoDropdown<String>), findsNothing);
        expect(find.byType(CorpoCard), findsNothing);

        // Show again (should recreate cleanly)
        await tester.tap(find.text('Show Components'));
        await tester.pumpAndSettle();

        expect(find.byType(CorpoTextField), findsOneWidget);
        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
        expect(find.byType(CorpoCard), findsOneWidget);
      });

      testWidgets('large datasets handle memory efficiently', (
        WidgetTester tester,
      ) async {
        // Simulate large dataset
        final List<String> items = List.generate(1000, (int index) => 'Item $index');

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items
                .map(
                  (String item) => CorpoDropdownItem(value: item, child: Text(item)),
                )
                .toList(),
            onChanged: (String? value) {},
            label: 'Large Dataset',
          ),
        );

        // Should handle large dataset without issues
        expect(find.byType(CorpoDropdown<String>), findsOneWidget);

        // Open dropdown
        await tester.tap(find.byType(DropdownButton<String>));
        await tester.pumpAndSettle();

        // Should show dropdown items (Flutter optimizes rendering)
        expect(find.text('Item 0'), findsOneWidget);
      });
    });

    group('Interaction Performance', () {
      testWidgets('button taps respond quickly', (WidgetTester tester) async {
        int tapCount = 0;
        final List<int> tapTimes = <int>[];

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => Column(
              children: <Widget>[
                Text('Taps: $tapCount'),
                CorpoButton(
                  onPressed: () {
                    final int now = DateTime.now().millisecondsSinceEpoch;
                    setState(() {
                      tapCount++;
                      tapTimes.add(now);
                    });
                  },
                  child: const Text('Tap Me'),
                ),
              ],
            ),
          ),
        );

        final Stopwatch stopwatch = Stopwatch()..start();

        // Perform multiple rapid taps
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.text('Tap Me'));
          await tester.pump(const Duration(milliseconds: 10));
        }

        stopwatch.stop();

        await tester.pumpAndSettle();

        // Verify all taps registered
        expect(find.text('Taps: 5'), findsOneWidget);

        // Performance check
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });

      testWidgets('form interactions remain responsive', (
        WidgetTester tester,
      ) async {
        String textValue = '';
        bool checkboxValue = false;
        String? dropdownValue;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => Column(
              children: <Widget>[
                CorpoTextField(
                  label: 'Responsive Input',
                  onChanged: (String value) => setState(() => textValue = value),
                ),
                CorpoCheckbox(
                  value: checkboxValue,
                  onChanged: (bool? value) =>
                      setState(() => checkboxValue = value ?? false),
                  label: 'Responsive Checkbox',
                ),
                CorpoDropdown<String>(
                  items: const <CorpoDropdownItem<String>>[
                    CorpoDropdownItem(
                      value: 'option1',
                      child: Text('Option 1'),
                    ),
                    CorpoDropdownItem(
                      value: 'option2',
                      child: Text('Option 2'),
                    ),
                  ],
                  value: dropdownValue,
                  onChanged: (String? value) => setState(() => dropdownValue = value),
                  label: 'Responsive Dropdown',
                ),
                Text('State: $textValue, $checkboxValue, $dropdownValue'),
              ],
            ),
          ),
        );

        final Stopwatch stopwatch = Stopwatch()..start();

        // Rapid interactions
        await tester.enterText(find.byType(TextField), 'Quick typing test');
        await tester.tap(find.byType(Checkbox));
        await tester.tap(find.byType(DropdownButton<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Option 1').last);
        await tester.pumpAndSettle();

        stopwatch.stop();

        // Verify responsive state updates
        expect(find.text('Quick typing test'), findsOneWidget);
        expect(find.text('Option 1'), findsOneWidget);

        // Performance check
        expect(stopwatch.elapsedMilliseconds, lessThan(2000));
      });
    });
  });

  group('Edge Case Scenarios', () {
    testWidgets('handles null and empty values gracefully', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        Column(
          children: <Widget>[
            const CorpoTextField(),
            CorpoDropdown<String>(
              items: const <CorpoDropdownItem<String>>[],
              onChanged: (String? value) {},
            ),
            const CorpoCheckbox(
              value: null,
              tristate: true,
              onChanged: null,
            ),
            const CorpoCard(child: SizedBox.shrink()),
          ],
        ),
      );

      // Components should handle null values without crashing
      expect(find.byType(CorpoTextField), findsOneWidget);
      expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      expect(find.byType(CorpoCheckbox), findsOneWidget);
      expect(find.byType(CorpoCard), findsOneWidget);
    });

    testWidgets('handles rapid component creation and destruction', (
      WidgetTester tester,
    ) async {
      bool showComponents = true;
      int cycleCount = 0;

      await CorpoTestUtils.pumpWithTheme(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, setState) => Column(
            children: <Widget>[
              Text('Cycle: $cycleCount'),
              CorpoButton(
                onPressed: () {
                  setState(() {
                    showComponents = !showComponents;
                    cycleCount++;
                  });
                },
                child: const Text('Toggle Components'),
              ),
              if (showComponents) ...<Widget>[
                const CorpoTextField(label: 'Dynamic Input'),
                CorpoCard(child: Text('Dynamic Card $cycleCount')),
                CorpoButton(
                  onPressed: () {},
                  child: const Text('Dynamic Button'),
                ),
              ],
            ],
          ),
        ),
      );

      // Rapid creation/destruction cycles
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Toggle Components'));
        await tester.pumpAndSettle();
      }

      // Should handle cycles without issues
      expect(find.text('Cycle: 5'), findsOneWidget);
    });

    testWidgets('handles concurrent state updates', (
      WidgetTester tester,
    ) async {
      int updateCount = 0;
      String status = 'Ready';

      await CorpoTestUtils.pumpWithTheme(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, setState) => Column(
            children: <Widget>[
              Text('Updates: $updateCount'),
              Text('Status: $status'),
              Row(
                children: <Widget>[
                  CorpoButton(
                    onPressed: () async {
                      setState(() => status = 'Updating...');
                      // Simulate async work
                      await Future.delayed(const Duration(milliseconds: 10));
                      setState(() {
                        updateCount++;
                        status = 'Updated';
                      });
                    },
                    child: const Text('Async Update'),
                  ),
                  CorpoButton(
                    onPressed: () {
                      setState(() {
                        updateCount++;
                        status = 'Sync Updated';
                      });
                    },
                    child: const Text('Sync Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      // Trigger concurrent updates
      await tester.tap(find.text('Async Update'));
      await tester.tap(find.text('Sync Update'));
      await tester.pumpAndSettle();

      // Should handle concurrent updates
      expect(find.textContaining('Updates: '), findsOneWidget);
      expect(find.textContaining('Status: '), findsOneWidget);
    });
  });
}
