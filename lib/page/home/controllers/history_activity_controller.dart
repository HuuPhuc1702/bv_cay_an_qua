import 'package:bv_cay_an_qua/models/history_activity_model.dart';
import 'package:bv_cay_an_qua/services/graphql/crud_repo.dart';
import 'package:bv_cay_an_qua/services/graphql/graphql_list_load_more_provider.dart';

class HistoryActivityController
    extends GraphqlListLoadMoreProvider<HistoryActivityModel> {
  static HistoryActivityProvider _provider = HistoryActivityProvider();
  static QueryInput queryInput =
      QueryInput(order: {"createdAt": -1}, limit: 20);

  HistoryActivityController({QueryInput? query})
      : super(service: _provider, query: query ?? queryInput, fragment: """
       id
      userId
      username
      message
      createdAt
  """);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}

class HistoryActivityProvider extends CrudRepository<HistoryActivityModel> {
  HistoryActivityProvider() : super(apiName: "Activity");

  @override
  HistoryActivityModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return HistoryActivityModel.fromJson(json);
  }
}
