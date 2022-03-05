import 'package:dio/dio.dart';
import '../helper/shared_manager.dart';

class ImgService {
  ImgService._();
  static final ImgService _instance = ImgService._();
  static ImgService get instance => _instance;
  final String _api = "test20.internative.net";

  Future<dynamic> uploadImgToApi(filePath) async {
    var url = Uri.http(_api, "/Blog/GetCategories");
    var dioURL = "http://test20.internative.net/General/UploadImage";
    String token =
        await SharedManager.instance.getStringValue(SharedKeys.TOKEN);

    try {
      FormData formData = FormData.fromMap(
          {"image": await MultipartFile.fromFile(filePath, filename: "dp")});
      Response response = await Dio().post(
        dioURL,
        data: formData,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
