/// Screen reader optimization utilities for the Corpo UI design system.
///
/// This file provides comprehensive screen reader support including
/// semantic markup, announcements, and content descriptions to ensure
/// excellent accessibility for users with visual impairments.
///
/// The screen reader system includes:
/// - Semantic labels and descriptions
/// - Live region announcements
/// - Navigation landmarks
/// - Content hierarchy optimization
///
/// Example usage:
/// ```dart
/// CorpoSemanticLabel(
///   label: 'Submit form',
///   hint: 'Submits the current form data',
///   child: CorpoButton(onPressed: _submit),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// A widget that provides enhanced semantic labeling for screen readers.
///
/// This component ensures that UI elements are properly described
/// for assistive technologies.
class CorpoSemanticLabel extends StatelessWidget {
  /// Creates a semantic label.
  const CorpoSemanticLabel({
    required this.child,
    this.label,
    this.hint,
    this.value,
    this.increasedValue,
    this.decreasedValue,
    this.onTap,
    this.onLongPress,
    this.onScrollLeft,
    this.onScrollRight,
    this.onScrollUp,
    this.onScrollDown,
    this.onIncrease,
    this.onDecrease,
    this.onCopy,
    this.onCut,
    this.onPaste,
    this.isButton = false,
    this.isTextField = false,
    this.isReadOnly = false,
    this.isSelected = false,
    this.isEnabled = true,
    this.isHidden = false,
    this.isHeader = false,
    this.isLink = false,
    this.isImage = false,
    this.isLiveRegion = false,
    this.liveRegionImportance = Assertiveness.polite,
    super.key,
  });

  /// The child widget to add semantics to.
  final Widget child;

  /// The semantic label for the widget.
  final String? label;

  /// Additional hint information.
  final String? hint;

  /// The current value (for inputs, sliders, etc.).
  final String? value;

  /// The value when increased.
  final String? increasedValue;

  /// The value when decreased.
  final String? decreasedValue;

  /// Tap action callback.
  final VoidCallback? onTap;

  /// Long press action callback.
  final VoidCallback? onLongPress;

  /// Scroll actions.
  final VoidCallback? onScrollLeft;
  final VoidCallback? onScrollRight;
  final VoidCallback? onScrollUp;
  final VoidCallback? onScrollDown;

  /// Increase/decrease actions.
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  /// Text manipulation actions.
  final VoidCallback? onCopy;
  final VoidCallback? onCut;
  final VoidCallback? onPaste;

  /// Semantic properties.
  final bool isButton;
  final bool isTextField;
  final bool isReadOnly;
  final bool isSelected;
  final bool isEnabled;
  final bool isHidden;
  final bool isHeader;
  final bool isLink;
  final bool isImage;
  final bool isLiveRegion;
  final Assertiveness liveRegionImportance;

  @override
  Widget build(BuildContext context) => Semantics(
      label: label,
      hint: hint,
      value: value,
      increasedValue: increasedValue,
      decreasedValue: decreasedValue,
      onTap: onTap,
      onLongPress: onLongPress,
      onScrollLeft: onScrollLeft,
      onScrollRight: onScrollRight,
      onScrollUp: onScrollUp,
      onScrollDown: onScrollDown,
      onIncrease: onIncrease,
      onDecrease: onDecrease,
      onCopy: onCopy,
      onCut: onCut,
      onPaste: onPaste,
      button: isButton,
      textField: isTextField,
      readOnly: isReadOnly,
      selected: isSelected,
      enabled: isEnabled,
      hidden: isHidden,
      header: isHeader,
      link: isLink,
      image: isImage,
      liveRegion: isLiveRegion,
      container: !isButton && !isTextField && !isLink && !isImage,
      child: child,
    );
}

/// A widget that provides live region announcements.
///
/// This component announces changes to screen readers without
/// requiring user focus.
class CorpoLiveRegion extends StatefulWidget {
  /// Creates a live region.
  const CorpoLiveRegion({
    required this.child,
    this.message,
    this.importance = Assertiveness.polite,
    this.announceImmediately = true,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The message to announce.
  final String? message;

  /// The importance level of the announcement.
  final Assertiveness importance;

  /// Whether to announce immediately when the message changes.
  final bool announceImmediately;

  @override
  State<CorpoLiveRegion> createState() => _CorpoLiveRegionState();
}

class _CorpoLiveRegionState extends State<CorpoLiveRegion> {
  String? _previousMessage;

  @override
  void didUpdateWidget(CorpoLiveRegion oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.message != _previousMessage &&
        widget.message != null &&
        widget.announceImmediately) {
      _announceMessage(widget.message!);
    }

    _previousMessage = widget.message;
  }

  void _announceMessage(String message) {
    // Use semantic announcements for immediate feedback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SemanticsService.announce(message, TextDirection.ltr);
    });
  }

  @override
  Widget build(BuildContext context) => Semantics(liveRegion: true, container: true, child: widget.child);
}

