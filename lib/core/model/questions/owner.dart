class Owner {
  int? accountId;
  int? userId;
  String? profileImage;
  String? displayName;
  String? link;

  Owner(
      {this.accountId,
      this.userId,
      this.profileImage,
      this.displayName,
      this.link});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
        accountId:
            json['account_id'] != null ? json['account_id'] as int : null,
        userId: json['user_id'] != null ? json['user_id'] as int : null,
        profileImage: json['profile_image'] != null
            ? json['profile_image'] as String
            : null,
        displayName: json['display_name'] != null
            ? json['display_name'] as String
            : null,
        link: json['link'] != null ? json['link'] as String : null);
  }
  // Owner.fromJson(Map<String, dynamic> json) {
  //   accountId = json['account_id'];
  //   userId = json['user_id'];
  //   profileImage = json['profile_image'];
  //   displayName = json['display_name'];
  //   link = json['link'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['account_id'] = accountId;
    data['user_id'] = userId;
    data['profile_image'] = profileImage;
    data['display_name'] = displayName;
    data['link'] = link;
    return data;
  }
}
