import 'items.dart';

class Questions {
  List<Items>? items;

  Questions({this.items});

  // Questions.fromJson(Map<String, dynamic> json) {
  //   if (json['items'] != null) {
  //     items = <Items>[];
  //     json['items'].forEach((v) {
  //       items!.add(Items.fromJson(v));
  //     });
  //   }
  // }

  // factory Questions.fromJson(Map<String, dynamic> json) {
  //   return Questions(items: json["items"] as List<Items>);
  // }

  factory Questions.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["items"] as List;
    List<Items> itemsList = jsonArray
        .map((jsonAraayObject) => Items.fromJson(jsonAraayObject))
        .toList();
    return Questions(items: json['items'] != null ? itemsList : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
