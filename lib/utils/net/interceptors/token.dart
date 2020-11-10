import 'package:dio/dio.dart';
import 'package:molan_edu/config/config.dart';
import 'package:molan_edu/utils/local_storage.dart';

/// Token拦截器
class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    var authorizationCode = await getAuthorization();
    _token = authorizationCode;
    print('_token:$_token');
    options.headers["token"] = _token;
    return options;
  }

  ///清除授权
  clearAuthorization() {
    _token = null;
    print('_token:$_token');
  }

  ///获取授权token
  getAuthorization() async {
    return await LocalStorage.getJSON(Config.S_TOKEN);
  }
}
