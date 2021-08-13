import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/layout/home_layout/home_layout.dart';
import 'package:shop/modules/log_in_screen/log_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/components/default_button.dart';
import 'package:shop/shared/components/default_text_field.dart';
import 'package:shop/shared/components/push_replacement.dart';
import 'package:shop/shared/components/toast.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ShopRegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state)
        {
          if (state is ShopRegisterSuccessState)
          {
            if (state.loginModel.status)
            {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value)
              {
                token = state.loginModel.data.token;

                navigatorPR(
                  context: context,
                  page: HomeLayOut(),
                );
              });
            } else {
              print(state.loginModel.message);

              showToast(
                message: state.loginModel.message,
                state: toastState.ERROR,
              );
            }
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.register.tr(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          LocaleKeys.registermessage.tr(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return LocaleKeys.usernamevalidation.tr();
                            }
                          },
                          hint: LocaleKeys.username.tr(),
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return LocaleKeys.emailvalidation.tr();
                            }
                          },
                          hint: LocaleKeys.email.tr(),
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value)
                          {

                          },
                          isPass: ShopRegisterCubit.get(context).isPassword,
                          obSecure: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validation: (String value) {
                            if (value.isEmpty) {
                              return LocaleKeys.passwordvalidation.tr();
                            }
                          },
                          hint: LocaleKeys.password.tr(),
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return LocaleKeys.phonevalidation.tr();
                            }
                          },
                          hint: LocaleKeys.phone.tr(),
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: LocaleKeys.register.tr(),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(LocaleKeys.haveanaccount.tr()),
                            SizedBox(
                              width: 10.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LogInScreen(),
                                      ));
                                },
                                child: Text(
                                  LocaleKeys.login.tr().toUpperCase(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}