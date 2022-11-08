import 'package:flutter/material.dart';
import 'package:primary_bus/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:primary_bus/model/user_info.dart' as model;
class UpdateData extends ChangeNotifier
{

  model.UserInfo? _userInfo;
  String? _counter ;
  model.UserInfo? get getUser=> _userInfo;
  String? get getCounter => _counter;
  bool isDataCalled=false;

  Future<void> getData() async{
    isDataCalled = true;
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot =await  db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    _userInfo = model.UserInfo.fromSnap(snapshot);
    notifyListeners();
    if(_userInfo?.tag==null||_userInfo!.tag!.isEmpty)
    {
      _counter = null;
      notifyListeners();
      return;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref().child(_userInfo!.tag);
    ref.onValue.listen((event) {
      final count =int.tryParse( event.snapshot.value.toString());

      if(count!=null){
        _counter = event.snapshot.value.toString();
      }else{
        _counter=null;
      }
      notifyListeners();
    });

  }

Future<void> signOut() async
{
  await FirebaseAuth.instance.signOut();
  notifyListeners();
}



}