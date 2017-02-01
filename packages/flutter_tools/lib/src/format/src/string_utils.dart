// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

enum _WordWrapParseMode { inSpace, inWord, atBreak }

/// Wraps the given string at the given width.
///
/// Wrapping occurs at space characters (U+0020).
///
/// This is not suitable for use with arbitrary Unicode text. For example, it
/// doesn't implement UAX #14, can't handle ideographic text, doesn't hyphenate,
/// and so forth. It is only intended for formatting English text as used in
/// Flutter's documentation.
Iterable<String> wrap(String body, int width) sync* {
  int start = 0;
  int index = 0;
  _WordWrapParseMode mode = _WordWrapParseMode.inSpace;
  int lastWordStart;
  int lastWordEnd;
  while (true) {
    switch (mode) {
      case _WordWrapParseMode.inSpace: // at start of break point (or start of line); can't break until next break
        while ((index < body.length) && (body[index] == ' '))
          index += 1;
        lastWordStart = index;
        mode = _WordWrapParseMode.inWord;
        break;
      case _WordWrapParseMode.inWord: // looking for a good break point
        while ((index < body.length) && (body[index] != ' '))
          index += 1;
        mode = _WordWrapParseMode.atBreak;
        break;
      case _WordWrapParseMode.atBreak: // at start of break point
        if ((index - start > width) || (index == body.length)) {
          // we are over the width line, so break
          if ((index - start <= width) || (lastWordEnd == null)) {
            // we should use this point, before either it doesn't actually go over the end (last line), or it does, but there was no earlier break point
            lastWordEnd = index;
          }
          yield body.substring(start, lastWordEnd);
          if (lastWordEnd >= body.length)
            return;
          // just yielded a line
          if (lastWordEnd == index) {
            // we broke at current position
            // eat all the spaces, then set our start point
            while ((index < body.length) && (body[index] == ' '))
              index += 1;
            start = index;
            mode = _WordWrapParseMode.inWord;
          } else {
            // we broke at the previous break point, and we're at the start of a new one
            assert(lastWordStart > lastWordEnd);
            start = lastWordStart;
            mode = _WordWrapParseMode.atBreak;
          }
          lastWordEnd = null;
        } else {
          // save this break point, we're not yet over the line width
          lastWordEnd = index;
          // skip to the end of this break point
          mode = _WordWrapParseMode.inSpace;
        }
        break;
    }
  }
}
