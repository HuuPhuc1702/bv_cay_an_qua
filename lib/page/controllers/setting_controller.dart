import 'package:bv_cay_an_qua/models/hospital_model.dart';
import 'package:bv_cay_an_qua/models/setting_model.dart';
import 'package:bv_cay_an_qua/repositories/auth_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';

class SettingController extends GraphqlListLoadMoreProvider<SettingModel> {
  static SettingProvider _provider = SettingProvider();

  SettingModel? detail;
  SettingController({QueryInput? query})
      : super(service: _provider, query: query, fragment: """
                      id
                      name
                      key
                      value
                      isActive
                      isPrivate
                      type
  """);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}

class SettingProvider extends CrudRepository<SettingModel> {
  SettingProvider() : super(apiName: "Setting");

  @override
  SettingModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return SettingModel.fromJson(json);
  }
}
