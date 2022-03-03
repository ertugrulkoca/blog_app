class BlogCategory {
  bool? hasError;
  String? message;
  List<BlogCategoryData>? data;

  BlogCategory({this.hasError, this.message, this.data});

  factory BlogCategory.fromJson(Map<String, dynamic> json) {
    List<BlogCategoryData> dataList = [];
    if (json["Data"] != null) {
      var dataArray = json["Data"] as List;
      dataList = dataArray.map((e) => BlogCategoryData.fromJson(e)).toList();
    }

    return BlogCategory(
      hasError: json['HasError'] != null ? json['HasError'] as bool : false,
      message: json['Message'] != null ? json['Message'] as String : "false",
      data: json['Data'] != null ? dataList : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['HasError'] = hasError;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlogCategoryData {
  String? title;
  String? image;
  String? id;

  BlogCategoryData({this.title, this.image, this.id});

  factory BlogCategoryData.fromJson(Map<String, dynamic> json) {
    return BlogCategoryData(
      title: json['Title'] != null ? json['Title'] as String : "",
      image: json['Image'] != null ? json['Image'] as String : "",
      id: json['Id'] != null ? json['Id'] as String : "false",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Title'] = title;
    data['Image'] = image;
    data['Id'] = id;
    return data;
  }
}
