import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cocktailapp/constraints.dart';

import '../main.dart';

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<Map> {
  late Future<Position> _currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _currentLocation = _getUserLocation();
  }

  Future<Position> _getUserLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap with Scaffold
      appBar: CommonAppBar(),
      body: FutureBuilder<Position>(
        future: _currentLocation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              Position snapshotData = snapshot.data!;
              LatLng _userLocation =
                  LatLng(snapshotData.latitude, snapshotData.longitude);
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _userLocation,
                  zoom: 12,
                ),
                markers: _markers
                  ..add(Marker(
                      markerId: MarkerId("User Location"),
                      infoWindow: InfoWindow(title: "User Location"),
                      position: _userLocation)),
              );
            } else {
              // Center(child: Text("Failed to get user location."));
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:btnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: btnMinSize,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Allow location permissions"),
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text("Failed to fetch user location."));
          }
        },
      ),
    );
  }
}
