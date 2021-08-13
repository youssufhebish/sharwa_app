import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/shared/components/favourite_item.dart';
import 'package:shop/shared/styles/colors.dart';

class SearchScreen extends StatefulWidget {
  final bool clear;

  const SearchScreen(this.clear);
  @override
  _SearchScreenState createState() => _SearchScreenState(clear);
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;
  bool clear;
  _SearchScreenState(this.clear);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: isSearching? TextField(
          style: TextStyle(color: primaryColor),
          onSubmitted: (string){
            AppCubit.get(context).search(string);
          },
          decoration: InputDecoration(
            hintText: LocaleKeys.searchhere.tr().toUpperCase(),
            hintStyle: TextStyle(color: primaryColor),
            focusColor: Colors.indigoAccent.withOpacity(0.0),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ): Text(''),
        actions: [
          IconButton(icon: Icon(isSearching? Icons.cancel : Icons.search), onPressed: (){
            setState((){
              isSearching = !isSearching;
              clear = true;
            });
          })
        ],
      ),
      body: ConditionalBuilder(
        condition: AppCubit.get(context).state is! SearchLoadingState,
        builder: (context) => !clear ||
                  AppCubit.get(context).state is! SearchSuccessState
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1 / 1.74,
                    crossAxisCount: 2,
                    children: List.generate(
                      AppCubit.get(context).searchModel.data.data.length,
                      (index) => favouriteItem(
                          AppCubit.get(context).searchModel.data.data[index],
                          context,
                          isOldPrice: false),
                    ),
                  ),
                ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
      )
    );
  }
}
