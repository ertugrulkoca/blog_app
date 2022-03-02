class UserItems {
  int? accountId;
  int? userId;
  String? aboutMe;
  String? link;
  String? profileImage;
  String? displayName;

  UserItems(
      {this.accountId,
      this.userId,
      this.aboutMe,
      this.link,
      this.profileImage,
      this.displayName});

  factory UserItems.fromJson(Map<String, dynamic> json) {
    return UserItems(
      accountId: json['account_id'] != null ? json['account_id'] as int : null,
      userId: json['user_id'] != null ? json['user_id'] as int : null,
      aboutMe: json['about_me'] != null ? json['about_me'] as String : null,
      link: json['link'] != null ? json['link'] as String : null,
      profileImage: json['profile_image'] != null
          ? json['profile_image'] as String
          : null,
      displayName:
          json['display_name'] != null ? json['display_name'] as String : null,
    );
    // accountId = json['account_id'];
    // userId = json['user_id'];
    // aboutMe = json['about_me'];
    // link = json['link'];
    // profileImage = json['profile_image'];
    // displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['account_id'] = accountId;
    data['user_id'] = userId;
    data['about_me'] = aboutMe;
    data['link'] = link;
    data['profile_image'] = profileImage;
    data['display_name'] = displayName;
    return data;
  }
}
