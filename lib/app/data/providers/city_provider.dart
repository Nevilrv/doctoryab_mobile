import 'package:get/get.dart';

import '../models/city_model.dart';

class CityProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) => City.fromJson(map);
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Response<City>> getCity(int id) async => await get('city/$id');
  Future<Response<City>> postCity(City city) async => await post('city', city);
  Future<Response> deleteCity(int id) async => await delete('city/$id');
}
