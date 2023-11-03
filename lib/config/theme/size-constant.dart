import 'dart:math';

import 'package:flutter/cupertino.dart';


double titleSize = 20;
double supTitleSize = 24;
double defaultSize = 16;

double miniSize = 13;
final double kConstantPadding = 10;

double roundDouble(double? value,  int places){ 
    if (value != null){
         num mod = pow(10, places); 
         return ((value * mod).round().toDouble() / mod); 
    } 
    else return 0.0;
}