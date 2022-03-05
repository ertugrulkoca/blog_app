import 'dart:async';
import 'package:blog_app_assignment/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/helper/shared_manager.dart';
import '../../core/service/account_service.dart';
import '../components/dummy_pages.dart';
import '../components/ui_components.dart';
import '../login/components/login_components.dart';
import '../login/login_view.dart';
import 'components/profile_components.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  //  lokasyon işlemleri için izin.
  late LocationPermission permission;
  Future<void> gpsPermission() async {
    permission = await Geolocator.requestPermission();
  }

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    gpsPermission();
  }

  GoogleMapController? _googleMapController;
  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  Marker? _markerLocation;
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
                  // snapshot'dan gelen datalar listeye atılıyor
                  var list = snapshot.data;
                  List<String> latLng = [];
                  for (var item in list!) {
                    latLng.add(item);
                  }
                  // enlem ve boylam bilgisinin değişkenlere atılması
                  double latitude = double.parse(latLng[0]);
                  double longitude = double.parse(latLng[1]);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customSizedBox(30),
                      profilePicture(context),
                      customSizedBox(20),
                      googleMapContainer(latitude, longitude),
                      customSizedBox(30),
                      // SAVE Button
                      loginRegisterButton(
                          "Save", dark, white, Icons.logout_rounded, () async {
                        //markerın boş olup olmadığı kontrol edilir.
                        if (_markerLocation != null) {
                          if (_markerLocation!.position != null) {
                            // seçilen konum bilgisi apiye gönderilir.
                            await AccountService.instance.accountUpdate(
                                "string",
                                _markerLocation!.position.latitude.toString(),
                                _markerLocation!.position.longitude.toString());
                          }
                        }
                      }),
                      customSizedBox(20),
                      // LOG OUT buton
                      loginRegisterButton(
                          "Log Out", white, dark, Icons.logout_rounded,
                          () async {
                        // kaydedilen token temizlenir.
                        await SharedManager.instance.clear();
                        // çıkış yapılır, login sayfasına yönlendirilir.
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                            (Route<dynamic> route) => false);
                      }),
                    ],
                  );
                } else {
                  // datada sorun olursa gösterilecek sayfa
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

  SizedBox googleMapContainer(double latitude, double longitude) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: GoogleMap(
        mapType: MapType.normal,
        // markerın boş olup olmadığı kontrol edilir.
        markers: {if (_markerLocation != null) _markerLocation!},
        // CameraPosition için eğer marker null ise apiden gelen konum gösterilir.
        // eğer markern seçili ise o konum gösterilir.
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
        onMapCreated: (controller) => _googleMapController = controller,
        onLongPress: _addMarker,
      ),
    );
  }

  //seçilen konum için marker fonksiyonu
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
