import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/Home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Add_user extends StatefulWidget {
  const Add_user({Key? key}) : super(key: key);

  @override
  State<Add_user> createState() => _Add_userState();
}

class _Add_userState extends State<Add_user> {
  String? url;
  add()async{
    var user={
      "name":name.text,
      "phone":phone.text,
      "photo":url
    };
  await  FirebaseFirestore.instance.collection("user").add(user);
  }
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  getImage()async{
    File file;
    ImagePicker picker=ImagePicker();
   XFile? xFile= await picker.pickImage(source: ImageSource.camera);
   if(xFile!=null){
      file=File(xFile!.path);
     storeImage(file);
   }
  }
  storeImage(File file)async{
   var ref=await FirebaseStorage.instance.ref().child("image${file.path}");
  await ref.putFile(file);
   url=await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add_user",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
              label: Text("add_name"),
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: phone,
          decoration: InputDecoration(
            label: Text("Add_number"),
          border: OutlineInputBorder()
          ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: (){
            getImage();
          }, child: Text("select_image")),
          ElevatedButton(onPressed: (){
            try{
              if(url != null){
                add();
                Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>Home_page()));

              }
            }
            catch(e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: SnackBar(content: Text("wait"),)));

              String error=e.toString();
              print(error);
            }
          }, child:Text("Submit"))
        ],
      ),
    );
  }
}
