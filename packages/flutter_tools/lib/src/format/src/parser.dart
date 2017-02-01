// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import '../../base/file_system.dart';
import 'parser.dart';
import 'text.dart';
import 'program.dart';
import 'rune_source.dart';

class ProgramParseContext {
  CommentContext currentComment;
  DartDocContext currentDartDoc;
  List<Statement> statements = <Statement>[];

  Future<DartProgram> parseDartProgram(RuneSource input) async {
    while (input.current != null) {
      switch (input.current) {
        case 0x2F: // U+002F SOLIDUS character (/)
          await input.consume();
          switch (input.current) {
            case 0x2F: // U+002F SOLIDUS character (/)
              await input.consume();
              switch (input.current) {
                case 0x2F: // U+002F SOLIDUS character (/)
                  // dartdoc
                  throw '/// dartdocs are not yet implemented';
                  break;
                default:
                  // comment
                  currentComment ??= new CommentContext();
                  await currentComment.parseLine(input);
                  break;
              }
              break;
            case 0x2A: // U+002A ASTERISK character (*)
              // block comment
              throw '/**/ comments are not yet implemented';
              break;
            default:
              // unexpected!
              throw 'unexpected character found at $input';
              break;
          }
          break;
        default:
          // unexpected!
          throw 'unexpected character found at $input';
          break;
      }
    }
    closeComment();
    return new DartProgram(statements);
  }

  void closeComment() {
    if (currentComment != null) {
      statements.add(currentComment.compile());
      currentComment = null;
    }
  }
}

class CommentContext {
  int currentIndent;
  bool currentBullet;
  List<TextSpan> currentBody;

  Future<Null> parseLine() async {
    if (input.current == null)
      return;
    assert(input.current != 0x2F); // not a U+002F SOLIDUS character (/), that would be a dartdoc
    if (input.current == 0x20)
      await input.consume();
    int indent = await _parseIndent(input);
    bool bullet = await _parseBullet(input);
    _
    await _addWordsToEndOfLine(input);
    
  }
}

