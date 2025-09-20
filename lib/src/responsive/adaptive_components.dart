/// Platform-adaptive components for the Corpo UI design system.
///
/// This file provides comprehensive platform-adaptive utilities that
/// automatically adjust component behavior based on the target platform
/// while maintaining corporate design consistency across all devices.
///
/// The adaptive system ensures that components feel native on each platform
/// while preserving the professional corporate aesthetic.
///
/// Example usage:
/// ```dart
/// CorpoAdaptiveButton(
///   onPressed: () => print('Adaptive action'),
///   child: Text('Submit'),
/// )
///
/// CorpoAdaptiveScaffold(
///   title: 'Dashboard',
///   body: MyContent(),
/// )
/// ```
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/buttons/corpo_button.dart';

/// Platform detection utilities.
abstract final class CorpoPlatform {
  /// Checks if running on iOS.
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  /// Checks if running on Android.
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Checks if running on macOS.
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  /// Checks if running on Windows.
  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  /// Checks if running on Linux.
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  /// Checks if running on web.
  static bool get isWeb => kIsWeb;

  /// Checks if running on mobile (iOS or Android).
  static bool get isMobile => isIOS || isAndroid;

  /// Checks if running on desktop (macOS, Windows, or Linux).
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Checks if the platform prefers Cupertino design.
  static bool get prefersCupertino => isIOS || isMacOS;

  /// Checks if the platform prefers Material design.
  static bool get prefersMaterial => isAndroid || isLinux || isWindows || isWeb;

  /// Gets the current target platform.
  static TargetPlatform get current => defaultTargetPlatform;
}

/// Design system preference based on platform and context.
enum CorpoDesignSystem {
  /// Material Design (Android, Web, Linux, Windows)
  material,

  /// Cupertino Design (iOS, macOS)
  cupertino,

  /// Corporate Design (platform-neutral)
  corporate,
}

/// Adaptive design system selection.
abstract final class CorpoAdaptive {
  /// Gets the preferred design system for the current platform.
  static CorpoDesignSystem getPreferredDesignSystem([
    TargetPlatform? platform,
  ]) {
    final TargetPlatform targetPlatform = platform ?? CorpoPlatform.current;

    switch (targetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CorpoDesignSystem.cupertino;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return CorpoDesignSystem.material;
    }
  }

  /// Selects a value based on the design system.
  static T select<T>({
    required T corporate,
    T? material,
    T? cupertino,
    TargetPlatform? platform,
  }) {
    final CorpoDesignSystem designSystem = getPreferredDesignSystem(platform);

    switch (designSystem) {
      case CorpoDesignSystem.material:
        return material ?? corporate;
      case CorpoDesignSystem.cupertino:
        return cupertino ?? corporate;
      case CorpoDesignSystem.corporate:
        return corporate;
    }
  }

  /// Selects a widget based on the design system.
  static Widget selectWidget({
    required Widget corporate,
    Widget? material,
    Widget? cupertino,
    TargetPlatform? platform,
  }) => select<Widget>(
    corporate: corporate,
    material: material,
    cupertino: cupertino,
    platform: platform,
  );
}

/// An adaptive button that adjusts its appearance based on platform.
///
/// This component automatically selects the appropriate button style
/// for the current platform while maintaining corporate branding.
class CorpoAdaptiveButton extends StatelessWidget {
  /// Creates an adaptive button.
  const CorpoAdaptiveButton({
    required this.onPressed,
    required this.child,
    this.variant = CorpoButtonVariant.primary,
    this.size = CorpoButtonSize.medium,
    this.isLoading = false,
    this.icon,
    super.key,
  });

  /// Callback for button press.
  final VoidCallback? onPressed;

  /// The button content.
  final Widget child;

  /// The button variant.
  final CorpoButtonVariant variant;

  /// The button size.
  final CorpoButtonSize size;

  /// Whether the button is in loading state.
  final bool isLoading;

