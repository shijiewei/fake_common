
import 'dart:async';

import 'package:flutter/services.dart';

class FakeCommon {
  static const MethodChannel _channel = MethodChannel('fake_common');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
