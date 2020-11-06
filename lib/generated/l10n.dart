// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `首页`
  String get home {
    return Intl.message(
      '首页',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `课程`
  String get course {
    return Intl.message(
      '课程',
      name: 'course',
      desc: '',
      args: [],
    );
  }

  /// `课程表`
  String get timetable {
    return Intl.message(
      '课程表',
      name: 'timetable',
      desc: '',
      args: [],
    );
  }

  /// `消息`
  String get message {
    return Intl.message(
      '消息',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `我的`
  String get mine {
    return Intl.message(
      '我的',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `请输入`
  String get inputPlaceholder {
    return Intl.message(
      '请输入',
      name: 'inputPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `电子字帖`
  String get homeNavWriting {
    return Intl.message(
      '电子字帖',
      name: 'homeNavWriting',
      desc: '',
      args: [],
    );
  }

  /// `精选好课`
  String get homeNavCourse {
    return Intl.message(
      '精选好课',
      name: 'homeNavCourse',
      desc: '',
      args: [],
    );
  }

  /// `拼团课`
  String get homeNavGroup {
    return Intl.message(
      '拼团课',
      name: 'homeNavGroup',
      desc: '',
      args: [],
    );
  }

  /// `邀请有礼`
  String get homeNavInvite {
    return Intl.message(
      '邀请有礼',
      name: 'homeNavInvite',
      desc: '',
      args: [],
    );
  }

  /// `了解墨岚`
  String get homeKnow {
    return Intl.message(
      '了解墨岚',
      name: 'homeKnow',
      desc: '',
      args: [],
    );
  }

  /// `最新课程`
  String get homeNewCourse {
    return Intl.message(
      '最新课程',
      name: 'homeNewCourse',
      desc: '',
      args: [],
    );
  }

  /// `搜索课程名称`
  String get searchCourse {
    return Intl.message(
      '搜索课程名称',
      name: 'searchCourse',
      desc: '',
      args: [],
    );
  }

  /// `拼团广场`
  String get groupTitle {
    return Intl.message(
      '拼团广场',
      name: 'groupTitle',
      desc: '',
      args: [],
    );
  }

  /// `{name}课时`
  String numberCourse(Object name) {
    return Intl.message(
      '$name课时',
      name: 'numberCourse',
      desc: '',
      args: [name],
    );
  }

  /// `立即报名`
  String get signNow {
    return Intl.message(
      '立即报名',
      name: 'signNow',
      desc: '',
      args: [],
    );
  }

  /// `我们的承诺`
  String get wePromise {
    return Intl.message(
      '我们的承诺',
      name: 'wePromise',
      desc: '',
      args: [],
    );
  }

  /// `VIP模式`
  String get vipMode {
    return Intl.message(
      'VIP模式',
      name: 'vipMode',
      desc: '',
      args: [],
    );
  }

  /// `搜索`
  String get search {
    return Intl.message(
      '搜索',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `我的主页`
  String get mineTitle {
    return Intl.message(
      '我的主页',
      name: 'mineTitle',
      desc: '',
      args: [],
    );
  }

  /// `体验课`
  String get experienceCourse {
    return Intl.message(
      '体验课',
      name: 'experienceCourse',
      desc: '',
      args: [],
    );
  }

  /// `拼团课`
  String get groupCourse {
    return Intl.message(
      '拼团课',
      name: 'groupCourse',
      desc: '',
      args: [],
    );
  }

  /// `查看更多`
  String get seeMore {
    return Intl.message(
      '查看更多',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `相关推荐`
  String get recommend {
    return Intl.message(
      '相关推荐',
      name: 'recommend',
      desc: '',
      args: [],
    );
  }

  /// `我的邀请`
  String get myInvitation {
    return Intl.message(
      '我的邀请',
      name: 'myInvitation',
      desc: '',
      args: [],
    );
  }

  /// `我已邀请`
  String get myInvited {
    return Intl.message(
      '我已邀请',
      name: 'myInvited',
      desc: '',
      args: [],
    );
  }

  /// `奖励明细`
  String get rewardDetail {
    return Intl.message(
      '奖励明细',
      name: 'rewardDetail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}