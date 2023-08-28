import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  String? name,id,phone,photo;
  Update({ required this.id,required this.name,required this.phone,required this.photo});

  @override
  State<Update> createState() => _UpdatState();
}

class _UpdatState extends State<Update> {
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController photo=TextEditingController();
  @override
  void initState() {
    name.text=widget.name!.toString();
    phone.text=widget.phone!.toString();
    photo.text=widget.photo!.toString();
    // TODO: implement initState
    super.initState();
  }
  update(){
    var data={
      "name":name.text,
      "phone":phone.text,
      "photo":photo.text
    };
    FirebaseFirestore.instance.collection("user").doc(widget.id).update(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("update",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor:Colors.red ,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
              label: Text("name"),
              hintText: "name",
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: phone,
            decoration: InputDecoration(
              label: Text(" phone"),
              hintText: "enter your phone number",
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: photo,
            decoration: InputDecoration(
              label: Text("image url"),
              hintText: "paste the url",
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed:(){
            try{
              update();
              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>Home_page()));
            }
            catch(e){
              String error=e.toString();
              print(error);
            }
          }, child:Text("update"))
        ],
      ),
    );
  }
}
