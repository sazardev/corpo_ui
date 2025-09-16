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

import '../../design_tokens.dart';

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
    final CorpoDesignTokens tokens = CorpoDesignTokens();
    final TextStyle codeStyle = _getCodeStyle(context, tokens);

    switch (variant) {
      case CorpoCodeVariant.inline:
        return _buildInlineCode(context, codeStyle, tokens);
      case CorpoCodeVariant.block:
        return _buildCodeBlock(context, codeStyle, tokens);
      case CorpoCodeVariant.terminal:
        return _buildTerminalCode(context, codeStyle, tokens);
    }
  }

  /// Builds inline code styling.
  Widget _buildInlineCode(
    BuildContext context,
    TextStyle codeStyle,
    CorpoDesignTokens tokens,
  ) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? Colors.grey[800]!
        : Colors.grey[100]!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing1x, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: _buildCodeText(codeStyle),
    );
  }

  /// Builds code block styling.
  Widget _buildCodeBlock(
    BuildContext context,
    TextStyle codeStyle,
    CorpoDesignTokens tokens,
  ) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color backgroundColor = isDark ? Colors.grey[900]! : Colors.grey[50]!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(tokens.spacing4x),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(tokens.borderRadius),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (language != null || showCopyButton) ...<Widget>[
            _buildCodeHeader(context, tokens),
            SizedBox(height: tokens.spacing2x),
          ],
          _buildCodeText(codeStyle),
        ],
      ),
    );
  }

  /// Builds terminal/console styling.
  Widget _buildTerminalCode(
    BuildContext context,
    TextStyle codeStyle,
    CorpoDesignTokens tokens,
  ) {
    final TextStyle terminalStyle = codeStyle.copyWith(
      color: Colors.white,
      fontFamily: 'monospace',
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(tokens.spacing4x),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(tokens.borderRadius),
        border: Border.all(color: Colors.grey[600]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showCopyButton) ...<Widget>[
            _buildTerminalHeader(context, tokens),
            SizedBox(height: tokens.spacing2x),
          ],
          _buildCodeText(terminalStyle),
        ],
      ),
    );
  }

  /// Builds the code header with language and copy button.
  Widget _buildCodeHeader(BuildContext context, CorpoDesignTokens tokens) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (language != null)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing2x,
                vertical: tokens.spacing1x,
              ),
              decoration: BoxDecoration(
                color: tokens.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(tokens.borderRadiusSmall),
              ),
              child: Text(
                language!.toUpperCase(),
                style: TextStyle(
                  fontSize: tokens.fontSizeSmall,
                  fontFamily: tokens.fontFamily,
                  fontWeight: FontWeight.w600,
                  color: tokens.primaryColor,
                ),
              ),
            )
          else
            const Spacer(),
          if (showCopyButton) _buildCopyButton(context, tokens),
        ],
      );

  /// Builds the terminal header with copy button.
  Widget _buildTerminalHeader(BuildContext context, CorpoDesignTokens tokens) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildTerminalDot(tokens.errorColor),
              SizedBox(width: tokens.spacing1x),
              _buildTerminalDot(tokens.warningColor),
              SizedBox(width: tokens.spacing1x),
              _buildTerminalDot(tokens.successColor),
            ],
          ),
          if (showCopyButton)
            _buildCopyButton(context, tokens, isTerminal: true),
        ],
      );

  /// Builds a terminal window dot.
  Widget _buildTerminalDot(Color color) => Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  /// Builds the copy button.
  Widget _buildCopyButton(
    BuildContext context,
    CorpoDesignTokens tokens, {
    bool isTerminal = false,
  }) {
    final Color iconColor = isTerminal
        ? Colors.grey[400]!
        : tokens.textSecondary;

    return IconButton(
      onPressed: () => _copyToClipboard(context),
      icon: Icon(Icons.copy, size: 16, color: iconColor),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.all(tokens.spacing1x),
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
  TextStyle _getCodeStyle(BuildContext context, CorpoDesignTokens tokens) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color textColor = isDark ? Colors.grey[100]! : Colors.grey[800]!;

    return TextStyle(
      fontFamily: 'monospace',
      fontSize: tokens.fontSizeSmall,
      fontWeight: FontWeight.normal,
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
