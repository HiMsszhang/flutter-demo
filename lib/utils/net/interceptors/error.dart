import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import '../code.dart';

/// 错误拦截
class ErrorInterceptors extends InterceptorsWrapper {
  // final Dio _dio;

  ErrorInterceptors(_dio);

  @override
  Future onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Code.errorHandleFunction(Code.NETWORK_ERROR, "");
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: 666);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      Code.errorHandleFunction(errorResponse.statusCode, e.message);
    } else {
      Code.errorHandleFunction(errorResponse.statusCode, errorResponse.data['msg']);
    }
    return super.onError(e);
  }
}
