/// Semantic markup utilities for the Corpo UI design system.
///
/// This file provides comprehensive semantic markup utilities to ensure
/// proper HTML-like semantic structure for Flutter applications,
/// improving accessibility and screen reader navigation.
///
/// The semantic system includes:
/// - Semantic containers for different content types
/// - Proper heading hierarchy management
/// - Navigation and landmark structures
/// - Form semantics and validation feedback
///
/// Example usage:
/// ```dart
/// CorpoSemanticStructure(
///   semanticRole: CorpoSemanticRole.main,
///   child: Column(children: [
///     CorpoHeading(level: 1, text: 'Page Title'),
///     CorpoSemanticContainer(
///       role: CorpoSemanticRole.article,
///       child: ContentWidget(),
///     ),
///   ]),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Semantic roles for different UI components.
enum CorpoSemanticRole {
  /// Main content area
  main,

  /// Navigation area
  navigation,

  /// Banner/header area
  banner,

  /// Content information/footer
  contentInfo,

  /// Complementary content/sidebar
  complementary,

  /// Search functionality
  search,

  /// Form container
  form,

  /// Article content
  article,

  /// Section content
  section,

  /// List container
  list,

  /// List item
  listItem,

  /// Button element
  button,

  /// Link element
  link,

  /// Heading element
  heading,

  /// Text content
  text,

  /// Image content
  image,

  /// Dialog/modal
  dialog,

  /// Alert/notification
  alert,

  /// Tab container
  tablist,

  /// Individual tab
  tab,

  /// Tab panel
  tabpanel,

  /// Menu container
  menu,

  /// Menu item
  menuitem,

  /// Progress indicator
  progressbar,

  /// Status indicator
  status,

  /// Group container
  group,

  /// Region container
  region,
}

/// Heading levels for semantic hierarchy.
enum CorpoSemanticHeadingLevel {
  /// H1 - Main page title
  h1(1),

  /// H2 - Section headers
  h2(2),

  /// H3 - Subsection headers
  h3(3),

  /// H4 - Minor section headers
  h4(4),

  /// H5 - Detail headers
  h5(5),

  /// H6 - Minor detail headers
  h6(6);

  const CorpoSemanticHeadingLevel(this.level);

  /// The numeric heading level.
  final int level;
}

/// A widget that provides semantic structure for content organization.
///
/// This component ensures proper semantic markup for different
/// types of content containers.
class CorpoSemanticStructure extends StatelessWidget {
  /// Creates a semantic structure.
  const CorpoSemanticStructure({
    required this.child,
    required this.semanticRole,
    this.label,
    this.hint,
    this.value,
    this.sortKey,
    this.customProperties = const <String, dynamic>{},
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The semantic role of this structure.
  final CorpoSemanticRole semanticRole;

  /// Semantic label for the structure.
  final String? label;

  /// Additional hint information.
  final String? hint;

  /// Current value (for interactive elements).
  final String? value;

  /// Sort key for ordering.
  final SemanticsSortKey? sortKey;

  /// Additional custom semantic properties.
  final Map<String, dynamic> customProperties;

  @override
  Widget build(BuildContext context) => Semantics(
      container: true,
      label: label,
      hint: hint,
      value: value,
      sortKey: sortKey,
      button: semanticRole == CorpoSemanticRole.button,
      link: semanticRole == CorpoSemanticRole.link,
      header:
          semanticRole == CorpoSemanticRole.heading ||
          semanticRole == CorpoSemanticRole.banner,
      textField: false, // Handled by specific form components
      image: semanticRole == CorpoSemanticRole.image,
      liveRegion:
          semanticRole == CorpoSemanticRole.alert ||
          semanticRole == CorpoSemanticRole.status,
      child: child,
    );
}

/// A widget that provides semantic heading structure.
///
/// This component ensures proper heading hierarchy for
/// screen reader navigation.
class CorpoSemanticHeading extends StatelessWidget {
  /// Creates a semantic heading.
  const CorpoSemanticHeading({
    required this.child,
    required this.level,
    this.text,
    super.key,
  });

  /// The child widget (typically a Text widget).
  final Widget child;

  /// The heading level.
  final CorpoSemanticHeadingLevel level;

  /// The text content (if not provided by child).
  final String? text;

  @override
  Widget build(BuildContext context) => CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.heading,
      label: text,
      sortKey: OrdinalSortKey(level.level.toDouble()),
      child: child,
    );
}

/// A widget that provides semantic list structure.
///
/// This component ensures proper list semantics for
/// collections of items.
class CorpoSemanticList extends StatelessWidget {
  /// Creates a semantic list.
  const CorpoSemanticList({
    required this.children,
    this.label,
    this.hint,
    this.isOrdered = false,
    super.key,
  });

