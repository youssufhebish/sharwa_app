import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({@required String message, @required toastState state}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state: state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum toastState {SUCCESS, ERROR, WARNING}

Color chooseToastColor({@required toastState state}){
  Color color;

  switch(state)
  {
    case toastState.SUCCESS:
      color = Colors.green;
      break;
    case toastState.ERROR:
      color = Colors.red;
      break;
    case toastState.WARNING:
      color = Colors.yellow;
      break;
  }
  
  return color;
}