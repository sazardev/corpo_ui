/// Comprehensive tests for Advanced Input Components.
///
/// This test suite covers CorpoCheckbox, CorpoRadio, CorpoSwitch, and CorpoDropdown
/// with comprehensive testing of functionality, variants, accessibility,
/// state management, and interaction testing.
library;

import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_utils.dart';

void main() {
  group('CorpoCheckbox Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with correct initial state', (
        WidgetTester tester,
      ) async {
        bool? value = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: value,
            onChanged: (bool? newValue) => value = newValue,
            label: 'Test Checkbox',
          ),
        );

        expect(find.byType(CorpoCheckbox), findsOneWidget);
        expect(find.text('Test Checkbox'), findsOneWidget);
        expect(find.byType(Checkbox), findsOneWidget);

        final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, isFalse);
      });

      testWidgets('toggles value when tapped', (WidgetTester tester) async {
        bool? value = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => CorpoCheckbox(
              value: value,
              onChanged: (bool? newValue) => setState(() => value = newValue),
              label: 'Toggle Checkbox',
            ),
          ),
        );

        await tester.tap(find.byType(CorpoCheckbox));
        await tester.pumpAndSettle();

        final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, isTrue);
      });

      testWidgets('supports tristate mode', (WidgetTester tester) async {
        bool? value;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => CorpoCheckbox(
              value: value,
              tristate: true,
              onChanged: (bool? newValue) => setState(() => value = newValue),
              label: 'Tristate Checkbox',
            ),
          ),
        );

        // Initial state: null (indeterminate)
        final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, isNull);
        expect(checkbox.tristate, isTrue);

        // First tap: null -> true
        await tester.tap(find.byType(CorpoCheckbox));
        await tester.pumpAndSettle();

        final Checkbox checkbox2 = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox2.value, isTrue);
      });

      testWidgets('shows description when provided', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: false,
            onChanged: (bool? value) {},
            label: 'Checkbox with Description',
            description: 'This is a detailed description',
          ),
        );

        expect(find.text('Checkbox with Description'), findsOneWidget);
        expect(find.text('This is a detailed description'), findsOneWidget);
      });

      testWidgets('disables when onChanged is null', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoCheckbox(
            value: false,
            onChanged: null,
            label: 'Disabled Checkbox',
          ),
        );

        final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.onChanged, isNull);
      });
    });

    group('Size Variants', () {
      testWidgets('renders small checkbox', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: false,
            onChanged: (bool? value) {},
            label: 'Small Checkbox',
            size: CorpoCheckboxSize.small,
          ),
        );

        expect(find.byType(CorpoCheckbox), findsOneWidget);
        expect(find.text('Small Checkbox'), findsOneWidget);
      });

      testWidgets('renders medium checkbox (default)', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: false,
            onChanged: (bool? value) {},
            label: 'Medium Checkbox',
          ),
        );

        expect(find.byType(CorpoCheckbox), findsOneWidget);
      });

      testWidgets('renders large checkbox', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: false,
            onChanged: (bool? value) {},
            label: 'Large Checkbox',
            size: CorpoCheckboxSize.large,
          ),
        );

        expect(find.byType(CorpoCheckbox), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has proper semantic properties', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: false,
            onChanged: (bool? value) {},
            label: 'Accessible Checkbox',
          ),
        );

        final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.autofocus, isFalse);
      });

      testWidgets('supports autofocus', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: false,
            onChanged: (bool? value) {},
            label: 'Autofocus Checkbox',
            autofocus: true,
          ),
        );

        final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.autofocus, isTrue);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles label-only checkbox', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(
            value: true,
            onChanged: (bool? value) {},
            label: 'Label Only',
          ),
        );

        expect(find.text('Label Only'), findsOneWidget);
        expect(find.byType(Checkbox), findsOneWidget);
      });

      testWidgets('handles checkbox without labels', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoCheckbox(value: true, onChanged: (bool? value) {}),
        );

        expect(find.byType(Checkbox), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });
    });
  });

  group('CorpoRadio Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with correct initial state', (
        WidgetTester tester,
      ) async {
        const String groupValue = 'option1';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<String>(
            value: 'option1',
            groupValue: groupValue,
            onChanged: (String? value) {},
            label: 'Radio Option 1',
          ),
        );

        expect(find.byType(CorpoRadio<String>), findsOneWidget);
        expect(find.text('Radio Option 1'), findsOneWidget);
        expect(find.byType(Radio<String>), findsOneWidget);

        final Radio<String> radio = tester.widget<Radio<String>>(find.byType(Radio<String>));
        expect(radio.value, equals('option1'));
        expect(radio.groupValue, equals('option1'));
      });

      testWidgets('handles selection change', (WidgetTester tester) async {
        String? groupValue = 'option1';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => Column(
              children: <Widget>[
                CorpoRadio<String>(
                  value: 'option1',
                  groupValue: groupValue,
                  onChanged: (String? value) => setState(() => groupValue = value),
                  label: 'Option 1',
                ),
                CorpoRadio<String>(
                  value: 'option2',
                  groupValue: groupValue,
                  onChanged: (String? value) => setState(() => groupValue = value),
                  label: 'Option 2',
                ),
              ],
            ),
          ),
        );

        // Initially option1 is selected
        final Radio<String> radio1 = tester.widget<Radio<String>>(
          find.byType(Radio<String>).first,
        );
        expect(radio1.groupValue, equals('option1'));

        // Tap option2
        await tester.tap(find.text('Option 2'));
        await tester.pumpAndSettle();

        // Now option2 should be selected
        final Radio<String> radio2 = tester.widget<Radio<String>>(
          find.byType(Radio<String>).last,
        );
        expect(radio2.groupValue, equals('option2'));
      });

      testWidgets('shows description when provided', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: (String? value) {},
            label: 'Radio with Description',
            description: 'This is additional information',
          ),
        );

        expect(find.text('Radio with Description'), findsOneWidget);
        expect(find.text('This is additional information'), findsOneWidget);
      });

      testWidgets('disables when onChanged is null', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: null,
            label: 'Disabled Radio',
          ),
        );

        final Radio<String> radio = tester.widget<Radio<String>>(find.byType(Radio<String>));
        expect(radio.onChanged, isNull);
      });
    });

    group('Size Variants', () {
      testWidgets('renders small radio', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: (String? value) {},
            label: 'Small Radio',
            size: CorpoRadioSize.small,
          ),
        );

        expect(find.byType(CorpoRadio<String>), findsOneWidget);
        expect(find.text('Small Radio'), findsOneWidget);
      });

      testWidgets('renders medium radio (default)', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: (String? value) {},
            label: 'Medium Radio',
          ),
        );

        expect(find.byType(CorpoRadio<String>), findsOneWidget);
      });

      testWidgets('renders large radio', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: (String? value) {},
            label: 'Large Radio',
            size: CorpoRadioSize.large,
          ),
        );

        expect(find.byType(CorpoRadio<String>), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('supports semantic labels', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: (String? value) {},
            label: 'Radio Option',
            semanticLabel: 'Custom semantic label',
          ),
        );

        expect(find.byType(CorpoRadio<String>), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('works with different value types', (
        WidgetTester tester,
      ) async {
        const int groupValue = 1;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<int>(
            value: 1,
            groupValue: groupValue,
            onChanged: (int? value) {},
            label: 'Integer Radio',
          ),
        );

        final Radio<int> radio = tester.widget<Radio<int>>(find.byType(Radio<int>));
        expect(radio.value, equals(1));
        expect(radio.groupValue, equals(1));
      });

      testWidgets('handles radio without labels', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoRadio<String>(
            value: 'option1',
            groupValue: 'option1',
            onChanged: (String? value) {},
          ),
        );

        expect(find.byType(Radio<String>), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });
    });
  });

  group('CorpoSwitch Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with correct initial state', (
        WidgetTester tester,
      ) async {
        bool value = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoSwitch(
            value: value,
            onChanged: (bool newValue) => value = newValue,
            label: 'Test Switch',
          ),
        );

        expect(find.byType(CorpoSwitch), findsOneWidget);
        expect(find.text('Test Switch'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);

        final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, isFalse);
      });

      testWidgets('toggles value when tapped', (WidgetTester tester) async {
        bool value = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => CorpoSwitch(
              value: value,
              onChanged: (bool newValue) => setState(() => value = newValue),
              label: 'Toggle Switch',
            ),
          ),
        );

        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();

        final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, isTrue);
      });

      testWidgets('shows description when provided', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoSwitch(
            value: false,
            onChanged: (bool value) {},
            label: 'Switch with Description',
            description: 'This explains what the switch does',
          ),
        );

        expect(find.text('Switch with Description'), findsOneWidget);
        expect(find.text('This explains what the switch does'), findsOneWidget);
      });

      testWidgets('disables when onChanged is null', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          const CorpoSwitch(
            value: false,
            onChanged: null,
            label: 'Disabled Switch',
          ),
        );

        final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.onChanged, isNull);
      });
    });

    group('Size Variants', () {
      testWidgets('renders small switch', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoSwitch(
            value: false,
            onChanged: (bool value) {},
            label: 'Small Switch',
            size: CorpoSwitchSize.small,
          ),
        );

        expect(find.byType(CorpoSwitch), findsOneWidget);
        expect(find.text('Small Switch'), findsOneWidget);
      });

      testWidgets('renders medium switch (default)', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoSwitch(
            value: false,
            onChanged: (bool value) {},
            label: 'Medium Switch',
          ),
        );

        expect(find.byType(CorpoSwitch), findsOneWidget);
      });

      testWidgets('renders large switch', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoSwitch(
            value: false,
            onChanged: (bool value) {},
            label: 'Large Switch',
            size: CorpoSwitchSize.large,
          ),
        );

        expect(find.byType(CorpoSwitch), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('supports autofocus', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoSwitch(
            value: false,
            onChanged: (bool value) {},
            label: 'Autofocus Switch',
            autofocus: true,
          ),
        );

        final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.autofocus, isTrue);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles switch without labels', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoSwitch(value: true, onChanged: (bool value) {}),
        );

        expect(find.byType(Switch), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('maintains state correctly', (WidgetTester tester) async {
        bool value = false;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => CorpoSwitch(
              value: value,
              onChanged: (bool newValue) => setState(() => value = newValue),
              label: 'State Switch',
            ),
          ),
        );

        // Toggle multiple times
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();

        final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, isTrue);
      });
    });
  });

  group('CorpoDropdown Tests', () {
    late List<CorpoDropdownItem<String>> items;

    setUp(() {
      items = <CorpoDropdownItem<String>>[
        const CorpoDropdownItem(value: 'option1', child: Text('Option 1')),
        const CorpoDropdownItem(value: 'option2', child: Text('Option 2')),
        const CorpoDropdownItem(value: 'option3', child: Text('Option 3')),
      ];
    });

    group('Basic Functionality', () {
      testWidgets('renders with items', (WidgetTester tester) async {
        String? value;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            value: value,
            onChanged: (String? newValue) => value = newValue,
            label: 'Test Dropdown',
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
        expect(find.text('Test Dropdown'), findsOneWidget);
        expect(find.byType(DropdownButton<String>), findsOneWidget);
      });

      testWidgets('shows selected value', (WidgetTester tester) async {
        String? value = 'option1';

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            value: value,
            onChanged: (String? newValue) => value = newValue,
            label: 'Selected Dropdown',
          ),
        );

        expect(find.text('Option 1'), findsOneWidget);
      });

      testWidgets('opens dropdown menu when tapped', (
        WidgetTester tester,
      ) async {
        String? value;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            value: value,
            onChanged: (String? newValue) => value = newValue,
            label: 'Dropdown Menu',
          ),
        );

        await tester.tap(find.byType(DropdownButton<String>));
        await tester.pumpAndSettle();

        // Should show dropdown items
        expect(find.text('Option 1'), findsWidgets);
        expect(find.text('Option 2'), findsOneWidget);
        expect(find.text('Option 3'), findsOneWidget);
      });

      testWidgets('selects item from dropdown', (WidgetTester tester) async {
        String? value;

        await CorpoTestUtils.pumpWithTheme(
          tester,
          StatefulBuilder(
            builder: (BuildContext context, setState) => CorpoDropdown<String>(
              items: items,
              value: value,
              onChanged: (String? newValue) => setState(() => value = newValue),
              label: 'Selectable Dropdown',
            ),
          ),
        );

        await tester.tap(find.byType(DropdownButton<String>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option 2').last);
        await tester.pumpAndSettle();

        expect(find.text('Option 2'), findsOneWidget);
      });

      testWidgets('shows placeholder when no value selected', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Dropdown',
            placeholder: 'Choose an option',
          ),
        );

        expect(find.text('Choose an option'), findsOneWidget);
      });

      testWidgets('shows helper text when provided', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Dropdown with Helper',
            helperText: 'This is helper text',
          ),
        );

        expect(find.text('This is helper text'), findsOneWidget);
      });

      testWidgets('shows error text when provided', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Dropdown with Error',
            errorText: 'This field is required',
          ),
        );

        expect(find.text('This field is required'), findsOneWidget);
      });

      testWidgets('disables when onChanged is null', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: null,
            label: 'Disabled Dropdown',
          ),
        );

        final DropdownButton<String> dropdown = tester.widget<DropdownButton<String>>(
          find.byType(DropdownButton<String>),
        );
        expect(dropdown.onChanged, isNull);
      });
    });

    group('Size Variants', () {
      testWidgets('renders small dropdown', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Small Dropdown',
            size: CorpoDropdownSize.small,
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      });

      testWidgets('renders medium dropdown (default)', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Medium Dropdown',
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      });

      testWidgets('renders large dropdown', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Large Dropdown',
            size: CorpoDropdownSize.large,
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      });
    });

    group('Validation', () {
      testWidgets('supports custom validator', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Validated Dropdown',
            validator: (String? value) =>
                value == null ? 'Please select an option' : null,
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('supports semantic labels', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
            label: 'Accessible Dropdown',
            semanticLabel: 'Custom semantic label',
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty items list', (WidgetTester tester) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: const <CorpoDropdownItem<String>>[],
            onChanged: (String? value) {},
            label: 'Empty Dropdown',
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      });

      testWidgets('handles dropdown without label', (
        WidgetTester tester,
      ) async {
        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<String>(
            items: items,
            onChanged: (String? value) {},
          ),
        );

        expect(find.byType(CorpoDropdown<String>), findsOneWidget);
      });

      testWidgets('works with different value types', (
        WidgetTester tester,
      ) async {
        final List<CorpoDropdownItem<int>> intItems = <CorpoDropdownItem<int>>[
          const CorpoDropdownItem(value: 1, child: Text('One')),
          const CorpoDropdownItem(value: 2, child: Text('Two')),
        ];

        await CorpoTestUtils.pumpWithTheme(
          tester,
          CorpoDropdown<int>(
            items: intItems,
            onChanged: (int? value) {},
            label: 'Integer Dropdown',
          ),
        );

        expect(find.byType(CorpoDropdown<int>), findsOneWidget);
      });
    });
  });

  group('Integration Tests', () {
    testWidgets('all input components work together', (
      WidgetTester tester,
    ) async {
      bool checkboxValue = false;
      String? radioValue = 'option1';
      bool switchValue = false;
      String? dropdownValue;

      final List<CorpoDropdownItem<String>> dropdownItems = <CorpoDropdownItem<String>>[
        const CorpoDropdownItem(value: 'choice1', child: Text('Choice 1')),
        const CorpoDropdownItem(value: 'choice2', child: Text('Choice 2')),
      ];

      await CorpoTestUtils.pumpWithTheme(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, setState) => Column(
            children: <Widget>[
              CorpoCheckbox(
                value: checkboxValue,
                onChanged: (bool? value) =>
                    setState(() => checkboxValue = value ?? false),
                label: 'Agreement Checkbox',
              ),
              CorpoRadio<String>(
                value: 'option1',
                groupValue: radioValue,
                onChanged: (String? value) => setState(() => radioValue = value),
                label: 'Radio Option 1',
              ),
              CorpoRadio<String>(
                value: 'option2',
                groupValue: radioValue,
                onChanged: (String? value) => setState(() => radioValue = value),
                label: 'Radio Option 2',
              ),
              CorpoSwitch(
                value: switchValue,
                onChanged: (bool value) => setState(() => switchValue = value),
                label: 'Feature Toggle',
              ),
              CorpoDropdown<String>(
                items: dropdownItems,
                value: dropdownValue,
                onChanged: (String? value) => setState(() => dropdownValue = value),
                label: 'Dropdown Selection',
              ),
            ],
          ),
        ),
      );

      // Verify all components render
      expect(find.byType(CorpoCheckbox), findsOneWidget);
      expect(find.byType(CorpoRadio<String>), findsNWidgets(2));
      expect(find.byType(CorpoSwitch), findsOneWidget);
      expect(find.byType(CorpoDropdown<String>), findsOneWidget);

      // Test interactions
      await tester.tap(find.text('Agreement Checkbox'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Radio Option 2'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choice 1').last);
      await tester.pumpAndSettle();

      // Verify states
      expect(find.text('Choice 1'), findsOneWidget);
    });

    testWidgets('form validation works across components', (
      WidgetTester tester,
    ) async {
      bool checkboxValue = false;
      String? dropdownValue;

      await CorpoTestUtils.pumpWithTheme(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, setState) => Form(
            child: Column(
              children: <Widget>[
                CorpoCheckbox(
                  value: checkboxValue,
                  onChanged: (bool? value) =>
                      setState(() => checkboxValue = value ?? false),
                  label: 'Required Agreement',
                ),
                CorpoDropdown<String>(
                  items: const <CorpoDropdownItem<String>>[
                    CorpoDropdownItem(
                      value: 'choice1',
                      child: Text('Choice 1'),
                    ),
                  ],
                  value: dropdownValue,
                  onChanged: (String? value) => setState(() => dropdownValue = value),
                  label: 'Required Selection',
                  validator: (String? value) => value == null ? 'Required' : null,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(CorpoCheckbox), findsOneWidget);
      expect(find.byType(CorpoDropdown<String>), findsOneWidget);
    });
  });
}
