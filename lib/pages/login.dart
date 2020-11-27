import 'dart:async';

import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/login_input.dart';
import 'package:molan_edu/apis/user.dart';
import 'package:molan_edu/apis/common.dart';
import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/models/ConfigModel.dart';
import 'package:molan_edu/pages/other/article.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with UtilsMixin {
  String _mobile = '';
  String _code = '';

  int _seconds = -1;
  Timer _timer;
  String _text = '获取验证码';

  bool _isCountDown = false;
  ConfigArticleModel _serviceData;
  ConfigArticleModel _privacyData;

  void _startTimer() {
    _seconds = 60;
    _isCountDown = true;
    _timer = Timer.periodic(Duration(seconds: 1), _update);
  }

  void _stopTimer() {
    _isCountDown = false;
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _update(Timer timer) {
    if (_seconds == 0) {
      _text = '重新获取';
      _stopTimer();
    } else {
      _seconds--;
      _text = '${_seconds}s';
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await context.read<UserState>().logOut();
      await _getSetting();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stopTimer();
  }

  _getSetting() async {
    DataResult result = await CommonAPI.getArticle(type: 'useragreement');
    DataResult res = await CommonAPI.getArticle(type: 'privacypolicy');
    _serviceData = result.data;
    _privacyData = res.data;
  }

  _showTerms() {
    showDialog(
      context: context,
      builder: (context) => _widgetTerms(),
    );
  }

  _submit() async {
    if (_mobile.isEmpty) {
      showToast('请输入正确的手机号');
      return;
    }
    if (_code.isEmpty) {
      showToast('请输入验证码');
      return;
    }
    try {
      DataResult res = await UserAPI.login(mobile: _mobile, code: _code);
      UserModel user = res.data;
      await context.read<UserState>().updateUser(user);
      showToast('登录成功!');
      NavigatorUtils.pushNamedAndRemoveUntil(context, '/');
    } catch (e) {}
  }

  _getCode() async {
    if (_mobile == '') {
      showToast('请输入手机号');
      return;
    }
    if (!_isCountDown) {
      try {
        await CommonAPI.getCode(mobile: _mobile);
        _startTimer();
      } catch (e) {}
    }
    if (_seconds > 0) return;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: double.infinity, height: double.infinity, color: Colors.white),
        Container(
          width: 750.w,
          height: 400.w + kToolbarHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC4A3),
                Color(0xFFFFABA4),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: Offstage(
              offstage: true,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 33.w,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            actions: [
              Offstage(
                offstage: false,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: IconButton(
                    icon: Text('跳过', style: Styles.normalFont(fontSize: 24.sp, color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            clipBehavior: Clip.none,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(30.w, 20.w, 30.w, 44.w),
            child: Column(
              children: [
                SizedBox(height: 200.w),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      width: 690.w,
                      padding: EdgeInsets.symmetric(horizontal: 54.w, vertical: 90.w),
                      decoration: Styles.normalDecoration.copyWith(
                        borderRadius: BorderRadius.circular(16.w),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('登录墨岚', style: Styles.normalFont(fontSize: 36.sp, color: Color(0xFFFFA680))),
                          SizedBox(height: 40.w),
                          LoginInput(
                            leading: Container(
                              width: 53.w,
                              alignment: Alignment.centerRight,
                              child: Image.asset('assets/images/common/icon_phone.png', width: 23.w, height: 30.w),
                            ),
                            hintText: '请输入手机号码',
                            action: GestureDetector(
                              onTap: _getCode,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(46.w),
                                  border: Border.all(width: 1, color: Color(0xFFFFAA86)),
                                ),
                                child: Text(_text, style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFFFAA86), height: 1.2)),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _mobile = value;
                              });
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 40.w),
                          LoginInput(
                            leading: Container(
                              width: 53.w,
                              alignment: Alignment.centerRight,
                              child: Image.asset('assets/images/common/icon_password.png', width: 23.w, height: 30.w),
                            ),
                            hintText: '请输入验证码',
                            onChanged: (value) {
                              setState(() {
                                _code = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 80.w),
                          Container(
                            width: double.infinity,
                            height: 94.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(94.w),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFC0A3),
                                  Color(0xFFFFABA4),
                                ],
                              ),
                            ),
                            child: RawMaterialButton(
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                              onPressed: _showTerms,
                              child: Text('注册即登录', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -89.w,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 208.w,
                            height: 208.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(208.w),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Image.asset('assets/images/logo.png', width: 120.w, height: 100.w, fit: BoxFit.contain),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _widgetTerms() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 690.w,
              padding: EdgeInsets.symmetric(horizontal: 43.w, vertical: 60.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    '用户服务协议及隐私政策',
                    style: Styles.normalFont(fontSize: 30.sp, color: Color(0xFF6F5B59), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 46.w),
                  RichText(
                    text: TextSpan(
                      style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999, height: 42 / 24),
                      children: [
                        TextSpan(text: '亲爱的用户，在您使用墨岚教育课程APP前，请您务必认真阅读'),
                        TextSpan(text: '《用户服务协议及隐私政策》', style: Styles.normalFont(color: Color(0xFF6F5B59))),
                        TextSpan(text: '中各项条款，了解我们对您个人信息的处理规则。同时您应特别注意前述协议中免除或者限制我们责任的条款、对您权利进行限制的条款、约定争议解决方式和司法管辖的条款。如您已详细阅读并同意'),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              NavigatorUtils.push(context, ArticlePage(title: _serviceData.title, content: _serviceData.content));
                            },
                            child: Text(
                              '《用户服务协议》',
                              style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFF6F5B59), height: 1.5),
                            ),
                          ),
                        ),
                        TextSpan(text: '和'),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              NavigatorUtils.push(context, ArticlePage(title: _privacyData.title, content: _privacyData.content));
                            },
                            child: Text(
                              '《隐私政策》',
                              style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFF6F5B59), height: 1.5),
                            ),
                          ),
                        ),
                        TextSpan(text: '，请点击按钮开始使用我们的产品和服务。'),
                      ],
                    ),
                  ),
                  SizedBox(height: 46.w),
                  Container(
                    width: double.infinity,
                    height: 77.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(77.w),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFC0A3),
                          Color(0xFFFFABA4),
                        ],
                      ),
                    ),
                    child: RawMaterialButton(
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onPressed: _submit,
                      child: Text('同意并登录', style: Styles.normalFont(fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
