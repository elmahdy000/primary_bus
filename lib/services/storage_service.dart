import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class StorageMethods
{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String catName,Uint8List file) async
  {
    Reference ref = _storage.ref().child(catName).child(_auth.currentUser!.uid);
    TaskSnapshot task =  await ref.putData(file);
    String url =  await task.ref.getDownloadURL();

    return url;
  }
}