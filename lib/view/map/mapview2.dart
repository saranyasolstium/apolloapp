
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class MapHome extends StatefulWidget {
  const MapHome({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MapHome> {
  final Completer<GoogleMapController> _controller = Completer();


  GoogleMapController? mapController;
  //LatLng _center = LatLng(0.0, 0.0); // Default center
  LatLng _center = const LatLng(13.0400596, 80.2380421);

  LatLng newlatlang = const LatLng(27.7149298,85.2903343);

  // mapController?.animateCamera(
  // CameraUpdate.newCameraPosition(
  // CameraPosition(target: newlatlang, zoom: 17)


// in the below line, we are specifying our camera position

 // model.latitude = 13.0400596;
  // model.longitude = 80.2380421;

  static const CameraPosition _kGoogle = CameraPosition(
   // target: LatLng(10.9997, 371.250021),
    target: LatLng(13.0400596, 80.2380421),
    zoom: 9.4746,
  );


  @override
  void initState() {
    _requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: const Text("Google Maps"),
        ),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: _kGoogle,
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true, rotateGesturesEnabled :true,
                 scrollGesturesEnabled :true,
                 zoomControlsEnabled : true,
                 zoomGesturesEnabled : true,
                 liteModeEnabled : false,
                 tiltGesturesEnabled : true,
                 myLocationButtonEnabled : true,
                 padding : EdgeInsets.zero,
                 indoorViewEnabled : false,
                 trafficEnabled : false,

              // onMapCreated: (GoogleMapController controller){
              //   _controller.complete(controller);
              // },
              //onMapCreated: _onMapCreated,
              onMapCreated: (controller) { //method called when map is created
                setState(() {
                  mapController = controller;
                });
              }
            )
          )
        )
    );
  }

  void _requestLocationPermission() async {
    var location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }


  Future<LocationData> _getLocation() async {
    var location = Location();
    return await location.getLocation();
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getLocation().then((locationData) {
      setState(() {
        _center = LatLng(locationData.latitude!, locationData.longitude!);
      });
    });
  }
}
