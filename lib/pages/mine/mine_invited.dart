import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/InviteModel.dart';
import 'package:molan_edu/apis/invite.dart';

class MineInvitedPage extends StatefulWidget {
  MineInvitedPage({Key key}) : super(key: key);

  @override
  _MineinvItedPageState createState() => _MineinvItedPageState();
}

class _MineinvItedPageState extends State<MineInvitedPage> with UtilsMixin {
  InvitePeopleListResp _data = new InvitePeopleListResp();
  List<InvitePeopleModel> _dataList = [];
  RefreshController _listController = RefreshController(initialRefresh: true);
  int _page = 1;
  int _listRow = 10;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _load();
    });
  }

  _load() async {
    setState(() {});
  }

  Future<List<InvitePeopleModel>> _getList() async {
    DataResult result = await InviteAPI.inviteList(
      page: _page,
      listRow: _listRow,
    );
    _data = result.data;
    return _data.data;
  }

  void _onRefresh() async {
    _page = 1;
    _dataList = await _getList();
    setState(() {});
    _listController.refreshCompleted();
  }

  void _onLoading() async {
    if (_data.lastPage == _page || _data.lastPage == 0) {
      _listController.loadNoData();
    } else {
      _page++;
      _dataList.addAll(await _getList());
      _listController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: S.current.myInvited,
      backgroundColor: Theme.of(context).primaryColor,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        controller: _listController,
        header: myCustomHeader(),
        footer: myCustomFooter(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
          itemCount: _dataList?.length ?? 0,
          itemBuilder: (context, index) {
            var item = _dataList[index];
            return Container(
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
                            avatar: item?.avatar ?? '',
                          ),
                          SizedBox(width: 21.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item?.name ?? '',
                                style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.w600, color: Color.fromRGBO(51, 51, 51, 1)),
                              ),
                              SizedBox(height: 10.w),
                              Row(
                                children: [
                                  Text(
                                    item?.mobile ?? '',
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
                        item?.createTime ?? '',
                        style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(153, 153, 153, 1)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
