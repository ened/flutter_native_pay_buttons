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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              for (IosPaymentButtonType type in IosPaymentButtonType.values)
                for (IosPaymentButtonStyle style
                    in IosPaymentButtonStyle.values) ...[
                  NativePayButton(
                    iosPaymentButtonType: type,
                    iosPaymentButtonStyle: style,
                  ),
                  SizedBox(height: 8),
                ]
            ],
          ),
        ),
      ),
    );
  }
}
