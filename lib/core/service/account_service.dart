import 'package:geolocator/geolocator.dart';
import '../helper/shared_manager.dart';
import '../model/account_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../model/blog_model.dart';
import 'blog_service.dart';

class AccountService {
  AccountService._();
  static final AccountService _instance = AccountService._();
  static AccountService get instance => _instance;
  final String _api = "test20.internative.net";

  Future<AccountData> getAccount() async {
    var url = Uri.http(_api, "/Account/Get");

    // kaydedilen tokene erişim
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
            // data null değilse json verisinin pars edilme işlemi.
            AccountData item =
                Account.fromJson(jsonDecode(response.body)).data!;
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
    //önce bütün bloglar çekilir
    List<BlogData> blogs = await BlogService.instance.getBlogs(null);
    // apiden gelecek olan favori listesi için dizi.
    List<String> favList = [];
    // kontrol için dizi
    List<BlogData> checkFavList = [];
    //kullanıcının verileri çekilir ve favListeye favorileri atılır.
    AccountData accountInfo = await getAccount() as AccountData;
    favList = accountInfo.favoriteBlogIds ?? [];
    // blog ve favList boş değilse, contains fonksiyonuyla eşleşenler kontrol edilip checkFavListe atılır.
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

  Future<String> accountUpdate(String image, latitude, longtitude) async {
    var url = Uri.http(_api, "/Account/Update");

    // kaydedilen tokene erişim
    String token =
        await SharedManager.instance.getStringValue(SharedKeys.TOKEN);

    // enlom boylam bilgisi
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
            // data null değilse json verisinin pars edilme işlemi.
            String message =
                AccountUpdate.fromJson(jsonDecode(response.body)).message!;
            return message;
          } else {
            return "data is empty";
          }
        } else {
          return "has error";
        }
      case HttpStatus.unauthorized:
        return "unauthorized";
    }
    return "";
  }

  Future<List<String>> getLocation() async {
    // enlem ve boylam için liste.
    List<String> latLng = [];
    //kullanıcı datası çekilir.
    AccountData data = await getAccount();
    if (data.location != null) {
      // kullanıcı daha önce lokasyon eklemediyse veri "string" olarak döner.
      if (data.location!.latitude == "string" ||
          data.location!.longtitude == "string") {
        // cihazın o anki konumu alınır.
        var gps = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        // enlem ve boylam bilgisi listeye atılır.
        latLng.add(gps.latitude.toString());
        latLng.add(gps.longitude.toString());
      } else {
        // apiden gelen enlem ve boylam bilgileri listeye atılır.
        latLng.add(data.location!.latitude!);
        latLng.add(data.location!.longtitude!);
      }
    }
    // güncel bilgiler apiye atılır
    await accountUpdate("string", latLng[0], latLng[1]);

    return latLng;
  }
}
