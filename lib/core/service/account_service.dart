import 'package:provider/provider.dart';

import '../helper/shared_manager.dart';
import '../model/account_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../model/blog_model.dart';
import '../provider/favorities_provider.dart';
import 'blog_service.dart';

class AccountService {
  AccountService._();
  static final AccountService _instance = AccountService._();
  static AccountService get instance => _instance;
  final String _api = "test20.internative.net";

  Future<AccountData> getAccount() async {
    var url = Uri.http(_api, "/Account/Get");
    String token =
        await SharedManager.instance.getStringValue(SharedKeys.TOKEN);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        if (Account.fromJson(jsonDecode(response.body)).hasError == false) {
          if (Account.fromJson(jsonDecode(response.body)).data != null) {
            AccountData item =
                Account.fromJson(jsonDecode(response.body)).data!;
            print(item.image);
            return item;
          } else {
            print("data boş");
          }
        } else {
          print("has error");
        }
        break;
      case HttpStatus.unauthorized:
        print("unauthorized");
        break;
    }
    return AccountData();
  }

  Future<List<BlogData>> getFavoriBlogs(bool state) async {
    List<BlogData> blogs = await BlogService.instance.getBlogs(null);
    List<String> favList = [];
    List<BlogData> checkFavList = [];
    AccountData accountInfo = await getAccount() as AccountData;
    favList = accountInfo.favoriteBlogIds ?? [];
    if (blogs != null) {
      if (favList != null) {
        for (var i = 0; i < blogs.length; i++) {
          if (favList.contains(blogs[i].id)) {
            checkFavList.add(blogs[i]);
          }
        }
      }
    }
    return checkFavList;
  }

  Future<String> accountUpdate(String image, longtitude, latitude) async {
    var url = Uri.http(_api, "/Account/Update");
    String token =
        await SharedManager.instance.getStringValue(SharedKeys.TOKEN);

    var location = {"Longtitude": longtitude, "Latitude": latitude};
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          <String, dynamic>{"CategoryId": image, "Location": location}),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        if (AccountUpdate.fromJson(jsonDecode(response.body)).hasError ==
            false) {
          if (AccountUpdate.fromJson(jsonDecode(response.body)).message !=
              null) {
            String message =
                AccountUpdate.fromJson(jsonDecode(response.body)).message!;
            return message;
          } else {
            print("data boş");
          }
        } else {
          print("has error");
        }
        break;
      case HttpStatus.unauthorized:
        print("unauthorized");
        break;
    }
    return "";
  }
}
