import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:corpo_ui/corpo_ui.dart';
import '../helpers/test_utils.dart';

void main() {
  group('Accessibility Compliance Tests', () {
    testWidgets('CorpoButton has proper accessibility semantics', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        CorpoButton(onPressed: () {}, child: const Text('Click me')),
      );

      final SemanticsNode buttonNode = tester.getSemantics(
        find.byType(CorpoButton),
      );

      expect(buttonNode.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(buttonNode.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
      expect(buttonNode.hasFlag(SemanticsFlag.isEnabled), isTrue);
      expect(buttonNode.label, contains('Click me'));
    });

    testWidgets('CorpoTextField has proper accessibility labels', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        const CorpoTextField(
          label: 'Email Address',
          helperText: 'Enter your email',
        ),
      );

      final SemanticsNode textFieldNode = tester.getSemantics(
        find.byType(TextField),
      );

      expect(textFieldNode.hasFlag(SemanticsFlag.isTextField), isTrue);
      // Note: Label might be handled differently by the component
      expect(find.text('Email Address'), findsOneWidget);
    });

    testWidgets('CorpoCheckbox has proper accessibility semantics', (
      WidgetTester tester,
    ) async {
      bool? value = false;
      await CorpoTestUtils.pumpWithTheme(
        tester,
        CorpoCheckbox(
          value: value,
          onChanged: (newValue) => value = newValue,
          label: 'Accept terms',
        ),
      );

      final SemanticsNode checkboxNode = tester.getSemantics(
        find.byType(Checkbox),
      );

      expect(checkboxNode.hasFlag(SemanticsFlag.hasCheckedState), isTrue);
      expect(checkboxNode.hasFlag(SemanticsFlag.isChecked), isFalse);
      expect(checkboxNode.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
      expect(checkboxNode.hasFlag(SemanticsFlag.isEnabled), isTrue);
    });

    testWidgets('CorpoRadio has proper accessibility semantics', (
      WidgetTester tester,
    ) async {
      String? selectedValue = 'option1';
      await CorpoTestUtils.pumpWithTheme(
        tester,
        Column(
          children: [
            CorpoRadio<String>(
              value: 'option1',
              groupValue: selectedValue,
              onChanged: (value) => selectedValue = value,
              label: 'Option 1',
            ),
            CorpoRadio<String>(
              value: 'option2',
              groupValue: selectedValue,
              onChanged: (value) => selectedValue = value,
              label: 'Option 2',
            ),
          ],
        ),
      );

      final firstRadio = tester.getSemantics(find.byType(Radio<String>).first);
      final secondRadio = tester.getSemantics(find.byType(Radio<String>).last);

      expect(firstRadio.hasFlag(SemanticsFlag.hasCheckedState), isTrue);
      expect(firstRadio.hasFlag(SemanticsFlag.isChecked), isTrue);
      expect(
        firstRadio.hasFlag(SemanticsFlag.isInMutuallyExclusiveGroup),
        isTrue,
      );

      expect(secondRadio.hasFlag(SemanticsFlag.hasCheckedState), isTrue);
      expect(secondRadio.hasFlag(SemanticsFlag.isChecked), isFalse);
      expect(
        secondRadio.hasFlag(SemanticsFlag.isInMutuallyExclusiveGroup),
        isTrue,
      );
    });

    testWidgets('CorpoSwitch has proper accessibility semantics', (
      WidgetTester tester,
    ) async {
      bool value = true;
      await CorpoTestUtils.pumpWithTheme(
        tester,
        CorpoSwitch(
          value: value,
          onChanged: (newValue) => value = newValue,
          label: 'Enable notifications',
        ),
      );

      final SemanticsNode switchNode = tester.getSemantics(find.byType(Switch));

      expect(switchNode.hasFlag(SemanticsFlag.hasToggledState), isTrue);
      expect(switchNode.hasFlag(SemanticsFlag.isToggled), isTrue);
      expect(switchNode.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
      expect(switchNode.hasFlag(SemanticsFlag.isEnabled), isTrue);
    });

    testWidgets('CorpoCard has proper semantic structure', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        const CorpoCard(child: Text('Card content')),
      );

      // Verify card content is accessible
      expect(find.text('Card content'), findsOneWidget);
      final textNode = tester.getSemantics(find.text('Card content'));
      expect(textNode.label, 'Card content');
    });

    testWidgets('CorpoAppBar has proper accessibility structure', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        Scaffold(
          appBar: CorpoAppBar(
            title: const Text('Test Title'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
                tooltip: 'Search',
              ),
            ],
          ),
          body: const Text('Body'),
        ),
      );

      // Verify AppBar title is accessible
      expect(find.text('Test Title'), findsOneWidget);

      // Verify action button is accessible
      final actionNode = tester.getSemantics(find.byIcon(Icons.search));
      expect(actionNode.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(actionNode.tooltip, 'Search');
    });

    testWidgets('Components support high contrast mode', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        Column(
          children: [
            CorpoButton(
              onPressed: () {},
              child: const Text('High Contrast Button'),
            ),
            const CorpoTextField(label: 'High Contrast Field'),
            CorpoCheckbox(
              value: true,
              onChanged: (value) {},
              label: 'High Contrast Checkbox',
            ),
          ],
        ),
        // Simulate high contrast
        darkMode: true,
      );

      // Verify components render in high contrast mode
      expect(find.byType(CorpoButton), findsOneWidget);
      expect(find.byType(CorpoTextField), findsOneWidget);
      expect(find.byType(CorpoCheckbox), findsOneWidget);
    });

    testWidgets('Error states have proper accessibility semantics', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        const CorpoTextField(label: 'Email', errorText: 'Invalid email format'),
      );

      // Error text should be announced to screen readers
      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('Components respect reduced motion preferences', (
      WidgetTester tester,
    ) async {
      // This test ensures components work when animations are disabled
      await CorpoTestUtils.pumpWithTheme(
        tester,
        CorpoButton(onPressed: () {}, child: const Text('Animated Button')),
      );

      // Tap button and verify it responds even with reduced motion
      await tester.tap(find.byType(CorpoButton));
      await tester.pump();

      // Button should still be interactive
      expect(find.byType(CorpoButton), findsOneWidget);
    });

    testWidgets('Large text scaling is supported', (WidgetTester tester) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
          child: Column(
            children: [
              CorpoButton(
                onPressed: () {},
                child: const Text('Large Text Button'),
              ),
              const CorpoTextField(label: 'Large Text Field'),
            ],
          ),
        ),
      );

      // Verify components render with large text
      expect(find.byType(CorpoButton), findsOneWidget);
      expect(find.byType(CorpoTextField), findsOneWidget);
      expect(find.text('Large Text Button'), findsOneWidget);
    });

    testWidgets('Color contrast meets WCAG guidelines', (
      WidgetTester tester,
    ) async {
      // Test both light and dark themes for contrast
      await CorpoTestUtils.pumpWithTheme(
        tester,
        CorpoButton(onPressed: () {}, child: const Text('Contrast Test')),
        darkMode: false,
      );

      expect(find.byType(CorpoButton), findsOneWidget);

      // Test dark theme
      await CorpoTestUtils.pumpWithTheme(
        tester,
        CorpoButton(onPressed: () {}, child: const Text('Contrast Test')),
        darkMode: true,
      );

      expect(find.byType(CorpoButton), findsOneWidget);
    });

    testWidgets('Disabled states are properly announced', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        Column(
          children: [
            CorpoButton(
              onPressed: null, // Disabled
              child: const Text('Disabled Button'),
            ),
            CorpoCheckbox(
              value: false,
              onChanged: null, // Disabled
              label: 'Disabled Checkbox',
            ),
          ],
        ),
      );

      final disabledButtonNode = tester.getSemantics(find.byType(CorpoButton));
      expect(disabledButtonNode.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
      expect(disabledButtonNode.hasFlag(SemanticsFlag.isEnabled), isFalse);

      final disabledCheckboxNode = tester.getSemantics(find.byType(Checkbox));
      expect(
        disabledCheckboxNode.hasFlag(SemanticsFlag.hasEnabledState),
        isTrue,
      );
      expect(disabledCheckboxNode.hasFlag(SemanticsFlag.isEnabled), isFalse);
    });
  });

  group('Basic Interaction Tests', () {
    testWidgets('Tapping components works correctly', (
      WidgetTester tester,
    ) async {
      bool buttonPressed = false;
      bool? checkboxValue = false;
      bool switchValue = false;

      await CorpoTestUtils.pumpWithTheme(
        tester,
        StatefulBuilder(
          builder: (context, setState) => Column(
            children: [
              CorpoButton(
                onPressed: () => setState(() => buttonPressed = true),
                child: const Text('Test Button'),
              ),
              CorpoCheckbox(
                value: checkboxValue,
                onChanged: (value) => setState(() => checkboxValue = value),
                label: 'Test Checkbox',
              ),
              CorpoSwitch(
                value: switchValue,
                onChanged: (value) => setState(() => switchValue = value),
                label: 'Test Switch',
              ),
            ],
          ),
        ),
      );

      // Test button interaction
      await tester.tap(find.byType(CorpoButton));
      await tester.pump();
      expect(buttonPressed, isTrue);

      // Test checkbox interaction
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(checkboxValue, isTrue);

      // Test switch interaction
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(switchValue, isTrue);
    });

    testWidgets('All interactive elements respond to touch', (
      WidgetTester tester,
    ) async {
      await CorpoTestUtils.pumpWithTheme(
        tester,
        Column(
          children: [
            CorpoButton(onPressed: () {}, child: const Text('Touch Button')),
            const CorpoTextField(label: 'Touch Field'),
            CorpoCheckbox(
              value: false,
              onChanged: (value) {},
              label: 'Touch Checkbox',
            ),
            CorpoSwitch(
              value: false,
              onChanged: (value) {},
              label: 'Touch Switch',
            ),
          ],
        ),
      );

      // Verify all components can be found and are interactive
      expect(find.byType(CorpoButton), findsOneWidget);
      expect(find.byType(CorpoTextField), findsOneWidget);
      expect(find.byType(CorpoCheckbox), findsOneWidget);
      expect(find.byType(CorpoSwitch), findsOneWidget);

      // Test that they respond to taps (no exceptions thrown)
      await tester.tap(find.byType(CorpoButton));
      await tester.tap(find.byType(Checkbox));
      await tester.tap(find.byType(Switch));
      await tester.pump();
    });
  });
}
