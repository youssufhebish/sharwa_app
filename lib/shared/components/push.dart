
import 'package:flutter/material.dart';

void navigatorP({@required context,@required page}) =>  Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => page),
);