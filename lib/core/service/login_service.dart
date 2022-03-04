import 'dart:convert';
import 'dart:io';
import 'package:blog_app_assignment/core/model/sign_model.dart';
import 'package:http/http.dart' as http;
import '../helper/shared_manager.dart';

class LoginService {
  LoginService._();
  static final LoginService _instance = LoginService._();
  static LoginService get instance => _instance;
  final String _api = "test20.internative.net";
  String _token = "";

  Future<bool> login(String email, password) async {
    var url = Uri.http(_api, "/Login/SignIn");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{"Email": email, "Password": password}),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        bool hasError =
            Sign.fromJson(jsonDecode(response.body)).hasError ?? false;
        if (hasError == false) {
          if (Sign.fromJson(jsonDecode(response.body)).data == null) {
            print("sign data yok");
          } else {
            if (Sign.fromJson(jsonDecode(response.body)).data!.token != null) {
              _token = Sign.fromJson(jsonDecode(response.body)).data!.token!;
              await SharedManager.instance.saveString(SharedKeys.TOKEN, _token);

              return true;
            } else {
              print("token boş");
            }
          }
        }
        break;
      case HttpStatus.unauthorized:
        print("unauthorized");
        break;
      default:
        return false;
    }
    return false;
  }

  Future<bool> register(String email, password) async {
    var url = Uri.http(_api, "/Login/SignUp");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "Email": email,
        "Password": password,
        "PasswordRetry": password
      }),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        bool hasError =
            Sign.fromJson(jsonDecode(response.body)).hasError ?? false;
        if (hasError == false) {
          if (Sign.fromJson(jsonDecode(response.body)).data == null) {
            print("sign data yok");
          } else {
            if (Sign.fromJson(jsonDecode(response.body)).data!.token != null) {
              _token = Sign.fromJson(jsonDecode(response.body)).data!.token!;
              await SharedManager.instance.saveString(SharedKeys.TOKEN, _token);

              return true;
            } else {
              print("token boş");
            }
          }
        }
        break;
      case HttpStatus.unauthorized:
        print("unauthorized");
        break;
      default:
        return false;
    }
    return false;
  }
}
