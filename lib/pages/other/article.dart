import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:flutter_html/flutter_html.dart';

class ArticlePage extends StatefulWidget {
  final String title;
  final String content;
  const ArticlePage({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: widget.title ?? '',
      backgroundColor: Theme.of(context).primaryColor,
      body: Html(data: widget.content),
    );
  }
}
