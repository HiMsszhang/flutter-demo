import 'package:flutter/material.dart';
import 'package:molan_edu/apis/copybook.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/CopyBookModel.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/gif_image.dart';

abstract class CopybookDialog {
  static show(BuildContext context, {String word}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CopybookDialogView(
          word: word,
        );
      },
    );
  }
}

class CopybookDialogView extends StatefulWidget {
  final String word;

  CopybookDialogView({Key key, this.word}) : super(key: key);

  _CopybookDialogViewState createState() => _CopybookDialogViewState();
}

class _CopybookDialogViewState extends State<CopybookDialogView> with UtilsMixin, TickerProviderStateMixin {
  CopyBookWordMeaningModel _detail;
  GifController _gifController;

  @override
  void initState() {
    super.initState();
    _gifController = GifController(vsync: this);
    delayed(() async {
      await _getInfo();
    });
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  _getInfo() async {
    DataResult res = await CopybookAPI.meaning(word: widget.word);
    if (!res.result) {
      return;
    }
    CopyBookWordMeaningModel data = res.data;
    _detail = data ?? {};
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 913.h,
          margin: EdgeInsets.only(top: 45.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
            color: Colors.white,
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 90.h, horizontal: 80.w),
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 443.w,
                    height: 443.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/copybook/dict_gif_bg.png"),
                      ),
                    ),
                    child: GifImage(
                      onFetchCompleted: (e) {
                        print(e);
                        _gifController.repeat(min: 0, max: e.toDouble(), period: Duration(milliseconds: e * 100));
                      },
                      width: 443.w,
                      height: 443.w,
                      controller: _gifController,
                      image: NetworkImage(_detail?.image ?? ""),
                    ),
                  )),
              SizedBox(height: 63.h),
              _widgetInfoItem(icon: "tone", title: "拼音", text: _detail?.pinyin.toString().replaceAll('[', "").replaceAll(']', "")),
              SizedBox(height: 27.h),
              _widgetInfoItem(icon: "traditional", title: "繁体", text: _detail?.traditional ?? ""),
              SizedBox(height: 27.h),
              _widgetInfoItem(icon: "radicals", title: "部首", text: _detail?.radical ?? ""),
              SizedBox(height: 27.h),
              _widgetInfoItem(icon: "strokes", title: "笔画", text: _detail?.strokeCount.toString() ?? ""),
            ],
          ),
        ),
        Positioned(
            right: 40.w,
            top: 0,
            child: Container(
              width: 89.w,
              height: 89.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/copybook/dict_bg.png"),
              )),
              alignment: Alignment.center,
              child: Text(_detail?.word ?? "", style: Styles.normalFont(fontSize: 40.sp, color: Colors.white)),
            )),
      ],
    );
  }

  Widget _widgetInfoItem({String icon, String title, String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/copybook/dict_$icon.png",
          width: 40.w,
          height: 40.w,
        ),
        SizedBox(
          width: 22.w,
        ),
        Text("$title：",
            style: Styles.normalFont(
              color: Color(0xFF727C90),
              fontSize: 28.sp,
            )),
        Text(text, style: Styles.normalFont(color: Color(0xFF2F3D57), fontSize: 28.sp, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
