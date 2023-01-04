// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';




 TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();

  GlobalKey<FormState> formstatelogin = GlobalKey<FormState>();

  TextEditingController createemail = TextEditingController();
  TextEditingController createpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  GlobalKey<FormState> formstatesignup = GlobalKey<FormState>(); 

  TextEditingController weight = TextEditingController();
  TextEditingController update = TextEditingController();
 
  
  GlobalKey<FormState> weightForm = GlobalKey<FormState>(); 



var categories = ['clothes','accessories','technologies',];
String? category;




myTextField(String label,prefex,suffex, action,TextEditingController mycontroller,bool isSecure,var myval){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
            controller: mycontroller,
            validator: myval,
            obscureText: isSecure,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(prefex),
              suffixIcon: IconButton(icon:suffex,onPressed: action,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),    
              ),
            ),
    ),
  );
}

myWeightTextField(String label,prefex,TextEditingController mycontroller,var myval){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
            controller: mycontroller,
            validator: myval,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(prefex),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),    
              ),
            ),
    ),
  );
}



myPushNavigator(context,screen){
  return Navigator.of(context).push(MaterialPageRoute(builder: (context)=>screen));
}

myReplaceNavigator(context,screen){
 return Navigator.maybeOf(context)!.pushReplacement(MaterialPageRoute(builder: (context)=>screen));
}

showdialog(context,String text,var content,var color){
    return showDialog(context: context, builder: (context){
      return AlertDialog(title: Text(text,style: TextStyle(color: Colors.white),),
      content: content,
      backgroundColor: color ,);
    });
  }

  snackbar(context,String message){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.green,));  
  }


String? myvalEmail(text){
  if(text.trim().isEmpty){
      return "This field mustn't be empty";  
  }
}

 String? myvalPassword(text){
  if(text.trim().isEmpty){
    return "This field mustn't be empty";   
  }
  else if(text.trim().length < 8){
        return "Password should be 8 characters or more";
  }
}

 
String? myvalConfirmPassword(text){
  if(text.trim().isEmpty){

    return "This field mustn't be empty";
     }
  
  else if(text != createpassword.text){

    return "Passwords is not the same ";
     
  }
}


 mylistwidget(String text,String image){
  return  Container(
                  height: 140,
                  width: 120,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(image:AssetImage(image),fit: BoxFit.cover, )
                        ),
                        ),
                    )

                    ],
                  ),
                );
 }



 myProductWidget(i,source,Widget? button,bool icon,context){
  return Row(
          children: [
          Container(
            height: 130,
            width: 130,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(image:  NetworkImage(source[i]['imageUrl']),fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(20)
            ),
            ),
            
            SizedBox(width: 20,),
  
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(" "+source[i]['name'],
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Price : "),

                    Text(source[i]['newPrice']+ " \$",style: TextStyle(color: Colors.deepOrange)),
                    
                    SizedBox(width: 20,),
                    
                    Text(source[i]['oldPrice'] + " \$",
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),),
                  ],
                ),
              ),
            
                  Text("  Discount : "+source[i]['discount']+" %",style: TextStyle(color: Colors.grey),),

              SizedBox(
                width: 180,
                child: Row(
                children: [
                 
                   icon? IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: Colors.black,size: 20,)):Icon(null),
                   Spacer(),
                  // SizedBox(width: MediaQuery.of(context).size.width /10,),
                 
                   SizedBox(
                      width: 100,
                      height: 30,
                      child:button
                    ),
                  
                ],
                ),
              )
            ],
          ),
        ],
      );
 }

 

