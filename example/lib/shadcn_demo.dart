/// ShadCN Philosophy Demo - "Change one file, transform your entire app"
///
/// This demo showcases the revolutionary ShadCN approach implemented in Corpo UI:
/// Change a single line in design tokens and watch your entire app transform!
library;

import 'package:flutter/material.dart';
import 'package:corpo_ui/corpo_ui.dart';

/// Demo page showing the ShadCN philosophy in action
class ShadCNPhilosophyDemo extends StatefulWidget {
  /// Creates a new ShadCN philosophy demo page.
  const ShadCNPhilosophyDemo({super.key});

  @override
  State<ShadCNPhilosophyDemo> createState() => _ShadCNPhilosophyDemoState();
}

class _ShadCNPhilosophyDemoState extends State<ShadCNPhilosophyDemo> {
  String _currentTheme = 'Corporate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CorpoAppBar(
        title: const CorpoText(
          'ShadCN Philosophy Demo',
          variant: CorpoTextVariant.headingMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(CorpoDesignTokens().spacing4x),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header explanation
            CorpoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CorpoText(
                    '🎯 The ShadCN Revolution in Flutter',
                    variant: CorpoTextVariant.headingLarge,
                    style: TextStyle(color: CorpoDesignTokens().primaryColor),
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing2x),
                  const CorpoText(
                    'Just like ShadCN UI transformed React, Corpo UI brings the same philosophy to Flutter: '
                    '"Change one file, transform your entire app". Watch as pressing these buttons '
                    'instantly transforms ALL components by modifying a single configuration!',
                    variant: CorpoTextVariant.bodyLarge,
                  ),
                ],
              ),
            ),

            SizedBox(height: CorpoDesignTokens().spacing6x),

            // Theme Selector
            CorpoCard(
              variant: CorpoCardVariant.outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CorpoText(
                    '🎨 One Line Changes Everything',
                    variant: CorpoTextVariant.headingMedium,
                    style: TextStyle(color: CorpoDesignTokens().primaryColor),
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing2x),
                  const CorpoText(
                    'Current theme: ',
                    variant: CorpoTextVariant.bodyMedium,
                  ),
                  CorpoText(
                    _currentTheme,
                    variant: CorpoTextVariant.bodyLarge,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CorpoDesignTokens().primaryColor,
                    ),
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing4x),

                  // Theme buttons
                  Wrap(
                    spacing: CorpoDesignTokens().spacing2x,
                    runSpacing: CorpoDesignTokens().spacing2x,
                    children: <Widget>[
                      CorpoButton(
                        onPressed: () {
                          setState(() {
                            CorpoDesignTokens.applyCorporateTheme();
                            _currentTheme = 'Corporate';
                          });
                        },
                        variant: CorpoButtonVariant.primary,
                        child: const CorpoText(
                          '💼 Corporate',
                          variant: CorpoTextVariant.button,
                        ),
                      ),
                      CorpoButton(
                        onPressed: () {
                          setState(() {
                            CorpoDesignTokens.applyModernTheme();
                            _currentTheme = 'Modern';
                          });
                        },
                        variant: CorpoButtonVariant.secondary,
                        child: const CorpoText(
                          '🚀 Modern',
                          variant: CorpoTextVariant.button,
                        ),
                      ),
                      CorpoButton(
                        onPressed: () {
                          setState(() {
                            CorpoDesignTokens.applyFriendlyTheme();
                            _currentTheme = 'Friendly';
                          });
                        },
                        variant: CorpoButtonVariant.tertiary,
                        child: const CorpoText(
                          '🌟 Friendly',
                          variant: CorpoTextVariant.button,
                        ),
                      ),
                      CorpoButton(
                        onPressed: () {
                          setState(() {
                            CorpoDesignTokens.applyMinimalTheme();
                            _currentTheme = 'Minimal';
                          });
                        },
                        variant: CorpoButtonVariant.danger,
                        child: const CorpoText(
                          '⚫ Minimal',
                          variant: CorpoTextVariant.button,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: CorpoDesignTokens().spacing6x),

            // Component showcase to demonstrate the theme changes
            CorpoText(
              '🎭 Watch Components Transform',
              variant: CorpoTextVariant.headingMedium,
              style: TextStyle(color: CorpoDesignTokens().primaryColor),
            ),
            SizedBox(height: CorpoDesignTokens().spacing4x),

            // Cards showcase
            Row(
              children: <Widget>[
                Expanded(
                  child: CorpoCard(
                    variant: CorpoCardVariant.filled,
                    child: Column(
                      children: <Widget>[
                        CorpoText(
                          'Filled Card',
                          variant: CorpoTextVariant.headingSmall,
                          style: TextStyle(
                            color: CorpoDesignTokens().primaryColor,
                          ),
                        ),
                        SizedBox(height: CorpoDesignTokens().spacing2x),
                        const CorpoText(
                          'This card adapts to the theme automatically',
                          variant: CorpoTextVariant.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: CorpoDesignTokens().spacing2x),
                Expanded(
                  child: CorpoCard(
                    variant: CorpoCardVariant.outlined,
                    child: Column(
                      children: <Widget>[
                        CorpoText(
                          'Outlined Card',
                          variant: CorpoTextVariant.headingSmall,
                          style: TextStyle(
                            color: CorpoDesignTokens().primaryColor,
                          ),
                        ),
                        SizedBox(height: CorpoDesignTokens().spacing2x),
                        const CorpoText(
                          'Borders and colors change with themes',
                          variant: CorpoTextVariant.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: CorpoDesignTokens().spacing4x),

            // Typography showcase
            CorpoCard(
              variant: CorpoCardVariant.tinted,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CorpoText(
                    'Typography Scales with Theme',
                    variant: CorpoTextVariant.headingMedium,
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing2x),
                  const CorpoText(
                    'Display Text - Premium Typography',
                    variant: CorpoTextVariant.displaySmall,
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing1x),
                  const CorpoText(
                    'Heading Large - Perfect for sections',
                    variant: CorpoTextVariant.headingLarge,
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing1x),
                  const CorpoText(
                    'Body Medium - The workhorse of your content',
                    variant: CorpoTextVariant.bodyMedium,
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing1x),
                  const CorpoText(
                    'Caption - For metadata and fine print',
                    variant: CorpoTextVariant.caption,
                  ),
                ],
              ),
            ),

            SizedBox(height: CorpoDesignTokens().spacing6x),

            // Code example
            CorpoCard(
              variant: CorpoCardVariant.outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CorpoText(
                    '💻 The Magic Behind The Scenes',
                    variant: CorpoTextVariant.headingMedium,
                    style: TextStyle(color: CorpoDesignTokens().primaryColor),
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing2x),
                  const CorpoText(
                    'Each button above calls a single line of code:',
                    variant: CorpoTextVariant.bodyMedium,
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing2x),
                  const CorpoCode('CorpoDesignTokens.applyModernTheme();'),
                  SizedBox(height: CorpoDesignTokens().spacing2x),
                  const CorpoText(
                    'That\'s it! One line transforms your entire app. No hunting through '
                    '50 files to change colors. No inconsistencies. Just pure ShadCN magic.',
                    variant: CorpoTextVariant.bodyMedium,
                  ),
                ],
              ),
            ),

            SizedBox(height: CorpoDesignTokens().spacing4x),

            // Call to action
            CorpoCard(
              child: Column(
                children: <Widget>[
                  CorpoText(
                    '🚀 Ready to Transform Your App?',
                    variant: CorpoTextVariant.headingLarge,
                    style: TextStyle(color: CorpoDesignTokens().primaryColor),
                  ),
                  SizedBox(height: CorpoDesignTokens().spacing2x),
                  const CorpoText(
                    'Try switching themes above and watch every single component adapt instantly. '
                    'This is the power of design tokens - the ShadCN way!',
                    variant: CorpoTextVariant.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
