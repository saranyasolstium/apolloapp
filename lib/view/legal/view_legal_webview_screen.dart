import 'package:flutter/material.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LegalWebViewScreen extends StatelessWidget {
  final String? myContent;
  final String? fromWhere;

  LegalWebViewScreen({
    Key? key,
    this.myContent, this.fromWhere
  }) : super(key: key);

  final WebViewController _controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    if (myContent == "Privacy Policy") {
      _controller
          .loadRequest(Uri.parse("https://my6senses.com/pages/privacy-policy"));
    } else {
      _controller
          .loadRequest(Uri.parse("https://my6senses.com/pages/term-of-use"));
    }
    return fromWhere == 'login' ? SafeArea(
      child: Scaffold(
        body: WebViewWidget(
            controller: _controller,
          )
      ),
    ) : DefaultAppBarWidget(
        title: myContent,
        child: WebViewWidget(
          controller: _controller,
        ));
  }
}
