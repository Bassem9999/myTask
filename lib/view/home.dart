import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker_task/components.dart';
import 'package:weight_tracker_task/model/model.dart';
import 'package:weight_tracker_task/view/homeScreen.dart';
import 'package:weight_tracker_task/view/login.dart';
import 'package:weight_tracker_task/view/profile.dart';
import 'package:weight_tracker_task/view_model/view_model.dart';




class HomePage extends ConsumerWidget {
 HomePage({super.key});


  @override
  Widget build(BuildContext context,ref) {
    final indexProv = ref.watch(indexProvider);
    List Screens = [HomeScreen(),ProfileScreen()];
    return  Scaffold(
      appBar: AppBar(
        title: Text("Weight Tracker"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexProv,
        onTap: (value){
          ref.read(indexProvider.state).state = value;
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
            ),

            BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
            ),

        ],
      ),
      body: Screens[indexProv]
    );
  }
}