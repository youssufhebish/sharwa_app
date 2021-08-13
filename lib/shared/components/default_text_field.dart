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
  onSubmit,
}) =>
    TextFormField(
      obscureText: isPass,
      controller: controller,
      keyboardType: keyboardType,
      validator: validation,
      onFieldSubmitted: onSubmit,
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