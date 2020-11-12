import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String url;
  const WebviewPage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> with UtilsMixin {
  WebViewController _controller;
  String _title = "webview";
  @override
  void initState() {
    super.initState();
    print(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: _title,
      backgroundColor: Theme.of(context).primaryColor,
      body: WebView(
        initialUrl: widget.url ?? '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          _controller.evaluateJavascript("document.title").then((result) {
            print(result);
            setState(() {
              _title = result.replaceAll("\"", "");
            });
          });
        },
      ),
    );
  }
}
