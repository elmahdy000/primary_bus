import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:primary_bus/screens/login_screen.dart';
import 'package:primary_bus/services/update_service.dart';
import 'package:provider/provider.dart';
import '../model/user_info.dart' as model;

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UpdateData>(context);
    if(data.isDataCalled==false){
      data.getData();
    }
    if(data.getUser==null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()),);
    }
    final userInfo = data?.getUser!;
    final counter = data?.getCounter;
    return Scaffold(
        backgroundColor: Colors.white,

        body: RefreshIndicator(
          onRefresh:() async=>await data.getData(),
          child: ListView(


            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: ()async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (_)=>  LoginScreen()));

                  }, icon: const Icon(Icons.logout))
                ],
              ),

              const SizedBox(height: 20,),
              Container(

                width: double.infinity,
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 10,
                  color: Colors.lightGreen,

                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height:    10),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('User name  : ${userInfo!.name}',style:  const TextStyle(
                                color: Colors.white,

                                fontSize: 20
                            ),)
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Email Address : ${userInfo!.email}',style:  TextStyle(

                              color: Colors.white,

                              fontSize: 20
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('phone number : ${userInfo!.phone}',style:  TextStyle(

                              color: Colors.white,

                              fontSize: 20
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Zigzag : ${userInfo!.university}',style:  TextStyle(

                              color: Colors.white,

                              fontSize: 20
                          ),),
                        ),






                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              if(counter!=null &&counter.isNotEmpty)
              Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.amber,

                   // borderRadius: BorderRadius.circular(100)

                ),
                child:  Text(counter,style: const TextStyle(fontSize: 14,color: Colors.white),),
              )else
               const Text("Pull down to refresh")
            ],
          ),
        ));
  }
}


/*

 */