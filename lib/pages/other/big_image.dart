import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class BigImgPage extends StatefulWidget {
  /// 文字图片
  final String imgUrl;

  /// 背景图片
  final Widget bg;

  BigImgPage({
    this.imgUrl,
    this.bg,
  });

  @override
  _BigImgPageState createState() => _BigImgPageState();
}

class _BigImgPageState extends State<BigImgPage> with UtilsMixin {
  bool _showTool = true;
  int _page = 0;
  List<String> appreciateImages = [];

  @override
  void initState() {
    super.initState();
    delayed(() {
      _init();
      setState(() {});
    });
  }

  void _init() async {
    appreciateImages = [widget.imgUrl];
    print(appreciateImages);
  }

  @override
  Widget build(BuildContext context) {
    int len = appreciateImages.length;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _showTool = !_showTool;
              setState(() {});
            },
            child: Container(
              color: Colors.transparent,
              child: PhotoViewGallery.builder(
                scrollDirection: Axis.horizontal,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext c, int i) {
                  var item = appreciateImages[i];
                  return PhotoViewGalleryPageOptions.customChild(
                    heroAttributes: PhotoViewHeroAttributes(
                      tag: item,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        widget.bg ?? Container(color: Colors.black),
                        CachedNetworkImage(
                          imageUrl: item,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => MyLoading(),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: appreciateImages.length,
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
                pageController: PageController(initialPage: 0),
                //点进去哪页默认就显示哪一页
                onPageChanged: (v) {
                  _page = v;
                  _showTool = true;
                  setState(() {});
                },
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _showTool ? 1 : 0,
            duration: Duration(milliseconds: 150),
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 33.w,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 32.w),
                    child: Text(
                      '${_page + (len > 0 ? 1 : 0)}/$len',
                      style: Styles.normalFont(color: Colors.white, fontSize: 28.sp),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
