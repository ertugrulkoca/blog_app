import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../service/img_service.dart';

class ImageModelPovider extends ChangeNotifier {
  String imgURL = "";
  String getImgUrl() {
    return imgURL;
  }

  void uploadImg(ImageSource imageSource) async {
    print("uploadImg $imageSource");
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("picked file nul değil ${pickedFile.path}");
      var response = await ImgService.instance.uploadImgToApi(pickedFile.path);
      print(response);
    }
  }
}
