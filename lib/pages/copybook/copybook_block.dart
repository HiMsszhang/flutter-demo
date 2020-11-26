import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/pages/copybook/copybook_dialog.dart';
import 'package:molan_edu/pages/other/big_image.dart';
import 'package:molan_edu/providers/copybook_state.dart';

class CopybookBlock extends StatefulWidget {
  final double size;
  final Widget child;
  final String word;
  final double cFontSize;
  final double cWidth;
  final double cHeight;
  final String imgUrl;
  final bool hasDetail;

  CopybookBlock({
    this.size,
    this.child,
    this.cFontSize: 20,
    this.cHeight: 88,
    this.cWidth: 88,
    this.word,
    this.imgUrl,
    this.hasDetail = false,
  });

  @override
  _CopybookBlockState createState() => _CopybookBlockState();
}

class _CopybookBlockState extends State<CopybookBlock> {
  CopybookState _config;

  @override
  void initState() {
    super.initState();
    _config = context.read<CopybookState>();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, cons) {
        double width = cons?.constrainWidth();
        return GestureDetector(
          onTap: () {
            if (!widget.hasDetail) {
              return;
            }
            NavigatorUtils.push(
              context,
              BigImgPage(
                imgUrl: widget.imgUrl,
                bg: Stack(
                  alignment: Alignment.center,
                  children: [
                    _widgetBg(),
                    _widgetGrid(),
                  ],
                ),
              ),
            );
          },
          child: Container(
            height: widget.size ?? width,
            width: widget.size ?? width,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Color.fromRGBO(112, 120, 136, 0.3), offset: Offset(0, 6.w), blurRadius: 18.w, spreadRadius: 0)],
              color: Colors.white,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _widgetBg(),
                _widgetGrid(),
                Positioned(
                  left: getSmallLeft(),
                  bottom: getSmallLeft(),
                  child: InkWell(
                    onTap: () => CopybookDialog.show(context, word: widget.word),
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(widget.cWidth),
                      height: ScreenUtil().setWidth(widget.cHeight),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(99, 100, 103, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(widget.cWidth))),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(widget.cWidth),
                        height: ScreenUtil().setWidth(widget.cWidth),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(99, 100, 103, 0.5),
                          border: new Border.all(color: Color.fromRGBO(255, 255, 255, 0.16), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(240)),
                        ),
                        margin: EdgeInsets.all(ScreenUtil().setWidth(6 / _config.getCompose)),
                        child: Text(
                          widget.word,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: widget.cFontSize),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  double getSmallLeft() {
    switch (_config.getCompose) {
      case 1:
        return 20.w;
      case 2:
        return 20.w;
      case 3:
        return 20.w;
      default:
        return 20.w;
    }
  }

  Widget _widgetBg() {
    return Container(
      child: ClipRRect(
        child: AspectRatio(
          aspectRatio: 1,
          child: _config.getPaperType != 'custom'
              ? Image.asset(
                  'assets/images/copybook/background/${_config.getPaperPath}.png',
                  fit: BoxFit.cover,
                )
              : (_config.customPaperPath == null
                  ? Image.asset(
                      'assets/images/copybook/background/custom.png',
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File.fromUri(Uri.file(_config.customPaperPath)),
                    )),
        ),
      ),
    );
  }

  Widget _widgetGrid() {
    var type = _config.getGridType;
    var color = _config.getGridColor;
    print(type);
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        alignment: Alignment.center,
        child: widget.child,
      ),
      Container(
          margin: EdgeInsets.all(0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/copybook/grid/${type}_$color.png'),
              fit: BoxFit.contain,
            ),
          )),
    ]);
  }

  double getBorderMargin() {
    if (_config.getCompose == 1)
      return 30.w;
    else if (_config.getCompose == 2)
      return ScreenUtil().setWidth(20);
    else
      return ScreenUtil().setWidth(15);
  }
}
