/// Comprehensive accessibility utilities for the Corpo UI design system.
///
/// This file exports all accessibility-related utilities including
/// focus management, screen reader optimizations, color contrast
/// validation, and semantic markup improvements.
///
/// The accessibility system provides:
/// - Focus management and keyboard navigation
/// - Screen reader optimization and announcements
/// - WCAG-compliant color contrast validation
/// - Semantic markup for proper content structure
/// - High contrast and reduced motion support
///
/// Example usage:
/// ```dart
/// // Focus management
/// CorpoFocusManager(
///   autoFocus: true,
///   child: MyWidget(),
/// )
///
/// // Screen reader support
/// CorpoSemanticLabel(
///   label: 'Submit form',
///   hint: 'Submits the current form data',
///   child: MyButton(),
/// )
///
/// // Contrast validation
/// final isCompliant = CorpoContrastValidator.validateContrast(
///   foreground: Colors.black,
///   background: Colors.white,
///   level: WCAGLevel.aa,
/// );
///
/// // Semantic structure
/// CorpoSemanticStructure(
///   semanticRole: CorpoSemanticRole.main,
///   child: ContentWidget(),
/// )
/// ```
library;

// Color Contrast Validation
export 'color_contrast.dart';
// Focus Management
export 'focus_management.dart';
// Screen Reader Optimization
export 'screen_reader.dart';
// Semantic Markup
export 'semantic_markup.dart';