/// A widget that provides semantic navigation landmarks.
///
/// This component helps screen reader users navigate between
/// different sections of the application.
class CorpoLandmark extends StatelessWidget {
  /// Creates a landmark.
  const CorpoLandmark({
    required this.child,
    required this.type,
    this.label,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The type of landmark.
  final CorpoLandmarkType type;

  /// Optional label for the landmark.
  final String? label;

  @override
  Widget build(BuildContext context) => CorpoSemanticLabel(
      label: label ?? type.defaultLabel,
      isHeader:
          type == CorpoLandmarkType.banner ||
          type == CorpoLandmarkType.contentInfo,
      child: child,
    );
}

/// Types of semantic landmarks.
enum CorpoLandmarkType {
  /// Main banner (typically header).
  banner('banner'),

  /// Main content area.
  main('main content'),

  /// Navigation area.
  navigation('navigation'),

  /// Complementary content (sidebar).
  complementary('complementary'),

  /// Content information (footer).
  contentInfo('content information'),

  /// Search functionality.
  search('search'),

  /// Form section.
  form('form'),

  /// Application region.
  application('application');

  const CorpoLandmarkType(this.defaultLabel);

  /// Default label for the landmark type.
  final String defaultLabel;
}

/// A widget that provides reading order control.
///
/// This component ensures that screen readers read content
/// in the correct logical order.
class CorpoReadingOrder extends StatelessWidget {
  /// Creates a reading order container.
  const CorpoReadingOrder({
    required this.children,
    this.semanticIndexOverrides = const <int, int>{},
    super.key,
  });

  /// The child widgets in reading order.
  final List<Widget> children;

  /// Override semantic indexes for specific children.
  final Map<int, int> semanticIndexOverrides;

  @override
  Widget build(BuildContext context) => Column(
      children: children.asMap().entries.map((MapEntry<int, Widget> entry) {
        final int index = entry.key;
        final Widget child = entry.value;
        final int semanticIndex = semanticIndexOverrides[index] ?? index;

        return IndexedSemantics(index: semanticIndex, child: child);
      }).toList(),
    );
}

/// A widget that excludes content from semantic tree.
///
/// This component hides decorative or redundant content
/// from screen readers.
class CorpoExcludeSemantics extends StatelessWidget {
  /// Creates a semantic exclusion.
  const CorpoExcludeSemantics({
    required this.child,
    this.excluding = true,
    super.key,
  });

  /// The child widget to exclude.
  final Widget child;

  /// Whether to exclude the child from semantics.
  final bool excluding;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(excluding: excluding, child: child);
}

/// A widget that merges semantic information from children.
///
/// This component combines multiple widgets into a single
/// semantic unit for screen readers.
class CorpoMergeSemantics extends StatelessWidget {
  /// Creates a semantic merger.
  const CorpoMergeSemantics({
    required this.child,
    this.merging = true,
    super.key,
  });

  /// The child widget to merge semantics for.
  final Widget child;

  /// Whether to merge semantics from children.
  final bool merging;

  @override
  Widget build(BuildContext context) => MergeSemantics(child: child);
}

/// Utility class for screen reader optimizations.
abstract final class CorpoScreenReaderUtils {
  /// Announces a message to screen readers.
  static void announce(String message, {TextDirection? textDirection}) {
    SemanticsService.announce(message, textDirection ?? TextDirection.ltr);
  }

  /// Announces a tooltip.
  static void announceTooltip(String message) {
    SemanticsService.tooltip(message);
  }

  /// Creates a semantic button action.
  static SemanticsAction createButtonAction(VoidCallback onPressed) => SemanticsAction.tap;

  /// Creates semantic properties for a text field.
  static SemanticsProperties createTextFieldSemantics({
    required String label,
    String? hint,
    String? value,
    bool isPassword = false,
    bool isMultiline = false,
    bool isReadOnly = false,
  }) => SemanticsProperties(
      label: label,
      hint: hint,
      value: value,
      textField: true,
      obscured: isPassword,
      multiline: isMultiline,
      readOnly: isReadOnly,
    );

  /// Creates semantic properties for a button.
  static SemanticsProperties createButtonSemantics({
    required String label,
    String? hint,
    bool isEnabled = true,
  }) => SemanticsProperties(
      label: label,
      hint: hint,
      button: true,
      enabled: isEnabled,
    );

  /// Creates semantic properties for a slider.
  static SemanticsProperties createSliderSemantics({
    required String label,
    required String value,
    String? hint,
    String? increasedValue,
    String? decreasedValue,
  }) => SemanticsProperties(
      label: label,
      value: value,
      hint: hint,
      increasedValue: increasedValue,
      decreasedValue: decreasedValue,
      slider: true,
    );

  /// Creates semantic properties for a list item.
  static SemanticsProperties createListItemSemantics({
    required String label,
    String? hint,
    bool isSelected = false,
    int? index,
  }) => SemanticsProperties(
      label: label,
      hint: hint,
      selected: isSelected,
      sortKey: index != null ? OrdinalSortKey(index.toDouble()) : null,
    );

  /// Checks if screen reader is active.
  static bool isScreenReaderActive(BuildContext context) => MediaQuery.of(context).accessibleNavigation;

  /// Gets the text scale factor for accessibility.
  static double getTextScaleFactor(BuildContext context) => MediaQuery.of(context).textScaler.scale(1);

  /// Checks if high contrast is enabled.
  static bool isHighContrastEnabled(BuildContext context) => MediaQuery.of(context).highContrast;

  /// Checks if animations should be reduced.
  static bool shouldReduceAnimations(BuildContext context) => MediaQuery.of(context).disableAnimations;
}
