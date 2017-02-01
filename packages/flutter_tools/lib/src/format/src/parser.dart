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

Future<DartProgram> parseDartProgram(RuneSource input) async {
  List<Statement> statements = <Statement>[];
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
                statements.add(await _parseLineComment(input));
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
  return new DartProgram(statements);
}

Future<Comment> _parseLineComment(RuneSource input) async {
  if (input.current == null)
    return new Comment(new TextSequence(<TextBlock>[]));
  assert(input.current != 0x2F); // not a U+002F SOLIDUS character (/)
  if (input.current == 0x20)
    await input.consume();
  int indent = await _parseIndent(input);
  String line = await _parseToEndOfLine(input);
  return new Comment(new TextSequence(blocks));
}

/*
            case 0x7E: // U+007E TILDE character (~)
              // slash-tilde operator
              throw 'integer division operator /~ is not yet implemented';
              break;
            default:
              // slash operator
              throw 'division operator / is not yet implemented';
              break;
*/