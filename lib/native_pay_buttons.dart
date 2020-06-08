import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum IosPaymentButtonType {
  plain,
  buy,
  setUp,
  inStore,
  donate,
  checkout,
  book,
  subscribe,
}

enum IosPaymentButtonStyle {
  white,
  whiteOutline,
  black,
}

class NativePayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: 'asia.ivity/native_pay_button',
      creationParams: {
        'woof': 'woof',
      },
      creationParamsCodec: StandardMessageCodec(),
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => TapGestureRecognizer(),
        ),
      ].toSet(),
    );
  }
}

class NativePayButtons {
  final MethodChannel _channel =
      const MethodChannel('asia.ivity/native_pay_buttons');

  NativePayButtons() {}

  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