  /// The list items.
  final List<Widget> children;

  /// Label for the list.
  final String? label;

  /// Hint for the list purpose.
  final String? hint;

  /// Whether this is an ordered list.
  final bool isOrdered;

  @override
  Widget build(BuildContext context) => CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.list,
      label: label,
      hint: hint,
      child: Column(
        children: children.asMap().entries.map((MapEntry<int, Widget> entry) {
          final int index = entry.key;
          final Widget child = entry.value;

          return CorpoSemanticListItem(
            index: index + 1,
            total: children.length,
            isOrdered: isOrdered,
            child: child,
          );
        }).toList(),
      ),
    );
}

/// A widget that provides semantic list item structure.
///
/// This component ensures proper list item semantics.
class CorpoSemanticListItem extends StatelessWidget {
  /// Creates a semantic list item.
  const CorpoSemanticListItem({
    required this.child,
    this.index,
    this.total,
    this.isOrdered = false,
    this.label,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The item index (1-based).
  final int? index;

  /// Total number of items.
  final int? total;

  /// Whether this is part of an ordered list.
  final bool isOrdered;

  /// Custom label for the item.
  final String? label;

  @override
  Widget build(BuildContext context) {
    String? semanticLabel = label;

    if (semanticLabel == null && index != null && total != null) {
      if (isOrdered) {
        semanticLabel = 'Item $index of $total';
      } else {
        semanticLabel = 'List item $index of $total';
      }
    }

    return CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.listItem,
      label: semanticLabel,
      sortKey: index != null ? OrdinalSortKey(index!.toDouble()) : null,
      child: child,
    );
  }
}

/// A widget that provides semantic form structure.
///
/// This component ensures proper form semantics and
/// validation feedback.
class CorpoSemanticForm extends StatelessWidget {
  /// Creates a semantic form.
  const CorpoSemanticForm({
    required this.child,
    this.label,
    this.hint,
    this.hasErrors = false,
    this.errorMessage,
    super.key,
  });

  /// The form content.
  final Widget child;

  /// Label for the form.
  final String? label;

  /// Hint about the form purpose.
  final String? hint;

  /// Whether the form has validation errors.
  final bool hasErrors;

  /// Error message for the form.
  final String? errorMessage;

  @override
  Widget build(BuildContext context) => CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.form,
      label: label,
      hint: hasErrors && errorMessage != null
          ? '$hint. Error: $errorMessage'
          : hint,
      child: child,
    );
}

/// A widget that provides semantic navigation structure.
///
/// This component ensures proper navigation semantics.
class CorpoSemanticNavigation extends StatelessWidget {
  /// Creates semantic navigation.
  const CorpoSemanticNavigation({
    required this.child,
    this.label,
    this.hint,
    super.key,
  });

  /// The navigation content.
  final Widget child;

  /// Label for the navigation.
  final String? label;

  /// Hint about the navigation purpose.
  final String? hint;

  @override
  Widget build(BuildContext context) => CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.navigation,
      label: label ?? 'Navigation',
      hint: hint,
      child: child,
    );
}

/// A widget that provides semantic tab structure.
///
/// This component ensures proper tab navigation semantics.
class CorpoSemanticTabContainer extends StatelessWidget {
  /// Creates a semantic tab container.
  const CorpoSemanticTabContainer({
    required this.child,
    this.label,
    this.selectedIndex,
    this.totalTabs,
    super.key,
  });

  /// The tab container content.
  final Widget child;

  /// Label for the tab container.
  final String? label;

  /// Currently selected tab index.
  final int? selectedIndex;

  /// Total number of tabs.
  final int? totalTabs;

  @override
  Widget build(BuildContext context) {
    String? hint;
    if (selectedIndex != null && totalTabs != null) {
      hint = 'Tab ${selectedIndex! + 1} of $totalTabs selected';
    }

    return CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.tablist,
      label: label ?? 'Tab navigation',
      hint: hint,
      child: child,
    );
  }
}

/// A widget that provides semantic tab item structure.
class CorpoSemanticTab extends StatelessWidget {
  /// Creates a semantic tab.
  const CorpoSemanticTab({
    required this.child,
    required this.label,
    this.isSelected = false,
    this.index,
    this.onTap,
    super.key,
  });

  /// The tab content.
  final Widget child;

  /// Label for the tab.
  final String label;

  /// Whether this tab is selected.
  final bool isSelected;

