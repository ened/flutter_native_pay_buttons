import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// https://developers.google.com/pay/api/android/guides/brand-guidelines
enum AndroidPaymentButtonStyle {
  badge,
  badgeNoShadow,
  buyWith,
  buyWithNoShadow,
}

/// Follows the enumerations at
/// - https://developer.apple.com/documentation/passkit/pkpaymentbuttonstyle
enum IosPaymentButtonStyle {
  white,
  whiteOutline,
  black,
}

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

const _viewType = 'asia.ivity/native_pay_button';

class NativePayButton extends StatelessWidget {
  const NativePayButton({
    Key? key,
    required this.androidPaymentButtonStyle,
    required this.iosPaymentButtonStyle,
    this.iosPaymentButtonType = IosPaymentButtonType.plain,
    required this.onPressed,
  }) : super(key: key);

  final AndroidPaymentButtonStyle androidPaymentButtonStyle;
  final IosPaymentButtonStyle iosPaymentButtonStyle;
  final IosPaymentButtonType iosPaymentButtonType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onPressed.call(),
      child: AspectRatio(
        aspectRatio: Platform.isIOS ? 16 / 2.5 : 16 / 2.5,
        child: Platform.isIOS
            ? UiKitView(
                viewType: _viewType,
                creationParams: {
                  'style': iosPaymentButtonStyle.index,
                  'type': iosPaymentButtonType.index,
                },
                hitTestBehavior: PlatformViewHitTestBehavior.transparent,
                creationParamsCodec: StandardMessageCodec(),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},
              )
            : AndroidView(
                viewType: _viewType,
                creationParams: {
                  'style': androidPaymentButtonStyle.index,
                },
                hitTestBehavior: PlatformViewHitTestBehavior.transparent,
                creationParamsCodec: StandardMessageCodec(),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},
              ),
      ),
    );
  }
}
