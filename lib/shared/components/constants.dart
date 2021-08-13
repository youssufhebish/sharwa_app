
import 'package:flutter/material.dart';
import 'package:shop/modules/onboarding/onboarding.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

bool onBoarding = CacheHelper.getData(key: 'onBoarding') == null? false: true;

String token = CacheHelper.getData(key: 'token');

Widget widget = OnBoardingScreen();

bool loadedMain = false;

bool loadedHome = false;