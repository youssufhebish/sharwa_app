import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/modules/log_in_screen/log_screen.dart';
import 'package:shop/modules/update/update.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/components/default_button.dart';
import 'package:shop/shared/components/push_replacement.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ConditionalBuilder(
                  condition: cubit.loadedHome,
                  builder: (context) =>
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 45,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(cubit.userModel.data.image,),
                                        radius: 40.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10.0,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.userModel.data.name,
                                        style: TextStyle(color: primaryColor, fontSize: 24.0, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        cubit.userModel.data.email,
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14.0,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Text(
                                        cubit.userModel.data.phone,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    iconSize: 35.0,
                                    color: primaryColor,
                                    icon: Icon(Icons.edit_road),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 28.0,
                            alignment: cubit.langSelector? Alignment.topLeft : Alignment.topRight,
                              child: Text('${LocaleKeys.languageChange.tr().toUpperCase()}', style: TextStyle(fontSize: 18.0),)),
                          SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async{
                                  cubit.changeLang(1);
                                  await context.setLocale(Locale('en'));
                                  cubit.getHome();
                                  cubit.getCategories();
                                  cubit.getFavorites();
                                  cubit.getUser();
                                },
                                child: Container(
                                  width: 100.0,
                                  height: 35.0,
                                  child: Center(
                                    child: Text(
                                      'english'.toUpperCase(),
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: cubit.langSelector? primaryColor : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                onTap: () async{
                                  cubit.changeLang(2);
                                  await context.setLocale(Locale('ar'));
                                  cubit.getHome();
                                  cubit.getCategories();
                                  cubit.getFavorites();
                                  cubit.getUser();
                                },
                                child: Container(
                                  width: 100.0,
                                  height: 35.0,
                                  child: Center(
                                    child: Text(
                                      'العربية'.toUpperCase(),
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: !cubit.langSelector? primaryColor : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(text: LocaleKeys.logoout.tr(), onPressed: (){
                            loadedMain = false;
                            CacheHelper.removeData(key: 'token').then((value) {
                              if(value)
                              {
                                navigatorPR(context: context, page: LogInScreen());
                              }
                            });
                          }),
                        ],
                      ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator())),
            ),
          ),
        );
      },
    );
  }
}
