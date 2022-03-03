import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../helper/shared_manager.dart';
import '../model/blog_category_model.dart';
import '../model/blog_model.dart';
import '../model/toggle_favorite_model.dart';

class BlogService {
  BlogService._();
  static final BlogService _instance = BlogService._();
  static BlogService get instance => _instance;
  final String _api = "test20.internative.net";

  Future<List<BlogCategoryData>> getCategories() async {
    var url = Uri.http(_api, "/Blog/GetCategories");
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
        bool hasError =
            BlogCategory.fromJson(jsonDecode(response.body)).hasError ?? false;
        if (hasError == false) {
          if (BlogCategory.fromJson(jsonDecode(response.body)).data != null) {
            List<BlogCategoryData> items =
                BlogCategory.fromJson(jsonDecode(response.body)).data!;
            for (var item in items) {
              print(item);
            }
            return items;
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
      default:
        return [];
    }

    return [];
  }

  Future<List<BlogData>> getBlogs(String? id) async {
    var url = Uri.http(_api, "/Blog/GetBlogs");
    String token =
        await SharedManager.instance.getStringValue(SharedKeys.TOKEN);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{"CategoryId": id ?? null}),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        bool hasError =
            Blogs.fromJson(jsonDecode(response.body)).hasError ?? false;
        if (hasError == false) {
          if (Blogs.fromJson(jsonDecode(response.body)).data != null) {
            List<BlogData> items =
                Blogs.fromJson(jsonDecode(response.body)).data!;
            for (var item in items) {
              print(item);
            }
            return items;
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
      default:
        return [];
    }

    return [];
  }

  Future<String> toggleFavorite(String id) async {
    var url = Uri.http(_api, "/Blog/ToggleFavorite");
    String token =
        await SharedManager.instance.getStringValue(SharedKeys.TOKEN);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{"Id": id}),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        if (ToggleFavorite.fromJson(jsonDecode(response.body)).hasError ==
            false) {
          if (ToggleFavorite.fromJson(jsonDecode(response.body)).message !=
              null) {
            String mesaj =
                ToggleFavorite.fromJson(jsonDecode(response.body)).message!;
            print(mesaj);
            return mesaj;
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
      default:
        return "";
    }
    return "";
  }
}
