import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<UserInfo> userInfoFromJson(String str) =>
    List<UserInfo>.from(json.decode(str).map((x) => UserInfo.fromJson(x)));

String userInfoToJson(List<UserInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserInfo {
  UserInfo(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.imgUrl,
      required this.tag,
      required this.university});

  String uid;
  String name;
  String email;
  String phone;
  String imgUrl;
  String tag;
  String university;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        uid: json["uid"],
        name: json[" name"],
        email: json["email"],
        phone: json["phone"],
        imgUrl: json["imgUrl"],
        tag: json["tag"],
        university: json["university"],
      );
  factory UserInfo.fromSnap(DocumentSnapshot json) => UserInfo(
        uid: json["uid"],
        name: json[" name"],
        email: json["email"],
        phone: json["phone"],
        imgUrl: json["imgUrl"],
        tag: json["tag"],
        university: json["university"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        " name": name,
        "email": email,
        "phone": phone,
        "imgUrl": imgUrl,
        "tag": tag,
        "university": university
      };
}
