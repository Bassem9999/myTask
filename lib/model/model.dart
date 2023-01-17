

class WeightsModel{
 late String weight;
 late String time;
  

  WeightsModel(this.weight,this.time);
  WeightsModel.fromJson(var json){
    weight = json['weight'];
    time = json['time'];
  }

  Map<String,dynamic> toJson(){
    return {'weight':weight, 'time':time};
  }



}