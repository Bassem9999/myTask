import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker_task/view/login.dart';
import 'view/home.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
SharedPreferences prefernces = await SharedPreferences.getInstance();
if(prefernces.getBool('login') == null){
  prefernces.setBool('login', false);
}
await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp(login: prefernces.getBool('login'),)));
}

class MyApp extends StatelessWidget {
  bool? login;
   MyApp({this.login});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
       return MaterialApp(
        title: 'Weight Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: login == true?  HomePage() : LoginPage(),
      );
        
      
  }
}

