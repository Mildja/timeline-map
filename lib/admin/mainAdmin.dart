import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/admin/sideMenu_addmin.dart';
import 'package:flutter_application_1/drop/bugkets_firestore.dart';
import 'package:flutter_application_1/states/sideMenu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mainAdmin extends StatefulWidget {
  @override
  _mainAdmin createState() => _mainAdmin();
}

class _mainAdmin extends State<mainAdmin> {
  bool mapToggle = false;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  var currentLocation;
  
  GoogleMapController? mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  getMarkerData() async {
    FirebaseFirestore.instance
        .collectionGroup(FirestoreBuckets.location)
        .get()
        .then((Doc) {
      if (Doc.docs.isNotEmpty) {
        for (int i = 0; i < Doc.docs.length; i++) {
          initMarker(Doc.docs[i].data(), Doc.docs[i].id);
        }
      }
    });
  }
 
  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Uint8List? markerIcon = await getBytesFromAsset('images/images1.png', 200);
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: LatLng(specify['latitude'], specify['longitude']),
      infoWindow: InfoWindow(snippet: specify['Address']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void initState() {
    getMarkerData();
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
  }
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
     ByteData data = await rootBundle.load(path);
     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
     ui.FrameInfo fi = await codec.getNextFrame();
     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TimeLineOnly1')),
      drawer: SideMenuAddmin(),
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              
              child: mapToggle
                  ? GoogleMap(
                      onMapCreated: onMapCreated,
                      mapType:MapType.normal ,
                       myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude,
                            currentLocation.longitude),
                        zoom: 16,
                      ),
                      markers: Set<Marker>.of(markers.values),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ))
        ],
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
