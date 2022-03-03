class Blogs {
  bool? hasError;
  String? message;
  List<BlogData>? data;

  Blogs({this.hasError, this.message, this.data});

  factory Blogs.fromJson(Map<String, dynamic> json) {
    List<BlogData> dataList = [];
    if (json["Data"] != null) {
      var dataArray = json["Data"] as List;
      dataList = dataArray.map((e) => BlogData.fromJson(e)).toList();
    }

    return Blogs(
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

class BlogData {
  String? title;
  String? content;
  String? image;
  String? categoryId;
  String? id;

  BlogData({this.title, this.content, this.image, this.categoryId, this.id});

  factory BlogData.fromJson(Map<String, dynamic> json) {
    return BlogData(
      title: json['Title'] != null ? json['Title'] as String : "",
      content: json['Content'] != null ? json['Content'] as String : "",
      image: json['Image'] != null ? json['Image'] as String : "",
      categoryId:
          json['CategoryId'] != null ? json['CategoryId'] as String : "",
      id: json['Id'] != null ? json['Id'] as String : "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Title'] = title;
    data['Content'] = content;
    data['Image'] = image;
    data['CategoryId'] = categoryId;
    data['Id'] = id;
    return data;
  }
}
