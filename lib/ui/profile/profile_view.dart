import 'dart:async';
import 'package:blog_app_assignment/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../core/helper/shared_manager.dart';
import '../../core/service/account_service.dart';
import '../components/dummy_pages.dart';
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
  Future<void> izin() async {
    permission = await Geolocator.requestPermission();
  }

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    izin();
  }

  GoogleMapController? _googleMapController;
  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  Marker? _markerLocation;
  Completer<GoogleMapController> haritaKontrol = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "My Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<String>>(
          future: AccountService.instance.getLocation(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var list = snapshot.data;
                  List<String> latLng = [];
                  for (var item in list!) {
                    latLng.add(item);
                  }
                  double latitude = double.parse(latLng[0]);
                  double longitude = double.parse(latLng[1]);

                  return Column(
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
                                  backgroundImage:
                                      AssetImage("assets/logo.png")),
                              Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 25, right: 25),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(Icons.camera_alt, size: 40)))
                            ])),
                      ),
                      customSizedBox(20),
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          markers: {
                            if (_markerLocation != null) _markerLocation!
                          },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _markerLocation == null
                                    ? latitude
                                    : _markerLocation!.position.latitude,
                                _markerLocation == null
                                    ? longitude
                                    : _markerLocation!.position.longitude,
                              ),
                              zoom: 12),
                          onMapCreated: (controller) =>
                              _googleMapController = controller,
                          onLongPress: _addMarker,
                        ),
                      ),
                      customSizedBox(30),
                      //login view Components
                      loginRegisterButton(
                          "Save", dark, white, Icons.logout_rounded, () async {
                        if (_markerLocation != null) {
                          if (_markerLocation!.position != null) {
                            await AccountService.instance.accountUpdate(
                                "string",
                                _markerLocation!.position.latitude.toString(),
                                _markerLocation!.position.longitude.toString());
                          }
                        }
                      }),
                      customSizedBox(20),
                      loginRegisterButton(
                          "Log Out", white, dark, Icons.logout_rounded,
                          () async {
                        await SharedManager.instance.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                            (Route<dynamic> route) => false);
                      }),
                    ],
                  );
                } else {
                  return notFoundWidget;
                }
              default:
                return waitingWidget;
            }
          },
        ),
      ),
      bottomNavigationBar: buttomBar(context, 2),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_markerLocation == null) {
      _markerLocation = Marker(
        markerId: const MarkerId('location'),
        infoWindow: const InfoWindow(title: 'location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      setState(() {
        _markerLocation = Marker(
          markerId: const MarkerId('location'),
          infoWindow: const InfoWindow(title: 'location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });
    }
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
  );
}
