
import 'package:flutter/material.dart';

Widget defaultButton({
  @required String text,
  @required Function onPressed,
}) => Container(
  height: 50.0,
  width: double.infinity,
  child: ElevatedButton(
    onPressed: onPressed,
    child: Text(
      text.toUpperCase(),
    ),
  ),
);