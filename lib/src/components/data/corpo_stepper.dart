import 'package:flutter/material.dart';
import '../../constants/spacing.dart';

/// Defines the variant styles for [CorpoStepper].
enum CorpoStepperVariant {
  /// Vertical stepper with steps arranged vertically
  vertical,

  /// Horizontal stepper with steps arranged horizontally
  horizontal,
}

/// Defines the stepper type for controlling behavior.
enum CorpoStepperType {
  /// Steps can be navigated in any order
  nonLinear,

  /// Steps must be completed sequentially
  linear,
}

/// Defines the state of a step in the stepper.
enum CorpoStepState {
  /// Step is not yet reached
  disabled,

  /// Step is currently active/selected
  indexed,

  /// Step has been completed
  complete,

  /// Step has an error
  error,

  /// Step is being edited
  editing,
}

/// Defines the density configuration for [CorpoStepper].
enum CorpoStepperDensity {
  /// Standard density with default spacing
  standard,

  /// Compact density with reduced spacing
  compact,

  /// Comfortable density with increased spacing
  comfortable,
}

/// Represents a single step in a [CorpoStepper].
class CorpoStep {
  /// Creates a stepper step.
  const CorpoStep({
    required this.title,
    required this.content,
    this.subtitle,
    this.isActive = false,
    this.state = CorpoStepState.disabled,
    this.label,
  });

  /// The title displayed for this step.
  final Widget title;

  /// The content displayed when this step is active.
  final Widget content;

  /// Optional subtitle for additional step information.
  final Widget? subtitle;

  /// Whether this step is currently active.
  final bool isActive;

  /// The current state of this step.
  final CorpoStepState state;

  /// Optional label for the step indicator (e.g., step number).
  final Widget? label;
}

/// A comprehensive stepper widget following Corpo UI design principles.
///
/// This component provides a way to display a sequence of steps with
/// professional styling and navigation controls. It supports both
/// vertical and horizontal layouts with customizable behavior.
class CorpoStepper extends StatefulWidget {
  /// Creates a Corpo UI stepper.
  const CorpoStepper({
    required this.steps,
    this.variant = CorpoStepperVariant.vertical,
    this.type = CorpoStepperType.linear,
    this.density = CorpoStepperDensity.standard,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.physics,
    this.margin,
    this.elevation = 0.0,
    super.key,
  });

  /// List of steps to display in the stepper.
  final List<CorpoStep> steps;

  /// Visual variant of the stepper layout.
  final CorpoStepperVariant variant;

  /// Type controlling the stepper's navigation behavior.
  final CorpoStepperType type;

  /// Density configuration for spacing and sizing.
  final CorpoStepperDensity density;

  /// Index of the currently active step.
  final int currentStep;

  /// Callback when a step header is tapped.
  final void Function(int step)? onStepTapped;

  /// Callback when the continue button is pressed.
  final VoidCallback? onStepContinue;

  /// Callback when the cancel button is pressed.
  final VoidCallback? onStepCancel;

  /// Builder for custom step controls.
  final Widget Function(BuildContext context, ControlsDetails details)?
  controlsBuilder;

  /// Scroll physics for the stepper content.
  final ScrollPhysics? physics;

  /// Margin around the stepper.
  final EdgeInsetsGeometry? margin;

  /// Elevation of the stepper.
  final double elevation;

  @override
  State<CorpoStepper> createState() => _CorpoStepperState();
}

