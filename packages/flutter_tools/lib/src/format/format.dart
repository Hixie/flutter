// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import '../base/file_system.dart';
import 'src/file_rune_source.dart';
import 'src/program.dart';

Future<String> reformat(File file) async {
  FileRuneSource input = new FileRuneSource(file);
  await input.open();
  DartProgram program = await parseDartProgram(input);
  program.normalize();
  return program.toString();
}
