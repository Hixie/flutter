// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'text.dart';
import 'serializable_segments.dart';

abstract class Statement extends SerializableSegment {
  const Statement();
}

class UnknownStatement extends Statement {
  const UnknownStatement(this.rune);

  final int rune;

  @override
  String serialize(int lineLength) => new String.fromCharCode(rune);
}

class Comment extends Statement {
  const Comment(this.body);

  final TextSequence body;

  @override
  String serialize(int lineLength) => '// $body';
}

class DartDoc extends Statement {
  const DartDoc(this.body);

  final TextSequence body;

  @override
  String serialize(int lineLength) => '/// $body';
}

class DartProgram extends SerializableSegment {
  DartProgram(this.statements);

  final List<Statement> statements;

  void normalize() {
  }

  @override
  String serialize(int lineLength) {
    return statements
             .map<String>((Statement statement) => statement.serialize(lineLength))
             .join('\n');
  }
}

class PreformattedDart extends PreformattedBlock {
  const PreformattedDart(this.program);

  final DartProgram program;

  @override
  String get format => 'dart';

  @override
  SerializableSegment get body => program;
}
