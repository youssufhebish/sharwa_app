import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/shared/components/favourite_item.dart';


class FavouritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: AppCubit.get(context).loadedFavourites,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              childAspectRatio: 1.0 / 1.8,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
              children: List.generate(
                AppCubit.get(context).favoritesModel.data.data.length,
                (index) => favouriteItem(
                    AppCubit.get(context)
                        .favoritesModel
                        .data
                        .data[index]
                        .product,
                    context,
                isOldPrice: true),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}