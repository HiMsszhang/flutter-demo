import 'package:flutter/material.dart';
import 'package:molan_edu/apis/timeTable.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/TimeTableModel.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/custom_rating_bar.dart';

class PopupRate extends StatefulWidget {
  final TimeTableMenuDetailModel data;
  final VoidCallback onBack;
  PopupRate({
    Key key,
    this.data,
    this.onBack,
  }) : super(key: key);

  _PopupRateState createState() => _PopupRateState();
}

class _PopupRateState extends State<PopupRate> with UtilsMixin {
  List<Map> labelList = [
    {'title': '老师的仪容仪表', 'rate': 5},
    {'title': '老师的专业素养', 'rate': 5},
    {'title': '课程编排的节奏', 'rate': 5},
    {'title': '总体', 'rate': 5},
  ];
  List<TeacherRateModel> _tagList = [];
  String _content;

  /// 评价选项
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getList();
    });
  }

  _getList() async {
    DataResult result = await TimeTableAPI.teacherRateTags();
    _tagList = result.data;
    setState(() {});
  }

  _onOptionsTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  _submit() async {
    var data = widget.data;
    DataResult result = await TimeTableAPI.rateTeacher(
      teacherId: data.teacherId,
      courseId: data.courseId,
      courseCatalogueId: data.id,
      teacherAppearance: labelList[0]['rate'],
      teacherLiteracy: labelList[1]['rate'],
      curriculumArrangement: labelList[2]['rate'],
      comprehensive: labelList[3]['rate'],
      teacherLabelId: _tagList[_selectedIndex].id,
      content: _content,
    );
    if (result.result) {
      showToast('评价成功');
      widget.onBack();
      NavigatorUtils.pop(context);
    }
  }

  _returnWord(int rate) {
    switch (rate) {
      case 1:
        return '不满意!';
        break;
      case 2:
        return '有待提高!';
        break;
      case 3:
        return '一般!';
        break;
      case 4:
        return '很赞!';
        break;
      case 5:
        return '超棒!';
        break;
      default:
        return '';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 50.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: 750.w,
                padding: EdgeInsets.symmetric(vertical: 30.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 3.w, color: Color(0xFFF5F5F5))),
                ),
                child: Text('本节课评价', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold, height: 1.2)),
              ),
              Align(
                alignment: Alignment(0.95, 0.5),
                child: IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/common/icon_close.png'),
                    size: 26.w,
                    color: Styles.color999999,
                  ),
                  onPressed: () {
                    NavigatorUtils.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          ...List.generate(labelList.length, (index) {
            var item = labelList[index];
            return _widgetRating(
              title: item['title'],
              index: index,
              onRating: (value, i) {
                setState(() {
                  labelList[index]['rate'] = value.toInt();
                });
              },
            );
          }),
          _widgetOptions(),
          Container(
            margin: EdgeInsets.only(top: 39.w, bottom: 39.w, left: 30.w, right: 30.w),
            child: Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: Color(0xFFF5F5F5)),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  color: Colors.white,
                  child: Text('其他想对班主任说的', style: Styles.normalFont(fontSize: 28.sp)),
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
                hintText: '请输入你想说的话(非必填)',
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              ),
              onChanged: (value) {
                setState(() {
                  _content = value;
                });
              },
            ),
          ),
          SizedBox(height: 40.w),
          GestureDetector(
            onTap: _submit,
            child: Container(
              width: 690.w,
              height: 90.w,
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90.w),
                color: Theme.of(context).buttonColor,
              ),
              child: Text('提 交', style: Styles.normalFont(fontSize: 30.sp, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _widgetRating({Function(double, ValueNotifier<bool>) onRating, String title = '', int index}) {
    var rate = labelList[index]['rate'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.w),
      child: Row(
        children: [
          Container(
            width: 200.w,
            child: Text(title, style: Styles.normalFont(fontSize: 28.sp, color: Styles.color666666)),
          ),
          SizedBox(width: 20.w),
          RatingBar(
            icon: Image.asset('assets/images/common/icon_star_border.png', width: 30.w, height: 30.w),
            size: 30.w,
            spacing: 7.w,
            allowHalfRating: false,
            rating: rate.toDouble(),
            color: Theme.of(context).accentColor,
            onRatingCallback: (value, i) {
              onRating(value, i);
            },
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Text('${_returnWord(rate)}', style: Styles.normalFont(fontSize: 28.sp, color: Styles.color666666)),
          ),
        ],
      ),
    );
  }

  Widget _widgetOptions() {
    return Container(
      width: 750.w,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 3.w, color: Color(0xFFF5F5F5))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.w).copyWith(top: 40.w),
      margin: EdgeInsets.only(top: 20.w),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 13.w,
        runSpacing: 20.w,
        children: List.generate(
          _tagList.length ?? 0,
          (index) => InkWell(
            onTap: () {
              _onOptionsTap(index);
            },
            child: Container(
              width: 160.w,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 11.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.w),
                color: _selectedIndex == index ? Theme.of(context).accentColor : Color(0xFFF5F5F5),
              ),
              child: Text(
                _tagList[index].labelTitle ?? '',
                style: Styles.normalFont(fontSize: 26.sp, color: _selectedIndex == index ? Colors.white : Styles.color999999),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
