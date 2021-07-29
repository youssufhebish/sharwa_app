

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/log_in_screen/cubit/state.dart';

class LogInScreenCubit extends Cubit<LogInScreenState>{

  LogInScreenCubit() : super(LogInScreenInitial());

  static LogInScreenCubit get(context) => BlocProvider.of(context);

  IconData iObSecure = Icons.visibility_outlined;
  bool isPass = true;

  void obSecureChange(bool b){
    if(b){
      isPass = false;
      iObSecure = Icons.visibility_off_outlined;
      print(false);
      emit(ObSecureState());
    } else{
      isPass = true;
      iObSecure = Icons.visibility_outlined;
      print(true);
      emit(ObSecureState());
    }

  }
}