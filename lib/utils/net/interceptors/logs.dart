import 'package:dio/dio.dart';
import 'package:molan_edu/config/config.dart';

/// Log 拦截器
class LogsInterceptors extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    if (!Config.isRelease) {
      if (response != null) {
        print('${response?.request?.method} - ${response?.request?.path} -> 返回参数: ' + response.toString());
      }
      print('request 请求头: ');
      print('request 请求头 end');
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    Response response = err.response;
    if (!Config.isRelease) {
      print('请求异常: ' + err.toString());
      print('请求异常信息: ' + response?.toString() ?? "");
      print("请求异常url: ${err?.request?.method} - ${err?.request?.path}");
      print('request 请求头: ' + err.response.headers.toString());
    }
    return super.onError(err);
  }
}
