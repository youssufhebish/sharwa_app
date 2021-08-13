
class HomeModel {
  bool status;
  HomeData data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}


class HomeData{

  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeData.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });

  }
}

class BannerModel{
  int id;
  String image;

  BannerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic old_price;
  String image;
  String name;
  dynamic discount;
  bool in_favorites;
  bool in_cart;
  List<dynamic> images;
  String description;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    image = json['image'];
    name = json['name'];
    discount = json['discount'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    images = json['images'];
    description = json['description'];
  }
}