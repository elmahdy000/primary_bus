import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth_services.dart';
import '../utiles/utiles.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
 const SignUpScreen() : super();



  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
 final TextEditingController universityController = TextEditingController();
  bool obsecureText = true;
   Uint8List? _image;
  bool isLoading = false;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }



  Future<String> signUp()
  async {
    setState(()  {
      isLoading = true;
    });
    String res = await AuthServices().signupUser(username: usernameController.text, password: passController.text, email: emailController.text, phone: phoneController.text, tag: "", file: _image!,university: universityController.text);


  setState(() {
    isLoading = false;
  });

  return res;
  }



@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passController.dispose();
    universityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.webp'),
                      ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                    color: Colors.white),
                child:  TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      hintText: "Enter Username",
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                    color: Colors.white),
                child:  TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: "Enter Email Address",
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                    color: Colors.white),
                child:  TextField(
                  obscureText: obsecureText,
                  controller: passController,
                  decoration:  InputDecoration(

                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          obsecureText = !obsecureText;
                        });
                      },
                      child: obsecureText == true ?Icon(Icons.visibility_off):Icon(Icons.visibility),
                    ),
                      hintText: "Enter password ",
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                    color: Colors.white),
                child:  TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      hintText: "Enter phone number",
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25),
                    color: Colors.white),
                child:  TextField(
                  controller: universityController,
                  decoration: const InputDecoration(
                      hintText: "Enter Your University",
                      border: InputBorder.none),
                ),
              ),
            ),
             GestureDetector(
               onTap: () {
              signUp();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

               },
               child: Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[400]
                  ),
                child: const Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 20,),),
            ),),
             )

          ],
        )),
      )),
    );
  }
}
