class CategoryContentModel
{
  bool status;
  Null message;
  Data data;

  CategoryContentModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int current_page;
  List<DataModel> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String name;
  String image;
  bool in_favorites;
  List<dynamic> images;
  String description;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    image = json['image'];
    name = json['name'];
    discount = json['discount'];
    in_favorites = json['in_favorites'];
    images = json['images'];
    description = json['description'];
  }
}