import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class EmojiList extends StatefulWidget {
  final bool isEmoji;
  final Function onTap;
  const EmojiList({
    Key key,
    this.isEmoji = false,
    this.onTap,
  }) : super(key: key);

  @override
  _EmojiListState createState() => _EmojiListState();
}

class _EmojiListState extends State<EmojiList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      height: widget.isEmoji ? 400.w : 0,
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("assets/emoji_list.json"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = jsonDecode(snapshot.data.toString());

            return GridView.custom(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 0,
                crossAxisSpacing: 1,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  var item = data[index]['unicode'];
                  return GestureDetector(
                    onTap: () {
                      widget.onTap(String.fromCharCode(item));
                    },
                    child: Center(
                      child: Text(
                        String.fromCharCode(item),
                        style: TextStyle(fontSize: 44.sp),
                      ),
                    ),
                  );
                },
                childCount: data.length,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
