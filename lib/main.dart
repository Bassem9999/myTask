import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker_task/view/login.dart';
import '../controller/appStates.dart';
import 'view/home.dart';
import '../controller/appCubit.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
 SharedPreferences prefernces = await SharedPreferences.getInstance();
await Firebase.initializeApp();
  runApp(MyApp(login: prefernces.getBool('login'),));
}

class MyApp extends StatelessWidget {
  bool? login;
   MyApp({this.login});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder:(context,state){
          return MaterialApp(
        title: 'Weight Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: login==true? const HomeScreen() : const LoginPage(),
      );
        }
      )
      
    );
  }
}

