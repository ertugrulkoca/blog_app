import 'user_items.dart';

class Users {
  List<UserItems>? items;

  Users({this.items});

  factory Users.fromJson(Map<String, dynamic> json) {
    var jsonArray = json['items'] as List;
    List<UserItems> itemsList = jsonArray
        .map((jsonArrayObject) => UserItems.fromJson(jsonArrayObject))
        .toList();

    return Users(items: json['items'] != null ? itemsList : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
