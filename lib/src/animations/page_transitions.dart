/// Page transition animations for the Corpo UI design system.
///
/// This file provides comprehensive page transition utilities with
/// corporate-appropriate timing and professional navigation effects.
/// The transitions follow business application design principles with
/// smooth, purposeful motion suitable for enterprise software.
///
/// Example usage:
/// ```dart
/// Navigator.of(context).push(
///   CorpoPageTransition(
///     type: CorpoPageTransitionType.slideFromRight,
///     child: NextPage(),
///   ),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'fade_transition.dart';

/// Defines the page transition type.
enum CorpoPageTransitionType {
  /// No transition (instant)
  none,

  /// Standard fade transition
  fade,

  /// Slide from right (default for forward navigation)
  slideFromRight,

  /// Slide from left (default for back navigation)
  slideFromLeft,

  /// Slide from bottom (modal-style)
  slideFromBottom,

  /// Slide from top
  slideFromTop,

  /// Scale transition (zoom effect)
  scale,

  /// Fade with slide combination
  fadeSlide,

  /// Professional slide with subtle scale
  professional,

  /// Corporate standard transition
  corporate,

  /// iOS-style cupertino transition
  cupertino,

  /// Material design transition
  material,
}

/// A comprehensive page transition route following Corpo UI design principles.
///
/// This component provides smooth page transitions with professional timing
/// and navigation effects suitable for corporate applications. It supports
/// various transition types and can be customized for different contexts.
class CorpoPageTransition<T> extends PageRouteBuilder<T> {
  /// Creates a page transition route.
  CorpoPageTransition({
    required this.child,
    this.type = CorpoPageTransitionType.slideFromRight,
    this.duration = CorpoAnimationDurations.standard,
    this.reverseDuration,
    this.curve = CorpoAnimationCurves.standard,
    this.reverseCurve,
    this.maintainState = true,
    this.fullscreenDialog = false,
    super.settings,
  }) : super(
         pageBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
             ) => child,
         maintainState: maintainState,
         fullscreenDialog: fullscreenDialog,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration ?? duration,
         transitionsBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
               Widget child,
             ) => _buildTransition(
               context: context,
               animation: animation,
               secondaryAnimation: secondaryAnimation,
               child: child,
               type: type,
               curve: curve,
               reverseCurve: reverseCurve ?? curve,
             ),
       );

  /// Creates a fade page transition.
  CorpoPageTransition.fade({
    required this.child,
    this.duration = CorpoAnimationDurations.quick,
    this.reverseDuration,
    this.maintainState = true,
    this.fullscreenDialog = false,
    super.settings,
  }) : type = CorpoPageTransitionType.fade,
       curve = CorpoAnimationCurves.subtle,
       reverseCurve = CorpoAnimationCurves.sharp,
       super(
         pageBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
             ) => child,
         maintainState: maintainState,
         fullscreenDialog: fullscreenDialog,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration ?? duration,
         transitionsBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
               Widget child,
             ) => _buildTransition(
               context: context,
               animation: animation,
               secondaryAnimation: secondaryAnimation,
               child: child,
               type: CorpoPageTransitionType.fade,
               curve: CorpoAnimationCurves.subtle,
               reverseCurve: CorpoAnimationCurves.sharp,
             ),
       );

  /// Creates a corporate standard page transition.
  CorpoPageTransition.corporate({
    required this.child,
    this.duration = CorpoAnimationDurations.standard,
    this.reverseDuration,
    this.maintainState = true,
    this.fullscreenDialog = false,
    super.settings,
  }) : type = CorpoPageTransitionType.corporate,
       curve = CorpoAnimationCurves.standard,
       reverseCurve = CorpoAnimationCurves.standard,
       super(
         pageBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
             ) => child,
         maintainState: maintainState,
         fullscreenDialog: fullscreenDialog,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration ?? duration,
         transitionsBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
               Widget child,
             ) => _buildTransition(
               context: context,
               animation: animation,
               secondaryAnimation: secondaryAnimation,
               child: child,
               type: CorpoPageTransitionType.corporate,
               curve: CorpoAnimationCurves.standard,
               reverseCurve: CorpoAnimationCurves.standard,
             ),
       );

  /// Creates a modal-style page transition (slide from bottom).
  CorpoPageTransition.modal({
    required this.child,
    this.duration = CorpoAnimationDurations.standard,
    this.reverseDuration,
    this.maintainState = true,
    super.settings,
  }) : type = CorpoPageTransitionType.slideFromBottom,
       curve = CorpoAnimationCurves.subtle,
       reverseCurve = CorpoAnimationCurves.sharp,
       fullscreenDialog = true,
       super(
         pageBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
             ) => child,
         maintainState: maintainState,
         fullscreenDialog: true,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration ?? duration,
         transitionsBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
               Widget child,
             ) => _buildTransition(
               context: context,
               animation: animation,
               secondaryAnimation: secondaryAnimation,
               child: child,
               type: CorpoPageTransitionType.slideFromBottom,
               curve: CorpoAnimationCurves.subtle,
               reverseCurve: CorpoAnimationCurves.sharp,
             ),
       );

  /// The page widget to display.
  final Widget child;

  /// The type of page transition.
  final CorpoPageTransitionType type;

  /// The duration of the transition.
  final Duration duration;

  /// The duration of the reverse transition.
  final Duration? reverseDuration;

  /// The animation curve for forward transitions.
  final Curve curve;

  /// The animation curve for reverse transitions.
  final Curve? reverseCurve;

  /// Whether to maintain the route's state.
  @override
  final bool maintainState;

  /// Whether this is a fullscreen dialog.
  @override
  final bool fullscreenDialog;

  /// Builds the appropriate transition widget based on type.
  static Widget _buildTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
    required CorpoPageTransitionType type,
    required Curve curve,
    required Curve reverseCurve,
  }) {
    switch (type) {
      case CorpoPageTransitionType.none:
        return child;

      case CorpoPageTransitionType.fade:
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: curve,
            reverseCurve: reverseCurve,
          ),
          child: child,
        );

      case CorpoPageTransitionType.slideFromRight:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                  reverseCurve: reverseCurve,
                ),
              ),
          child: child,
        );

      case CorpoPageTransitionType.slideFromLeft:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                  reverseCurve: reverseCurve,
                ),
              ),
          child: child,
        );

      case CorpoPageTransitionType.slideFromBottom:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                  reverseCurve: reverseCurve,
                ),
              ),
          child: child,
        );

      case CorpoPageTransitionType.slideFromTop:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                  reverseCurve: reverseCurve,
                ),
              ),
          child: child,
        );

      case CorpoPageTransitionType.scale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            ),
          ),
          child: child,
        );

      case CorpoPageTransitionType.fadeSlide:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                  reverseCurve: reverseCurve,
                ),
              ),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            ),
            child: child,
          ),
        );

      case CorpoPageTransitionType.professional:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                  reverseCurve: reverseCurve,
                ),
              ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: curve,
                reverseCurve: reverseCurve,
              ),
            ),
            child: child,
          ),
        );

      case CorpoPageTransitionType.corporate:
        // Slide with subtle fade and scale
        final Animation<Offset> slideAnimation =
            Tween<Offset>(
              begin: const Offset(0.2, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: curve,
                reverseCurve: reverseCurve,
              ),
            );

        final Animation<double> fadeAnimation = Tween<double>(begin: 0, end: 1)
            .animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(0, 0.8, curve: curve),
                reverseCurve: Interval(0.2, 1, curve: reverseCurve),
              ),
            );

        final Animation<double> scaleAnimation =
            Tween<double>(begin: 0.98, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: curve,
                reverseCurve: reverseCurve,
              ),
            );

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          ),
        );

      case CorpoPageTransitionType.cupertino:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linearToEaseOut,
                  reverseCurve: Curves.easeInToLinear,
                ),
              ),
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-0.3, 0),
                ).animate(
                  CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.easeInToLinear,
                  ),
                ),
            child: child,
          ),
        );

      case CorpoPageTransitionType.material:
        return _buildMaterialTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
          curve: curve,
          reverseCurve: reverseCurve,
        );
    }
  }

  /// Builds Material Design page transition.
  static Widget _buildMaterialTransition({
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
    required Curve curve,
    required Curve reverseCurve,
  }) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: animation,
            curve: curve,
            reverseCurve: reverseCurve,
          ),
        ),
    child: FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: curve,
        reverseCurve: reverseCurve,
      ),
      child: child,
    ),
  );
}

