import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class MineInvitedPage extends StatefulWidget {
  MineInvitedPage({Key key}) : super(key: key);

  @override
  _MineinvItedPageState createState() => _MineinvItedPageState();
}

class _MineinvItedPageState extends State<MineInvitedPage> with UtilsMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: S.current.myInvited,
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 10.w),
          width: 690.w,
          height: 144.w,
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
                          Text(
                            "公爵爸",
                            style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(51, 51, 51, 1)),
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
                    "09-12",
                    style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(153, 153, 153, 1)),
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
