import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

class LogoutDetailPage extends StatefulWidget {
  LogoutDetailPage({Key key}) : super(key: key);

  @override
  _LogoutDetailPageState createState() => _LogoutDetailPageState();
}

class _LogoutDetailPageState extends State<LogoutDetailPage> with UtilsMixin {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      backgroundColor: Colors.white,
      title: '注销账户',
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 36.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '距离正式注销还有',
                    style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w500, color: Color(0xFF999999)),
                  ),
                  Text(
                    '7h，',
                    style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w500, color: Color(0xFFFFAA86)),
                  ),
                  Text(
                    '期间您可以',
                    style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w500, color: Color(0xFF999999)),
                  ),
                  Text(
                    '撤销注销',
                    style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w500, color: Color(0xFFFFAD8A)),
                  ),
                ],
              ),
              SizedBox(height: 40.w),
              Column(
                children: [
                  Container(
                    width: 690.w,
                    height: 132.w,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.w, color: Color(0xFFF5F5F5)))),
                    child: Row(
                      children: [
                        Image.asset('assets/images/common/logout_phone.png', width: 23.w, height: 30.w),
                        SizedBox(width: 20.w),
                        Text(
                          '手机号',
                          style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.w500, color: Color(0xFF666666)),
                        ),
                        SizedBox(width: 53.w),
                        Text(
                          '188****8990',
                          style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
                        ),
                        SizedBox(width: 152.w),
                        Container(
                          width: 152.w,
                          height: 46.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Color(0xFFBBBBBB)),
                            borderRadius: BorderRadius.circular(23.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '已发送',
                                style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.w400, color: Color(0xFF999999)),
                              ),
                              Text(
                                '(42s)',
                                style: Styles.normalFont(fontSize: 18.sp, fontWeight: FontWeight.w400, color: Color(0xFF999999)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 690.w,
                    height: 132.w,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.w, color: Color(0xFFF5F5F5)))),
                    child: Row(
                      children: [
                        Image.asset('assets/images/common/logout_password.png', width: 23.w, height: 30.w),
                        SizedBox(width: 20.w),
                        Text(
                          '验证码',
                          style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.w500, color: Color(0xFF666666)),
                        ),
                        SizedBox(width: 53.w),
                        Container(
                          width: 400.w,
                          height: 120.w,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            controller: _controller,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 493.w),
              RawMaterialButton(
                onPressed: () {},
                child: Container(
                  width: 584.w,
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
                  child: Text('确认撤销', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
