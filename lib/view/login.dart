import 'package:flutter/material.dart';
import '../components.dart';
import '../view_model/view_model.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

   AppViewModel viewModel = AppViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weight Tracker"),
      centerTitle: true,
      automaticallyImplyLeading: false, ),
      
      body: ListView(
        children: [
          const SizedBox(height: 100,),
          SizedBox(
            child: Form(
              key: formstatelogin,
              child: Column(
                children: [
                  const Text("Login to Weight Tracker",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

                  const SizedBox(height: 30,),

                   myTextField('Email',Icons.email_outlined ,const Icon(null) ,(){},loginemail,false,myvalEmail),
                   myTextField('Password',Icons.lock_outline,viewModel.isvisible? const Icon(Icons.visibility_off):const Icon(Icons.visibility) ,viewModel.visibility,loginpassword,viewModel.isvisible,myvalPassword),

                  ElevatedButton(onPressed:(){viewModel.login(context);},
                   child: viewModel.loginTap? Container( 
                    margin: const EdgeInsets.symmetric(horizontal: 122,vertical: 10),child: const CircularProgressIndicator(color: Colors.white,strokeWidth:4.5 ,)) : 
                   const Text("Login ",style: TextStyle(fontSize: 18),),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 40),
                  ), ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Text("Don't have Account? ",),
                         TextButton(child:const Text("create One "),onPressed: (){myPushNavigator(context, SignUpPage());}),
                      ],
                    ), 
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}