/// Extension methods for Navigator to use Corpo page transitions.
extension CorpoNavigator on NavigatorState {
  /// Pushes a page with Corpo transition.
  Future<T?> pushCorpo<T extends Object?>(
    Widget page, {
    CorpoPageTransitionType type = CorpoPageTransitionType.slideFromRight,
    Duration? duration,
    RouteSettings? settings,
  }) => push<T>(
    CorpoPageTransition<T>(
      child: page,
      type: type,
      duration: duration ?? CorpoAnimationDurations.standard,
      settings: settings,
    ),
  );

  /// Pushes a page with fade transition.
  Future<T?> pushFade<T extends Object?>(
    Widget page, {
    Duration? duration,
    RouteSettings? settings,
  }) => push<T>(
    CorpoPageTransition<T>.fade(
      child: page,
      duration: duration ?? CorpoAnimationDurations.quick,
      settings: settings,
    ),
  );

  /// Pushes a modal page with slide from bottom.
  Future<T?> pushModal<T extends Object?>(
    Widget page, {
    Duration? duration,
    RouteSettings? settings,
  }) => push<T>(
    CorpoPageTransition<T>.modal(
      child: page,
      duration: duration ?? CorpoAnimationDurations.standard,
      settings: settings,
    ),
  );

  /// Pushes a page with corporate transition.
  Future<T?> pushCorporate<T extends Object?>(
    Widget page, {
    Duration? duration,
    RouteSettings? settings,
  }) => push<T>(
    CorpoPageTransition<T>.corporate(
      child: page,
      duration: duration ?? CorpoAnimationDurations.standard,
      settings: settings,
    ),
  );
}

/// Utility class for page transition helpers.
abstract final class CorpoPageTransitions {
  /// Creates a custom page route with specified transition.
  static Route<T> createRoute<T>({
    required Widget page,
    required CorpoPageTransitionType type,
    Duration? duration,
    Curve? curve,
    RouteSettings? settings,
  }) => CorpoPageTransition<T>(
    child: page,
    type: type,
    duration: duration ?? CorpoAnimationDurations.standard,
    curve: curve ?? CorpoAnimationCurves.standard,
    settings: settings,
  );

  /// Gets the default transition type for the platform.
  static CorpoPageTransitionType getDefaultTransition(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CorpoPageTransitionType.cupertino;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return CorpoPageTransitionType.material;
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return CorpoPageTransitionType.corporate;
    }
  }

  /// Creates a no-animation route for instant navigation.
  static Route<T> noAnimation<T>(Widget page, [RouteSettings? settings]) =>
      CorpoPageTransition<T>(
        child: page,
        type: CorpoPageTransitionType.none,
        settings: settings,
      );
}
