import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/widgets/invite_card.dart';
import 'package:molan_edu/widgets/invite_jump_button.dart';

class MineInvitePage extends StatefulWidget {
  MineInvitePage({
    Key key,
  }) : super(key: key);

  @override
  _MineInvitePageState createState() => _MineInvitePageState();
}

class _MineInvitePageState extends State<MineInvitePage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: S.current.myInvitation,
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 4.w),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 690.w,
                height: 348.w,
                decoration: Styles.normalDecoration.copyWith(
                  borderRadius: BorderRadius.circular(16.w),
                  color: Color.fromRGBO(255, 193, 179, 1),
                ),
              ),
            ),
            SizedBox(height: 20.w),
            _widgetMineInvitedPage(),
            SizedBox(height: 20.w),
            _widgetInvited(),
            SizedBox(height: 20.w),
            Container(
              width: 690.w,
              padding: EdgeInsets.only(top: 67.w),
              decoration: Styles.normalDecoration.copyWith(
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(height: 67.w),
                  InviteCard(),
                  JumpButton(),
                  SizedBox(height: 14.w)
                ],
              ),
            ),
            SizedBox(height: 40.w)
          ],
        ),
      ),
    );
  }

  Widget _widgetMineInvitedPage() {
    return Container(
      width: 690.w,
      height: 234.w,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/invite/icon_reward.png"),
                        width: 36.w,
                        height: 34.w,
                      ),
                      SizedBox(width: 17.w),
                      Text(
                        '我的奖励',
                        style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      return NavigatorUtils.pushNamed(context, '/mine.reward.detail');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "明细",
                          style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(102, 102, 102, 1)),
                        ),
                        SizedBox(width: 14.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 28.w,
                          color: Styles.color999999,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.w,
              width: 630.w,
              decoration: Styles.normalDecoration.copyWith(
                borderRadius: BorderRadius.circular(1.w),
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
            Expanded(
              flex: 142,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '300墨币',
                    style: Styles.normalFont(fontSize: 40.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(254, 167, 134, 1)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetInvited() {
    return Container(
      width: 690.w,
      height: 234.w,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/invite/icon_invite.png"),
                        width: 36.w,
                        height: 40.w,
                      ),
                      SizedBox(width: 17.w),
                      Text(
                        '我已邀请.',
                        style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '22人',
                        style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      return NavigatorUtils.pushNamed(context, '/mine.invited');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "查看全部",
                          style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(102, 102, 102, 1)),
                        ),
                        SizedBox(width: 14.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 28.w,
                          color: Styles.color999999,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.w,
              width: 630.w,
              decoration: Styles.normalDecoration.copyWith(
                borderRadius: BorderRadius.circular(1.w),
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
            Expanded(
              flex: 142,
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
            )
          ],
        ),
      ),
    );
  }
}
