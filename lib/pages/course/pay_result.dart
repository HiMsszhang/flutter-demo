import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/pages/main.dart';

class PayResultPage extends StatefulWidget {
  const PayResultPage({
    Key key,
  }) : super(key: key);

  @override
  _PayResultPageState createState() => _PayResultPageState();
}

class _PayResultPageState extends State<PayResultPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                  colors: [Color(0xFFFFC4A3), Color(0xFFFFABA4)],
                  transform: GradientRotation(-10),
                ),
              ),
            ),
            Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  brightness: Brightness.dark,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    '购课成功',
                    style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                    children: [
                      Container(
                        width: 690.w,
                        height: 1059.w,
                        padding: EdgeInsets.only(top: 79.w),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/course/bg_pay.png'),
                        )),
                        child: Column(
                          children: [
                            Text('恭喜您 购买成功', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                            SizedBox(height: 24.w),
                            Text('您可以去课程表里去学习', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color999999)),
                            SizedBox(height: 68.w),
                            RichText(
                              text: TextSpan(style: Styles.normalFont(fontSize: 28.sp, color: Styles.color999999), children: [
                                TextSpan(text: '墨岚为您匹配了一位'),
                                TextSpan(
                                  text: '班主任老师',
                                  style: Styles.normalFont(
                                    fontSize: 28.sp,
                                    color: Styles.color666666,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(height: 29.w),
                            Text('可微信扫描下方二维码添加', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                            SizedBox(height: 74.w),
                            Container(
                              width: 328.w,
                              height: 328.w,
                              child: Placeholder(),
                            ),
                            Container(
                              width: 572.w,
                              height: 88.w,
                              margin: EdgeInsets.only(top: 30.w),
                              clipBehavior: Clip.hardEdge,
                              decoration: Styles.normalDecoration.copyWith(
                                borderRadius: BorderRadius.circular(88.w),
                                color: Color(0xFFFFC088),
                              ),
                              child: RawMaterialButton(
                                constraints: BoxConstraints(minHeight: 88.w, minWidth: 572.w),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {
                                  NavigatorUtils.pushReplacement(context, MainPage(page: 3));
                                },
                                child: Text('APP内沟通', style: Styles.normalFont(fontSize: 34.sp, color: Colors.white)),
                              ),
                            ),
                            Container(
                              width: 572.w,
                              height: 88.w,
                              margin: EdgeInsets.only(top: 30.w),
                              clipBehavior: Clip.hardEdge,
                              decoration: Styles.normalDecoration.copyWith(
                                borderRadius: BorderRadius.circular(88.w),
                                color: Color(0xFFFFAB8F),
                              ),
                              child: RawMaterialButton(
                                constraints: BoxConstraints(minHeight: 88.w, minWidth: 572.w),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {},
                                child: Text('保存二维码至相册', style: Styles.normalFont(fontSize: 34.sp, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
