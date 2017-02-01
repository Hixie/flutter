// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'serializable_segments.dart';
import 'string_utils.dart';

abstract class TextBlock extends SerializableSegment {
  const TextBlock();
}

class Paragraph extends TextBlock {
  const Paragraph(this.body, { this.indentLevel: 0, this.bulleted: false });

  final String body;
  final int indentLevel;
  final bool bulleted;

  @override
  String serialize(int lineLength) {
    String indent, firstLineIdent;
    if (bulleted) {
      if (indentLevel < 1) {
        firstLineIdent = '* ';
        indent = '  ';
      } else {
        firstLineIdent = ' ' * ((indentLevel - 1) * 2) + ' * ';
        indent = ' ' * (indentLevel * 2 + 1);
      }
    } else {
      firstLineIdent = indent = ' ' * (indentLevel * 2);
    }
    List<String> lines = wrap(body, lineLength - indent.length);
    return '$firstLineIdent${lines.join("\n$indent")}';
  }
}

class BlankLine extends TextBlock {
  const BlankLine();

  @override
  String serialize(int lineLength) {
    return '';
  }
}

abstract class PreformattedBlock extends TextBlock {
  const PreformattedBlock();

  String get format;
  SerializableSegment get body;

  @override
  String serialize(int lineLength) {
    return '```$format\n${body.serialize(lineLength)}\n```';
  }
}

class TextSequence extends SerializableSegment {
  const TextSequence(this.blocks);

  final List<TextBlock> blocks;
  
  @override
  String serialize(int lineLength) {
    return blocks
             .map<String>((TextBlock block) => block.serialize(lineLength))
             .join('\n');
  }
}

class RawText extends SerializableSegment {
  const RawText(this.body);

  final String body;

  @override
  String serialize(int lineLength) => body;
}
