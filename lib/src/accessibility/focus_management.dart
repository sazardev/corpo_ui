/// Focus management utilities for the Corpo UI design system.
///
/// This file provides comprehensive focus management capabilities including
/// focus nodes, focus scopes, and keyboard navigation utilities to ensure
/// excellent accessibility across all corporate applications.
///
/// The focus management system includes:
/// - Smart focus traversal and keyboard navigation
/// - Focus state management and restoration
/// - Screen reader integration and announcements
/// - Keyboard shortcut handling
///
/// Example usage:
/// ```dart
/// CorpoFocusManager(
///   child: MyWidget(),
///   onFocusChange: (focused) => print('Focus changed: $focused'),
///   autoFocus: true,
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that manages focus for its child widgets.
///
/// This component provides enhanced focus management capabilities
/// for corporate applications with accessibility support.
class CorpoFocusManager extends StatefulWidget {
  /// Creates a focus manager.
  const CorpoFocusManager({
    required this.child,
    this.focusNode,
    this.onFocusChange,
    this.onKeyEvent,
    this.autoFocus = false,
    this.skipTraversal = false,
    this.canRequestFocus = true,
    this.debugLabel,
    super.key,
  });

  /// The child widget to manage focus for.
  final Widget child;

  /// The focus node to use. If null, a new one will be created.
  final FocusNode? focusNode;

  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when a key event occurs.
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;

  /// Whether to automatically focus when the widget is built.
  final bool autoFocus;

  /// Whether to skip this widget during focus traversal.
  final bool skipTraversal;

  /// Whether this widget can request focus.
  final bool canRequestFocus;

  /// Debug label for the focus node.
  final String? debugLabel;

  @override
  State<CorpoFocusManager> createState() => _CorpoFocusManagerState();
}

class _CorpoFocusManagerState extends State<CorpoFocusManager> {
  late FocusNode _focusNode;
  bool _hasExternalFocusNode = false;

  @override
  void initState() {
    super.initState();
    _hasExternalFocusNode = widget.focusNode != null;
    _focusNode =
        widget.focusNode ??
        FocusNode(
          debugLabel: widget.debugLabel,
          skipTraversal: widget.skipTraversal,
          canRequestFocus: widget.canRequestFocus,
        );

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(CorpoFocusManager oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);

      if (!_hasExternalFocusNode) {
        _focusNode.dispose();
      }

      _hasExternalFocusNode = widget.focusNode != null;
      _focusNode =
          widget.focusNode ??
          FocusNode(
            debugLabel: widget.debugLabel,
            skipTraversal: widget.skipTraversal,
            canRequestFocus: widget.canRequestFocus,
          );

      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (!_hasExternalFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    widget.onFocusChange?.call(_focusNode.hasFocus);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (widget.onKeyEvent != null) {
      return widget.onKeyEvent!(node, event);
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) => Focus(
    focusNode: _focusNode,
    autofocus: widget.autoFocus,
    onKeyEvent: _handleKeyEvent,
    child: widget.child,
  );
}

/// A widget that provides keyboard navigation utilities.
///
/// This component helps implement common keyboard navigation patterns
/// for corporate applications.
class CorpoKeyboardNavigator extends StatelessWidget {
  /// Creates a keyboard navigator.
  const CorpoKeyboardNavigator({
    required this.child,
    this.onArrowKey,
    this.onEnterKey,
    this.onEscapeKey,
    this.onTabKey,
    this.onSpaceKey,
    this.shortcuts = const <ShortcutActivator, VoidCallback>{},
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Called when an arrow key is pressed.
  final void Function(LogicalKeyboardKey direction)? onArrowKey;

  /// Called when Enter is pressed.
  final VoidCallback? onEnterKey;

  /// Called when Escape is pressed.
  final VoidCallback? onEscapeKey;

  /// Called when Tab is pressed.
  final void Function(bool isShiftPressed)? onTabKey;

  /// Called when Space is pressed.
  final VoidCallback? onSpaceKey;

  /// Custom keyboard shortcuts.
  final Map<ShortcutActivator, VoidCallback> shortcuts;

  @override
  Widget build(BuildContext context) {
    final Map<ShortcutActivator, Intent> shortcutMap =
        <ShortcutActivator, Intent>{};
    final Map<Type, Action<Intent>> actionMap = <Type, Action<Intent>>{};

    // Add arrow key shortcuts
    if (onArrowKey != null) {
      for (final LogicalKeyboardKey key in <LogicalKeyboardKey>[
        LogicalKeyboardKey.arrowUp,
        LogicalKeyboardKey.arrowDown,
        LogicalKeyboardKey.arrowLeft,
        LogicalKeyboardKey.arrowRight,
      ]) {
        shortcutMap[LogicalKeySet(key)] = _ArrowKeyIntent(key);
      }
      actionMap[_ArrowKeyIntent] = _ArrowKeyAction(onArrowKey!);
    }

    // Add Enter key shortcut
    if (onEnterKey != null) {
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.enter)] =
          const _EnterKeyIntent();
      actionMap[_EnterKeyIntent] = _CallbackAction(onEnterKey!);
    }

    // Add Escape key shortcut
    if (onEscapeKey != null) {
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.escape)] =
          const _EscapeKeyIntent();
      actionMap[_EscapeKeyIntent] = _CallbackAction(onEscapeKey!);
    }

    // Add Tab key shortcuts
    if (onTabKey != null) {
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.tab)] = const _TabKeyIntent(
        false,
      );
      shortcutMap[LogicalKeySet(
        LogicalKeyboardKey.shift,
        LogicalKeyboardKey.tab,
      )] = const _TabKeyIntent(
        true,
      );
      actionMap[_TabKeyIntent] = _TabKeyAction(onTabKey!);
    }

    // Add Space key shortcut
    if (onSpaceKey != null) {
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.space)] =
          const _SpaceKeyIntent();
      actionMap[_SpaceKeyIntent] = _CallbackAction(onSpaceKey!);
    }

    // Add custom shortcuts
    for (final MapEntry<ShortcutActivator, VoidCallback> entry
        in shortcuts.entries) {
      final _CustomIntent intent = _CustomIntent(entry.value);
      shortcutMap[entry.key] = intent;
      actionMap[_CustomIntent] = _CallbackAction(entry.value);
    }

    return Shortcuts(
      shortcuts: shortcutMap,
      child: Actions(actions: actionMap, child: child),
    );
  }
}

