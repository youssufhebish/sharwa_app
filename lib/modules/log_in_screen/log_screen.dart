import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/layout/home_layout/home_layout.dart';
import 'package:shop/modules/register_screen/register_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/components/default_button.dart';
import 'package:shop/shared/components/default_text_field.dart';
import 'package:shop/shared/components/push_replacement.dart';
import 'package:shop/shared/components/toast.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';

class LogInScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          var cubit = AppCubit.get(context);
          if (state is ShopLoginSuccess) {
            if (cubit.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                      key: 'token', value: cubit.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigatorPR(
                  context: context,
                  page: HomeLayOut(),
                );
              });

              showToast(
                  message: cubit.loginModel.message, state: toastState.SUCCESS);
            }
          } else if (state is ShopLoginError) {
            showToast(
                message: cubit.loginModel.message, state: toastState.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.login.tr().toUpperCase(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          LocaleKeys.loginmessage.tr(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: defaultTextField(
                              keyboardType: TextInputType.text,
                              controller: emailController,
                              hint: LocaleKeys.email.tr(),
                              validation: (value) {
                                if (value.isEmpty)
                                  return  LocaleKeys.emailvalidation.tr();
                                else
                                  return null;
                              },
                              prefix: Icons.email_outlined),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: defaultTextField(
                            isPass: cubit.isPass,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passController,
                            hint:  LocaleKeys.password.tr(),
                            validation: (value) {
                              if (value.isEmpty)
                                return LocaleKeys.passwordvalidation.tr();
                              else
                                return null;
                            },
                            prefix: Icons.vpn_key,
                            suffix: cubit.iObSecure,
                            obSecure: () => cubit.obSecureChange(cubit.isPass),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoading,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: defaultButton(
                                text: LocaleKeys.login.tr(),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    print(emailController.text);
                                    print(passController.text);
                                  }
                                  cubit.userLogin(email: emailController.text, password: passController.text);
                                }),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(LocaleKeys.donthave.tr()),
                            SizedBox(
                              width: 10.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ShopRegisterScreen(),
                                      ));
                                },
                                child: Text(
                                  LocaleKeys.register.tr().toUpperCase(),
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
