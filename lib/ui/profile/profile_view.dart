import 'dart:async';
import 'dart:io';
import 'package:blog_app_assignment/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../core/helper/shared_manager.dart';
import '../components/ui_components.dart';
import '../login/components/login_components.dart';
import '../login/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late LocationPermission permission;

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    izin();
  }

  Future<void> izin() async {
    permission = await Geolocator.requestPermission();
  }

  Future<void> konumaGit() async {
    GoogleMapController controller = await haritaKontrol.future;
    var gidilecekIsaret = const Marker(
      markerId: MarkerId("id"),
      position: LatLng(41.0039643, 28.4517462),
      infoWindow: InfoWindow(title: "İstanbul", snippet: "Evim"),
    );

    setState(() {
      isaretler.add(gidilecekIsaret);
    });

    var gidilecekKonum = await const CameraPosition(
        target: LatLng(41.0039643, 28.4517462), zoom: 8);

    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
  }

  Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKocum =
      const CameraPosition(target: LatLng(41.0039643, 28.4517462), zoom: 8);
  List<Marker> isaretler = <Marker>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "My Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customSizedBox(30),
            GestureDetector(
              onTap: () {
                _alertImageAndButtons(context, () {
                  _alertWithButtons(context, () {});
                });
              },
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(children: const [
                    CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage("assets/logo.png")),
                    Padding(
                        padding: EdgeInsets.only(bottom: 25, right: 25),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.camera_alt, size: 40)))
                  ])),
            ),
            customSizedBox(20),
            // Container(
            //     color: Colors.grey,
            //     width: double.infinity,
            //     height: 200,
            //     child: Image.asset("assets/background.png", fit: BoxFit.cover)),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: GoogleMap(
                  markers: Set<Marker>.of(isaretler),
                  mapType: MapType.normal,
                  initialCameraPosition: baslangicKocum,
                  onMapCreated: (GoogleMapController controller) {
                    haritaKontrol.complete(controller);
                  }),
            ),
            customSizedBox(30),
            //login view Components
            loginRegisterButton(
                "Save", dark, white, Icons.logout_rounded, () {}),
            customSizedBox(20),
            loginRegisterButton("Log Out", white, dark, Icons.logout_rounded,
                () async {
              await SharedManager.instance.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginView()),
                  (Route<dynamic> route) => false);
            }),
          ],
        ),
      ),
      bottomNavigationBar: buttomBar(context, 2),
    );
  }
}

_alertImageAndButtons(context, void Function() fun) {
  Alert(
    context: context,
    image: Image.asset(
      "assets/logo.png",
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    ),
    buttons: [
      alertButton(context, "Select", Icons.login, white, dark, fun),
      alertButton(context, "Remove", Icons.login, dark, white, fun)
    ],
  ).show();
}

_alertWithButtons(context, void Function() fun) {
  Alert(
    context: context,
    title: "Select a Picture",
    buttons: [
      alertButton(context, "Camera", Icons.camera_alt, white, dark, fun),
      alertButton(context, "Galery", Icons.photo_size_select_large_rounded,
          dark, white, fun)
    ],
  ).show();
}

DialogButton alertButton(context, String text, IconData icon, Color textColor,
    backgroundColor, void Function() fun) {
  return DialogButton(
    border: Border.fromBorderSide(BorderSide(color: dark, width: 1)),
    radius: const BorderRadius.all(Radius.circular(10)),
    color: backgroundColor,
    child: Row(
      children: [
        Icon(icon, color: textColor),
        const SizedBox(width: 10),
        Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ],
    ),
    onPressed: fun,
    // onPressed: () => Navigator.pop(context),
  );
}
