import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/IntroduceModel.dart';
import 'package:molan_edu/pages/home/introduce/video.dart';
import 'package:molan_edu/utils/imports.dart';

class CardIntroduce extends StatefulWidget {
  final IntroduceModel data;
  CardIntroduce({
    Key key,
    this.data,
  }) : super(key: key);

  _CardIntroduceState createState() => _CardIntroduceState();
}

class _CardIntroduceState extends State<CardIntroduce> with UtilsMixin {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context, IntroduceVideoPage(data: data));
      },
      child: Container(
        decoration: Styles.normalDecoration.copyWith(borderRadius: BorderRadius.circular(16.w)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: 394.w,
                  fit: BoxFit.cover,
                  imageUrl: data?.image,
                  placeholder: (context, url) => Image.asset('assets/images/placeholder.png', width: double.infinity, height: 394.w, fit: BoxFit.cover),
                ),
                Positioned(
                  right: 26.w,
                  bottom: 26.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.w),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Text(
                      '${formatNum(data?.visiteNum ?? 0)}人浏览',
                      style: Styles.normalFont(
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
              alignment: Alignment.centerLeft,
              child: Text(
                data?.title ?? '',
                style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
