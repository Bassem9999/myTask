import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components.dart';
import '../view/home.dart';

final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

 final dataProvider = StreamProvider<QuerySnapshot>(((ref) => getdata().asStream()));

Future<QuerySnapshot>getdata()async{
   var data = await _firestore.collection('weights').orderBy('time',descending: true).get();
   return data;
   }

   final indexProvider = StateProvider<int>(((ref) => 0));

 class AppViewModel{
  
  bool loginTap = false; 
  bool signupTap = false;
  bool isvisible = true;

  String userEmail = loginemail.text;

  

showUpdatedialog(context,String text){
    return showDialog(context: context, builder: (context){
      return AlertDialog(title: Column(
        children: [
          Row(
            children: [
              Text(" Weight : "),
              SizedBox(
                width: 80,
                height: 20,
                child: TextFormField(
                  controller: update,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: text
                  ),
                 ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          ElevatedButton(onPressed: (){updateWeight(context, 'weights', {
            'weight': update.text,
            'time' : DateTime.now().toString()
          },text);}, 
          child: Text("Update"))
        ],
      ),
     
    );
    });
  }


    visibility(){
      isvisible = !isvisible;
    }


   login(context)async{
     SharedPreferences prefernces = await SharedPreferences.getInstance();
    var currentData = formstatelogin.currentState;
    currentData!.save();
    if(currentData.validate()){
      loginTap = true;
    await _auth.signInWithEmailAndPassword(email: loginemail.text.trim(), password: loginpassword.text.trim()).then((value) {
      prefernces.setBool('login',true);
      prefernces.setString('email',loginemail.text);
      myReplaceNavigator(context,HomePage());
       loginTap = false;
      print("success");
    }).catchError((onError){
      loginTap = false;
      print(onError.toString());
      showdialog(context,"Some thing went Wrong",null,Colors.black);
    });   
    } 
  }


   signUp(context)async{
    SharedPreferences prefernces = await SharedPreferences.getInstance();
    var currentData = formstatesignup.currentState;
    currentData!.save();
    if(currentData.validate()){
      signupTap = true;
    await _auth.createUserWithEmailAndPassword(email: createemail.text.trim(), password: createpassword.text.trim()).then((value) {
      prefernces.setBool('login',true);
      print(prefernces.getBool('login').toString());
      myReplaceNavigator(context,HomePage());
      signupTap = false;
      print("success");
    }).catchError((onError){
      signupTap = false;
      print(onError.toString());
      showdialog(context, "Email not valid",null,Colors.white);
    });   
    }
  }


  getdata(String collection)async{
   var data = await _firestore.collection(collection).orderBy('time',descending: true).get();
   return data.docs;
  }

 addWeight(context,String collection, Map<String,dynamic> mydata,String p_name)async{
    await _firestore.collection(collection).doc(p_name).set(mydata).then(((value) {
    weight.text = "";
    snackbar(context, "Item was Added successfully");
    }));
  }

  updateWeight(context,String collection, Map<String,dynamic> mydata,String p_name)async{
    await _firestore.collection(collection).doc(p_name).set(mydata).then((value){
    Navigator.pop(context);
    snackbar(context, "Item was Updated successfully");
    update.text = "";
    });
    
  }

   deleteWeight(context,String document)async{
    await _firestore.collection('weights').doc(document).delete().then((value) {
      snackbar(context, "Item was Deleted successfully");
      print("success");
    });
    
  }


   

 

  








  




String? myvalEmail(text){
  if(text.trim().isEmpty){
      return "This field mustn't be empty";  
  }
}

 String? myvalPhone(text){
  if(text.trim().isEmpty){
    return "This field mustn't be empty";   
  }
  else if(text.trim().length < 10){
        return "Password should be 10 Numbers";
  }
  else if(text.startsWith(RegExp('05'))==false){
        return "should starts with 05";
   }
}

 
String? myvalConfirmPassword(text){
  if(text.trim().isEmpty){

    return "This field mustn't be empty";
     }
  
}
}