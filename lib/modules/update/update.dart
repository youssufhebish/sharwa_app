
import 'package:flutter/material.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/layout/home_layout/home_layout.dart';
import 'package:shop/modules/profile/profile_screen.dart';
import 'package:shop/shared/components/default_button.dart';
import 'package:shop/shared/components/default_text_field.dart';
import 'package:shop/shared/components/push_replacement.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateScreen extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('update data'.toString(),
          style: TextStyle(color: primaryColor),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                defaultTextField(
                    controller: nameController,
                    hint: LocaleKeys.username.tr(),
                    validation: (String value) {
                      if (value.isEmpty) {
                        return LocaleKeys.usernamevalidation.tr();
                      }
                    },
                    prefix: Icons.person,
                ),
                SizedBox(
                  height: 15.0,
                ),
                defaultTextField(
                    controller: emailController,
                    hint: LocaleKeys.email.tr(),
                    validation: (String value) {
                      if (value.isEmpty) {
                        return LocaleKeys.emailvalidation.tr();
                      }
                    },
                    prefix: Icons.email,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(
                  height: 15.0,
                ),
                defaultTextField(
                    controller: phoneController,
                    hint: LocaleKeys.phone.tr(),
                    validation: (String value) {
                      if (value.isEmpty) {
                        return LocaleKeys.phonevalidation.tr();
                      }
                    },
                    prefix: Icons.phone,
                    keyboardType: TextInputType.phone),
                SizedBox(
                  height: 15.0,
                ),
                defaultButton(text: LocaleKeys.update.tr(), onPressed: (){
                      if(formKey.currentState.validate()) {
                        AppCubit.get(context).updateUser(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayOut()));
                      }
                    }),
                SizedBox(
                  height: 15.0,
                ),
                defaultButton(text: LocaleKeys.cancel.tr(), onPressed: (){
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
      );
  }
}
