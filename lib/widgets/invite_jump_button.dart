import 'package:molan_edu/utils/imports.dart';
import 'package:flutter/material.dart';

class JumpButton extends StatefulWidget {
  final ValueChanged<int> onTap;
  const JumpButton({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  _JumpButtonState createState() => _JumpButtonState();
}

class _JumpButtonState extends State<JumpButton> {
  @override
  Widget build(BuildContext context) {
    List<Map> _buttonDescription = [
      {'title': '立即邀请微信好友', 'name': 'invite_wechat'},
      {'title': '立即分享到朋友圈', 'name': 'invite_moment'},
    ];
    return Container(
      margin: EdgeInsets.only(top: 40.w),
      child: Column(
        children: List.generate(
          _buttonDescription.length,
          (index) {
            var item = _buttonDescription[index];
            return Container(
              margin: EdgeInsets.only(bottom: 26.w),
              width: 649.w,
              height: 100.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/invite/bg_partake.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(100.w),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      child: Center(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 49.w,
                                height: 49.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/invite/icon_${item['name']}.png')),
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                "${item['title']}",
                                style: TextStyle(fontSize: 36.w, color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        widget.onTap(index);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
