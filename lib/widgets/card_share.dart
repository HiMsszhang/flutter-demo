import 'package:flutter/material.dart';
import 'package:molan_edu/apis/teacher.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/TeacherModel.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class CardShare extends StatefulWidget {
  final TeacherShareModel data;
  CardShare({
    Key key,
    this.data,
  }) : super(key: key);

  _CardShareState createState() => _CardShareState();
}

class _CardShareState extends State<CardShare> with UtilsMixin {
  bool _isLike = false;
  int _likeNum = 0;

  _likeTap() async {
    DataResult res = await TeacherAPI.likeAction(teacherShareId: widget.data.id);
    if (res.result) {
      if (_isLike) {
        _isLike = false;
        _likeNum--;
        showToast('取消点赞成功');
      } else {
        _isLike = true;
        _likeNum++;
        showToast('点赞成功');
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _isLike = widget.data.isPraise == 1;
    _likeNum = widget.data.praiseNum;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Container(
      width: 750.w,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF5F5F5))),
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 30.w).copyWith(bottom: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonAvatar(size: 72.w, showSex: false, avatar: data?.avatar),
                SizedBox(width: 18.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${data?.teacherName}老师', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12.w),
                    Text(data?.createTime ?? '', style: Styles.normalFont(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Styles.color666666)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.w),
            Text(
              data?.shareTitle ?? '',
              style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, height: 1.5),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20.w),
            Container(
              width: 690.w,
              height: 406.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                imageUrl: data?.image ?? '',
                placeholder: (context, url) => Image.asset('assets/images/placeholder.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 28.w),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/course/icon_share_see.png', width: 38.w, height: 23.w, fit: BoxFit.contain),
                      SizedBox(width: 13.w),
                      Text('${data?.visiteNum ?? 0}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _likeTap();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/course/icon_share_like${_isLike ? "d" : ""}.png', width: 30.w, height: 30.w, fit: BoxFit.contain),
                        SizedBox(width: 13.w),
                        Text('${_likeNum ?? 0}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Image.asset('assets/images/course/icon_share_comment.png', width: 30.w, height: 30.w, fit: BoxFit.contain),
                //       SizedBox(width: 13.w),
                //       Text('888', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
