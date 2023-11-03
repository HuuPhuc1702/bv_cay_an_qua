import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/repositories/auth_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';

class HospitalController extends GraphqlListLoadMoreProvider<HospitalModel> {
  static HospitalProvider _provider = HospitalProvider();

  HospitalModel? detail;
  HospitalController({QueryInput? query})
      : super(service: _provider, query: query, fragment: """
      id
      name
      logo
      phone
      place{
        fullAddress
        location
      }
      intro
  """);

  getOnePost(String id) async {
    var data = await _provider.getOne(id: id, fragment: this.fragment);
    detail = data;
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}

class HospitalProvider extends CrudRepository<HospitalModel> {
  HospitalProvider() : super(apiName: "Hospital");

  @override
  HospitalModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return HospitalModel.fromJson(json);
  }
}
