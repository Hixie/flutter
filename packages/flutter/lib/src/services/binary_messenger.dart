// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';
import 'dart:ui' as ui;

/// A function which takes a platform message and asynchronously returns an encoded response.
typedef MessageHandler = Future<ByteData?>? Function(ByteData? message);

/// A messenger which sends binary data across the Flutter platform barrier.
///
/// This class also registers handlers for incoming messages.
abstract class BinaryMessenger {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const BinaryMessenger();

  /// Queues a message.
  ///
  /// The returned future completes immediately.
  ///
  /// To send a message from the framework to plugins, it is more efficient to
  /// call `ServicesBinding.instance.channelBuffers.push` directly.
  ///
  /// In tests, consider using [WidgetTester.sendMockPlatformMessage].
  ///
  /// To register a handler for a given message channel, see [setMessageHandler].
  // TODO(ianh): deprecate this method: @Deprecated(
  //   'Instead of calling this method, use ServicesBinding.instance.channelBuffers.push. '
  //   'This feature was deprecated after v000.'
  // )
  Future<void> handlePlatformMessage(String channel, ByteData? data, ui.PlatformMessageResponseCallback? callback);

  /// Send a binary message to the platform plugins on the given channel.
  ///
  /// Returns a [Future] which completes to the received response, undecoded,
  /// in binary form.
  Future<ByteData?>? send(String channel, ByteData? message);

  /// Set a callback for receiving messages from the platform plugins on the
  /// given channel, without decoding them.
  ///
  /// The given callback will replace the currently registered callback for that
  /// channel, if any. To remove the handler, pass null as the [handler]
  /// argument.
  ///
  /// The handler's return value, if non-null, is sent as a response, unencoded.
  void setMessageHandler(String channel, MessageHandler? handler);
}
