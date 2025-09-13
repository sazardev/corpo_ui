/// Corpo UI - A comprehensive Flutter design system.
///
/// Corpo UI provides a robust foundation for building design systems
/// inspired by corporate application design principles. It offers
/// customizable UI components, themes, and utilities to create
/// consistent and professional Flutter applications.
///
/// This library is organized into several key modules:
/// - Design tokens (colors, spacing, typography)
/// - Theme system (light/dark themes with customization)
/// - UI components (buttons, inputs, layouts, etc.)
/// - Utilities (responsive helpers, accessibility)
///
/// Example usage:
/// ```dart
/// import 'package:corpo_ui/corpo_ui.dart';
///
/// // Apply Corpo UI theme to your app
/// MaterialApp(
///   theme: CorpoTheme.light(),
///   darkTheme: CorpoTheme.dark(),
///   home: MyApp(),
/// )
/// ```
library;

// Button Components
export 'src/components/buttons/corpo_button.dart';
export 'src/components/inputs/corpo_checkbox.dart';
export 'src/components/inputs/corpo_switch.dart';
// Input Components
export 'src/components/inputs/corpo_text_field.dart';
export 'src/components/typography/corpo_code.dart';
// Typography Components
export 'src/components/typography/corpo_text.dart';
// Design Tokens
export 'src/constants/colors.dart';
export 'src/constants/spacing.dart';
export 'src/constants/typography.dart';
// Theme System
export 'src/theme/corpo_theme.dart';
