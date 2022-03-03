class Sign {
  bool? hasError;
  String? message;
  Data? data;

  Sign({this.hasError, this.message, this.data});

  factory Sign.fromJson(Map<String, dynamic> json) {
    return Sign(
      hasError: json['HasError'] != null ? json['HasError'] as bool : false,
      message: json['Message'] != null ? json['Message'] as String : "false",
      data: json['Data'] != null ? Data.fromJson(json['Data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HasError'] = this.hasError;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(token: json['Token'] != null ? json['Token'] as String : "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    return data;
  }
}
