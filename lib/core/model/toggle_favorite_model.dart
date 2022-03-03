class ToggleFavorite {
  bool? hasError;
  String? message;

  ToggleFavorite({this.hasError, this.message});

  factory ToggleFavorite.fromJson(Map<String, dynamic> json) {
    return ToggleFavorite(
      hasError: json['HasError'] != null ? json['HasError'] as bool : false,
      message: json['Message'] != null ? json['Message'] as String : "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['HasError'] = hasError;
    data['Message'] = message;
    return data;
  }
}
