import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/Add_user.dart';
import 'package:contact_app/Update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Home_page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>Add_user()));
            },
            child: Icon(Icons.add,color: Colors.white,size: 50,)),SizedBox(width: 20,)],
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("user").snapshots(),
            builder: (context,snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            if(snapshot.hasData){
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index) {
                      return GestureDetector(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>Update(id: snapshot.data!.docs[index].id,name:snapshot.data!.docs[index]["name"],phone: snapshot.data!.docs[index]["phone"],photo: snapshot.data!.docs[index]["photo"],)));
                        },
                        child: ListTile(
                          title: Text(snapshot.data!.docs[index]["name"]),
                          subtitle: Text(snapshot.data!.docs[index]["phone"].toString()),
                          trailing: InkWell(
                              onTap: ()async{
                                await FirebaseFirestore.instance.collection("user").doc(snapshot.data!.docs[index].id).delete();
                              },
                              child: Icon(Icons.delete,color: Colors.red,)),
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(snapshot.data!.docs[index]["photo"])
                                ),
                                color: Colors.yellow,
                                shape: BoxShape.circle
                            ),
                          ),
                        ),
                      );
                    }
                ),
              );
            }
            else{
              return Center(
                child: Text("Something wrong"),
              );
            }
            }
          )
        ],
      ),
    );
  }
}
