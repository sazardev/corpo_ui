/// Matcher utilities for Corpo UI testing.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Custom matcher for finding RichText widgets with specific text content.
Matcher hasRichTextContent(String expectedText) =>
    _HasRichTextContent(expectedText);

class _HasRichTextContent extends Matcher {
  const _HasRichTextContent(this.expectedText);

  final String expectedText;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! RichText) return false;
    final InlineSpan span = item.text;
    return _extractTextFromSpan(span).contains(expectedText);
  }

  String _extractTextFromSpan(InlineSpan span) {
    if (span is TextSpan) {
      String text = span.text ?? '';
      if (span.children != null) {
        for (final InlineSpan child in span.children!) {
          text += _extractTextFromSpan(child);
        }
      }
      return text;
    }
    return '';
  }

  @override
  Description describe(Description description) =>
      description.add('RichText containing "$expectedText"');
}
