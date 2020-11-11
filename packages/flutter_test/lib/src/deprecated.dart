// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';

import 'binding.dart';

/// Shim to support the obsolete [setMockMessageHandler] and
/// [checkMockMessageHandler] methods on [BinaryMessenger] in tests.
///
/// The implementations defer to [TestDefaultBinaryMessengerBinding].
///
/// Rather than calling [setMockMessageHandler] on the
/// `ServicesBinding.defaultBinaryMessenger`, use
/// `tester.binding.defaultBinaryMessenger.setMockMessageHandler` directly. This
/// more accurately represents the actual method invocation.
extension TestBinaryMessengerExtension on BinaryMessenger {
  /// Shim for [TestDefaultBinaryMessengerBinding.setMockMessageHandler].
  // TODO(ianh): deprecate this method: @Deprecated(
  //   'Use tester.binding.defaultBinaryMessenger.setMockMessageHandler instead. '
  //   'This feature was deprecated after v000.'
  // )
  void setMockMessageHandler(String channel, MessageHandler? handler) {
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockMessageHandler(channel, handler);
  }

  /// Shim for [TestDefaultBinaryMessengerBinding.checkMockMessageHandler].
  // TODO(ianh): deprecate this method: @Deprecated(
  //   'Use tester.binding.defaultBinaryMessenger.checkMockMessageHandler instead. '
  //   'This feature was deprecated after v000.'
  // )
  bool checkMockMessageHandler(String channel, Object? handler) {
    return TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.checkMockMessageHandler(channel, handler);
  }
}

/// Shim to support the obsolete [setMockMessageHandler] and
/// [checkMockMessageHandler] methods on [BasicMessageChannel] in tests.
///
/// The implementations defer to [TestDefaultBinaryMessengerBinding].
///
/// Rather than calling [setMockMessageHandler] on the message channel, use
/// `tester.binding.defaultBinaryMessenger.setMockDecodedMessageHandler`
/// directly. This more accurately represents the actual method invocation.
extension TestBasicMessageChannelExtension<T> on BasicMessageChannel<T> {
  /// Shim for [TestDefaultBinaryMessengerBinding.setMockDecodedMessageHandler].
  // TODO(ianh): deprecate this method: @Deprecated(
  //   'Use tester.binding.defaultBinaryMessenger.setMockDecodedMessageHandler. '
  //   'This feature was deprecated after v000.'
  // )
  void setMockMessageHandler(Future<T> Function(T? message)? handler) {
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockDecodedMessageHandler<T>(this, handler);
  }

  /// Shim for [TestDefaultBinaryMessengerBinding.checkMockMessageHandler].
  // TODO(ianh): deprecate this method: @Deprecated(
  //   'Use tester.binding.defaultBinaryMessenger.checkMockMessageHandler instead. '
  //   'This feature was deprecated after v000.'
  // )
  bool checkMockMessageHandler(Object? handler) {
    return TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.checkMockMessageHandler(name, handler);
  }
}

/// Shim to support the obsolete [setMockMethodCallHandler] and
/// [checkMockMethodCallHandler] methods on [MethodChannel] in tests.
///
/// The implementations defer to [TestDefaultBinaryMessengerBinding].
///
/// Rather than calling [setMockMethodCallHandler] on the method channel, use
/// `tester.binding.defaultBinaryMessenger.setMockMethodCallHandler` directly.
/// This more accurately represents the actual method invocation.
extension TestMethodChannelExtension on MethodChannel {
  /// Shim for [TestDefaultBinaryMessengerBinding.setMockMethodCallHandler].
  // TODO(ianh): deprecate this method: @Deprecated(
  //   'Use tester.binding.defaultBinaryMessenger.setMockMethodCallHandler instead. '
  //   'This feature was deprecated after v000.'
  // )
  void setMockMethodCallHandler(Future<dynamic>? Function(MethodCall call)? handler) {
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockMethodCallHandler(this, handler);
  }

  /// Shim for [TestDefaultBinaryMessengerBinding.checkMockMessageHandler].
  // TODO(ianh): deprecate this method: @Deprecated(
  //   'Use tester.binding.defaultBinaryMessenger.checkMockMessageHandler instead. '
  //   'This feature was deprecated after v000.'
  // )
  bool checkMockMethodCallHandler(Object? handler) {
    return TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.checkMockMessageHandler(name, handler);
  }
}
