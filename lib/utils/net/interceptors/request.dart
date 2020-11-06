import 'package:dio/dio.dart';

/// Request 拦截器
class RequestInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    return super.onRequest(options);
  }
}
