import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../service/img_service.dart';

class ImageModelPovider extends ChangeNotifier {
  String imgURL = "";
  String getImgUrl() {
    return imgURL;
  }

  void uploadImg(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      var response = await ImgService.instance.uploadImgToApi(pickedFile.path);
      print(response);
    }
  }
}
