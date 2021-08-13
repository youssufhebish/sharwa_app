import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_cubit.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/modules/category_content/category_content.dart';
import 'package:shop/shared/components/category_item.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/components/product_item.dart';
import 'package:shop/shared/components/push.dart';
import 'package:shop/shared/components/toast.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              if(state is ShopSuccessHome) {
                loadedHome = true;
              }
              if(state is ChangeFavouritesSuccess){
                if(!state.model.status){
                  return showToast(message: state.model.message, state: toastState.ERROR);
                }
              }
            },
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return ConditionalBuilder(
                  condition: cubit.loadedHome,
                  builder: (context) =>
                      productBuilder(cubit.homeModel, cubit.categoriesModel, context),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()));
            });
  }

  Widget productBuilder(HomeModel homeModel, CategoriesModel categoriesModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data.banners
                  .map(
                    (e) => Image.network(
                      '${e.image}',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(LocaleKeys.categories.tr().toUpperCase()),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 150.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    onTap: (){
                        navigatorP(
                          context: context,
                          page: CategoryContent(
                              categoriesModel.data.data[index].name,
                              categoriesModel.data.data[index].id),
                        );
                      },
                      child: categoryItem(categoryName: categoriesModel.data.data[index].name, image: categoriesModel.data.data[index].image,)),
                  separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                  itemCount: categoriesModel.data.data.length,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(LocaleKeys.allproducts.tr().toUpperCase()),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              color: Colors.grey[200],
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
                    homeModel.data.products.length,
                    (index) => productItem(
                      homeModel.data.products[index],
                      context
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
  );
}
