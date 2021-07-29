import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/modules/log_in_screen/cubit/cubit.dart';
import 'file:///D:/Programming/Projects/shope/shop/lib/modules/onboarding/onboarding.dart';
import 'package:shop/shared/styles/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => AppCubit(),
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) => null,
            builder: (context, state) {
              return MaterialApp(
                title: 'shop',
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                home: OnBoardingScreen(),
              );
            },
          ),
    );
  }
}

