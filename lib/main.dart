import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapViewScreen(),
    );
  }
}

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  Position? currentLocation;

  void getRealTimePosition() async {
    await Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.bestForNavigation,
                distanceFilter: 30,
                timeLimit: Duration(seconds: 5)))
        .listen((event) {
      print(event);
    });
  }

  @override
  void initState() {
    super.initState();
    getRealTimePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
      // body: GoogleMap(
      //     initialCameraPosition:
      //         CameraPosition(target: LatLng(37.4219983, -122.084))),
      body: Center(child: Text(currentLocation.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Takes permission from user for location
          LocationPermission permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse) {
            // Takes the current position.
            currentLocation = await Geolocator.getCurrentPosition();
            log(currentLocation.toString());
            setState(() {});
          } else {
            log('Permission denied');
          }
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
