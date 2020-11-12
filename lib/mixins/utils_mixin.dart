import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:molan_edu/models/AdModel.dart';
import 'package:molan_edu/pages/course/course_detail.dart';
import 'package:molan_edu/styles.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';

mixin UtilsMixin<T extends StatefulWidget> on State<T> {
  Future<void> delayed(cb, {Duration duration}) async {
    await Future.delayed(duration ?? Duration.zero, cb);
  }

  /// 弹窗动画
  Widget overlayTransitionsBuilder(_, Animation<double> animation, __, Widget child, {Offset begin}) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin ?? Offset(1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: child,
    );
  }

  /// 登录弹窗
  toLoginPopup() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              NavigatorUtils.pop(context);
            },
            child: Container(width: double.infinity, height: double.infinity, color: Colors.transparent),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 549.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w),
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/common/pic_login.png'),
                  alignment: Alignment.topRight,
                  scale: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('您还没有登录！', style: Styles.normalFont(fontSize: 26.sp)),
                  SizedBox(height: 14.w),
                  Text('请先登录再进行此操作', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                  SizedBox(height: 20.w),
                  GestureDetector(
                    onTap: () {
                      NavigatorUtils.pushNamed(context, '/login');
                    },
                    child: Container(
                      width: 157.w,
                      height: 53.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(53.w),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Text('登录', style: Styles.normalFont(fontSize: 30.sp, color: Colors.white, fontWeight: FontWeight.bold, height: 1.2)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 课程难度弹窗
  courseInfoPopup(BuildContext context, _data) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              NavigatorUtils.pop(context);
            },
            child: Container(width: double.infinity, height: double.infinity, color: Colors.transparent),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 549.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.w).copyWith(bottom: 107.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w),
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/common/pic_learn.png'),
                  alignment: Alignment(0.8, 0.8),
                  scale: 1.8,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_data.courseDifficultyDesc, style: Styles.normalFont(fontSize: 26.sp)),
                  SizedBox(height: 25.w),
                  Text('建议年龄：12岁+', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 列表加载头部
  Widget myCustomHeader() {
    return WaterDropHeader(
      complete: Text("加载完成"),
    );
  }

  /// 列表加载底部
  Widget myCustomFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("上拉加载");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("加载失败！点击重试！");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("松手,加载更多!");
        } else {
          body = Text("没有更多数据了!");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  /// toast
  void showToast(String msg, {int time}) {
    Fluttertoast.showToast(msg: msg, timeInSecForIosWeb: time);
  }

  /// 广告点击事件
  adTapAction(AdModel item) {
    switch (item.advertCateId) {
      case 1:
        NavigatorUtils.pushNamed(context, '/webview', arguments: {'url': item.url});
        break;
      case 2:
        NavigatorUtils.push(context, CourseDetailPage(courseId: item.url));
        break;
      default:
        NavigatorUtils.pushNamed(context, '/webview', arguments: {'url': item.url});
    }
  }
}
