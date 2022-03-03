class Account {
  bool? hasError;
  String? message;
  AccountData? data;

  Account({this.hasError, this.message, this.data});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      hasError: json['HasError'] != null ? json['HasError'] as bool : false,
      message: json['Message'] != null ? json['Message'] as String : "",
      data: json['Data'] != null ? AccountData.fromJson(json['Data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['HasError'] = hasError;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class AccountData {
  String? id;
  String? email;
  String? image;
  Location? location;
  List<String>? favoriteBlogIds;

  AccountData(
      {this.id, this.email, this.image, this.location, this.favoriteBlogIds});

  factory AccountData.fromJson(Map<String, dynamic> json) {
    List<String> FavoriteBlogIdList = [];
    if (json["FavoriteBlogIds"] != null) {
      FavoriteBlogIdList = json['FavoriteBlogIds'].cast<String>();
    }

    return AccountData(
      id: json['Id'] != null ? json['Id'] as String : "",
      email: json['Email'] != null ? json['Email'] as String : "",
      image: json['Image'] != null ? json['Image'] as String : "",
      location:
          json['Location'] != null ? Location.fromJson(json['Location']) : null,
      favoriteBlogIds: FavoriteBlogIdList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = id;
    data['Email'] = email;
    data['Image'] = image;
    if (location != null) {
      data['Location'] = location!.toJson();
    }
    data['FavoriteBlogIds'] = favoriteBlogIds;
    return data;
  }
}

class Location {
  String? longtitude;
  String? latitude;

  Location({this.longtitude, this.latitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longtitude:
          json['Longtitude'] != null ? json['Longtitude'] as String : null,
      latitude: json['Latitude'] != null ? json['Latitude'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Longtitude'] = longtitude;
    data['Latitude'] = latitude;
    return data;
  }
}

class AccountUpdate {
  bool? hasError;
  String? message;

  AccountUpdate({this.hasError, this.message});

  factory AccountUpdate.fromJson(Map<String, dynamic> json) {
    return AccountUpdate(
      hasError: json['HasError'] != null ? json['HasError'] as bool : false,
      message: json['Message'] != null ? json['Message'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['HasError'] = hasError;
    data['Message'] = message;
    return data;
  }
}