  /// Optional icon for the button.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (CorpoPlatform.prefersCupertino) {
      return _buildCupertinoButton(context);
    } else {
      return _buildMaterialButton(context);
    }
  }

  Widget _buildCupertinoButton(BuildContext context) {
    if (variant == CorpoButtonVariant.tertiary) {
      return CupertinoButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator()
            : _buildButtonContent(),
      );
    }

    return CupertinoButton.filled(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CupertinoActivityIndicator(color: Colors.white)
          : _buildButtonContent(),
    );
  }

  Widget _buildMaterialButton(BuildContext context) {
    // Use the existing CorpoButton for Material design
    return CorpoButton(
      onPressed: onPressed,
      variant: variant,
      size: size,
      isLoading: isLoading,
      icon: icon,
      child: child,
    );
  }

  Widget _buildButtonContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          child,
        ],
      );
    }
    return child;
  }
}

/// An adaptive app bar that adjusts its appearance based on platform.
///
/// This component automatically selects between Material AppBar and
/// Cupertino NavigationBar based on the platform.
class CorpoAdaptiveAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// Creates an adaptive app bar.
  const CorpoAdaptiveAppBar({
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.centerTitle,
    super.key,
  });

  /// The app bar title.
  final Widget? title;

  /// The leading widget.
  final Widget? leading;

  /// The action widgets.
  final List<Widget>? actions;

  /// The background color.
  final Color? backgroundColor;

  /// The elevation.
  final double? elevation;

  /// Whether to center the title.
  final bool? centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    if (CorpoPlatform.prefersCupertino) {
      return _buildCupertinoNavigationBar(context);
    } else {
      return _buildMaterialAppBar(context);
    }
  }

  Widget _buildCupertinoNavigationBar(BuildContext context) =>
      CupertinoNavigationBar(
        middle: title,
        leading: leading,
        trailing: actions?.isNotEmpty == true
            ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
            : null,
        backgroundColor: backgroundColor,
      );

  Widget _buildMaterialAppBar(BuildContext context) => AppBar(
    title: title,
    leading: leading,
    actions: actions,
    backgroundColor: backgroundColor,
    elevation: elevation,
    centerTitle: centerTitle,
  );
}

/// An adaptive scaffold that adjusts its behavior based on platform.
///
/// This component provides platform-appropriate scaffold behavior
/// while maintaining corporate design consistency.
class CorpoAdaptiveScaffold extends StatelessWidget {
  /// Creates an adaptive scaffold.
  const CorpoAdaptiveScaffold({
    this.appBar,
    this.body,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    super.key,
  });

  /// The app bar.
  final PreferredSizeWidget? appBar;

  /// The body content.
  final Widget? body;

  /// The drawer.
  final Widget? drawer;

  /// The end drawer.
  final Widget? endDrawer;

  /// The bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// The floating action button.
  final Widget? floatingActionButton;

  /// The background color.
  final Color? backgroundColor;

  /// Whether to resize to avoid bottom inset.
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    if (CorpoPlatform.prefersCupertino) {
      return _buildCupertinoScaffold(context);
    } else {
      return _buildMaterialScaffold(context);
    }
  }

  Widget _buildCupertinoScaffold(BuildContext context) {
    Widget scaffold = CupertinoPageScaffold(
      navigationBar: appBar as CupertinoNavigationBar?,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      child: body ?? const SizedBox.shrink(),
    );

    // Add bottom navigation if provided
    if (bottomNavigationBar != null) {
      scaffold = Column(
        children: <Widget>[
          Expanded(child: scaffold),
          bottomNavigationBar!,
        ],
      );
    }

    return scaffold;
  }

  Widget _buildMaterialScaffold(BuildContext context) => Scaffold(
    appBar: appBar,
    body: body,
    drawer: drawer,
    endDrawer: endDrawer,
    bottomNavigationBar: bottomNavigationBar,
    floatingActionButton: floatingActionButton,
    backgroundColor: backgroundColor,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
  );
}

