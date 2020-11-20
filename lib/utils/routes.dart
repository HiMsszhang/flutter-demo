import 'package:flutter/material.dart';
import 'package:molan_edu/pages/course/course_search.dart';
import 'package:molan_edu/pages/course/course_detail.dart';
import 'package:molan_edu/pages/course/course_rate.dart';
import 'package:molan_edu/pages/home/group/group.dart';
import 'package:molan_edu/pages/logout.dart';
import 'package:molan_edu/pages/logout_detail.dart';
import 'package:molan_edu/pages/mine/mine_course.dart';
import 'package:molan_edu/pages/mine/mine_favorite.dart';
import 'package:molan_edu/pages/mine/mine_info_edit.dart';
import 'package:molan_edu/pages/mine/mine_headmaster.dart';
import 'package:molan_edu/pages/chat/chat_detail.dart';
import 'package:molan_edu/pages/chat/chat_search.dart';
import 'package:molan_edu/pages/mine/mine_report.dart';
import 'package:molan_edu/pages/mine/mine_report_detail.dart';
import 'package:molan_edu/pages/course/teacher_info.dart';
import 'package:molan_edu/pages/course/teacher_course.dart';
import 'package:molan_edu/pages/course/pay_result.dart';
import 'package:molan_edu/pages/timetable/timetable_list.dart';
import 'package:molan_edu/pages/timetable/timetable_detail.dart';
import 'package:molan_edu/pages/chat/chat_person.dart';
import 'package:molan_edu/pages/home/invite/invite.dart';
import 'package:molan_edu/pages/mine/mine_invite.dart';
import 'package:molan_edu/pages/mine/mine_invited.dart';
import 'package:molan_edu/pages/mine/mine_reward_detail.dart';
import 'package:molan_edu/pages/login.dart';
import 'package:molan_edu/pages/mine/setting.dart';
import 'package:molan_edu/pages/main.dart';
import 'package:molan_edu/pages/guide.dart';
import 'package:molan_edu/pages/other/webview.dart';
import 'package:molan_edu/pages/home/course_experience.dart';
import 'package:molan_edu/pages/home/group/group_list.dart';

class MyRoutes {
  static routes(String name, Map arguments) {
    var route = <String, WidgetBuilder>{
      // 首页
      '/': (context) => MainPage(),
      // 课程搜索
      '/course.search': (context) => CourseSearchPage(),
      // 课程详情
      '/course.detail': (context) => CourseDetailPage(),
      // 课程学员评价
      '/course.rate': (context) => CourseRatePage(),
      // 拼团广场
      '/group': (context) => GroupPage(),
      // 拼团课列表
      '/group.list': (context) => GroupListPage(),
      // 我的课程
      '/mine.course': (context) => MineCoursePage(),
      // 我的收藏
      '/mine.favorite': (context) => MineFavoritePage(),
      // 编辑我的资料
      '/mine.info.edit': (context) => MineInfoEditPage(),
      // 我的班主任
      '/mine.headmaster': (context) => MineHeadMasterPage(),
      // 聊天详情
      '/chat.detail': (context) => ChatDetailPage(),
      // 聊天搜索
      '/chat.search': (context) => ChatSearchPage(),
      // 我的报告
      '/mine.report': (context) => MineReportPage(),
      // 我的报告分析
      '/mine.report.detail': (context) => MineReportDetailPage(),
      // 老师详情
      '/teacher.info': (context) => TeacherInfoPage(),
      // 老师全部课程
      '/teacher.course': (context) => TeacherCoursePage(),
      // 支付结果
      '/pay.result': (context) => PayResultPage(),
      // 课程表-列表
      '/timetable.list': (context) => TimetableListPage(),
      // 课程表-详情
      '/timetable.detail': (context) => TimetableDetailPage(),
      // 单人聊天
      '/chat.person': (context) => ChatPersonPage(),

      //邀请有礼
      '/invite': (context) => InvitePage(),
      //我的邀请
      '/mine.invite': (context) => MineInvitePage(),
      // 我已邀请
      '/mine.invited': (context) => MineInvitedPage(),
      //奖励明细
      '/mine.reward.detail': (context) => MineRewardDetailPage(),
      //登录
      '/login': (context) => LoginPage(),
      //设置
      '/setting': (context) => SettingPage(),
      //引导页
      '/guide': (context) => GuidePage(),
      //webview
      '/webview': (context) => WebviewPage(url: arguments['url']),
      //体验课列表
      '/course.experience': (context) => CourseExperiencePage(),
      //用户注销
      '/user.logout': (context) => UserLogoutPage(),
      //用户注销详情
      '/logout.detail': (context) => LogoutDetailPage(),
    };
    return route[name];
  }
}
