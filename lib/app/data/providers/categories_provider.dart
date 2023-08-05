import 'package:get/get.dart';

import '../models/categories_model.dart';

class CategoriesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) => Categories.fromJson(map);
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Response<Categories>> getCategories(int id) async =>
      await get('categories/$id');
  Future<Response<Categories>> postCategories(Categories categories) async =>
      await post('categories', categories);
  Future<Response> deleteCategories(int id) async =>
      await delete('categories/$id');
}
