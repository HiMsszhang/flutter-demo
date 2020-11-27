import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:molan_edu/utils/local_storage.dart';
import 'package:molan_edu/widgets/my_pagination.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({
    Key key,
  }) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> with UtilsMixin {
  List<Map> _list = [
    {'title': ' 疑问不残留', 'info': '秉承即学即问即解答的教学宗旨'},
    {'title': ' 骨灰级讲师', 'info': '斥巨资聘请全国顶级书法家教学'},
    {'title': ' 出品精品课', 'info': '专业课程研发团队把控教学质量'},
    {'title': ' 陪伴型讲师', 'info': '亦师亦友时刻关注学员成长变化'},
  ];

  @override
  void initState() {
    super.initState();
  }

  _launch() async {
    await LocalStorage.setJSON(Config.S_FIRST, 1);
    NavigatorUtils.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Text('跳过', style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFBBBBBB))),
        onPressed: _launch,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: 750.w,
          height: 1334.h,
          child: Swiper(
            itemCount: _list.length,
            loop: false,
            pagination: new SwiperCustomPagination(
              builder: (context, config) => MyPagination(
                length: _list.length,
                config: config,
                alignment: Alignment(0, 0.9),
              ),
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = _list[index];
              return Column(
                children: [
                  SizedBox(height: 200.h),
                  Image.asset('assets/images/common/guide_${index + 1}.png', width: 711.w, height: 711.w, fit: BoxFit.contain),
                  SizedBox(height: 30.h),
                  Text('${item['title']}', style: Styles.normalFont(fontSize: 50.sp, color: Color(0xFFFFA06B), fontWeight: FontWeight.bold)),
                  SizedBox(height: 36.h),
                  Text('${item['info']}', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color999999)),
                  SizedBox(height: 50.h),
                  index == _list.length - 1
                      ? GestureDetector(
                          onTap: _launch,
                          child: Container(
                            width: 289.w,
                            height: 80.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.w),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFC0A3),
                                  Color(0xFFFFABA4),
                                ],
                              ),
                            ),
                            child: Text('立即体验', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white)),
                          ),
                        )
                      : Container(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
