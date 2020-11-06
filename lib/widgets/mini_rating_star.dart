import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/custom_rating_bar.dart';

class MiniRatingStar extends StatefulWidget {
  final double rating;
  final Widget icon;
  final Color color;

  /// 是否隐藏背景星星
  final bool showAllStar;
  MiniRatingStar({
    Key key,
    this.rating,
    this.icon,
    this.color,
    this.showAllStar = true,
  }) : super(key: key);

  _MiniRatingStarState createState() => _MiniRatingStarState();
}

class _MiniRatingStarState extends State<MiniRatingStar> {
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      icon: widget.icon ?? Image.asset('assets/images/common/icon_star_border.png', width: 22.w, height: 22.w),
      size: 22.w,
      spacing: 3.w,
      rating: widget.rating,
      color: widget.color ?? Theme.of(context).accentColor,
      allowHalfRating: true,
      isIndicator: true,
      showAllStar: widget.showAllStar,
    );
  }
}
