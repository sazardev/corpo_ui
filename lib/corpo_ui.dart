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

// Accessibility System (Phase 5.3)
export 'src/accessibility/accessibility.dart';
// Animation System (Phase 5.1)
export 'src/animations/animations.dart';
// Avatar Components
export 'src/components/avatars/corpo_avatar.dart';
// Badge Components
export 'src/components/badges/corpo_badge.dart';
// Button Components
export 'src/components/buttons/corpo_button.dart';
export 'src/components/buttons/corpo_icon_button.dart';
export 'src/components/buttons/corpo_outlined_button.dart';
export 'src/components/buttons/corpo_text_button.dart';
// Data Components
export 'src/components/data/corpo_data_table.dart';
export 'src/components/data/corpo_expansion_panel.dart';
export 'src/components/data/corpo_list_tile.dart';
export 'src/components/data/corpo_stepper.dart';
export 'src/components/data/corpo_timeline.dart';
// Feedback Components
export 'src/components/feedback/corpo_alert.dart';
export 'src/components/feedback/corpo_dialog.dart';
export 'src/components/feedback/corpo_skeleton.dart';
export 'src/components/feedback/corpo_snackbar.dart';
// Form Components
export 'src/components/forms/corpo_date_picker.dart';
export 'src/components/forms/corpo_dropdown.dart';
export 'src/components/forms/corpo_form.dart';
export 'src/components/forms/corpo_form_field.dart';
export 'src/components/forms/corpo_search_field.dart';
export 'src/components/forms/corpo_slider.dart';
export 'src/components/forms/corpo_time_picker.dart';
export 'src/components/forms/validation.dart';
// Icon Components
export 'src/components/icons/corpo_icon.dart';
// Input Components
export 'src/components/inputs/corpo_checkbox.dart';
export 'src/components/inputs/corpo_radio.dart';
export 'src/components/inputs/corpo_switch.dart';
export 'src/components/inputs/corpo_text_field.dart';
// Layout Components
export 'src/components/layout/corpo_card.dart';
export 'src/components/layout/corpo_divider.dart';
export 'src/components/layout/corpo_spacer.dart';
export 'src/components/layout/corpo_surface.dart';
// Media Components
export 'src/components/media/corpo_image.dart';
// Navigation Components
export 'src/components/navigation/corpo_app_bar.dart';
export 'src/components/navigation/corpo_bottom_navigation.dart';
export 'src/components/navigation/corpo_breadcrumb.dart';
export 'src/components/navigation/corpo_drawer.dart';
export 'src/components/navigation/corpo_tabs.dart';
// Overlay Components
export 'src/components/overlay/corpo_modal.dart';
export 'src/components/overlay/corpo_popover.dart';
export 'src/components/overlay/corpo_sheet.dart';
export 'src/components/overlay/corpo_tooltip.dart';
// Progress Components
export 'src/components/progress/corpo_progress_bar.dart';
export 'src/components/progress/corpo_spinner.dart';
// Typography Components
export 'src/components/typography/corpo_code.dart';
export 'src/components/typography/corpo_heading.dart';
export 'src/components/typography/corpo_label.dart';
export 'src/components/typography/corpo_text.dart';
// Design Tokens - ShadCN-style configuration system
export 'src/design_tokens.dart';
// Design Tokens
export 'src/constants/colors.dart';
export 'src/constants/spacing.dart';
export 'src/constants/typography.dart';
// Responsive System (Phase 5.2)
export 'src/responsive/adaptive_components.dart';
export 'src/responsive/layout_grid.dart';
export 'src/responsive/responsive_builder.dart';
export 'src/responsive/screen_size.dart';
// Theme System
export 'src/theme/corpo_theme.dart';
// Utilities
export 'src/utils/accessibility.dart';
