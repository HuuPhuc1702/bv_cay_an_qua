import 'dart:math';

num? roundDouble(double? value,  int places){
  try{
    if (value != null){
      num mod = pow(10, places);
      return ((value * mod).round().toDouble() / mod);
    }
    else return 1.0;
  }catch(error){
    return null;
  }
}