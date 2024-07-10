import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:location/location.dart';

class AddLens extends StatefulWidget {
  const AddLens({Key? key}) : super(key: key);

  @override
  State<AddLens> createState() => _AddLensState();
}

class _AddLensState extends State<AddLens> {
  late GoogleMapController googleMapController;

//  late CameraPosition cameraPosition;
  LatLng initialCameraPosition = LatLng(20.5937, 78.9629);
  late Location location;

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    location.onLocationChanged.listen((l) {
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title:"Add Lens",
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition:
          CameraPosition(target: initialCameraPosition),
          onMapCreated: onMapCreated,
          mapType: MapType.normal,
          myLocationEnabled: true,
        ),
      ),
    );
    // return SafeArea(
    //     child: Scaffold(
    //         appBar: AppBar(
    //           backgroundColor: loginTextColor,
    //           title: const Text("Add lens"),
    //           // leading: Image.asset("assets/images/back_arrow.png",),
    //           leading: InkWell(
    //               onTap: () => Get.back(),
    //               child: Icon(
    //                 Icons.arrow_back_ios,
    //                 size: 28.0,
    //               )),
    //           actions: <Widget>[
    //             IconButton(
    //               icon: Image.asset("assets/images/menu.png"),
    //               onPressed: () {},
    //             ), //IconButton
    //           ], //
    //         ),
    //         body: Container(
    //           height: MediaQuery.of(context).size.height,
    //           width: MediaQuery.of(context).size.width,
    //           child: GoogleMap(
    //             initialCameraPosition:
    //                 CameraPosition(target: initialCameraPosition),
    //             onMapCreated: onMapCreated,
    //             mapType: MapType.normal,
    //             myLocationEnabled: true,
    //           ),
    //         )));
  }
}
