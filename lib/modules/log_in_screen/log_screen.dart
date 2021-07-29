import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/log_in_screen/cubit/cubit.dart';
import 'package:shop/modules/log_in_screen/cubit/state.dart';
import 'package:shop/shared/components/widgets.dart';

class LogInScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LogInScreenCubit(),
      child: BlocConsumer<LogInScreenCubit, LogInScreenState>(
        listener: (context, state) => null,
        builder: (context, state) {
          var cubit = LogInScreenCubit.get(context);
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'log-in to view our hot offers',
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
                              hint: 'e-mail',
                              validation: (value) {
                                if (value.isEmpty)
                                  return 'Email must not to be empty ..';
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
                            hint: 'password',
                            validation: (value) {
                              if (value.isEmpty)
                                return 'password must not to be empty ..';
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
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: defaultButton(
                              text: 'log in',
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  print(emailController.text);
                                  print(passController.text);
                                }
                              }),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account?'),
                            SizedBox(
                              width: 10.0,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Register'.toUpperCase(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ))
                          ],
                        )
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
