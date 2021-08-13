import 'package:flutter/material.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';

Widget favouriteItem(
  model,
  context, {
  bool isOldPrice = true,
}) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.network(
                      model.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 200.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
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
                                    '${model.price.round().toString()} ${LocaleKeys.le.tr()}',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  if(model.discount != 0 && isOldPrice) Text(
                                    '${model.oldPrice.round().toString()} ${LocaleKeys.le.tr()}',
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
                              isOldPrice ? IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 18.0,
                                  ),
                                  onPressed: () {
                                    AppCubit.get(context).changeFavourites(model.id);
                                    print(model.id);
                                  }) : Container(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(model.discount != 0  && isOldPrice) Container(
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
}