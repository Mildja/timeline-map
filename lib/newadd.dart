import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/dialog.dart';
import 'package:flutter_application_1/states/sideMenu.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_1/authen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class newadd extends StatefulWidget {
  @override
  _newaddState createState() => _newaddState();
}

class _newaddState extends State<newadd> {
  DateTime date = DateTime(2022, 12, 24);
  GoogleMapController? googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position? position;
  double? lo;
  double? la;
  String? addressLocation;
  String? country;
  String? postalcode;

  final auth = FirebaseAuth.instance;
  TimeOfDay initialTime = TimeOfDay(hour: 9, minute: 0);

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(snippet: addressLocation));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AddTimeline'), flexibleSpace: Container(
       decoration: new BoxDecoration(
         gradient:  new LinearGradient(colors: [
           Color.fromARGB(235, 44, 16, 88),
           Color.fromARGB(235, 243, 177, 223),
         ],begin: const FractionalOffset(0.0, 0.0),
         end:const FractionalOffset(1.0, 0.0) ,
         stops: [0.0,1.0],
         tileMode: TileMode.clamp)
       ),
     ),),
      drawer: SideMenu(),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 490,
                  child: GoogleMap(
                    onTap: (tapped) async {
                      final coordinated = new geoCo.Coordinates(
                          tapped.latitude, tapped.longitude);
                      var address = await geoCo.Geocoder.local
                          .findAddressesFromCoordinates(coordinated);
                      var firstAddress = address.first;
                      getMarkers(tapped.latitude, tapped.longitude);
                      setState(() {
                        country = firstAddress.countryName;
                        postalcode = firstAddress.postalCode;
                        addressLocation = firstAddress.addressLine;
                        lo = tapped.longitude;
                        la = tapped.latitude;
                      });
                    },
                    mapType: MapType.normal,
                    compassEnabled: true,
                    trafficEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        googleMapController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(position?.latitude.toDouble(),
                          position?.longitude.toDouble()),
                      zoom: 16,
                    ),
                    markers: Set<Marker>.of(markers.values),
                  ),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: 600,
                height: 85,
                child: Card(
                  color: Color.fromARGB(232, 247, 206, 96),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Address: $addressLocation',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: FractionalOffset.topCenter,
                          child: Text(
                            '${date.year}/${date.month}/${date.day} \t \t \t \t \t \t \t \t  ${initialTime.hour}:${initialTime.minute}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              padding: const EdgeInsets.only(bottom: 13.0, right: 100),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2030));

                //if 'cencle'  => null
                if (newDate == null) return;

                // if 'Ok' => DateTime
                setState(() => date = newDate);
                {}
              },
              icon: Icon(Icons.calendar_month),
            ),
          ),
          IconButton(
            padding: const EdgeInsets.only(bottom: 15.0, right: 85),
            onPressed: () async {
              TimeOfDay? newTime = await showTimePicker(
                context: context,
                initialTime: initialTime,
              );

              //if 'cencle'  => null
              if (newTime == null) return;

              // if 'Ok' => DateTime
              setState(() => initialTime = newTime);
              {}
            },
            icon: Icon(Icons.more_time),
          ),
          FloatingActionButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(auth.currentUser!.uid)
                  .collection('location')
                  .add({
                'latitude': la,
                'longitude':lo,
                'Address': addressLocation,
                'Country': country,
                'Postalcode': postalcode,
                'Date': date,
                //'time': initialTime,
              });
              normalDialog(context, 'สถานะการยืนยัน', 'เพิ่มไทม์ไลน์สำเร็จ');
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
