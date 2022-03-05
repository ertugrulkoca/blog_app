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
import 'components/profile_components.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
                      profilePicture(context),
                      customSizedBox(20),
                      googleMapContainer(latitude, longitude),
                      customSizedBox(30),
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

  SizedBox googleMapContainer(double latitude, double longitude) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: GoogleMap(
        mapType: MapType.normal,
        markers: {if (_markerLocation != null) _markerLocation!},
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
