import 'package:bv_cay_an_qua/models/doctor_model.dart';
import 'package:bv_cay_an_qua/models/prescription/medicine_model.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';

class MedicineProvider extends CrudRepository<MedicineModel> {
  MedicineProvider() : super(apiName: "Medicine");

  @override
  MedicineModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return MedicineModel.fromJson(json);
  }
}

class MedicineController extends GraphqlListLoadMoreProvider<MedicineModel> {
  QueryInput? queryInput = QueryInput(limit: 30, page: 1);
  static MedicineProvider _provider = MedicineProvider();
  MedicineController({query})
      : super(service: _provider, query: query, fragment: """
            id
      name
      code
      thumbnail
      images
      desc
      ingredientIds
      target
      supplier
      ingredients{
        id
        name
        medicineCount
        code
      }
      """) {
    this.queryInput = query;
  }

  refreshData() {
    if (queryInput == null) {
      queryInput = QueryInput(order: {"createdAt": -1});
    }
    this.loadAll(query: this.queryInput);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}
