import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Provider/app_states.dart';
import 'package:shop/generated/locale_keys.g.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/category_content_model.dart';
import 'package:shop/models/favourites_model.dart';
import 'package:shop/models/get_favourites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/categories/categories_screen.dart';
import 'package:shop/modules/favourites/favourites.dart';
import 'package:shop/modules/products/products_screen.dart';
import 'package:shop/modules/profile/profile_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/endpoints.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:easy_localization/easy_localization.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  IconData iObSecure = Icons.visibility_outlined;
  bool isPass = true;

  LoginModel loginModel;

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

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoading());
    DioHelper.postData(url: login,
        lang: CacheHelper.getData(key: 'lang') ?? 'ar',
        data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data.token);
      emit(ShopLoginSuccess(loginModel));
    }).catchError((error) {
      emit(ShopLoginError(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screenList = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];



  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopBottomBarChange());
  }

  HomeModel homeModel;
  Map<int, bool> favourites = {};
  bool loadedHome = false;

  void getHome() {
    emit(ShopLoadingHome());
    DioHelper.getData(
      url: home,
      token: token,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favourites.addAll({element.id: element.in_favorites});
      });
      print(favourites);
      print(favourites[63]);
      print(homeModel.toString());
      loadedHome = true;
      emit(ShopSuccessHome());
    }).catchError((error) {
      print(error);
      emit(ShopErrorHome());
    });
  }

  CategoriesModel categoriesModel;
  bool loadedCategories = false;

  void getCategories() {
    emit(CategoriesLoadingHome());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.toString());
      loadedCategories = true;
      emit(CategoriesSuccessHome());
    }).catchError((error) {
      print(error);
      emit(CategoriesErrorHome());
    });
  }

  ChangeFavouritesModel changeFavouritesModel;

  void changeFavourites(int productId) {

    favourites[productId] = !favourites[productId];
    emit(ChangeFavouritesSuccess(changeFavouritesModel));

    DioHelper.postData(
      url: FAVOURITES,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);

      if (!changeFavouritesModel.status)
        favourites[productId] = !favourites[productId];
      else
        getFavorites();

      print(value.data);
      print('done');

      emit(ChangeFavouritesSuccess(changeFavouritesModel));
    }).catchError((error) {

      print('problem');
      print(error.toString());

      favourites[productId] = !favourites[productId];

      ChangeFavouritesError(error.toString());
    });
  }

  FavoritesModel favoritesModel;
  bool loadedFavourites = false;

  void getFavorites() {
    emit(ShopLoadingGetFavorites());

    DioHelper.getData(
      url: FAVOURITES,
      token: token,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());
      loadedFavourites = true;
      emit(GetFavouritesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavouritesError());
    });
  }

  LoginModel userModel;
  bool loadedUser = false;

  void getUser() {
    emit(GetUserDataLoading());
    DioHelper.getData(
      url: PROFILE,
      token: token,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel.toString());
      loadedUser = true;
      emit(GetUserDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataError());
    });
  }

  void updateUser({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    print('aaa');
    emit(UpdateLoading());
    DioHelper.putData(
      url: UPDATE,
      token: token,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel.toString());
      emit(UpdateSuccess(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateError());
    });
  }

  SearchModel searchModel;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
      data: {
        'text': text,
      },
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);

      print(searchModel.status);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  CategoryContentModel categoryContentModel;
  bool loadedContent = false;

  void getCategoryContent(int id) {
    emit(CCLoadingState());
    DioHelper.getData(
      url: CATEGORY_CONTENT + id.toString(),
      token: token,
      lang: CacheHelper.getData(key: 'lang') ?? 'ar',
    ).then((value) {
      categoryContentModel = CategoryContentModel.fromJson(value.data);
      categoryContentModel.data.data.forEach((element) {
        favourites.addAll({element.id: element.in_favorites});
      });
      print(categoryContentModel.toString());
      loadedContent = true;
      emit(CCSuccessState());
    }).catchError((error) {
      print(error);
      emit(CCErrorState());
    });
  }

  //langChange => true == en ,, => false == ar..
  bool langSelector = CacheHelper.getData(key: 'langSelector')?? false;

  void changeLang(int langId) {
    if(langId == 1) {
      CacheHelper.saveData(key: 'langSelector', value: true);
      CacheHelper.saveData(key: 'lang', value: 'en');
      CacheHelper.saveData(key: 'fontFamily', value: 'NotoSansTC');
      langSelector = CacheHelper.getData(key: 'langSelector');
    } else if(langId == 2) {
      CacheHelper.saveData(key: 'langSelector', value: false);
      CacheHelper.saveData(key: 'lang', value: 'ar');
      CacheHelper.saveData(key: 'fontFamily', value: 'Changa');
      langSelector = CacheHelper.getData(key: 'langSelector');
    }
    print(CacheHelper.getData(key: 'langSelector'));
    print(langSelector);
    emit(ChangeLanguage());
  }
}

