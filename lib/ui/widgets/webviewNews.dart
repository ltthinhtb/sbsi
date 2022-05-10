import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/stock_data/news_detail.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../services/api/api_service.dart';

class NewsWeb extends StatelessWidget {
  final String title;
  final int id;

  const NewsWeb({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: title,
      ),
      body: FutureBuilder<NewsDetail>(
          future: Get.find<ApiService>().getNewsDetail(id),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: HtmlWidget(
                    snapshot.data?.content ?? "",
                    // render a custom widget
                    customWidgetBuilder: (element) {
                      if (element.attributes['id'] == "ifrmChart0") {
                        return SizedBox(
                          height: 200,
                          child: WebView(
                            initialUrl: element.attributes['src'],
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                        );
                      }

                      if (element.attributes.containsKey("frameborder")) {
                        return SizedBox(
                          height: 200,
                          child: WebView(
                            initialUrl: element.attributes['src'],
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ));
            }
            return const SizedBox(
              child: Text('No data'),
            );
          }),
    );
  }
}
