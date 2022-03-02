import 'package:intl/intl.dart';

class UiHepler {
  static final UiHepler _instance = UiHepler._private();
  UiHepler._private();
  static UiHepler get instance => _instance;
  List<String?> convertTags(List<String?> list) {
    List<String?> x = [];
    for (var i = 0; i < list.length; i++) {
      x.add("#" + list[i]!);
    }

    return x;
  }

  String parseHtmlString(String htmlString) {
    String parsedHtml = Bidi.stripHtmlIfNeeded(htmlString);
    return parsedHtml;
  }
}
