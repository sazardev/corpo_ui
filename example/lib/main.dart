import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';

import 'shadcn_demo.dart';

void main() {
  runApp(const CorpoUIExampleApp());
}

/// Example application demonstrating Corpo UI components.
class CorpoUIExampleApp extends StatelessWidget {
  /// Creates a new Corpo UI example app.
  const CorpoUIExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Corpo UI Example',
    theme: CorpoTheme.light(),
    darkTheme: CorpoTheme.dark(),
    home: const ExampleHomePage(),
  );
}

/// Home page showcasing basic Corpo UI components.
class ExampleHomePage extends StatefulWidget {
  /// Creates a new example home page.
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  bool _switchValue = false;
  String _textFieldValue = '';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CorpoAppBar(
      title: const CorpoText(
        'Corpo UI Example',
        variant: CorpoTextVariant.bodyLarge,
      ),
      centerTitle: true,
      actions: <Widget>[
        CorpoIconButton(
          icon: Icons.science,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ShadCNPhilosophyDemo(),
              ),
            );
          },
          tooltip: 'ShadCN Philosophy Demo',
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(CorpoSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ShadCN Demo Button
          CorpoCard(
            child: Column(
              children: <Widget>[
                const CorpoText(
                  '🎯 Experience the ShadCN Philosophy',
                  variant: CorpoTextVariant.headingMedium,
                ),
                const CorpoSpacer.small(),
                const CorpoText(
                  'See how "Change one file, transform your entire app" works in action!',
                  variant: CorpoTextVariant.bodyMedium,
                ),
                const CorpoSpacer.medium(),
                CorpoButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ShadCNPhilosophyDemo(),
                      ),
                    );
                  },
                  child: const CorpoText(
                    '🚀 Try ShadCN Demo',
                    variant: CorpoTextVariant.button,
                  ),
                ),
              ],
            ),
          ),
          const CorpoSpacer.large(),
          // Typography Examples
          const CorpoHeading(
            'Typography Components',
            level: CorpoHeadingLevel.h2,
          ),
          const CorpoSpacer.medium(),
          const CorpoText(
            'This is a sample of Corpo UI typography components. '
            'The design system provides consistent text styling across your app.',
            variant: CorpoTextVariant.bodyMedium,
          ),
          const CorpoSpacer.large(),

          // Button Examples
          const CorpoHeading('Button Components', level: CorpoHeadingLevel.h2),
          const CorpoSpacer.medium(),
          Column(
            children: <Widget>[
              CorpoButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Primary button pressed!')),
                  );
                },
                child: const CorpoText(
                  'Primary Button',
                  variant: CorpoTextVariant.labelLarge,
                ),
              ),
              const CorpoSpacer.small(),
              CorpoButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Secondary button pressed!')),
                  );
                },
                variant: CorpoButtonVariant.secondary,
                child: const CorpoText(
                  'Secondary Button',
                  variant: CorpoTextVariant.labelLarge,
                ),
              ),
              const CorpoSpacer.small(),
              CorpoOutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Outlined button pressed!')),
                  );
                },
                child: const CorpoText(
                  'Outlined Button',
                  variant: CorpoTextVariant.labelLarge,
                ),
              ),
            ],
          ),
          const CorpoSpacer.large(),

          // Input Examples
          const CorpoHeading('Input Components', level: CorpoHeadingLevel.h2),
          const CorpoSpacer.medium(),
          CorpoTextField(
            label: 'Sample Text Field',
            placeholder: 'Enter some text...',
            onChanged: (String value) {
              setState(() {
                _textFieldValue = value;
              });
            },
          ),
          const CorpoSpacer.medium(),
          Row(
            children: <Widget>[
              const CorpoText(
                'Toggle Switch: ',
                variant: CorpoTextVariant.bodyMedium,
              ),
              CorpoSwitch(
                value: _switchValue,
                onChanged: (bool value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ],
          ),
          const CorpoSpacer.large(),

          // Card Example
          const CorpoHeading('Layout Components', level: CorpoHeadingLevel.h2),
          const CorpoSpacer.medium(),
          CorpoCard(
            child: Padding(
              padding: const EdgeInsets.all(CorpoSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CorpoHeading(
                    'Sample Card',
                    level: CorpoHeadingLevel.h3,
                  ),
                  const CorpoSpacer.small(),
                  const CorpoText(
                    'This is an example of a Corpo UI card component. '
                    'Cards are great for grouping related content.',
                    variant: CorpoTextVariant.bodyMedium,
                  ),
                  const CorpoSpacer.medium(),
                  if (_textFieldValue.isNotEmpty)
                    CorpoText(
                      'You typed: $_textFieldValue',
                      variant: CorpoTextVariant.bodySmall,
                    ),
                ],
              ),
            ),
          ),
          const CorpoSpacer.large(),

          // Icons and Badges
          const CorpoHeading('Icons & Badges', level: CorpoHeadingLevel.h2),
          const CorpoSpacer.medium(),
          Row(
            children: <Widget>[
              const CorpoIcon(Icons.star, semanticLabel: 'Star icon'),
              const CorpoSpacer.small(),
              const CorpoIcon(Icons.favorite, semanticLabel: 'Heart icon'),
              const CorpoSpacer.small(),
              CorpoBadge(
                _switchValue ? 'Active' : 'Inactive',
                variant: _switchValue
                    ? CorpoBadgeVariant.success
                    : CorpoBadgeVariant.neutral,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
