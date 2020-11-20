import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:molan_edu/styles.dart';

class ScaffoldWithAppbar extends StatelessWidget {
  final String title;
  final Widget actionWidget;
  final Widget actionTitle;
  final TextStyle actionStyle;
  final bool hideBack;
  final List<Widget> actions;
  final Widget body;
  final Widget bottomNavigationBar;
  final VoidCallback onBack;
  final Widget floatingActionButton;
  final Color backgroundColor;
  final bool showBorder;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  ScaffoldWithAppbar({
    Key key,
    this.body,
    this.title,
    this.actionTitle,
    this.actionStyle,
    this.actionWidget,
    this.actions,
    this.hideBack = false,
    this.bottomNavigationBar,
    this.onBack,
    this.floatingActionButton,
    this.backgroundColor = Colors.transparent,
    this.showBorder = true,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: this.resizeToAvoidBottomInset,
      backgroundColor: this.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        shape: Border(
          bottom: BorderSide(width: 0.5, color: showBorder ? Styles.colorBorder : Colors.transparent),
        ),
        backgroundColor: Colors.transparent,
        title: actionTitle ?? Text(title, style: Styles.normalFont(fontSize: 36.sp)),
        leading: Offstage(
          offstage: hideBack,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 33.w,
              color: Styles.colorText,
            ),
            onPressed: () {
              if (onBack != null) {
                onBack();
                return;
              }
              Navigator.pop(context);
            },
          ),
        ),
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
