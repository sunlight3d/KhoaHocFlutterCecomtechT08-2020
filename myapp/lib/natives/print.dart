import 'package:flutter/services.dart';

const methodChannel = const MethodChannel('cecomtech.training/printf');
Future<void> printf({String content}) async {
  try {
    await methodChannel.invokeMethod('printf',<String, dynamic>{
      'content': content,
    });
  } on PlatformException catch (e) {
  }
}