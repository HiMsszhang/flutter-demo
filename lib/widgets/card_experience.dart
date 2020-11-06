import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class CardExperience extends StatefulWidget {
  final double width;
  final double height;
  CardExperience({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  _CardExperienceState createState() => _CardExperienceState();
}

class _CardExperienceState extends State<CardExperience> {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Stack(
        children: [
          Container(
            width: widget.width ?? double.infinity,
            height: widget.height ?? double.infinity,
            padding: EdgeInsets.fromLTRB(26.w, 78.w, 180.w, 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home/bg_card.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text('勤礼碑一', style: Styles.specialFont(fontSize: 40.sp, color: Color(0xFFFF7E30))),
                    SizedBox(width: 10.w),
                    Text('楷书', style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFFF7E30))),
                  ],
                ),
                SizedBox(height: 17.w),
                Text(
                  'Win老师手把手教你毛毛毛毛毛',
                  style: Styles.normalFont(fontSize: 28.sp, color: Styles.color999999),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.w),
                    border: Border.all(width: 1, color: Color(0xFFFF7E30)),
                  ),
                  child: Text(
                    '3节课 I 7节课',
                    style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFFF7E30), height: 1.2),
                  ),
                ),
                SizedBox(height: 33.w),
                Text(
                  '4365人学习',
                  style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 320.w,
              height: 50.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Text(
                '7天学会毛笔基本笔法',
                style: Styles.normalFont(fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 26.w,
            child: Image.asset(
              'assets/images/home/pic_learning_girl.png',
              width: 234.w,
              height: 235.w,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
