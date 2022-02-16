import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadFirebase extends StatefulWidget {
  const ReadFirebase({Key? key}) : super(key: key);

  @override
  _ReadFirebaseState createState() => _ReadFirebaseState();
}

class _ReadFirebaseState extends State<ReadFirebase> {

  final FirebaseFirestore ourFirestore = FirebaseFirestore.instance;
  // final CollectionReference ourReference = ourFirestore.collection("78");

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await ourFirestore
        .collection("78")
        .doc("3").collection("Jahangir").doc("1")
        .get();
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Text(""),
    //         Text(""),
    //         Text(""),
    //       ],
    //     )
    //   ],
    // );
    return Center(
      child: FutureBuilder<DocumentSnapshot>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Name: ${data['name']}"),
                Text("Password: ${data['password']}"),
                Text("Batch: ${data['batch']}"),
                Text("Location: ${data['location']}"),
              ],
            );
            // return Text("Data: ${data['name']} ${data['money']}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

}
