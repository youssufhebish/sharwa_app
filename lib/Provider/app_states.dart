import 'package:shop/models/favourites_model.dart';
import 'package:shop/models/login_model.dart';

abstract class AppStates{}

class InitialState extends AppStates{}

class PageChange extends AppStates{}

class ObSecureState extends AppStates{}

class ShopLoginLoading extends AppStates{}

class ShopLoginSuccess extends AppStates{
  final LoginModel loginModel;

  ShopLoginSuccess(this.loginModel);

}

class ShopLoginError extends AppStates {
  final String error;

  ShopLoginError(this.error);
}

class ShopBottomBarChange extends AppStates{}

class ShopLoadingHome extends AppStates{}

class ShopSuccessHome extends AppStates{}

class ShopErrorHome extends AppStates{}

class CategoriesLoadingHome extends AppStates{}

class CategoriesSuccessHome extends AppStates{}

class CategoriesErrorHome extends AppStates{}

class ChangeFavouritesSuccess extends AppStates{
  final ChangeFavouritesModel model;

  ChangeFavouritesSuccess(this.model);
}

class ChangeFavouritesChange extends AppStates {}

class ChangeFavouritesError extends AppStates{
  final String error;

  ChangeFavouritesError(this.error);
}

class GetFavouritesSuccess extends AppStates {}

class ShopLoadingGetFavorites extends AppStates {}

class GetFavouritesError extends AppStates {}

class GetUserDataLoading extends AppStates {}

class GetUserDataSuccess extends AppStates {}

class GetUserDataError extends AppStates {}

class UpdateLoading extends AppStates {}

class UpdateSuccess extends AppStates {
  final LoginModel loginModel;

  UpdateSuccess(this.loginModel);
}

class UpdateError extends AppStates {}

class SearchInitialState extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {}

class SearchErrorState extends AppStates {}

class CCLoadingState extends AppStates {}

class CCSuccessState extends AppStates {}

class CCErrorState extends AppStates {}

class ChangeLanguage extends AppStates {}