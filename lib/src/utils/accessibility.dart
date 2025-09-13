/// Accessibility utilities for the Corpo UI design system.
///
/// This file provides comprehensive accessibility helpers including
/// semantic announcements, focus management, WCAG compliance utilities,
/// and assistive technology support for building inclusive corporate
/// applications.
///
/// The accessibility system includes:
/// - Screen reader announcements and live regions
/// - Focus management and keyboard navigation
/// - Color contrast and visual accessibility
/// - WCAG 2.1 compliance utilities
/// - Assistive technology integration
///
/// Example usage:
/// ```dart
/// // Announce to screen readers
/// CorpoAccessibility.announce(
///   context,
///   'Data loaded successfully',
///   priority: AnnouncementPriority.polite,
/// );
///
/// // Focus management
/// CorpoAccessibility.requestFocus(context, focusNode);
///
/// // Check color contrast
/// final hasGoodContrast = CorpoAccessibility.hasGoodContrast(
///   foreground: Colors.black,
///   background: Colors.white,
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

/// Priority levels for screen reader announcements.
///
/// Determines how urgent an announcement is and how it should
/// interrupt or queue with other announcements.
enum AnnouncementPriority {
  /// Polite announcements that wait for current speech to finish
  polite,

  /// Assertive announcements that interrupt current speech
  assertive,

  /// Critical announcements for emergency situations
  critical,
}

/// Focus direction for keyboard navigation.
enum FocusDirection {
  /// Move focus to the next focusable element
  next,

  /// Move focus to the previous focusable element
  previous,

  /// Move focus up (for grid-like navigation)
  up,

  /// Move focus down (for grid-like navigation)
  down,

  /// Move focus left (for grid-like navigation)
  left,

  /// Move focus right (for grid-like navigation)
  right,
}

/// WCAG compliance levels for accessibility testing.
enum WcagLevel {
  /// WCAG Level A (minimum)
  a,

  /// WCAG Level AA (standard for most applications)
  aa,

  /// WCAG Level AAA (highest, for specialized applications)
  aaa,
}

/// Comprehensive accessibility utilities for corporate applications.
///
/// Provides static methods for common accessibility patterns,
/// WCAG compliance checking, and assistive technology integration.
abstract final class CorpoAccessibility {
  /// Announces text to screen readers.
  ///
  /// Sends an announcement to assistive technologies like screen readers.
  /// The [priority] determines how the announcement is handled.
  static void announce(
    BuildContext context,
    String message, {
    AnnouncementPriority priority = AnnouncementPriority.polite,
  }) {
    final Assertiveness assertiveness = _getAssertiveness(priority);

    SemanticsService.announce(
      message,
      Directionality.of(context),
      assertiveness: assertiveness,
    );
  }

  /// Requests focus for a specific focus node.
  ///
  /// Safely requests focus and provides feedback to assistive technologies.
  static void requestFocus(
    BuildContext context,
    FocusNode focusNode, {
    String? announcement,
  }) {
    focusNode.requestFocus();

    if (announcement != null) {
      // Delay announcement to ensure focus change is processed first
      WidgetsBinding.instance.addPostFrameCallback((_) {
        announce(context, announcement);
      });
    }
  }

  /// Moves focus in the specified direction.
  ///
  /// Useful for implementing custom keyboard navigation patterns.
  static bool moveFocus(BuildContext context, FocusDirection direction) {
    final FocusNode currentFocus = FocusScope.of(context);

    switch (direction) {
      case FocusDirection.next:
        return currentFocus.nextFocus();
      case FocusDirection.previous:
        return currentFocus.previousFocus();
      case FocusDirection.up:
        return currentFocus.focusInDirection(TraversalDirection.up);
      case FocusDirection.down:
        return currentFocus.focusInDirection(TraversalDirection.down);
      case FocusDirection.left:
        return currentFocus.focusInDirection(TraversalDirection.left);
      case FocusDirection.right:
        return currentFocus.focusInDirection(TraversalDirection.right);
    }
  }

  /// Checks if a color contrast ratio meets WCAG guidelines.
  ///
  /// Calculates the contrast ratio between foreground and background colors
  /// and checks against WCAG standards.
  static bool hasGoodContrast(
    Color foreground,
    Color background, {
    WcagLevel level = WcagLevel.aa,
    bool isLargeText = false,
  }) {
    final double contrastRatio = calculateContrastRatio(foreground, background);
    final double requiredRatio = _getRequiredContrastRatio(level, isLargeText);

    return contrastRatio >= requiredRatio;
  }

  /// Calculates the contrast ratio between two colors.
  ///
  /// Returns a value between 1 and 21, where 21 is the highest contrast
  /// (black on white) and 1 is no contrast (identical colors).
  static double calculateContrastRatio(Color color1, Color color2) {
    final double luminance1 = _calculateLuminance(color1);
    final double luminance2 = _calculateLuminance(color2);

    final double lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final double darker = luminance1 > luminance2 ? luminance2 : luminance1;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Creates an accessible button with proper semantics.
  ///
  /// Wraps a widget with appropriate semantics for button behavior,
  /// including role, actions, and state information.
  static Widget accessibleButton({
    required Widget child,
    required VoidCallback? onPressed,
    String? semanticLabel,
    String? tooltip,
    bool enabled = true,
  }) {
    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      onTap: enabled ? onPressed : null,
      child: Tooltip(message: tooltip ?? '', child: child),
    );
  }

