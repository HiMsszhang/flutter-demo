import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:molan_edu/config/config.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'interceptors/error.dart';
import 'interceptors/request.dart';
import 'interceptors/response.dart';
import 'interceptors/token.dart';

class HttpManager {
  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();
  Dio dio = new Dio(BaseOptions(
    baseUrl: Config.apiHost,
    contentType: "application/x-www-form-urlencoded",
    responseType: ResponseType.plain,

    /// 超时
    connectTimeout: 60 * 1000,
    receiveTimeout: 100 * 1000,
  ));
  HttpManager() {
    dio.interceptors.add(new DioCacheManager(CacheConfig(baseUrl: Config.apiHost)).interceptor);
    dio.interceptors.add(new CookieManager(CookieJar()));
    dio.interceptors.add(new RequestInterceptors());
    dio.interceptors.add(new TokenInterceptors());
    dio.interceptors.add(new LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    dio.interceptors.add(new ErrorInterceptors(dio));
    dio.interceptors.add(new ResponseInterceptors(dio)); // 使用默认配置
    // // if(Config.env == Env.DEV){
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   // config the http client
    //   client.findProxy = (uri) {
    //     //proxy all request to localhost:8888
    //     return "PROXY 192.168.124.11:8888";
    //   };
    //   // you can also create a HttpClient to dio
    //   // return HttpClient();
    // };
    // // }
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();
final Dio http = httpManager.dio;
