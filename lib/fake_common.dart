
import 'dart:async';

import 'package:flutter/services.dart';

// Step-4：dart层接口实现
class FakeCommon {
  static const MethodChannel _channel = MethodChannel('FakeCommon');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future submitPolicyGrantResult(bool granted, Function(dynamic ret,Map err)result) {
    Map args = {"granted": granted};
    Future<dynamic> callback = _channel.invokeMethod('submitPolicyGrantResult', args);
    callback.then((dynamic response){
      if(result != null)
      {
        if(response is Map)
        {
          result(response["ret"],response["err"]);
        }
        else
        {
          // result(null,null);
        }
      }
    });
    return callback;
  }
}
