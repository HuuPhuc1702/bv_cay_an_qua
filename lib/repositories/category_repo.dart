import 'package:bv_cay_an_qua/models/category/district_model.dart';
import 'package:bv_cay_an_qua/models/category/document_group_model.dart';
import 'package:bv_cay_an_qua/models/category/ward_model.dart';
import 'package:bv_cay_an_qua/models/topic_model.dart';
import 'package:bv_cay_an_qua/models/user/plant_model.dart';

import '../models/category/province_model.dart';
import '../services/graphql/graphql_repo.dart';

class _CategoryRepository extends GraphqlRepository {
  Future<List<ProvinceModel>> getProvince() async {
    var result = await this.query(
      """
      getProvince(){
        id
        province
      }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<ProvinceModel>.from(
          result.data?["g0"].map((d) => ProvinceModel.fromJson(d)));
    }
    return [];
  }

  Future<List<DistrictModel>> getDistrict({
    required String provinceId,
  }) async {
    var result = await this.query(
      """
        getDistrict(provinceId:"$provinceId"){
            id
            district
          }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<DistrictModel>.from(
          result.data?["g0"].map((d) => DistrictModel.fromJson(d)));
    }
    return [];
  }

  Future<List<WardModel>> getWard({
    required String districtId,
  }) async {
    var result = await this.query(
      """
        getWard(districtId:"$districtId"){
          id
          ward
        }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      // print(result.data?["g0"]);
      return List<WardModel>.from(
          result.data?["g0"].map((d) => WardModel.fromJson(d)));
    }
    return [];
  }
}

final categoryRepository = new _CategoryRepository();