class _CorpoStepperState extends State<CorpoStepper> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final List<Step> materialSteps = widget.steps.asMap().entries.map((
      MapEntry<int, CorpoStep> entry,
    ) {
      final int index = entry.key;
      final CorpoStep step = entry.value;

      return Step(
        title: step.title,
        content: Container(
          width: double.infinity,
          padding: _getContentPadding(),
          child: step.content,
        ),
        subtitle: step.subtitle,
        isActive: index == widget.currentStep || step.isActive,
        state: _mapStepState(step.state, index),
        label: step.label,
      );
    }).toList();

    final Widget stepper = Theme(
      data: theme.copyWith(
        colorScheme: colorScheme.copyWith(
          primary: colorScheme.primary,
          onSurface: colorScheme.onSurface,
        ),
      ),
      child: Stepper(
        steps: materialSteps,
        type: widget.variant == CorpoStepperVariant.horizontal
            ? StepperType.horizontal
            : StepperType.vertical,
        currentStep: widget.currentStep,
        onStepTapped: widget.type == CorpoStepperType.nonLinear
            ? widget.onStepTapped
            : _handleLinearStepTapped,
        onStepContinue: widget.onStepContinue,
        onStepCancel: widget.onStepCancel,
        controlsBuilder: widget.controlsBuilder ?? _buildDefaultControls,
        physics: widget.physics,
        margin: widget.margin ?? _getDefaultMargin(),
        elevation: widget.elevation,
      ),
    );

    return stepper;
  }

  EdgeInsetsGeometry _getContentPadding() => switch (widget.density) {
      CorpoStepperDensity.compact => const EdgeInsets.all(CorpoSpacing.small),
      CorpoStepperDensity.comfortable => const EdgeInsets.all(
        CorpoSpacing.large,
      ),
      CorpoStepperDensity.standard => const EdgeInsets.all(CorpoSpacing.medium),
    };

  EdgeInsetsGeometry _getDefaultMargin() => switch (widget.density) {
      CorpoStepperDensity.compact => EdgeInsets.zero,
      CorpoStepperDensity.comfortable => const EdgeInsets.all(
        CorpoSpacing.medium,
      ),
      CorpoStepperDensity.standard => const EdgeInsets.all(CorpoSpacing.small),
    };

  StepState _mapStepState(CorpoStepState state, int index) => switch (state) {
      CorpoStepState.disabled => StepState.disabled,
      CorpoStepState.indexed => StepState.indexed,
      CorpoStepState.complete => StepState.complete,
      CorpoStepState.error => StepState.error,
      CorpoStepState.editing => StepState.editing,
    };

  void _handleLinearStepTapped(int step) {
    // In linear mode, only allow navigation to completed steps or the next step
    if (step <= widget.currentStep) {
      widget.onStepTapped?.call(step);
    }
  }

  Widget _buildDefaultControls(BuildContext context, ControlsDetails details) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final bool isLastStep = details.stepIndex == widget.steps.length - 1;
    final bool isFirstStep = details.stepIndex == 0;

    return Container(
      margin: const EdgeInsets.only(top: CorpoSpacing.medium),
      child: Row(
        children: <Widget>[
          if (widget.onStepContinue != null)
            ElevatedButton(
              onPressed: details.onStepContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
              child: Text(isLastStep ? 'Finish' : 'Continue'),
            ),
          if (widget.onStepCancel != null) ...<Widget>[
            const SizedBox(width: CorpoSpacing.small),
            TextButton(
              onPressed: details.onStepCancel,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
              ),
              child: Text(isFirstStep ? 'Cancel' : 'Back'),
            ),
          ],
        ],
      ),
    );
  }
}

/// A builder widget for creating step titles with consistent styling.
///
/// This helper widget provides common title layouts and styling patterns
/// for use with [CorpoStep.title].
class CorpoStepTitle extends StatelessWidget {
  /// Creates a step title.
  const CorpoStepTitle({
    required this.text,
    this.icon,
    this.trailing,
    this.style,
    super.key,
  });

  /// The title text.
  final String text;

  /// Optional leading icon.
  final Widget? icon;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Text style for the title.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final TextStyle effectiveStyle =
        style ??
        textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ) ??
        const TextStyle();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          icon!,
          const SizedBox(width: CorpoSpacing.small),
        ],
        Flexible(child: Text(text, style: effectiveStyle)),
        if (trailing != null) ...<Widget>[
          const SizedBox(width: CorpoSpacing.small),
          trailing!,
        ],
      ],
    );
  }
}

/// A builder widget for creating step content with consistent styling.
///
/// This helper widget provides common content layouts and styling patterns
/// for use with [CorpoStep.content].
class CorpoStepContent extends StatelessWidget {
  /// Creates step content.
  const CorpoStepContent({required this.child, this.padding, super.key});

  /// The content widget.
  final Widget child;

  /// Optional padding override.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding ?? const EdgeInsets.all(CorpoSpacing.medium),
      child: child,
    );
}
