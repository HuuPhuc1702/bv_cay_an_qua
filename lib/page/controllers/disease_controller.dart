import 'package:bv_cay_an_qua/models/disease_model.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';

class DiseaseProvider extends CrudRepository<DiseaseModel> {
  DiseaseProvider() : super(apiName: "Disease");

  @override
  DiseaseModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return DiseaseModel.fromJson(json);
  }
}

class DiseaseController extends GraphqlListLoadMoreProvider<DiseaseModel> {
  QueryInput? queryInput;
  static DiseaseProvider _provider = DiseaseProvider();
  DiseaseController({query})
      : super(service: _provider, query: query, fragment: """
            id
            name
            thumbnail
            code
            type
            scienceName
            alternativeName
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
