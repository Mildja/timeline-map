import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/drop/bugkets_firestore.dart';
import 'package:flutter_application_1/drop/fields_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/drop/update.dart';
import 'package:flutter_application_1/states/backgroun_painter.dart';
import 'package:flutter_application_1/states/sideMenu.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadSubCollections extends StatefulWidget {
  @override
  _ReadSubCollections createState() => _ReadSubCollections();
}

class _ReadSubCollections extends State<ReadSubCollections> {
  //const ReadSubCollections({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  get db => null;

  @override
  Widget build(BuildContext contect) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        flexibleSpace: Container(
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
      
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirestoreBuckets.user)
              .doc(auth.currentUser!.uid)
              .collection(FirestoreBuckets.location)
              .snapshots(),
          builder: (__,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              print("Total Documents: ${snapshot.data!.docs.length}");
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (___, int index) {
                    Map<String, dynamic> docData =
                        snapshot.data!.docs[index].data();
                    String docID =
                        snapshot.data!.docs[index].id;

                    if (docData.isEmpty) {
                      return const Text(
                        "Document is Empty",
                        textAlign: TextAlign.center,
                      );
                    }
                    
                    String Address = docData[FirestoreFields.Address];
                    String Country = docData[FirestoreFields.Country];
                    String Postalcode = docData[FirestoreFields.Postalcode];
                    var latitude = docData[FirestoreFields.latitude];
                    var longitude = docData[FirestoreFields.longitude];

                    return Stack(
                      children: [
                        Positioned(
                            bottom: 45,
                            left: 5,
                            right: 5,
                            top: 5,
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 255, 238, 244),
                                    Color.fromARGB(255, 231, 249, 255),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              title: Text(Address),
                              subtitle: Text("latitude: " +
                                  latitude.toString() +
                                  "\nlongitude: " +
                                  longitude.toString()),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                   
                                    IconButton(
                                        color: Colors.red,
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          final out = FirebaseFirestore.instance
                                              .collection('user')
                                              .doc(auth.currentUser!.uid)
                                              .collection('location')
                                              .doc(docID);
                                          
                                          out.delete();

                                          
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (___, ____) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              } else {
                return const Center(
                  child: Text("Document aren't available"),
                );
              }
            } else {
              return const Center(
                child: Text("Getting Error"),
              );
            }
          },
        ),
      ),
    );
  }
}