/// A widget that manages focus traversal order.
///
/// This component provides explicit control over keyboard navigation
/// order for complex layouts.
class CorpoFocusTraversalGroup extends StatelessWidget {
  /// Creates a focus traversal group.
  const CorpoFocusTraversalGroup({
    required this.child,
    this.policy,
    this.descendantsAreFocusable = true,
    this.descendantsAreTraversable = true,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The focus traversal policy to use.
  final FocusTraversalPolicy? policy;

  /// Whether descendants can be focused.
  final bool descendantsAreFocusable;

  /// Whether descendants can be traversed.
  final bool descendantsAreTraversable;

  @override
  Widget build(BuildContext context) => FocusTraversalGroup(
    policy: policy ?? OrderedTraversalPolicy(),
    descendantsAreFocusable: descendantsAreFocusable,
    descendantsAreTraversable: descendantsAreTraversable,
    child: child,
  );
}

/// A widget that provides focus restoration capabilities.
///
/// This component remembers and restores focus when the widget
/// is rebuilt or returns from navigation.
class CorpoFocusRestorer extends StatefulWidget {
  /// Creates a focus restorer.
  const CorpoFocusRestorer({
    required this.child,
    this.restoreId,
    this.enabled = true,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Unique identifier for focus restoration.
  final String? restoreId;

  /// Whether focus restoration is enabled.
  final bool enabled;

  @override
  State<CorpoFocusRestorer> createState() => _CorpoFocusRestorerState();
}

class _CorpoFocusRestorerState extends State<CorpoFocusRestorer>
    with RestorationMixin {
  final RestorableBool _hasFocus = RestorableBool(false);
  FocusNode? _focusNode;

  @override
  String? get restorationId => widget.restoreId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_hasFocus, 'has_focus');

    if (_hasFocus.value && widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode?.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) => Focus(
    onFocusChange: (bool focused) {
      _hasFocus.value = focused;
    },
    child: Builder(
      builder: (BuildContext context) {
        _focusNode = Focus.of(context);
        return widget.child;
      },
    ),
  );

  @override
  void dispose() {
    _hasFocus.dispose();
    super.dispose();
  }
}

/// Utility class for common focus management operations.
abstract final class CorpoFocusUtils {
  /// Moves focus to the next focusable widget.
  static void focusNext(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  /// Moves focus to the previous focusable widget.
  static void focusPrevious(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }

  /// Unfocuses the currently focused widget.
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Requests focus for a specific focus node.
  static void requestFocus(FocusNode focusNode) {
    focusNode.requestFocus();
  }

  /// Gets the currently focused widget.
  static FocusNode? getCurrentFocus(BuildContext context) =>
      FocusScope.of(context).focusedChild;

  /// Checks if a widget has focus.
  static bool hasFocus(FocusNode focusNode) => focusNode.hasFocus;

  /// Creates a focus node with common corporate settings.
  static FocusNode createCorporateFocusNode({
    String? debugLabel,
    bool skipTraversal = false,
    bool canRequestFocus = true,
  }) => FocusNode(
    debugLabel: debugLabel,
    skipTraversal: skipTraversal,
    canRequestFocus: canRequestFocus,
  );

  /// Creates a focus traversal policy for corporate applications.
  static FocusTraversalPolicy createCorporateTraversalPolicy() =>
      OrderedTraversalPolicy();
}

// Intent classes for keyboard navigation
class _ArrowKeyIntent extends Intent {
  const _ArrowKeyIntent(this.direction);
  final LogicalKeyboardKey direction;
}

class _EnterKeyIntent extends Intent {
  const _EnterKeyIntent();
}

class _EscapeKeyIntent extends Intent {
  const _EscapeKeyIntent();
}

class _TabKeyIntent extends Intent {
  const _TabKeyIntent(this.isShiftPressed);
  final bool isShiftPressed;
}

class _SpaceKeyIntent extends Intent {
  const _SpaceKeyIntent();
}

class _CustomIntent extends Intent {
  const _CustomIntent(this.callback);
  final VoidCallback callback;
}

// Action classes for keyboard navigation
class _ArrowKeyAction extends Action<_ArrowKeyIntent> {
  _ArrowKeyAction(this.callback);
  final void Function(LogicalKeyboardKey) callback;

  @override
  Object? invoke(_ArrowKeyIntent intent) {
    callback(intent.direction);
    return null;
  }
}

class _TabKeyAction extends Action<_TabKeyIntent> {
  _TabKeyAction(this.callback);
  final void Function(bool) callback;

  @override
  Object? invoke(_TabKeyIntent intent) {
    callback(intent.isShiftPressed);
    return null;
  }
}

class _CallbackAction extends Action<Intent> {
  _CallbackAction(this.callback);
  final VoidCallback callback;

  @override
  Object? invoke(Intent intent) {
    callback();
    return null;
  }
}
