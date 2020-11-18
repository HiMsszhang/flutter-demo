import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_experience.dart';
import 'package:molan_edu/models/GroupModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:molan_edu/widgets/card_group.dart';
import 'package:molan_edu/widgets/my_pagination.dart';
import 'package:molan_edu/apis/common.dart';
import 'package:molan_edu/apis/group.dart';
import 'package:molan_edu/models/AdModel.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({
    Key key,
  }) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> with UtilsMixin {
  List<ExperienceModel> _experienceList = [];
  List<GroupCourseModel> _groupList = [];
  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getExperienceList();
      await _getGroupList();
      setState(() {});
    });
  }

  Future<List<AdModel>> _getAdList() async {
    DataResult res = await CommonAPI.adList(advertCateId: 2);
    return res.data;
  }

  _getExperienceList() async {
    DataResult res = await GroupAPI.getExperienceList(page: 1, listRow: 4);
    _experienceList = res.data.data;
  }

  _getGroupList() async {
    DataResult res = await GroupAPI.groupCourseList(page: 1, listRow: 4);
    _groupList = res.data.data;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: S.current.groupTitle,
      backgroundColor: Theme.of(context).primaryColor,
      showBorder: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _widgetBanner(),
            _widgetTitle(title: S.current.experienceCourse, color: Color(0xFFCBB0FF)),
            _widgetExperience(),
            _widgetTitle(
              title: S.current.groupCourse,
              color: Color(0xFFFFC292),
              showMore: true,
              onTap: () {
                NavigatorUtils.pushNamed(context, '/group.list');
              },
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _groupList.length ?? 0,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: 20.w),
                child: CardGroup(
                  width: 690.w,
                  height: 338.w,
                  data: _groupList[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetBanner() {
    return Container(
      width: 750.w,
      height: 380.w,
      child: FutureBuilder(
        future: _getAdList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<AdModel> list = snapshot.data;
            return Swiper(
              itemCount: list?.length ?? 0,
              pagination: new SwiperCustomPagination(
                builder: (context, config) => MyPagination(
                  length: list?.length ?? 0,
                  config: config,
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                var item = list[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w).copyWith(bottom: 30.w, top: 20.w),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(192, 192, 192, 0.27),
                        blurRadius: 54.w,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      adTapAction(item);
                    },
                    child: CachedNetworkImage(
                      imageUrl: item.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        "assets/images/placeholder.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Image.asset(
              "assets/images/placeholder.png",
              fit: BoxFit.cover,
            );
          }
        },
      ),
    );
  }

  Widget _widgetTitle({String title, Color color, bool showMore = false, VoidCallback onTap}) {
    return Stack(
      children: [
        Positioned(
          left: 30.w,
          bottom: 30.w,
          child: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.49),
              borderRadius: BorderRadius.circular(38.w),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 30.w),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title ?? "",
                  style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorText, fontWeight: FontWeight.bold),
                ),
              ),
              Offstage(
                offstage: !showMore,
                child: GestureDetector(
                  onTap: onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.current.seeMore,
                        style: Styles.normalFont(fontSize: 26.sp, color: Styles.color999999),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 28.w,
                        color: Styles.color999999,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _widgetExperience() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 750.w,
            height: 308.w,
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: _experienceList?.length ?? 0,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: CardExperience(
                  width: 513.w,
                  height: 308.w,
                  data: _experienceList[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
