import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components.dart';
import '../model/model.dart';
import '../view_model/view_model.dart';

class HomeScreen extends ConsumerWidget {
   HomeScreen({super.key});

   AppViewModel viewModel = AppViewModel();
  @override
  Widget build(BuildContext context,ref) {
    final data = ref.watch(dataProvider);
    return ListView(
        children: [
          const SizedBox(height: 20,),
          const Center(child: Text("Add New Weight",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: myWeightTextField("new weight", Icons.monitor_weight_outlined,weight, viewModel.myvalEmail)),
              Expanded(
                flex: 1,
                child: ElevatedButton(onPressed: (){
                  viewModel.addWeight(context,'weights', {'weight':weight.text,'time':DateTime.now().toString()}, weight.text);
                  print(DateTime.now());
                },child: const Text("Add Weight"),)),
                const SizedBox(width: 5,)
            ],
          ),
          SizedBox(
            height: 500,
            child: data.when(
              data: (QuerySnapshot value){ 
               return ListView.builder(
                itemCount:value.docs.length,
                itemBuilder :(context,i){
                  WeightsModel weightsModel = WeightsModel.fromJson(value.docs[i].data());
                  return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Row(
                            children: [
                              Text("  Weight : ${weightsModel.weight}"),
                            ],
                          )),
                          Expanded(child: Text("Date : ${weightsModel.time}")),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                           SizedBox(width: 10,),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(onPressed: (){viewModel.showUpdatedialog(context,weightsModel.weight[i]);}, child: Text("Update"),
                            style: ElevatedButton.styleFrom(fixedSize: Size(80, 2),
                            )),
                          ),
                          Spacer(),
                           SizedBox(
                            height: 30,
                             child: ElevatedButton(onPressed: (){
                              viewModel.deleteWeight(context, weightsModel.weight[i]);
                             }, child: Text("Delete"),
                          style: ElevatedButton.styleFrom(fixedSize: Size(80, 2),
                          )),
                           ),
                           SizedBox(width: 10,)
                        ],
                      ),
                       SizedBox(height: 10,),
                    ],
                  ),
                );
                }
               );
  },
               error:(e,s)=> Text("errror"),
                loading:()=> Center(child: CircularProgressIndicator())),
          ),
        ],
      );
  }
}