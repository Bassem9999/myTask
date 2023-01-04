import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker_task/model/components.dart';
import 'package:weight_tracker_task/view/login.dart';

import '../controller/appCubit.dart';
import '../controller/appStates.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
      var cubit = AppCubit.get(context);
      return Scaffold(
      appBar: AppBar(
        title: Text("Weight Tracker"),
        centerTitle: true,
        leading: IconButton(onPressed: ()async{
          SharedPreferences prefernces = await SharedPreferences.getInstance();
          Navigator.maybeOf(context)!.pushReplacement(MaterialPageRoute(builder: ((context) => LoginPage())));
           prefernces.setBool('login',false);
        }, icon: Icon(Icons.logout)),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          const Center(child: Text("Add New Weight",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: myWeightTextField("new weight", Icons.monitor_weight_outlined,weight, cubit.myvalEmail)),
              Expanded(
                flex: 1,
                child: ElevatedButton(onPressed: (){
                  cubit.addWeight(context,'weights', {'weight':weight.text,'time':DateTime.now().toString()}, weight.text);
                  print(DateTime.now());
                },child: const Text("Add Weight"),)),
                const SizedBox(width: 5,)
            ],
          ),
          SizedBox(
            height: 500,
            child: FutureBuilder(
              future: cubit.getdata('weights'),
              builder: ((BuildContext context,AsyncSnapshot snapshot){
                if(snapshot.hasData){
                return ListView.builder(itemCount: snapshot.data.length,
                itemBuilder: (context,i){
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Row(
                            children: [
                              Text("  Weight : ${snapshot.data[i]['weight']}"),
                            ],
                          )),
                          Expanded(child: Text("Date : ${snapshot.data[i]['time']}")),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(onPressed: (){cubit.showUpdatedialog(context,snapshot.data[i]['weight']);}, child: Text("Update"),
                            style: ElevatedButton.styleFrom(fixedSize: Size(80, 2),
                            )),
                          ),
                          Spacer(),
                           SizedBox(
                            height: 30,
                             child: ElevatedButton(onPressed: (){
                              cubit.deleteWeight(context, snapshot.data[i]['weight']);
                             }, child: Text("Delete"),
                          style: ElevatedButton.styleFrom(fixedSize: Size(80, 2),
                          )),
                           )
                        ],
                      ),
                       SizedBox(height: 10,),
                    ],
                  ),
                );
                });
                }else{
                  return const Center(child: CircularProgressIndicator());
                }
              }),
              
                
               ),
          ),
        ],
      )
    );
      });
  }
}