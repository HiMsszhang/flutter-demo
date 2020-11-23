import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/models/InviteModel.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/widgets/invite_card.dart';
import 'package:molan_edu/widgets/invite_jump_button.dart';
import 'package:molan_edu/widgets/invite_share.dart';
import 'package:molan_edu/apis/invite.dart';

class MineInvitePage extends StatefulWidget {
  MineInvitePage({
    Key key,
  }) : super(key: key);

  @override
  _MineInvitePageState createState() => _MineInvitePageState();
}

class _MineInvitePageState extends State<MineInvitePage> with UtilsMixin {
  MyInviteModel _data;
  bool _loadFlag = false;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      DataResult res = await InviteAPI.myInvite();
      _data = res.data;
      _loadFlag = true;
      setState(() {});
    });
  }

  _buildShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InviteShare();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: S.current.myInvitation,
      showBorder: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: _loadFlag
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 4.w),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 690.w,
                      height: 348.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: Styles.normalDecoration.copyWith(
                        borderRadius: BorderRadius.circular(16.w),
                        color: Color.fromRGBO(255, 193, 179, 1),
                      ),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: _data?.inviteImg ?? '',
                        placeholder: (context, url) => Image.asset('assets/images/placeholder.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
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
                        JumpButton(
                          onTap: (value) {
                            _buildShowDialog(context);
                          },
                        ),
                        SizedBox(height: 14.w)
                      ],
                    ),
                  ),
                  SizedBox(height: 40.w)
                ],
              ),
            )
          : MyLoading(),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 28.w),
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
                          style: Styles.normalFont(fontSize: 28.sp, color: Color.fromRGBO(102, 102, 102, 1)),
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
              height: 1,
              width: 630.w,
              color: Color.fromRGBO(245, 245, 245, 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 48.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_data?.totalMoMoney ?? 0}墨币',
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
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 19.w),
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
                        '${_data?.totalInviteNum ?? 0}人',
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
                          style: Styles.normalFont(fontSize: 28.sp, color: Color.fromRGBO(102, 102, 102, 1)),
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
              height: 1,
              width: 630.w,
              color: _data?.invite?.length == 0 ? Colors.transparent : Color.fromRGBO(245, 245, 245, 1),
            ),
            _data?.invite?.length == 0
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 28.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CommonAvatar(
                                showSex: false,
                                size: 87.w,
                                avatar: _data?.invite[0]?.avatar ?? '',
                              ),
                              SizedBox(width: 21.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _data?.invite[0]?.name ?? '',
                                    style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(51, 51, 51, 1)),
                                  ),
                                  SizedBox(height: 10.w),
                                  Row(
                                    children: [
                                      Text(
                                        _data?.invite[0]?.mobile ?? '',
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
                            _data?.invite[0]?.createTime ?? '',
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
