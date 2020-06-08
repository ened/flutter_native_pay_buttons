import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Follows the enumeration at https://developer.apple.com/documentation/passkit/pkpaymentbuttontype
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

/// Follows the enumeration at https://developer.apple.com/documentation/passkit/pkpaymentbuttonstyle
enum IosPaymentButtonStyle {
  white,
  whiteOutline,
  black,
}

class NativePayButton extends StatelessWidget {
  const NativePayButton({
    Key key,
    this.iosPaymentButtonType = IosPaymentButtonType.plain,
    this.iosPaymentButtonStyle,
  }) : super(key: key);

  final IosPaymentButtonType iosPaymentButtonType;
  final IosPaymentButtonStyle iosPaymentButtonStyle;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 212 / 38,
      child: GestureDetector(
        onTap: () {
          print('tap');
        },
        onDoubleTap: () {
          print('tap tap');
        },
        child: UiKitView(
          viewType: 'asia.ivity/native_pay_button',
          creationParams: {
            'type': iosPaymentButtonType.index,
            'style': iosPaymentButtonStyle.index,
          },
          creationParamsCodec: StandardMessageCodec(),
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            // Factory<OneSequenceGestureRecognizer>(() => TapGestureRecognizer()),
          ].toSet(),
        ),
      ),
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
