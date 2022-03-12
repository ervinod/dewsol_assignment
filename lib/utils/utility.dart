import 'package:flutter/material.dart';

//Getting Full height of current Screen
double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//Getting Full width of current Screen
double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
