import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/drop/bugkets_firestore.dart';
import 'package:flutter_application_1/states/sideMenu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GetPoints extends StatefulWidget {
  @override
  _GetPoints createState() => _GetPoints();
}

class _GetPoints extends State<GetPoints> {

  bool mapToggle = false;

  var currentLocation;

  GoogleMapController? mapController;

  Map<MarkerId , Marker> markers = <MarkerId , Marker>{};

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
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
     ByteData data = await rootBundle.load(path);
     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
     ui.FrameInfo fi = await codec.getNextFrame();
     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
}
  void initMarker(specify , specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Uint8List? markerIcon = await getBytesFromAsset('images/images1.png', 200);
    final Marker marker = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon),
      markerId: markerId,
      position: LatLng(specify['latitude'],specify['longitude']),
      infoWindow: InfoWindow(snippet: specify['Address']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void initState() {
    getMarkerData();
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      
      });
    });
  }
  
  @override  
  Widget build(BuildContext context) {
    return MaterialApp(  
      home: Scaffold(  
        appBar: AppBar(title: Text('Show Timeline'), flexibleSpace: Container(
       decoration: new BoxDecoration(
         gradient:  new LinearGradient(colors: [
           Color.fromARGB(235, 44, 16, 88),
           Color.fromARGB(235, 243, 177, 223),
         ],begin: const FractionalOffset(0.0, 0.0),
         end:const FractionalOffset(1.0, 0.0) ,
         stops: [0.0,1.0],
         tileMode: TileMode.clamp)
       )
       
     ), 
       leading : BackButton(
         color: Colors.white,
        onPressed: () {
                Navigator.pushReplacementNamed(context, '/authen');
              },
         
       )),
      
        body: Stack(  
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: mapToggle ?
              GoogleMap(
                onMapCreated: onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentLocation.latitude, currentLocation.longitude),
                zoom: 16,
                ),
                markers: Set<Marker>.of(markers.values),
              ):
              Center(child: 
              CircularProgressIndicator(),
              )
            )
          ],  
        ),  
      ),  
    );  
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }  
}   