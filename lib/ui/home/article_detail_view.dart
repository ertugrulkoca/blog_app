import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/model/blog_model.dart';
import '../components/ui_components.dart';

class ArtivleView extends StatefulWidget {
  BlogData article;
  ArtivleView(this.article) : super();
  @override
  State<ArtivleView> createState() => _ArtivleViewState();
}

class _ArtivleViewState extends State<ArtivleView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "Home"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: size.height,
            width: double.infinity,
            child: Column(
              children: [
                Text(widget.article.title ?? "",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(parseHtmlString(widget.article.content!),
                    style: const TextStyle(fontSize: 16))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buttomBar(context, 1),
    );
  }

  //  metnin html etiketlerinden arındırılma işlemi.
  String parseHtmlString(String htmlString) {
    String parsedHtml = Bidi.stripHtmlIfNeeded(htmlString);
    return parsedHtml;
  }
}
