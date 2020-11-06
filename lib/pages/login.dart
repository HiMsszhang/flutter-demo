import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
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
                child: IconButton(
                  icon: Text('跳过', style: Styles.normalFont(fontSize: 24.sp, color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                Image.asset('assets/images/logo.png', width: 369.w, height: 150.w),
                SizedBox(height: 118.w),
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
                      Text('欢迎来到墨岚', style: Styles.normalFont(fontSize: 36.sp, color: Color(0xFFFFA680))),
                      SizedBox(height: 40.w),
                      LoginInput(
                        leading: Container(
                          width: 53.w,
                          alignment: Alignment.centerRight,
                          child: Image.asset('assets/images/common/icon_phone.png', width: 23.w, height: 30.w),
                        ),
                        hintText: '请输入手机号码',
                        action: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(46.w),
                              border: Border.all(width: 1, color: Color(0xFFFFAA86)),
                            ),
                            child: Text('获取验证码', style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFFFAA86), height: 1.2)),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.w),
                      LoginInput(
                        leading: Container(
                          width: 53.w,
                          alignment: Alignment.centerRight,
                          child: Image.asset('assets/images/common/icon_password.png', width: 23.w, height: 30.w),
                        ),
                        hintText: '请输入验证码',
                      ),
                      SizedBox(height: 80.w),
                      Container(
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
                        child: Text('登录', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
