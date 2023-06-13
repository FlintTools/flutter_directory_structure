import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';

import '/api/user.dart';
import '/route/route_name.dart';
import '/utils/ui.dart';
import '/view_model/base_viewmodel.dart';
import '/utils/logger.dart';

class LoginViewmodel extends  BaseViewmodel{
  var count = 0.obs;
  increment() => count++;


  /// 用户登录
  login(Map<String, dynamic> data) async {
    context.go('/${RouteName.translate}');
  }
}