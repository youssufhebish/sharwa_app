import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/modules/category_content/category_content.dart';
import 'package:shop/shared/components/category_item.dart';
import 'package:shop/shared/components/constants.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(condition: cubit.loadedCategories,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => GridView.count(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1 / 0.9,
            crossAxisCount: 2,
            children: List.generate(
              cubit.categoriesModel.data.data.length,
              (index) => InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryContent(
                        cubit.categoriesModel.data.data[index].name,
                        cubit.categoriesModel.data.data[index].id,
                      ),
                    ),
                  );
                },
                child: categoryItem(
                  image: cubit.categoriesModel.data.data[index].image,
                  categoryName: cubit.categoriesModel.data.data[index].name,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