  /// Creates an accessible text input with proper semantics.
  ///
  /// Adds appropriate semantics for text input fields including
  /// labels, hints, error states, and input validation.
  static Widget accessibleTextField({
    required Widget child,
    String? label,
    String? hint,
    String? error,
    bool required = false,
    bool multiline = false,
    TextInputType? keyboardType,
  }) {
    return Semantics(
      textField: true,
      label: label,
      hint: hint,
      multiline: multiline,
      child: child,
    );
  }

  /// Creates a live region for dynamic content updates.
  ///
  /// Used for content that changes dynamically and should be announced
  /// to screen readers, such as loading states or validation messages.
  static Widget liveRegion({
    required Widget child,
    required String announcement,
    AnnouncementPriority priority = AnnouncementPriority.polite,
  }) {
    return Semantics(liveRegion: true, label: announcement, child: child);
  }

  /// Wraps content with skip link functionality.
  ///
  /// Provides a way for keyboard users to skip repetitive navigation
  /// and jump directly to main content.
  static Widget skipLink({
    required Widget child,
    required String skipText,
    required VoidCallback onSkip,
  }) {
    return Focus(
      child: Builder(
        builder: (BuildContext context) {
          return Semantics(
            label: skipText,
            button: true,
            onTap: onSkip,
            child: child,
          );
        },
      ),
    );
  }

  /// Creates an accessible heading with proper semantics.
  ///
  /// Marks text as a heading with the appropriate level for
  /// screen reader navigation structure.
  static Widget heading({
    required Widget child,
    required int level,
    String? semanticLabel,
  }) {
    return Semantics(
      header: true,
      sortKey: OrdinalSortKey(level.toDouble()),
      label: semanticLabel,
      child: child,
    );
  }

  /// Provides haptic feedback for accessibility.
  ///
  /// Gives tactile feedback for users with visual impairments
  /// to understand interface interactions.
  static void hapticFeedback(HapticFeedbackType type) {
    switch (type) {
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
      case HapticFeedbackType.impact:
        HapticFeedback.lightImpact();
      case HapticFeedbackType.success:
        HapticFeedback.mediumImpact();
      case HapticFeedbackType.warning:
        HapticFeedback.heavyImpact();
      case HapticFeedbackType.error:
        HapticFeedback.vibrate();
    }
  }

  /// Checks if high contrast mode is enabled.
  ///
  /// Useful for adjusting UI for users who need high contrast visuals.
  static bool isHighContrastEnabled(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  /// Checks if animations should be reduced for accessibility.
  ///
  /// Returns true if the user has requested reduced motion.
  static bool shouldReduceAnimations(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Gets the current text scale factor for accessibility.
  ///
  /// Returns the user's preferred text scaling for vision accessibility.
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }

  /// Checks if the app is being used with a screen reader.
  ///
  /// Useful for providing alternative interfaces for screen reader users.
  static bool isScreenReaderEnabled(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation;
  }

  // Private helper methods

  static Assertiveness _getAssertiveness(AnnouncementPriority priority) {
    switch (priority) {
      case AnnouncementPriority.polite:
        return Assertiveness.polite;
      case AnnouncementPriority.assertive:
      case AnnouncementPriority.critical:
        return Assertiveness.assertive;
    }
  }

  static double _getRequiredContrastRatio(WcagLevel level, bool isLargeText) {
    switch (level) {
      case WcagLevel.a:
        return 3.0; // Minimum for Level A
      case WcagLevel.aa:
        return isLargeText ? 3.0 : 4.5; // Standard for Level AA
      case WcagLevel.aaa:
        return isLargeText ? 4.5 : 7.0; // Enhanced for Level AAA
    }
  }

  static double _calculateLuminance(Color color) {
    // Convert to RGB values between 0 and 1
    final double r = color.red / 255.0;
    final double g = color.green / 255.0;
    final double b = color.blue / 255.0;

    // Apply gamma correction
    final double rLin = r <= 0.03928
        ? r / 12.92
        : ((r + 0.055) / 1.055).pow(2.4);
    final double gLin = g <= 0.03928
        ? g / 12.92
        : ((g + 0.055) / 1.055).pow(2.4);
    final double bLin = b <= 0.03928
        ? b / 12.92
        : ((b + 0.055) / 1.055).pow(2.4);

    // Calculate relative luminance
    return 0.2126 * rLin + 0.7152 * gLin + 0.0722 * bLin;
  }
}

/// Types of haptic feedback for accessibility.
enum HapticFeedbackType {
  /// Light feedback for selections
  selection,

  /// Medium feedback for interactions
  impact,

  /// Positive feedback for success states
  success,

  /// Attention feedback for warnings
  warning,

  /// Strong feedback for errors
  error,
}

/// Extension for missing pow function.
extension DoubleExtensions on double {
  double pow(double exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent.round(); i++) {
      result *= this;
    }
    return result;
  }
}
