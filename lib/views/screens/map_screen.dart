import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodlink/resources/components/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:foodlink/helpers/helper_methods.dart';
import 'package:foodlink/views/screens/main_Screen.dart';

import '../../provider/app_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double bottomPadding = 0;
  late GoogleMapController mapController;
  final Geolocator geolocator = Geolocator();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  /// geting user location

  late Position currentPosition;

  setUpPositionLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,
    );

    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 15);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await HelperMethods.findCordinateAddress(position, context);

    print(address);
    print('ok');
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPadding),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);

              mapController = controller;

              setState(() {
                bottomPadding = 300;
              });

              await setUpPositionLocation();
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      width: MediaQuery.of(context).size.width - 70,
                      child: ElevatedButton.icon(


                          onPressed: () async {
                            double? latitude = 34.36744335;
                                // Provider.of<AppData>(context, listen: false)
                                //     .pickUpAddress!
                                //     .latitude;

                            double? logitude = 34.36744335;
                                // Provider.of<AppData>(context, listen: false)
                                //     .pickUpAddress!
                                // .longitude;

                            String? placeName = "9687+WJ6, Mansehra, Khyber Pakhtunkhwa, Pakistan";
                                // Provider.of<AppData>(context, listen: false)
                                //     .pickUpAddress!
                                //     .placeName ??
                                //     "9687+WJ6, Mansehra, Khyber Pakhtunkhwa, Pakistan";

                            EasyLoading.show(status: 'Saving Address...');
                            await FirebaseFirestore.instance
                                .collection('buyers')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              'latitude': latitude,
                              'longitude': logitude,
                              'placeName': placeName,
                            }).whenComplete((){
                              EasyLoading.dismiss();
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MainScreen();
                            }));
                          },
                          icon: Icon(FontAwesomeIcons.shop, color: AppColors.blackColor,),
                          label: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'SHOP NOW ',
                              style: TextStyle(
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                          )),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
