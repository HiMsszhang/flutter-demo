import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/apis/user.dart';
import 'package:molan_edu/apis/common.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class MineInfoEditPage extends StatefulWidget {
  const MineInfoEditPage({
    Key key,
  }) : super(key: key);

  @override
  _MineInfoEditPageState createState() => _MineInfoEditPageState();
}

class _MineInfoEditPageState extends State<MineInfoEditPage> with UtilsMixin {
  int _sex = 1;
  UserModel _user;
  TextEditingController _nameController;
  int _age;

  @override
  void initState() {
    super.initState();
    _user = context.read<UserState>().userInfo;
    _sex = _user.gender;
    _nameController = TextEditingController(text: _user.name);
    _age = _user.age;
    setState(() {});
  }

  _onRadioChange(int value) async {
    await _submit(gender: value);
    _sex = value;
    setState(() {});
  }

  _submit({String name, String avatar, int gender, int age}) async {
    DataResult res = await UserAPI.editUserInfo(name: name, avatar: avatar, gender: gender, age: age);
    _user = res.data;
    await context.read<UserState>().updateUser(_user);
    setState(() {});
    showToast('修改成功');
  }

  _showAvatarPicker() {
    showMaterialFilePicker(
      context: context,
      fileType: FileType.image,
      onChanged: (file) async {
        print(file.path);
        var res = await CommonAPI.upload(path: file.path);
        print(res.data);
        await _submit(avatar: res.data['link']);
      },
    );
  }

  _showNameInput() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
          onSubmitted: (value) async {
            await _submit(name: value);
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('确定'),
            onPressed: () async {
              await _submit(name: _nameController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _showAgeInput() {
    showMaterialNumberPicker(
      context: context,
      title: '',
      buttonTextColor: Theme.of(context).accentColor,
      backgroundColor: Theme.of(context).primaryColor,
      maxShortSide: 10,
      minNumber: 1,
      maxNumber: 150,
      selectedNumber: _user.age,
      onChanged: (value) {
        setState(() {
          _age = value;
        });
      },
      onConfirmed: () async {
        await _submit(age: _age);
      },
    );
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
                CommonAvatar(size: 87.w, showSex: false, avatar: _user.avatar, sex: _user.gender),
                SizedBox(width: 16.w),
                Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
              ],
              onTap: _showAvatarPicker,
            ),
            Container(width: 750.w, height: 5.w, color: Color(0xFFF5F5F5)),
            _widgetItem(
              title: '名字',
              actions: [
                Text(_user.name ?? '', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                SizedBox(width: 16.w),
                Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
              ],
              onTap: _showNameInput,
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
                Text('${_user.age}岁', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                SizedBox(width: 16.w),
                Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
              ],
              onTap: _showAgeInput,
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
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFF5F5F5))),
        ),
        child: Row(
          children: [
            Text(title ?? '', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.w500)),
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
