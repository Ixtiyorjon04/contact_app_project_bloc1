
import 'package:dio/dio.dart';

import '../models/brand_model.dart';
import '../models/distict_model.dart';
import '../models/model_model.dart';
import '../models/region_model.dart';

class FormApi {
  final dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 60)));

  Future<List<RegionModel>> regions() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await dio.get("https://openbudget.uz/api/v1/regions");
    return (response.data["regions"] as List)
        .map((e) => RegionModel.fromJson(e))
        .toList();
  }

  Future<List<DistrictModel>> districts(int regionId) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await dio.get(
      "https://openbudget.uz/api/v1/districts?region_id=$regionId",
    );
    return (response.data["districts"] as List)
        .map((e) => DistrictModel.fromJson(e))
        .toList();
  }

  Future<List<BrandsModel>> brands() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await dio.get("https://m.avtoelon.uz/avto/brands/");
    print(response.data);
    return (response.data as List)
        .map((e) => BrandsModel.fromJson(e))
        .toList();

  }

  Future<List<ModelModel>> models(String brandId) async {
    print("id${brandId}");
    final response =
        await dio.get("https://m.avtoelon.uz/avto/models/$brandId/");
    print(response.data);
    return (response.data as List).map((e) => ModelModel.fromJson(e)).toList();
  }
}
