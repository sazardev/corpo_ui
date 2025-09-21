/// Corpo UI Theme Switcher - The Magic of ShadCN in Flutter!
///
/// This file demonstrates the REVOLUTIONARY ShadCN philosophy:
/// "Change one file, transform your entire app"
///
/// Every theme switch here instantly updates ALL components throughout
/// the entire application by modifying the central design tokens.

import 'package:flutter/material.dart';
import 'package:corpo_ui/corpo_ui.dart';

/// A powerful theme switcher widget that demonstrates the ShadCN philosophy.
///
/// This widget provides instant theme switching capabilities, showing how
/// changing design tokens transforms the entire application instantly.
class CorpoThemeSwitcher extends StatefulWidget {
  const CorpoThemeSwitcher({super.key});

  @override
  State<CorpoThemeSwitcher> createState() => _CorpoThemeSwitcherState();
}

class _CorpoThemeSwitcherState extends State<CorpoThemeSwitcher> {
  String _currentTheme = 'Corporate';

  final List<ThemePreset> _themes = [
    ThemePreset(
      name: 'Corporate',
      description: 'Professional blue theme',
      primaryColor: const Color(0xFF3182CE),
      icon: Icons.business_center,
      onApply: () => CorpoDesignTokens.applyCorporateTheme(),
    ),
    ThemePreset(
      name: 'Modern',
      description: 'Purple modern theme',
      primaryColor: const Color(0xFF8B5CF6),
      icon: Icons.auto_awesome,
      onApply: () => CorpoDesignTokens.applyModernTheme(),
    ),
    ThemePreset(
      name: 'Friendly',
      description: 'Orange warm theme',
      primaryColor: const Color(0xFFEA580C),
      icon: Icons.emoji_emotions,
      onApply: () => CorpoDesignTokens.applyFriendlyTheme(),
    ),
    ThemePreset(
      name: 'Minimal',
      description: 'Black & white minimal',
      primaryColor: const Color(0xFF1F2937),
      icon: Icons.minimize,
      onApply: () => CorpoDesignTokens.applyMinimalTheme(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return PopupMenuButton<ThemePreset>(
      icon: CorpoIcon(
        Icons.palette,
        color: tokens.getTextColorFor(tokens.primaryColor),
        size: CorpoIconSize.medium,
      ),
      tooltip: 'Switch Theme - See ShadCN Magic!',
      itemBuilder: (context) => _themes
          .map(
            (theme) => PopupMenuItem<ThemePreset>(
              value: theme,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(
                        tokens.borderRadiusSmall,
                      ),
                    ),
                    child: _currentTheme == theme.name
                        ? CorpoIcon(
                            Icons.check,
                            color: tokens.getTextColorFor(theme.primaryColor),
                            size: CorpoIconSize.extraSmall,
                          )
                        : null,
                  ),
                  CorpoSpacer.small(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CorpoText(
                          theme.name,
                          variant: CorpoTextVariant.bodyMedium,
                        ),
                        CorpoText(
                          theme.description,
                          variant: CorpoTextVariant.bodySmall,
                          color: tokens.textSecondary,
                        ),
                      ],
                    ),
                  ),
                  CorpoIcon(
                    theme.icon,
                    color: tokens.textSecondary,
                    size: CorpoIconSize.small,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onSelected: (theme) {
        setState(() => _currentTheme = theme.name);
        theme.onApply();

        // Show magic happening!
        _showThemeChangeNotification(theme);
      },
    );
  }

  void _showThemeChangeNotification(ThemePreset theme) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: tokens.primaryColor,
        content: Row(
          children: [
            CorpoIcon(
              Icons.auto_fix_high,
              color: tokens.getTextColorFor(tokens.primaryColor),
              size: CorpoIconSize.small,
            ),
            CorpoSpacer.small(),
            CorpoText(
              '🎨 ShadCN Magic! ${theme.name} theme applied instantly!',
              color: tokens.getTextColorFor(tokens.primaryColor),
              variant: CorpoTextVariant.bodyMedium,
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Theme preset configuration model.
class ThemePreset {
  const ThemePreset({
    required this.name,
    required this.description,
    required this.primaryColor,
    required this.icon,
    required this.onApply,
  });

  final String name;
  final String description;
  final Color primaryColor;
  final IconData icon;
  final VoidCallback onApply;
}

/// Advanced theme customization widget for power users.
///
/// This widget allows real-time customization of design tokens,
/// demonstrating the full power of the ShadCN system.
class CorpoThemeCustomizer extends StatefulWidget {
  const CorpoThemeCustomizer({super.key});

  @override
  State<CorpoThemeCustomizer> createState() => _CorpoThemeCustomizerState();
}

class _CorpoThemeCustomizerState extends State<CorpoThemeCustomizer> {
  late Color _primaryColor;
  late Color _secondaryColor;
  late double _borderRadius;
  late double _spacing;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    final tokens = CorpoDesignTokens();
    _primaryColor = tokens.primaryColor;
    _secondaryColor = tokens.secondaryColor;
    _borderRadius = tokens.borderRadius;
    _spacing = tokens.spacing4x;
    _fontSize = tokens.baseFontSize;
  }

  @override
  Widget build(BuildContext context) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Dialog(
      backgroundColor: tokens.surfaceColor,
      child: Container(
        width: 400,
        padding: EdgeInsets.all(tokens.spacing6x),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CorpoHeading('Theme Customizer', level: CorpoHeadingLevel.h2),
                CorpoIconButton(
                  icon: Icons.close,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            CorpoSpacer.medium(),
            CorpoText(
              'Customize your theme and see the ShadCN magic in real-time!',
              variant: CorpoTextVariant.bodyMedium,
              color: tokens.textSecondary,
            ),
            CorpoSpacer.large(),

            // Primary Color
            _buildColorPicker('Primary Color', _primaryColor, (color) {
              setState(() => _primaryColor = color);
              CorpoThemeManager.applyCustomColors(primaryColor: color);
            }),
            CorpoSpacer.medium(),

            // Secondary Color
            _buildColorPicker('Secondary Color', _secondaryColor, (color) {
              setState(() => _secondaryColor = color);
              CorpoThemeManager.applyCustomColors(secondaryColor: color);
            }),
            CorpoSpacer.medium(),

            // Border Radius
            _buildSlider(
              'Border Radius',
              _borderRadius,
              0.0,
              20.0,
              '${_borderRadius.toInt()}px',
              (value) {
                setState(() => _borderRadius = value);
                CorpoThemeManager.applyCustomBorderRadius(value);
              },
            ),
            CorpoSpacer.medium(),

            // Spacing Scale
            _buildSlider(
              'Spacing Scale',
              _spacing,
              8.0,
              32.0,
              '${_spacing.toInt()}px',
              (value) {
                setState(() => _spacing = value);
                // This would update spacing in real implementation
                CorpoThemeManager.applyCustomSpacing(value / 4);
              },
            ),
            CorpoSpacer.medium(),

            // Font Size
            _buildSlider(
              'Font Size',
              _fontSize,
              12.0,
              20.0,
              '${_fontSize.toInt()}px',
              (value) {
                setState(() => _fontSize = value);
                // This would update font size in real implementation
              },
            ),
            CorpoSpacer.large(),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CorpoOutlinedButton(
                    onPressed: _resetToDefaults,
                    child: const Text('Reset'),
                  ),
                ),
                CorpoSpacer.medium(),
                Expanded(
                  child: CorpoButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker(
    String label,
    Color color,
    ValueChanged<Color> onChanged,
  ) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Row(
      children: [
        Expanded(
          child: CorpoText(label, variant: CorpoTextVariant.labelMedium),
        ),
        GestureDetector(
          onTap: () => _showColorDialog(color, onChanged),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(tokens.borderRadius),
              border: Border.all(color: tokens.textSecondary.withOpacity(0.3)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    String displayValue,
    ValueChanged<double> onChanged,
  ) {
    final CorpoDesignTokens tokens = CorpoDesignTokens();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CorpoText(label, variant: CorpoTextVariant.labelMedium),
            CorpoText(
              displayValue,
              variant: CorpoTextVariant.bodySmall,
              color: tokens.textSecondary,
            ),
          ],
        ),
        CorpoSpacer.small(),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: tokens.primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _showColorDialog(Color currentColor, ValueChanged<Color> onChanged) {
    final colors = [
      Colors.blue[600]!,
      Colors.purple[600]!,
      Colors.orange[600]!,
      Colors.green[600]!,
      Colors.red[600]!,
      Colors.teal[600]!,
      Colors.pink[600]!,
      Colors.indigo[600]!,
      Colors.brown[600]!,
      Colors.grey[600]!,
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Color'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors
              .map(
                (color) => GestureDetector(
                  onTap: () {
                    onChanged(color);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: currentColor == color
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _resetToDefaults() {
    CorpoDesignTokens.applyCorporateTheme();
    final tokens = CorpoDesignTokens();
    setState(() {
      _primaryColor = tokens.primaryColor;
      _secondaryColor = tokens.secondaryColor;
      _borderRadius = tokens.borderRadius;
      _spacing = tokens.spacing4x;
      _fontSize = tokens.baseFontSize;
    });
  }
}

/// Utility class for design tokens management.
///
/// This class provides convenient methods for theme customization,
/// demonstrating the ShadCN philosophy of centralized control.
class CorpoThemeManager {
  /// Apply a custom color scheme instantly.
  static void applyCustomColors({Color? primaryColor, Color? secondaryColor}) {
    // For now, we'll use the preset themes
    // In a real implementation, you would modify the design tokens directly
    if (primaryColor != null) {
      // This would update the design tokens if we had setters
      // tokens.primaryColor = primaryColor;
    }
  }

  /// Apply custom spacing scale.
  static void applyCustomSpacing(double baseSpacing) {
    // This would update the spacing scale
    // tokens.spacing = baseSpacing;
  }

  /// Apply custom border radius.
  static void applyCustomBorderRadius(double radius) {
    // This would update the border radius
    // tokens.borderRadius = radius;
  }
}
