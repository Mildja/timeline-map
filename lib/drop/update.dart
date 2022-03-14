import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/sideMenu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class updatePage extends StatelessWidget {
  List<Marker> myMarker = [];

  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    updateUser() {
      print('haha update jaaaaa');
    }

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      drawer: SideMenu(),
     
        
          body: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(14.0229, 99.992), zoom: 15.0),
              markers: Set.from(myMarker),
              mapType: MapType.normal
              //  onTap:,
              ),
    
 
    );
  }
}