/// An adaptive switch that adjusts its appearance based on platform.
///
/// This component automatically selects between Material Switch and
/// Cupertino Switch based on the platform.
class CorpoAdaptiveSwitch extends StatelessWidget {
  /// Creates an adaptive switch.
  const CorpoAdaptiveSwitch({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    super.key,
  });

  /// The current value of the switch.
  final bool value;

  /// Callback for value changes.
  final ValueChanged<bool>? onChanged;

  /// The active color.
  final Color? activeColor;

  /// The inactive color.
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    if (CorpoPlatform.prefersCupertino) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: activeColor,
        inactiveTrackColor: inactiveColor,
      );
    }
  }
}

/// An adaptive slider that adjusts its appearance based on platform.
///
/// This component automatically selects between Material Slider and
/// Cupertino Slider based on the platform.
class CorpoAdaptiveSlider extends StatelessWidget {
  /// Creates an adaptive slider.
  const CorpoAdaptiveSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    super.key,
  });

  /// The current value of the slider.
  final double value;

  /// Callback for value changes.
  final ValueChanged<double>? onChanged;

  /// The minimum value.
  final double min;

  /// The maximum value.
  final double max;

  /// The number of divisions.
  final int? divisions;

  /// The active color.
  final Color? activeColor;

  /// The inactive color.
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    if (CorpoPlatform.prefersCupertino) {
      return CupertinoSlider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        activeColor: activeColor,
      );
    } else {
      return Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
        divisions: divisions,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      );
    }
  }
}

/// An adaptive alert dialog that adjusts its appearance based on platform.
///
/// This component automatically selects between Material AlertDialog and
/// Cupertino AlertDialog based on the platform.
class CorpoAdaptiveAlertDialog extends StatelessWidget {
  /// Creates an adaptive alert dialog.
  const CorpoAdaptiveAlertDialog({
    this.title,
    this.content,
    this.actions,
    super.key,
  });

  /// The dialog title.
  final Widget? title;

  /// The dialog content.
  final Widget? content;

  /// The dialog actions.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    if (CorpoPlatform.prefersCupertino) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions ?? <Widget>[],
      );
    } else {
      return AlertDialog(title: title, content: content, actions: actions);
    }
  }

  /// Shows the adaptive alert dialog.
  static Future<T?> show<T>(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  }) => showDialog<T>(
    context: context,
    builder: (BuildContext context) => CorpoAdaptiveAlertDialog(
      title: title,
      content: content,
      actions: actions,
    ),
  );
}

/// Utility class for creating platform-adaptive components.
abstract final class CorpoAdaptiveUtils {
  /// Gets the appropriate border radius for the platform.
  static BorderRadius getPlatformBorderRadius() =>
      CorpoAdaptive.select<BorderRadius>(
        corporate: BorderRadius.circular(8),
        material: BorderRadius.circular(4),
        cupertino: BorderRadius.circular(8),
      );

  /// Gets the appropriate elevation for the platform.
  static double getPlatformElevation() =>
      CorpoAdaptive.select<double>(corporate: 2, material: 2, cupertino: 0);

  /// Gets the appropriate padding for the platform.
  static EdgeInsets getPlatformPadding() => CorpoAdaptive.select<EdgeInsets>(
    corporate: const EdgeInsets.all(16),
    material: const EdgeInsets.all(16),
    cupertino: const EdgeInsets.all(16),
  );

  /// Shows a platform-appropriate date picker.
  static Future<DateTime?> showDatePicker(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    if (CorpoPlatform.prefersCupertino) {
      return _showCupertinoDatePicker(
        context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
    } else {
      return showDatePicker(
        context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
    }
  }

  static Future<DateTime?> _showCupertinoDatePicker(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    DateTime selectedDate = initialDate;

    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: <Widget>[
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(selectedDate),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: firstDate,
                maximumDate: lastDate,
                onDateTimeChanged: (DateTime date) => selectedDate = date,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
