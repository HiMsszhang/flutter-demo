import 'package:molan_edu/utils/imports.dart';
import 'package:flutter/material.dart';

class InviteCard extends StatelessWidget {
  const InviteCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> _inviteList = [
      {'title': "点击下方\n分享按钮", 'name': "partake", 'icon': 'right'},
      {'title': "分享至微信\n群/好友", 'name': "wechat", 'icon': 'right'},
      {'title': "好友完成\n注册", 'name': "register", 'icon': 'arrow_right'},
      {'title': "礼包自动\n发放", 'name': "gift"}
    ];
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        Container(
          width: 634.w,
          padding: EdgeInsets.only(bottom: 29.w, top: 46.w),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 248, 237, 1),
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _inviteList.length,
                  (index) {
                    var item = _inviteList[index];
                    return InviteIcon(item: item, index: index);
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -29.w,
          child: Container(
            width: 229.w,
            height: 49.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/invite/bg_research.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Center(
              child: Text(
                '邀请攻略',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 31.w,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 70.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) {
                return Container(
                  margin: EdgeInsets.only(left: 60.w, right: 60.w),
                  child: Icon(
                    Icons.arrow_right,
                    size: 40.w,
                    color: Theme.of(context).accentColor,
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class InviteIcon extends StatelessWidget {
  const InviteIcon({
    Key key,
    @required this.item,
    @required this.index,
  }) : super(key: key);

  final Map item;
  final index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(left: 35.w, top: 46.w, right: 32.w, bottom: 20.w),
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45.w),
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Center(
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/invite/icon_${item['name']}.png"), fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.w),
          Text(
            '${index + 1}.${item['title']}',
            textAlign: TextAlign.center,
            style: Styles.normalFont(color: Color.fromRGBO(110, 110, 96, 1), fontSize: 22.w, fontWeight: FontWeight.w300),
            strutStyle: StrutStyle(height: 2.w),
          ),
        ],
      ),
    );
  }
}
