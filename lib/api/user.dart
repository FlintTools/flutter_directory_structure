import 'dart:async';

import 'request.dart';
import "/config.dart";

class UserApi {

  /// 用户登陆
  static Future<Map> login(Map<String, dynamic> param) async {
    final response =  await Request().post(
        "$apiVersion/api/user/login",
      data:param,
    );

    return response;
  }
  
}
