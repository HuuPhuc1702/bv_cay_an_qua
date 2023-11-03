import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';

class DoctorProvider extends CrudRepository<DoctorModel> {
  DoctorProvider() : super(apiName: "Doctor");

  @override
  DoctorModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return DoctorModel.fromJson(json);
  }
}

class DoctorController extends GraphqlListLoadMoreProvider<DoctorModel> {
  // QueryInput? queryInput;
  static DoctorProvider _provider = DoctorProvider();
  DoctorController({query})
      : super(service: _provider, query: query, fragment: """
            id
            name
            email
            phone
            avatar
            position
            degree
            subject
            specialized
            intro
            hospitalId
      """) {
    // this.queryInput = query;
  }

  refreshData() {
    // if (queryInput == null) {
    //   queryInput = QueryInput(order: {"createdAt": -1});
    // }
    this.loadAll();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}
