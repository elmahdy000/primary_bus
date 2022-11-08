import 'dart:typed_data';
import '../model/user_info.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:primary_bus/services/storage_service.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthServices{
   late FirebaseAuth _auth;
  late FirebaseFirestore _db;
  late DatabaseReference _dbrel;

 AuthServices(){
   _auth = FirebaseAuth.instance;
   _db = FirebaseFirestore.instance;
   _dbrel = FirebaseDatabase.instance.ref();
 }

 Future<String> signupUser ({
    required String username,
    required String password,
    required String email,
    required String phone,
    required String tag,
    required String university,
    required Uint8List file
 })async
 {
   String res = "Error in Signup";
   try
   {
     if(username.isNotEmpty || password.isNotEmpty || email.isNotEmpty || phone.isNotEmpty || tag.isNotEmpty || university.isNotEmpty ||file != null)
     {
       UserCredential userCredential =   await _auth.createUserWithEmailAndPassword(email: email, password: password);

       String photoUrl = await  StorageMethods().uploadImageToStorage('profileImages', file);
       model.UserInfo userInfo = model.UserInfo(
         uid: _auth.currentUser!.uid,
         name: username,
         email: email,
         imgUrl: photoUrl,
         phone: phone,
         tag: tag,
         university: university
                );
    //   await _dbrel.child(userCredential.user!.uid).set({"uid": _auth.currentUser!.uid,"tag" :tag});
       await  _db.collection('users').doc(userCredential.user!.uid).set(userInfo.toJson());
       res = "success";

     }

   }catch(e)
   {
     res =e.toString();
   }

   return res;
 }

 Future<String> signIn ({

    required String password,
   required String email,

 })async
 {
   String res = "Error in Signup";
   try
   {
     if(password.isNotEmpty || email.isNotEmpty )
     {
       UserCredential userCredential =   await _auth.signInWithEmailAndPassword(email: email, password: password);
       res = "success";

     }

   }catch(e)
   {
     res =e.toString();
   }

   return res;
 }

 Future<void> updataUser() async
 {

  
   DatabaseReference ref = _dbrel.child(_auth.currentUser!.uid).child('quta');
   ref.get().then((snapshot){

     _db.collection('users').doc(_auth.currentUser!.uid).update({
       "quta" : snapshot.value
     });
   }

   );







 }

}



