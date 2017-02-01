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

class FileRuneSource extends RuneSource {
  FileRuneSource(this.file);

  final File file;

  StreamIterator<int> _iterator;

  int _line = 1;
  int _column = 1;

  Future<Null> open() async {
    _iterator = new StreamIterator<int>(
      file
        .openRead()
        .transform(UTF8.decoder)
        .expand<int>((String chunk) => chunk.runes)
    );
    await _iterator.moveNext();
  }

  @override
  int get current => _iterator.current;

  int get line => _line;
  int get column => _column;

  @override
  Future<Null> consume() async {
    assert(current != null);
    await _iterator.moveNext();
    if (current == 0x0A) {
      _line += 1;
      _column = 1;
    } else {
      _column += 1;
    }
  }

  @override
  String toString() => 'line $line column $column (${ current != null ? "\"${new String.fromCharCode(current)}\"" : "EOF"})';
}
