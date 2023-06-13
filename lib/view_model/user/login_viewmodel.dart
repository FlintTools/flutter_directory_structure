import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '/route/route_name.dart';
import '/view_model/base_viewmodel.dart';

class LoginViewmodel extends  BaseViewmodel{
  var count = 0.obs;
  increment() => count++;


  /// 用户登录
  login(Map<String, dynamic> data) async {
    context.go('/${RouteName.translate}');
  }
}