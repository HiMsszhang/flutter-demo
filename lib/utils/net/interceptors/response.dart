import 'package:dio/dio.dart';
import 'package:molan_edu/models/ResponseData.dart';
import 'dart:convert';

import '../code.dart';

/// Response 拦截器
class ResponseInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ResponseInterceptors(this._dio);

  @override
  Future onResponse(Response response) {
    RequestOptions option = response.request;
    if (option.responseType == ResponseType.stream) {
      return _dio.resolve(response.data);
    }
    ResponseData data = ResponseData.fromJson(jsonDecode(response.data) ?? {});
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (data.code != 1) {
          print(data.toJson());
          Code.errorHandleFunction(data.code, data.msg);
          return _dio.reject(data.toJson());
        }
        return _dio.resolve(data.data);
      }
      Code.errorHandleFunction(400, data.msg);
      return _dio.reject(data.toJson());
    } catch (e) {
      print(e.toString() + option.path);
      Code.errorHandleFunction(400, data.msg);
      return _dio.reject(data.toJson());
    }
  }
}
