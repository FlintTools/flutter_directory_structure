import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/utils/logger.dart';
import '/config.dart';

// 参考来源： https://blog.csdn.net/UserNamezhangxi/article/details/112576483
// 官方文档： https://github.com/flutterchina/dio/blob/master/README-ZH.md
// https://www.liujunmin.com/flutter/dio_encapsulation.html

/// 将 Dio 实例化和拦截器注册的操作放到单独的方法中，方便管理
Dio initDio(String _apiHost) {
  BaseOptions options = BaseOptions(
    baseUrl: _apiHost,
  );
  Dio dio = Dio(options);
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      getLogger().i({
        "type": "请求数据",
        "请求数据：": options.data,
        "请求地址：": options.uri.toString(),
        "请求头：": options.headers,
        "请求方式：": options.method,
      });
      return handler.next(options);
    },
    onResponse: (response, handler) {
      getLogger().i({
        "type": "响应数据",
        "响应数据：": response.data,
        "响应头：": response.headers,
      });
      return handler.next(response);
    },
    onError: (e, handler) {
      /// 请求出错后，关闭加载提示
      getLogger().e({
        "type": "错误响应数据",
        "错误信息：": e.message,
        "错误类型：": e.type,
      });
      return handler.next(e);
    },
  ));
  return dio;
}

class Request {
  static final Request _singleton = Request._init();
  static Dio dio = initDio(apiHost);

  factory Request() {
    return _singleton;
  }

  Request._init();

  /// get 请求
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? param,
        Map<String, dynamic>? headers,
      }) async {

    final prefs = await SharedPreferences.getInstance();
    if(headers != null){
      headers.addAll({"token":prefs.getString('token')});
    }else{
      headers = {"token":prefs.getString('token')};
    }

    Response response = await dio.get(
      path,
      queryParameters: param,
      options: Options(
        headers: headers,
      ),
    );
    return _handleResponse(response);
  }

  /// post 请求
  Future<dynamic> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? headers,
      }) async {

    final prefs = await SharedPreferences.getInstance();
    if(headers != null){
      headers.addAll({"token":prefs.getString('token')});
    }else{
      headers = {"token":prefs.getString('token')};
    }

    Response response = await dio.post(
      path,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200) {
      try {
        return response.data;
      } catch (e) {
        getLogger().e({
          "type": "错误",
          "服务端返回的数据：": response,
        });
      }
    } else {
      getLogger().e({
        "type": "错误",
        "服务端返回的数据：": response,
      });
    }
  }
}


