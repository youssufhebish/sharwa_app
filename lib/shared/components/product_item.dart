import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/modules/product_details.dart';
import 'package:shop/shared/components/push.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget productItem(model, context) {
  return BlocConsumer<AppCubit, AppStates>(
    listener: (context, state) => null,
    builder: (context, state) {
      var cubit = AppCubit.get(context);
      return InkWell(
        onTap: () {
          navigatorP(
            context: context,
            page: ProductDetails(
              model.images,
              model.name,
              model.description,
              model.price,
              model.old_price,
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(
                      model.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 200.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1),),
                          Spacer(),
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${model.price.round()} ${LocaleKeys.le.tr()}',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  if(model.discount != 0) Text(
                                    '${model.old_price.round()} ${LocaleKeys.le.tr()}',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                  icon: Icon(
                                    cubit.favourites[model.id]
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 18.0,
                                  ),
                                  onPressed: () {
                                    cubit.changeFavourites(model.id);
                                    print(model.id);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(model.discount != 0) Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7.0,
                  vertical: 2.0,
                ),
                child: Text(
                  LocaleKeys.discount.tr().toUpperCase(),
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                ),
              ),
              color: Colors.red,
            ),
          ],
        ),
      );
    },
  );
}
