// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import '../base/common.dart';
import '../runner/flutter_command.dart';
import '../format/format.dart' as formatter;
import '../base/file_system.dart';

class FormatCommand extends FlutterCommand {
  @override
  final String name = 'format';

  @override
  final String description = 'Reformat a dart file and output the results to the console.';

  @override
  String get invocation => "${runner.executableName} $name <filename>";

  @override
  Future<Null> runCommand() async {
    if (argResults.rest.isEmpty) {
      throwToolExit(
        'No file specified to be formatted.\n'
        '\n'
        '$usage'
      );
    }

    if (argResults.rest.length > 1) {
      throwToolExit(
        'Multiple files specified to be formatted. Currently only one file may be specified at a time.\n'
        '\n'
        '$usage'
      );
    }

    print(await formatter.reformat(fs.file(argResults.rest.single)));
  }
}
