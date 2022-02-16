import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase78/home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'authentication.dart';

class AllOperation extends StatefulWidget {
  const AllOperation({Key? key}) : super(key: key);

  @override
  _AllOperationState createState() => _AllOperationState();
}

class _AllOperationState extends State<AllOperation> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  FirebaseFirestore operationFirestore = FirebaseFirestore.instance;
  bool data = false;
  var myData = "";


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _globalKey,
        child: Card(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value!.length > 3 ){
                      return null;
                    }else{
                      return "Name length must be more than 3 letters";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    // prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value){
                    if(value!.length > 6){
                      return null;
                    }else{
                      return "Password must be more than 6 digits";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    if(_globalKey.currentState!.validate()){
                      addData(nameController.text, passwordController.text);
                      // addDataWithDocumentName(nameController.text, passwordController.text);
                    }
                  },
                  child: Text("Create Data")
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    if(_globalKey.currentState!.validate()){
                      // getData();
                      // print(getData().toString());

                    }
                    getData();
                    setState(() {
                      data = true;
                    });
                  },
                  child: Text("Read Single Data")
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    if(_globalKey.currentState!.validate()){
                      // getData();
                      // print(getData().toString());

                    }
                    // getData();
                    getAllDocument();
                    setState(() {
                      data = true;
                    });
                  },
                  child: Text("Read all Data")
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: (){
                      if(_globalKey.currentState!.validate()){
                        updateData(nameController.text);

                      }
                    },
                    child: Text("Update Data")
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: (){
                      if(_globalKey.currentState!.validate()){
                        // addData(nameController.text, ageController.text);
                        deleteData();
                      }
                    },
                    child: Text("Delete Data")
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: (){
                      if(_globalKey.currentState!.validate()){
                        Authentication
                            .signIn(email: nameController.text, password: passwordController.text)
                            .then((result) {
                          if (result == null) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                result,
                                style: TextStyle(fontSize: 16),
                              ),
                            ));
                          }
                        });
                      }
                    },
                    child: Text("Sign IN")
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: (){
                      if(_globalKey.currentState!.validate()){
                        Authentication
                            .signUP(nameController.text, passwordController.text,)
                            .then((result) {
                          if (result == null) {
                            operationFirestore.collection("78").doc("user1").set({
                              "Email": nameController.text,
                              "Password": passwordController.text,
                              "Username" : nameController.text
                            });
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                result,
                                style: TextStyle(fontSize: 16),
                              ),
                            ));
                          }
                        });
                      }
                    },
                    child: Text("Sign UP")
                ),
              ),

              data ? Center(
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
                          Text("Name: ${data}"),
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
              ) : Container(),

            ],
          ),
        ),
      ),
    );
  }

  addData(String ourName,String password) async {
    try{
      return await operationFirestore.collection("75").add(
          {
            "name": ourName,
            "password" : password,
            "batch" : "75",
            "location" : "Sylhet",
            "info" : {
              "address" : {
                "word" : "250",
                "house number": "B121"
              },
              "gender" : "FeMale",
              "age" : "250",
            }
          }
      );
    }catch(e){
      print(e);
    }

  }

  addDataWithDocumentName(String name,String pass)async{
    return await operationFirestore.collection("77").doc(name).set(
      {
        "name": name,
        "password" : pass,
        "batch" : "77",
        // "location" : "Sylhet",
        "info" : {
          "address" : {
            "word" : "26",
            "house number": "B13"
          },
          "gender" : "Male",
          "age" : "25",
        }
      }
    );
  }

  Future<DocumentSnapshot> getData() async {
    return await
    operationFirestore
        .collection("77").
        doc("naima").get().then(
          (snapshot){
            // var name = snapshot.get("name");
            // print(snapshot.get("name"));
            return snapshot;

          }
        );
        // .doc("Tomal")
        // .get();
  }

 getAllDocument() async {
   await operationFirestore
    .collection("77").where("info.gender",isEqualTo: "Female").
      snapshots().listen((snapshot) { 
       snapshot.docs.forEach(
         (snapshotItem) {
          print(snapshotItem.get("info.age"));
       }) ;
      });
      // .where("money", isGreaterThan: "10000")
      // .get().then((allDocument) {
      //   allDocument.docs.forEach((value) {
      //     try{
      //       myData = value.get("name").toString();
      //     }catch (e){
      //       myData = e.toString();
      //     }
      //     print(myData);
      //   });
      //  });
 }

  updateData(String name)async{
    return await operationFirestore.collection("77").doc(name).update(
      {
        "info": {
          "address": {
            "word": "32",
            "house number": "C112"
          },
          "gender": "Female",
          "age": "26",
        }
      }
    ).then((value) {
      Fluttertoast.showToast(msg: "Data Updated Successfully");
    });
      
  }

  deleteData()async{
    return await operationFirestore.collection("80").doc("Tomal").delete();
  }

}
