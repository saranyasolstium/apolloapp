import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlTextView extends StatelessWidget {
  final String htmlContent;

  const HtmlTextView({Key? key, required this.htmlContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Html(
        data: htmlContent,
        style: {
          "html": Style(
            fontSize: FontSize.medium,
            color: Colors.black,
          ),
        },
      ),
    );
  }
}
