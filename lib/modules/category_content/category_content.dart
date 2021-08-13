import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/shared/components/product_item.dart';
import 'package:shop/shared/styles/colors.dart';

class CategoryContent extends StatelessWidget {
  final String title;
  final int id;

  const CategoryContent(this.title, this.id);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getCategoryContent(id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var c = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: c.loadedContent,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => Container(
                child: Padding(
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
                      c.categoryContentModel.data.data.length,
                          (index) => productItem(
                              c.categoryContentModel.data.data[index],
                          context
                      ),
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
