
import 'package:flutter/material.dart';

void navigatorPR({@required context,@required page}) =>  Navigator.pushReplacement(
  context,
  MaterialPageRoute(
      builder: (context) => page),
);