import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_pay_buttons/native_pay_buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (Platform.isAndroid)
                  for (AndroidPaymentButtonStyle style
                      in AndroidPaymentButtonStyle.values)
                    NativePayButton(
                      androidPaymentButtonStyle: style,
                      onPressed: () {
                        print('pressed - android');
                      },
                    ),
                SizedBox(height: 8),
                if (Platform.isIOS)
                  for (IosPaymentButtonType type in IosPaymentButtonType.values)
                    for (IosPaymentButtonStyle style
                        in IosPaymentButtonStyle.values) ...[
                      NativePayButton(
                        iosPaymentButtonType: type,
                        iosPaymentButtonStyle: style,
                        onPressed: () {
                          print('pressed - ios');
                        },
                      ),
                      SizedBox(height: 8),
                    ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
