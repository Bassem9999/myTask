import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/components.dart';
import '../view/home.dart';
import 'appStates.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(NewsIntialState());

 static AppCubit get(context) => BlocProvider.of(context);

bool loginTap = false; 
bool signupTap = false;
bool isvisible = true;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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
      emit(PasswordVisibilityState()); 
    }


   login(context)async{
     SharedPreferences prefernces = await SharedPreferences.getInstance();
    var currentData = formstatelogin.currentState;
    currentData!.save();
    if(currentData.validate()){
      loginTap = true;
      emit(LoginLoadingState());
    await _auth.signInWithEmailAndPassword(email: loginemail.text.trim(), password: loginpassword.text.trim()).then((value) {
      prefernces.setBool('login',true);
      print(prefernces.getBool('login').toString());
      myPushNavigator(context,HomeScreen());
       loginTap = false;
      emit(LoginNotLoadingState());
      print("success");
    }).catchError((onError){
      loginTap = false;
      emit(LoginNotLoadingState());
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
      emit(SignUpLoadingState());
    await _auth.createUserWithEmailAndPassword(email: createemail.text.trim(), password: createpassword.text.trim()).then((value) {
      prefernces.setBool('login',true);
      print(prefernces.getBool('login').toString());
      myPushNavigator(context,HomeScreen());
      signupTap = false;
      emit(SignUpNotLoadingState());
      print("success");
    }).catchError((onError){
      signupTap = false;
      emit(SignUpNotLoadingState());
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
    emit(AddtoCartState());
    }));
  }

  updateWeight(context,String collection, Map<String,dynamic> mydata,String p_name)async{
    await _firestore.collection(collection).doc(p_name).set(mydata).then((value){
    Navigator.pop(context);
    snackbar(context, "Item was Updated successfully");
    update.text = "";
    emit(UpdateWeightState());
    });
    
  }

   deleteWeight(context,String document)async{
    await _firestore.collection('weights').doc(document).delete().then((value) {
      snackbar(context, "Item was Deleted successfully");
      emit(DeleteWeightState());
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