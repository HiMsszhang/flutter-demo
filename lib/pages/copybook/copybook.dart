import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:flutter/rendering.dart';
import 'package:molan_edu/models/CopyBookModel.dart';
import 'package:molan_edu/apis/copybook.dart';
import 'package:molan_edu/providers/copybook_state.dart';
import 'package:molan_edu/pages/copybook/copybook_block.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CopybookPage extends StatefulWidget {
  CopybookPage({
    Key key,
  }) : super(key: key);

  _CopybookPageState createState() => _CopybookPageState();
}

class _CopybookPageState extends State<CopybookPage> with UtilsMixin {
  bool _isFilterShow = false;
  int _selectedIndex = 0;

  RefreshController _courseController = RefreshController(initialRefresh: false);
  CopyBookListResp _bookResp;
  List<CopyBookModel> _bookList;
  int _bookPage = 1;
  int _bookLimit = 10;

  int _fixedCrossAxisCount = 1;
  List<String> _letterItems = [];
  ScrollController _controller = new ScrollController();

  CopybookState _config;

  int _currentPage = 1;
  List<CopyBookWordModel> _wordsList;
  ScrollPosition _currentPosition;
  int _listRow = 15;

  @override
  void initState() {
    super.initState();
    _config = context.read<CopybookState>();
    delayed(() async {
      _bookList = await _getCourseList();
      int currentIndex = 1;
      var currentPage = (currentIndex ~/ _listRow) + 1;
      _currentPage = currentPage;
      _controller.addListener(_scrollListener);
      if (_bookResp.total > 0) await _getWords();
      setState(() {});
    });
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    super.dispose();
  }

  _hideFilter(int index) {
    setState(() {
      _selectedIndex = index;
      _isFilterShow = false;
    });
  }

  Future<List<CopyBookModel>> _getCourseList() async {
    DataResult res = await CopybookAPI.bookList(page: _bookPage, listRow: _bookLimit);
    _bookResp = res.data;
    return _bookResp.data;
  }

  void _onCourseLoading() async {
    if (_bookResp.lastPage == _bookPage || _bookResp.lastPage == 0) {
      _courseController.loadNoData();
    } else {
      _bookPage++;
      _bookList.addAll(await _getCourseList());
      _courseController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  _getWords({bool isLoad = false}) async {
    delayed(() async {
      EasyLoading.show();
      DataResult dataResult = await CopybookAPI.wordList(copybookId: _bookList?.elementAt(_selectedIndex)?.id, fontColor: _config.getFontColor, page: _currentPage, listRow: _listRow);
      if (!isLoad) {
        _wordsList = List.generate(
          _bookList?.elementAt(_selectedIndex)?.wordNum,
          (i) => new CopyBookWordModel(),
        );
        _wordsList.setAll((_currentPage - 1) * _listRow, dataResult.data.data);
      } else {
        _wordsList.setAll((_currentPage - 1) * _listRow, dataResult.data.data);
        _controller.attach(_currentPosition);
      }
      _letterItems.clear();
      _letterItems = List.generate(_wordsList.length, (index) {
        return _wordsList[index].word;
      });
      print(_letterItems);
      if (!isLoad) {
        int selectIndex = 0;
        var h = 750.w;
        if (_fixedCrossAxisCount == 2) h = 187.5.w;
        if (_fixedCrossAxisCount == 3) {
          h = 80.w;
        }
        _controller.animateTo(h * (selectIndex),
            duration: Duration(microseconds: 1),
            curve: Interval(
              0.0,
              0.1,
              curve: Curves.easeIn,
            ));
      }
      setState(() {});
      EasyLoading.dismiss();
    });
  }

  double getWidth() {
    switch (_config.getCompose) {
      case 1:
        return 700.w;
        break;
      case 2:
        return 320.w;
        break;
      case 3:
        return 180.w;
        break;
      default:
        return 700.w;
        break;
    }
  }

  double getGridWidth() {
    switch (_config.getCompose) {
      case 1:
        return 88;
        break;
      case 2:
        return 41.7;
        break;
      case 3:
        return 27;
        break;
      default:
        return 88;
        break;
    }
  }

  void _scrollListener() async {
    var h = 750.w;
    if (_fixedCrossAxisCount == 2) h = 187.5.w;
    if (_fixedCrossAxisCount == 3) {
      h = 80.w;
    }
    var currentIndex = (_controller.offset + h) ~/ h;
    var currentPage = (currentIndex ~/ _listRow) + 1;
    print(currentPage);
    print(currentIndex);
    var direction = _controller.position.userScrollDirection;
    _currentPage = currentPage;
    _currentPosition = _controller.position;
    if (direction == ScrollDirection.reverse && currentIndex == (currentPage - 1) * _listRow && _letterItems[currentIndex] == "-") {
      _controller.detach(_currentPosition);
      await _getWords(isLoad: true);
    } else if (direction == ScrollDirection.forward && currentIndex == currentPage * _listRow - 1 && _letterItems[currentIndex] == "-") {
      _controller.detach(_currentPosition);
      await _getWords(isLoad: true);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      actionTitle: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${_bookList?.elementAt(_selectedIndex)?.copybookTitle ?? ''}', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
            Transform.rotate(
              angle: _isFilterShow ? -(pi / 2) : (pi / 2),
              child: Icon(Icons.play_arrow, size: 34.w, color: Styles.color999999),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            _isFilterShow = !_isFilterShow;
          });
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Styles.colorText,
            size: 33.w,
          ),
          onPressed: () {},
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          GridView.builder(
            controller: _controller,
            physics: ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _fixedCrossAxisCount),
            itemCount: _letterItems.length,
            itemBuilder: (context, index) {
              return Container(
                child: CopybookBlock(
                  cFontSize: (36 / _fixedCrossAxisCount).ssp,
                  cHeight: getGridWidth() * 2.w,
                  cWidth: getGridWidth() * 2.w,
                  word: _letterItems.length <= 0 ? "-" : _letterItems[index],
                  child: CachedNetworkImage(
                    imageUrl: _wordsList[index].image,
                    placeholder: (context, url) => Image.asset("assets/images/placeholder.png"),
                    width: 750.w,
                    height: 750.w,
                  ),
                  imgUrl: _wordsList[index].image ?? "",
                  hasDetail: true,
                ),
              );
            },
          ),
          _isFilterShow
              ? Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      _isFilterShow = false;
                      setState(() {});
                    },
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                )
              : Container(),
          filterOverlay(),
        ],
      ),
    );
  }

  Widget filterOverlay() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.w)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 750.w,
        height: _isFilterShow ? 600.w : 0,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        color: Theme.of(context).primaryColor,
        child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          onLoading: _onCourseLoading,
          controller: _courseController,
          footer: myCustomFooter(),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: Text(_bookList[index]?.copybookTitle ?? '', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666)),
              onPressed: () {
                _hideFilter(index);
              },
            ),
            itemCount: _bookList?.length ?? 0,
          ),
        ),
      ),
    );
  }
}