  /// Tab index.
  final int? index;

  /// Tap callback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Semantics(
      button: true,
      selected: isSelected,
      label: label,
      hint: isSelected ? 'Selected tab' : 'Tap to select tab',
      sortKey: index != null ? OrdinalSortKey(index!.toDouble()) : null,
      onTap: onTap,
      child: child,
    );
}

/// A widget that provides semantic dialog structure.
class CorpoSemanticDialog extends StatelessWidget {
  /// Creates a semantic dialog.
  const CorpoSemanticDialog({
    required this.child,
    this.label,
    this.hint,
    this.isModal = true,
    super.key,
  });

  /// The dialog content.
  final Widget child;

  /// Label for the dialog.
  final String? label;

  /// Hint about the dialog purpose.
  final String? hint;

  /// Whether this is a modal dialog.
  final bool isModal;

  @override
  Widget build(BuildContext context) => CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.dialog,
      label: label,
      hint: hint,
      child: child,
    );
}

/// Utility class for creating semantic markup.
abstract final class CorpoSemanticUtils {
  /// Creates a semantic button.
  static Widget button({
    required Widget child,
    required String label,
    String? hint,
    bool isEnabled = true,
    VoidCallback? onTap,
  }) => Semantics(
      button: true,
      enabled: isEnabled,
      label: label,
      hint: hint,
      onTap: onTap,
      child: child,
    );

  /// Creates a semantic link.
  static Widget link({
    required Widget child,
    required String label,
    String? hint,
    VoidCallback? onTap,
  }) => Semantics(
      link: true,
      label: label,
      hint: hint,
      onTap: onTap,
      child: child,
    );

  /// Creates a semantic image.
  static Widget image({
    required Widget child,
    required String alt,
    String? hint,
  }) => Semantics(image: true, label: alt, hint: hint, child: child);

  /// Creates a semantic text field.
  static Widget textField({
    required Widget child,
    required String label,
    String? hint,
    String? value,
    bool isPassword = false,
    bool isReadOnly = false,
    bool hasError = false,
    String? errorText,
  }) => Semantics(
      textField: true,
      label: label,
      hint: hasError && errorText != null ? '$hint. Error: $errorText' : hint,
      value: value,
      obscured: isPassword,
      readOnly: isReadOnly,
      child: child,
    );

  /// Creates a semantic slider.
  static Widget slider({
    required Widget child,
    required String label,
    required String value,
    String? hint,
    String? increasedValue,
    String? decreasedValue,
    VoidCallback? onIncrease,
    VoidCallback? onDecrease,
  }) => Semantics(
      slider: true,
      label: label,
      value: value,
      hint: hint,
      increasedValue: increasedValue,
      decreasedValue: decreasedValue,
      onIncrease: onIncrease,
      onDecrease: onDecrease,
      child: child,
    );

  /// Creates a semantic progress indicator.
  static Widget progressBar({
    required Widget child,
    required String label,
    String? value,
    String? hint,
  }) => CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.progressbar,
      label: label,
      value: value,
      hint: hint,
      child: child,
    );

  /// Creates a semantic status indicator.
  static Widget status({
    required Widget child,
    required String label,
    String? hint,
    bool isLiveRegion = true,
  }) => Semantics(
      label: label,
      hint: hint,
      liveRegion: isLiveRegion,
      child: child,
    );

  /// Creates a semantic alert.
  static Widget alert({
    required Widget child,
    required String message,
    String? hint,
  }) => CorpoSemanticStructure(
      semanticRole: CorpoSemanticRole.alert,
      label: message,
      hint: hint,
      child: child,
    );

  /// Gets the appropriate semantic label for a widget.
  static String getSemanticLabel(CorpoSemanticRole role, String? customLabel) {
    if (customLabel != null) return customLabel;

    switch (role) {
      case CorpoSemanticRole.main:
        return 'Main content';
      case CorpoSemanticRole.navigation:
        return 'Navigation';
      case CorpoSemanticRole.banner:
        return 'Banner';
      case CorpoSemanticRole.contentInfo:
        return 'Content information';
      case CorpoSemanticRole.complementary:
        return 'Complementary content';
      case CorpoSemanticRole.search:
        return 'Search';
      case CorpoSemanticRole.form:
        return 'Form';
      case CorpoSemanticRole.article:
        return 'Article';
      case CorpoSemanticRole.section:
        return 'Section';
      case CorpoSemanticRole.list:
        return 'List';
      case CorpoSemanticRole.listItem:
        return 'List item';
      default:
        return role.name;
    }
  }
}
