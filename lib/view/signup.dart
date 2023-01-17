import 'package:flutter/material.dart';
import '../components.dart';
import '../view_model/view_model.dart';
import 'login.dart';

class SignUpPage extends StatelessWidget {
 SignUpPage({Key? key}) : super(key: key);
  
      AppViewModel viewModel = AppViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weight Tracker"),
      centerTitle: true,
      automaticallyImplyLeading: false,
      ),
      

      body: ListView(
        children: [
          const SizedBox(height: 100,),
          SizedBox(
            child: Form(
              key: formstatesignup,
              child: Column(
                children: [
                  const Text("Create Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 30,),
                   myTextField('Email',Icons.email_outlined ,const Icon(null),null,createemail,false,myvalEmail),
                   myTextField('Password',Icons.lock_outline ,viewModel.isvisible? const Icon(Icons.visibility_off):const Icon(Icons.visibility) ,viewModel.visibility,createpassword,viewModel.isvisible,myvalPassword),
                   myTextField('ConfirmPassword',Icons.confirmation_number_outlined,viewModel.isvisible? const Icon(Icons.visibility_off):const Icon(Icons.visibility) ,viewModel.visibility,confirmpassword,viewModel.isvisible,myvalConfirmPassword),
            
                  ElevatedButton(onPressed:(){viewModel.signUp(context);}, child: viewModel.signupTap? Container( 
                    margin: const EdgeInsets.symmetric(horizontal: 122,vertical: 10),child: const CircularProgressIndicator(color: Colors.white,strokeWidth:4.5 ,)) : 
                   const Text("Create Account ",style: TextStyle(fontSize: 17),),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 40),
                   //animationDuration: Duration(milliseconds: 2000)  
                  ), 
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Text("Already have Account? ",),
                         TextButton(child:const Text("Login "),onPressed: (){myPushNavigator(context, LoginPage());},),
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