import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/codegen_loader.g.dart';
import 'package:shop/layout/home_layout/home_layout.dart';
import 'package:shop/modules/log_in_screen/log_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/themes.dart';

import 'Provider/bloc_observer.dart';
import 'modules/product_details.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  DioHelper.init();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      assetLoader: CodegenLoader(),
      fallbackLocale: Locale('ar'),
      startLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    if(onBoarding != false){
      if(token != null) widget = HomeLayOut();
      else widget = LogInScreen();
    }

    return BlocProvider(
          create: (context) => AppCubit(),
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              if(state is ShopSuccessHome) loadedMain = true;
            },
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'sharwa',
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                home: widget,
          );
            },
          ),
    );
  }
}

