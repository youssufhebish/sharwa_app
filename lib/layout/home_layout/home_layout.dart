import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop/modules/search_screen/search_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/styles/colors.dart';

class HomeLayOut extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getHome()..getCategories()..getFavorites()..getUser(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if(state is ShopSuccessHome) loadedMain = true;
          },
          builder: (context, state){

            List<String> titles = [
              LocaleKeys.home.tr(),
              LocaleKeys.categories.tr(),
              LocaleKeys.favourites.tr(),
              LocaleKeys.profile.tr(),
            ];

            var cubit = AppCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  titles[cubit.currentIndex].toUpperCase(),
                  style: TextStyle(color: primaryColor),
                ),
                actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen(false)),
                      );
                    }),
              ],
            ),
              body: cubit.screenList[cubit.currentIndex],
              bottomNavigationBar: Container(
                color: Colors.white,
                child: SalomonBottomBar(
                  margin: EdgeInsets.all(5.0),
                  currentIndex: cubit.currentIndex,
                  itemPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
                  onTap: (index){
                    cubit.changeIndex(index);
                  },
                  items: [
                    SalomonBottomBarItem(
                      unselectedColor: Colors.grey,
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.home),
                      ),
                      title: Text(LocaleKeys.home.tr().toUpperCase(), style: TextStyle(fontFamily: 'Changa'),),
                      selectedColor: Colors.pink,
                    ),
                    SalomonBottomBarItem(
                      unselectedColor: Colors.grey,
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.category),
                      ),
                      title: Text(LocaleKeys.categories.tr().toUpperCase(), style: TextStyle(fontFamily: 'Changa'),),
                      selectedColor: Colors.indigoAccent,
                    ),
                    SalomonBottomBarItem(
                      unselectedColor: Colors.grey,
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.favorite),
                      ),
                      title: Text(LocaleKeys.favourites.tr().toUpperCase(), style: TextStyle(fontFamily: 'Changa'),),
                      selectedColor: Colors.red,
                    ),
                    SalomonBottomBarItem(
                      unselectedColor: Colors.grey,
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.person),
                      ),
                      title: Text(LocaleKeys.profile.tr().toUpperCase(), style: TextStyle(fontFamily: 'Changa'),),
                      selectedColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            );
          } ,
        ),
    );
  }
}
