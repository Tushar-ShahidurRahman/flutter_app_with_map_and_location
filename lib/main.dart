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
  // for using and accessing map out side Google map widget.
  late GoogleMapController _googleMapController;
  Position? currentLocation;

  void getRealTimePosition() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 30,
        // timeLimit: Duration(seconds: 5),
      ),
    ).listen((event) {
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
      body: GoogleMap(
        onMapCreated: (controller) {
          _googleMapController = controller;
        },
        // Zoom controller
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        // for getting my location from the app
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        // for getting position from the map where someone taps.
        onTap: (LatLng position) {
          print(position);
        },
        mapType: MapType.normal,
        // Marker code is here
        markers: <Marker>{
          Marker(
            markerId: const MarkerId("Vivasoft - office"),
            position: const LatLng(23.793895737073488, 90.40448580672911),
            infoWindow: const InfoWindow(title: 'Vivasoft - office'),
            icon:
                //for customized color in the marker
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            // for draggable marker
            draggable: true,
            onDrag: (LatLng initLatLng) {},
            onDragStart: (LatLng onDragStartPosition) {
              print('Starting point : $onDragStartPosition');
            },
            onDragEnd: (LatLng onDragEndPosition) {
              print('Ending point : $onDragEndPosition');
            },
          ),
          const Marker(
            markerId: MarkerId('Rabbani Hotel'),
            position: LatLng(23.79281974207595, 90.40310081094503),
            infoWindow: InfoWindow(title: 'Rabbani Hotel'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
        // For creating a circle around a center of certain radius.
        circles: <Circle>{
          const Circle(
            // onTap function is used as a call back function to receive tap events.
            // onTap: () {},
            circleId: CircleId('Gol Alu'),
            radius: 60,
            center: LatLng(23.792258945039197, 90.40521338582039),
            // fillColor: Colors.brown,
            strokeColor: Colors.green,
            strokeWidth: 10,
          ),
        },
        // For crating a polygon in the map
        polygons: <Polygon>{
          const Polygon(
            polygonId: PolygonId('gon poly'),
            points: [
              LatLng(23.790299511010467, 90.40300626307726),
              LatLng(23.787733825703548, 90.40342334657907),
              LatLng(23.7874574048336, 90.4051560536027),
              LatLng(23.79023938073747, 90.4049763455987),
              LatLng(23.788990444134686, 90.40163330733776)
            ],
            strokeWidth: 5,
            fillColor: Colors.cyan,
            strokeColor: Colors.teal,
          ),
        },
        // For drawing polyline
        polylines: <Polyline>{
          const Polyline(
              polylineId: PolylineId('Demo polyline'),
              width: 4,
              color: Colors.blue,
              points: [
                LatLng(23.799256770175383, 90.4044134169817),
                LatLng(23.796286935662668, 90.40347699075939),
                LatLng(23.796893731044133, 90.40817420929669),
              ])
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.793895737073488, 90.40448580672911),
          zoom: 16,
          bearing: 0,
          tilt: 0,
        ),
      ),
      // body: Center(child: Text(currentLocation.toString())),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // Takes permission from user for location
      //     LocationPermission permission = await Geolocator.requestPermission();
      //     if (permission == LocationPermission.always ||
      //         permission == LocationPermission.whileInUse) {
      //       // Takes the current position.
      //       currentLocation = await Geolocator.getCurrentPosition();
      //       log(currentLocation.toString());
      //       setState(() {});
      //     } else {
      //       log('Permission denied');
      //     }
      //   },
      //   child: const Icon(Icons.location_on),
      // ),
    );
  }
}
