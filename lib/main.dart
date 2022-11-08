import 'package:flutter/material.dart';
import 'package:primary_bus/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:primary_bus/screens/login_screen.dart';
import 'package:primary_bus/screens/signup_screen.dart';
import 'package:primary_bus/services/update_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (context)=>UpdateData(),
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Bus',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData)
            {
              return const HomePage();
            }
          if(snapshot.hasError){
            return const Text('Error');
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }

          return const LoginScreen();
        },
      )
    ),);
  }
}



