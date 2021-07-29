

import 'package:flutter/material.dart';

Widget defaultTextField({
  @required TextEditingController controller,
  @required String hint,
  @required Function validation,
  bool isPass = false,
  IconData prefix,
  IconData suffix,
  Function obSecure,
  TextInputType keyboardType = TextInputType.text,
}) =>
    TextFormField(
      obscureText: isPass,
      controller: controller,
      keyboardType: keyboardType,
      validator: validation,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontStyle: FontStyle.italic),
        suffixIcon: IconButton(icon: Icon(suffix), onPressed: obSecure,),
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
      ),
    );

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