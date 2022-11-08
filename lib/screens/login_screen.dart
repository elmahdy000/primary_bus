import 'package:flutter/material.dart';
import 'package:primary_bus/screens/home_page.dart';
import 'package:primary_bus/screens/signup_screen.dart';

import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen() : super();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;
  Future<String> singIn()
  async {
    setState(()  {
      isLoading = true;
    });
    String res = await AuthServices().signIn(email: emailController.text,password: passController.text);


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
    passController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: AppBar(
       title: const Text('Login Page'),
     ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius:  BorderRadius.circular(25),
                color: Colors.white,),

            child:   TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: "Enter Email Address",
                  border: InputBorder.none),
            ),
            ),

            ),

          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius:  BorderRadius.circular(25)
                       ),


              child:  TextField(
                controller: passController,
                decoration: const InputDecoration(
                    hintText: "Enter password ",
                    border: InputBorder.none),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(onPressed: (){
                  singIn();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                }, child: const Text('SignIn',style: TextStyle(fontSize: 16),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Don\'t has account"),
              ),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
              }, child: const Text('SingUp'))
            ],
          )
        ],
      ),
    );
  }
}
