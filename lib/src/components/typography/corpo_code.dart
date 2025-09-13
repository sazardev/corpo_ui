/// A specialized text component for displaying code and monospace content.
///
/// CorpoCode provides consistent styling for code blocks, inline code,
/// and other monospace text content. It includes syntax highlighting
/// support, copy functionality, and responsive design for technical
/// documentation and developer interfaces.
///
/// This component is designed for corporate applications that need to
/// display technical content, configuration examples, API responses,
/// or any other monospace text with proper formatting.
///
/// Example usage:
/// ```dart
/// CorpoCode('console.log("Hello World");')
///
/// CorpoCode.inline('const variable = "value"')
///
/// CorpoCode.block('''
/// function example() {
///   return "formatted code block";
/// }
/// ''')
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';
import '../../constants/spacing.dart';
import '../../constants/typography.dart';

/// Display variants for code content.
///
/// Determines how the code should be presented visually
/// and what container styling to apply.
enum CorpoCodeVariant {
  /// Inline code within text flow
  inline,

  /// Code block with background and padding
  block,

  /// Terminal/console style code
  terminal,
}

/// A widget for displaying code and monospace text with proper styling.
///
/// This component provides consistent formatting for code content
/// across the application, with support for different display variants,
/// copy functionality, and theme integration.
class CorpoCode extends StatelessWidget {
  /// Creates a Corpo UI code widget.
  ///
  /// The [code] parameter contains the code text to display.
  /// The [variant] determines the visual presentation.
  const CorpoCode(
    this.code, {
    this.variant = CorpoCodeVariant.inline,
    this.language,
    this.showCopyButton = false,
    this.selectable = true,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    super.key,
  });

  /// Convenience constructor for inline code.
  const CorpoCode.inline(
    this.code, {
    this.language,
    this.showCopyButton = false,
    this.selectable = true,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    super.key,
  }) : variant = CorpoCodeVariant.inline;

  /// Convenience constructor for code blocks.
  const CorpoCode.block(
    this.code, {
    this.language,
    this.showCopyButton = true,
    this.selectable = true,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    super.key,
  }) : variant = CorpoCodeVariant.block;

  /// Convenience constructor for terminal/console style.
  const CorpoCode.terminal(
    this.code, {
    this.language,
    this.showCopyButton = true,
    this.selectable = true,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    super.key,
  }) : variant = CorpoCodeVariant.terminal;

  /// The code text to display.
  final String code;

  /// The display variant for the code.
  final CorpoCodeVariant variant;

  /// Optional language identifier for syntax highlighting.
  final String? language;

  /// Whether to show a copy button for the code.
  final bool showCopyButton;

  /// Whether the text should be selectable.
  final bool selectable;

  /// Maximum number of lines to display.
  final int? maxLines;

  /// How to handle text overflow.
  final TextOverflow overflow;

  /// Optional custom text style.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final TextStyle codeStyle = _getCodeStyle(context);

    switch (variant) {
      case CorpoCodeVariant.inline:
        return _buildInlineCode(context, codeStyle);
      case CorpoCodeVariant.block:
        return _buildCodeBlock(context, codeStyle);
      case CorpoCodeVariant.terminal:
        return _buildTerminalCode(context, codeStyle);
    }
  }

  /// Builds inline code styling.
  Widget _buildInlineCode(BuildContext context, TextStyle codeStyle) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? CorpoColors.neutral800
        : CorpoColors.neutral100;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CorpoSpacing.extraSmall,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isDark ? CorpoColors.neutral700 : CorpoColors.neutral200,
        ),
      ),
      child: _buildCodeText(codeStyle),
    );
  }

  /// Builds code block styling.
  Widget _buildCodeBlock(BuildContext context, TextStyle codeStyle) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? CorpoColors.neutral900
        : CorpoColors.neutral50;

    return Container(
      width: double.infinity,
      padding: CorpoPadding.medium,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? CorpoColors.neutral700 : CorpoColors.neutral200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (language != null || showCopyButton) ...<Widget>[
            _buildCodeHeader(context),
            const SizedBox(height: CorpoSpacing.small),
          ],
          _buildCodeText(codeStyle),
        ],
      ),
    );
  }

  /// Builds terminal/console styling.
  Widget _buildTerminalCode(BuildContext context, TextStyle codeStyle) {
    final TextStyle terminalStyle = codeStyle.copyWith(
      color: CorpoColors.neutralWhite,
      fontFamily: 'monospace',
    );

    return Container(
      width: double.infinity,
      padding: CorpoPadding.medium,
      decoration: BoxDecoration(
        color: CorpoColors.neutralBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CorpoColors.neutral600),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showCopyButton) ...<Widget>[
            _buildTerminalHeader(context),
            const SizedBox(height: CorpoSpacing.small),
          ],
          _buildCodeText(terminalStyle),
        ],
      ),
    );
  }

  /// Builds the code header with language and copy button.
  Widget _buildCodeHeader(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (language != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CorpoSpacing.small,
              vertical: CorpoSpacing.extraSmall,
            ),
            decoration: BoxDecoration(
              color: CorpoColors.primary100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              language!.toUpperCase(),
              style: CorpoTypography.labelSmall.copyWith(
                color: CorpoColors.primary700,
                fontWeight: CorpoFontWeight.semiBold,
              ),
            ),
          )
        else
          const Spacer(),
        if (showCopyButton) _buildCopyButton(context),
      ],
    );

  /// Builds the terminal header with copy button.
  Widget _buildTerminalHeader(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildTerminalDot(CorpoColors.error),
            const SizedBox(width: CorpoSpacing.extraSmall),
            _buildTerminalDot(CorpoColors.warning),
            const SizedBox(width: CorpoSpacing.extraSmall),
            _buildTerminalDot(CorpoColors.success),
          ],
        ),
        if (showCopyButton) _buildCopyButton(context, isTerminal: true),
      ],
    );

  /// Builds a terminal window dot.
  Widget _buildTerminalDot(Color color) => Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );

  /// Builds the copy button.
  Widget _buildCopyButton(BuildContext context, {bool isTerminal = false}) {
    final Color iconColor = isTerminal
        ? CorpoColors.neutral400
        : CorpoColors.textSecondary;

    return IconButton(
      onPressed: () => _copyToClipboard(context),
      icon: Icon(Icons.copy, size: 16, color: iconColor),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: const EdgeInsets.all(CorpoSpacing.extraSmall),
      tooltip: 'Copy code',
    );
  }

  /// Builds the code text widget.
  Widget _buildCodeText(TextStyle codeStyle) {
    final TextStyle effectiveStyle = codeStyle.merge(style);

    if (selectable) {
      return SelectableText(code, style: effectiveStyle, maxLines: maxLines);
    }

    return Text(
      code,
      style: effectiveStyle,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Gets the appropriate code text style for the current theme.
  TextStyle _getCodeStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color textColor = isDark
        ? CorpoColors.neutral100
        : CorpoColors.neutral800;

    return TextStyle(
      fontFamily: 'monospace',
      fontSize: CorpoFontSize.small,
      fontWeight: CorpoFontWeight.regular,
      color: textColor,
      height: 1.4,
      letterSpacing: 0.5,
    );
  }

  /// Copies the code to the clipboard and shows a snackbar.
  Future<void> _copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: code));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Code copied to clipboard'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }
}
