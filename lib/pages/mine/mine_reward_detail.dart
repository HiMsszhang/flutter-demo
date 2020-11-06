import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class MineRewardDetailPage extends StatefulWidget {
  MineRewardDetailPage({Key key}) : super(key: key);

  @override
  _MineRewardDetailPageState createState() => _MineRewardDetailPageState();
}

class _MineRewardDetailPageState extends State<MineRewardDetailPage> with UtilsMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: S.current.rewardDetail,
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 10.w),
          width: 688.w,
          height: 139.w,
          decoration: Styles.normalDecoration.copyWith(
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 31.w, right: 31.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      CommonAvatar(
                        showSex: false,
                        size: 87.w,
                      ),
                      SizedBox(width: 21.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "公爵爸",
                                style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(51, 51, 51, 1)),
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                '09-12邀请成功',
                                style: Styles.normalFont(fontSize: 22.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(153, 153, 153, 1)),
                              )
                            ],
                          ),
                          SizedBox(height: 10.w),
                          Row(
                            children: [
                              Text(
                                "1324",
                                style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(153, 153, 153, 1)),
                              ),
                              Text(
                                "*******",
                                style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(153, 153, 153, 1)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "+300",
                    style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(255, 0, 0, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
