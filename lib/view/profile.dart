import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker_task/components.dart';
import 'package:weight_tracker_task/view/login.dart';
import 'package:weight_tracker_task/view_model/view_model.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  AppViewModel view_model = AppViewModel();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Email : ${view_model.userEmail}"),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            myReplaceNavigator(context, LoginPage());
          }, child: Text("Logout"))
        ],
      ),
    );
  }
}