import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/custom_rating_bar.dart';

class MineHeadMasterPage extends StatefulWidget {
  const MineHeadMasterPage({
    Key key,
  }) : super(key: key);

  @override
  _MineHeadMasterPageState createState() => _MineHeadMasterPageState();
}

class _MineHeadMasterPageState extends State<MineHeadMasterPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
        backgroundColor: Theme.of(context).primaryColor,
        title: '我的班主任',
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 34.w),
          itemCount: 10,
          itemBuilder: (context, index) => _widgetItem(),
        ));
  }

  Widget _widgetItem() {
    return Container(
      width: 690.w,
      height: 265.w,
      margin: EdgeInsets.only(bottom: 14.w),
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      padding: EdgeInsets.all(30.w),
      child: Row(
        children: [
          Container(
            width: 167.w,
            height: 205.w,
            margin: EdgeInsets.only(right: 24.w),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Stack(
              children: [
                Image.asset('assets/images/demo.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0),
                          Color.fromRGBO(0, 0, 0, 1),
                        ],
                      ),
                    ),
                    child: Text(
                      '林云老师',
                      style: Styles.normalFont(fontSize: 24.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold, height: 1.2)),
                    Text('【楷书】', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                  ],
                ),
                SizedBox(height: 22.w),
                Row(
                  children: [
                    Text('微信号：323', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                    SizedBox(width: 36.w),
                    Container(
                      width: 78.w,
                      height: 34.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: Theme.of(context).accentColor),
                      child: Text('复制', style: Styles.normalFont(fontSize: 24.sp, color: Colors.white)),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _popupRate(context);
                        },
                        child: Container(
                          width: 196.w,
                          height: 55.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Text('APP内对话', style: Styles.normalFont(fontSize: 28.sp, color: Colors.white)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 196.w,
                          height: 55.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            border: Border.all(width: 1, color: Styles.colorBlue),
                          ),
                          child: Text('修改评价', style: Styles.normalFont(fontSize: 28.sp, color: Styles.colorBlue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 评价弹窗
  _popupRate(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.w).copyWith(bottom: 50.w + MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('评价班主任', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 22.w),
            Text('滑动星星给出星级评价！', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
            SizedBox(height: 32.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar(
                  icon: Image.asset('assets/images/common/icon_star_border.png', width: 43.w, height: 43.w),
                  size: 43.w,
                  spacing: 7.w,
                  color: Theme.of(context).accentColor,
                  onRatingCallback: (value, i) {},
                ),
                SizedBox(width: 7.w),
                Text('很赞！', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor, height: 1.2)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 64.w, bottom: 39.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(height: 1, color: Color(0xFFF5F5F5)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    color: Colors.white,
                    child: Text('我想对班主任说', style: Styles.normalFont(fontSize: 28.sp)),
                  ),
                  Expanded(
                    child: Container(height: 1, color: Color(0xFFF5F5F5)),
                  ),
                ],
              ),
            ),
            Container(
              width: 690.w,
              height: 153.w,
              color: Color(0xFFF5F5F5),
              padding: EdgeInsets.all(10.w),
              child: TextField(
                maxLength: 30,
                maxLines: 5,
                style: Styles.normalFont(fontSize: 26.sp),
                decoration: InputDecoration(
                  hintText: S.current.inputPlaceholder,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                ),
              ),
            ),
            SizedBox(height: 40.w),
            Container(
              width: 690.w,
              height: 90.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90.w),
                color: Theme.of(context).accentColor,
              ),
              child: Text('提 交', style: Styles.normalFont(fontSize: 30.sp, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
