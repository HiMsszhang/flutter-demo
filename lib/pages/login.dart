import 'dart:async';

import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/login_input.dart';
import 'package:molan_edu/apis/user.dart';
import 'package:molan_edu/apis/common.dart';
import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/providers/user_state.dart';

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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stopTimer();
  }

  _submit() async {
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
                          RawMaterialButton(
                            onPressed: _submit,
                            child: Container(
                              width: double.infinity,
                              height: 94.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(94.w),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFFFABA4),
                                    Color(0xFFFFC4A3),
                                  ],
                                ),
                              ),
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
}
