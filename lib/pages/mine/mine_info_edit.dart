import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_avatar.dart';

class MineInfoEditPage extends StatefulWidget {
  const MineInfoEditPage({
    Key key,
  }) : super(key: key);

  @override
  _MineInfoEditPageState createState() => _MineInfoEditPageState();
}

class _MineInfoEditPageState extends State<MineInfoEditPage> with UtilsMixin {
  int _sex = 1;

  @override
  void initState() {
    super.initState();
  }

  _onRadioChange(int value) {
    _sex = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
        backgroundColor: Theme.of(context).primaryColor,
        title: '编辑资料',
        body: ListView(
          children: [
            _widgetItem(
              title: '头像',
              actions: [
                CommonAvatar(size: 87.w, showSex: false),
                SizedBox(width: 16.w),
                Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
              ],
            ),
            Container(width: 750.w, height: 5.w, color: Color(0xFFF5F5F5)),
            _widgetItem(
              title: '名字',
              actions: [
                Text('公爵大人', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                SizedBox(width: 16.w),
                Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
              ],
            ),
            _widgetItem(
              title: '性别',
              actions: [
                Radio(value: 1, groupValue: _sex, onChanged: _onRadioChange),
                Text('男', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                Radio(value: 2, groupValue: _sex, onChanged: _onRadioChange),
                Text('女', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
              ],
            ),
            _widgetItem(
              title: '年龄',
              actions: [
                Text('20岁', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                SizedBox(width: 16.w),
                Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
              ],
            ),
          ],
        ));
  }

  Widget _widgetItem({String title, List<Widget> actions, VoidCallback onTap}) {
    return InkWell(
      onTap: onTap ?? null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 30.w),
        child: Row(
          children: [
            Text(title ?? '', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
