import 'dart:async';

import 'request.dart';
import "/config.dart";

class UserApi {


  /// 用户注册
  static Future<Map> register(Map<String, dynamic> param) async {
    final response =  await Request().post(
        "$apiVersion/api/user/register",
      data:param,
    );

    return response;
  }

  /// 用户登陆
  static Future<Map> login(Map<String, dynamic> param) async {
    final response =  await Request().post(
        "$apiVersion/api/user/login",
      data:param,
    );

    return response;
  }

  /// 找回密码
  static Future<Map> resetPassword(Map<String, dynamic> param) async {
    final response =  await Request().post(
      "$apiVersion/api/user/reset_password",
      data:param,
    );

    return response;
  }

  /// 消耗能量值
  static Future<Map> consumeEnergyValue(Map<String, dynamic> param) async {
    final response =  await Request().post(
      "$apiVersion/api/user/consume_energy_value",
      data:param,
    );

    return response;
  }

  /// 获取能量值
  static Future<Map> getEnergyValue() async {
    final response =  await Request().get(
      "$apiVersion/api/user/get_energy_value",
    );

    return response;
  }

  /// 创建支付订单
  static Future<Map> createPayOrder(Map<String, dynamic> param) async {
    final response =  await Request().post(
      "$apiVersion/api/user/create_pay_order",
      data:param,
    );

    return response;
  }

  /// 创建支付订单
  static Future<Map> inspectPayStatus(Map<String, dynamic> param) async {
    final response =  await Request().post(
      "$apiVersion/api/user/inspect_pay_status",
      data:param,
    );

    return response;
  }
}
